FROM maven:3.8.4-openjdk-21-slim AS build
WORKDIR /build
COPY pom.xml .
COPY src src
RUN mvn clean package -DskipTests
FROM openjdk:21-jre-slim
WORKDIR /app
COPY --from=build /build/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
