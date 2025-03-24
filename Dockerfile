# 1. Build fázis
FROM node:18-alpine as builder
WORKDIR /app
COPY package.json yarn.lock ./
RUN npm install
COPY . .
RUN npm run build

# 2. Futtatás
FROM node:18-alpine
RUN npm install -g serve
WORKDIR /app
COPY --from=builder /app/build ./build
EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "3000"]
