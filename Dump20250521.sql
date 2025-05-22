-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: cajerodb
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `ClienteID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `Apellidos` varchar(150) NOT NULL,
  `Celular` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Direccion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ClienteID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuenta`
--

DROP TABLE IF EXISTS `cuenta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuenta` (
  `CuentaID` int NOT NULL AUTO_INCREMENT,
  `ClienteID` int NOT NULL,
  `ClaveBancaria` varchar(20) NOT NULL,
  `TipoCuenta` varchar(50) NOT NULL,
  `Saldo` decimal(18,2) NOT NULL,
  `FechaApertura` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`CuentaID`),
  UNIQUE KEY `ClaveBancaria` (`ClaveBancaria`),
  KEY `ClienteID` (`ClienteID`),
  CONSTRAINT `cuenta_ibfk_1` FOREIGN KEY (`ClienteID`) REFERENCES `cliente` (`ClienteID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuenta`
--

LOCK TABLES `cuenta` WRITE;
/*!40000 ALTER TABLE `cuenta` DISABLE KEYS */;
/*!40000 ALTER TABLE `cuenta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historialtransaccion`
--

DROP TABLE IF EXISTS `historialtransaccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historialtransaccion` (
  `HistorialID` int NOT NULL AUTO_INCREMENT,
  `CuentaID` int NOT NULL,
  `Tipo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Monto` decimal(18,2) NOT NULL,
  `FechaHora` datetime DEFAULT CURRENT_TIMESTAMP,
  `Descripcion` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `CuentaDestinoID` int DEFAULT NULL,
  PRIMARY KEY (`HistorialID`),
  KEY `CuentaID` (`CuentaID`),
  KEY `CuentaDestinoID` (`CuentaDestinoID`),
  CONSTRAINT `historialtransaccion_ibfk_1` FOREIGN KEY (`CuentaID`) REFERENCES `cuenta` (`CuentaID`),
  CONSTRAINT `historialtransaccion_ibfk_2` FOREIGN KEY (`CuentaDestinoID`) REFERENCES `cuenta` (`CuentaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historialtransaccion`
--

LOCK TABLES `historialtransaccion` WRITE;
/*!40000 ALTER TABLE `historialtransaccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `historialtransaccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tarjeta`
--

DROP TABLE IF EXISTS `tarjeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tarjeta` (
  `TarjetaID` int NOT NULL AUTO_INCREMENT,
  `CuentaID` int NOT NULL,
  `NumeroTarjeta` varchar(20) NOT NULL,
  `CVV` varchar(5) NOT NULL,
  `FechaExpiracion` date NOT NULL,
  `PINHash` varchar(256) NOT NULL,
  `Estado` tinyint NOT NULL,
  PRIMARY KEY (`TarjetaID`),
  UNIQUE KEY `NumeroTarjeta` (`NumeroTarjeta`),
  KEY `CuentaID` (`CuentaID`),
  CONSTRAINT `tarjeta_ibfk_1` FOREIGN KEY (`CuentaID`) REFERENCES `cuenta` (`CuentaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tarjeta`
--

LOCK TABLES `tarjeta` WRITE;
/*!40000 ALTER TABLE `tarjeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tarjeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaccion`
--

DROP TABLE IF EXISTS `transaccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaccion` (
  `TransaccionID` int NOT NULL AUTO_INCREMENT,
  `CuentaOrigenID` int NOT NULL,
  `CuentaDestinoID` int DEFAULT NULL,
  `Tipo` varchar(20) NOT NULL,
  `Monto` decimal(18,2) NOT NULL,
  `FechaHora` datetime DEFAULT CURRENT_TIMESTAMP,
  `Descripcion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`TransaccionID`),
  KEY `CuentaOrigenID` (`CuentaOrigenID`),
  KEY `CuentaDestinoID` (`CuentaDestinoID`),
  CONSTRAINT `transaccion_ibfk_1` FOREIGN KEY (`CuentaOrigenID`) REFERENCES `cuenta` (`CuentaID`),
  CONSTRAINT `transaccion_ibfk_2` FOREIGN KEY (`CuentaDestinoID`) REFERENCES `cuenta` (`CuentaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaccion`
--

LOCK TABLES `transaccion` WRITE;
/*!40000 ALTER TABLE `transaccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuariosistema`
--

DROP TABLE IF EXISTS `usuariosistema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuariosistema` (
  `UsuarioID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `Usuario` varchar(50) NOT NULL,
  `Contraseña` varchar(256) NOT NULL,
  `Rol` varchar(50) NOT NULL,
  `Estado` varchar(20) DEFAULT 'Activo',
  PRIMARY KEY (`UsuarioID`),
  UNIQUE KEY `Usuario` (`Usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuariosistema`
--

LOCK TABLES `usuariosistema` WRITE;
/*!40000 ALTER TABLE `usuariosistema` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuariosistema` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-21 21:28:23
