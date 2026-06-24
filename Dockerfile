# ── ETAPA 1: Build con Maven ───────────────────────────────────────
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /app

COPY Springboot-API-REST/pom.xml ./pom.xml
RUN mvn dependency:go-offline -B

COPY Springboot-API-REST/src ./src
RUN mvn clean package -DskipTests -B

# ── ETAPA 2: Imagen de producción ─────────────────────────────────
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

COPY --from=build /app/target/Springboot-API-REST-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
