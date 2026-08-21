using System;
using System.Security.Cryptography;
using System.Text;

namespace Ase;

public static class EncryptUtility
{
	public static string MD5(string input)
	{
		using MD5 mD = System.Security.Cryptography.MD5.Create();
		return BitConverter.ToString(mD.ComputeHash(Encoding.UTF8.GetBytes(input))).Replace("-", "").ToLowerInvariant();
	}

	public static string SHA256(string input)
	{
		using SHA256 sHA = System.Security.Cryptography.SHA256.Create();
		return BitConverter.ToString(sHA.ComputeHash(Encoding.UTF8.GetBytes(input))).Replace("-", "").ToLowerInvariant();
	}

	public static string AESEncrypt(string plainText, string secret)
	{
		using Aes aes = Aes.Create();
		aes.Key = Encoding.UTF8.GetBytes(secret.PadRight(32).Substring(0, 32));
		aes.IV = new byte[16];
		ICryptoTransform cryptoTransform = aes.CreateEncryptor(aes.Key, aes.IV);
		byte[] bytes = Encoding.UTF8.GetBytes(plainText);
		return Convert.ToBase64String(cryptoTransform.TransformFinalBlock(bytes, 0, bytes.Length));
	}

	public static string AESDecrypt(string cipherText, string secret)
	{
		using Aes aes = Aes.Create();
		aes.Key = Encoding.UTF8.GetBytes(secret.PadRight(32).Substring(0, 32));
		aes.IV = new byte[16];
		ICryptoTransform cryptoTransform = aes.CreateDecryptor(aes.Key, aes.IV);
		byte[] array = Convert.FromBase64String(cipherText);
		byte[] bytes = cryptoTransform.TransformFinalBlock(array, 0, array.Length);
		return Encoding.UTF8.GetString(bytes);
	}

	public static string HmacSHA256(string message, string secret)
	{
		ASCIIEncoding aSCIIEncoding = new ASCIIEncoding();
		byte[] bytes = aSCIIEncoding.GetBytes(secret);
		byte[] bytes2 = aSCIIEncoding.GetBytes(message);
		using HMACSHA256 hMACSHA = new HMACSHA256(bytes);
		return Convert.ToBase64String(hMACSHA.ComputeHash(bytes2));
	}
}
