using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace YooAsset;

public static class HashUtility
{
	private static string ToString(byte[] hashBytes)
	{
		return BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
	}

	public static string StringSHA1(string str)
	{
		return BytesSHA1(Encoding.UTF8.GetBytes(str));
	}

	public static string FileSHA1(string filePath)
	{
		using FileStream stream = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.Read);
		return StreamSHA1(stream);
	}

	public static string FileSHA1Safely(string filePath)
	{
		try
		{
			return FileSHA1(filePath);
		}
		catch (Exception exception)
		{
			YooLogger.Exception(exception);
			return string.Empty;
		}
	}

	public static string StreamSHA1(Stream stream)
	{
		return ToString(HashAlgorithm.Create().ComputeHash(stream));
	}

	public static string BytesSHA1(byte[] buffer)
	{
		return ToString(HashAlgorithm.Create().ComputeHash(buffer));
	}

	public static string StringMD5(string str)
	{
		return BytesMD5(Encoding.UTF8.GetBytes(str));
	}

	public static string FileMD5(string filePath)
	{
		using FileStream stream = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.Read);
		return StreamMD5(stream);
	}

	public static string FileMD5Safely(string filePath)
	{
		try
		{
			return FileMD5(filePath);
		}
		catch (Exception exception)
		{
			YooLogger.Exception(exception);
			return string.Empty;
		}
	}

	public static string StreamMD5(Stream stream)
	{
		return ToString(new MD5CryptoServiceProvider().ComputeHash(stream));
	}

	public static string BytesMD5(byte[] buffer)
	{
		return ToString(new MD5CryptoServiceProvider().ComputeHash(buffer));
	}

	public static string StringCRC32(string str)
	{
		return BytesCRC32(Encoding.UTF8.GetBytes(str));
	}

	public static string FileCRC32(string filePath)
	{
		using FileStream stream = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.Read);
		return StreamCRC32(stream);
	}

	public static string FileCRC32Safely(string filePath)
	{
		try
		{
			return FileCRC32(filePath);
		}
		catch (Exception exception)
		{
			YooLogger.Exception(exception);
			return string.Empty;
		}
	}

	public static string StreamCRC32(Stream stream)
	{
		return ToString(new CRC32Algorithm().ComputeHash(stream));
	}

	public static string BytesCRC32(byte[] buffer)
	{
		return ToString(new CRC32Algorithm().ComputeHash(buffer));
	}
}
