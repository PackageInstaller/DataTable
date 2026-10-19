using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace ACT;

internal static class AotCrypto
{
	private const string Prefix = "ENC:";

	private static readonly byte[] Key = DeriveKey("Lumin_Key_v1");

	public static void WriteEncrypted(string path, string content)
	{
		if (content == null)
		{
			content = string.Empty;
		}
		string contents = EncryptToText(content);
		EnsureDirectory(path);
		File.WriteAllText(path, contents, Encoding.UTF8);
	}

	public static void WriteEncryptedLines(string path, string[] lines)
	{
		string content = ((lines == null) ? string.Empty : string.Join("\n", lines));
		WriteEncrypted(path, content);
	}

	public static string ReadDecrypted(string path)
	{
		if (!File.Exists(path))
		{
			return string.Empty;
		}
		string text = File.ReadAllText(path, Encoding.UTF8);
		if (string.IsNullOrEmpty(text))
		{
			return string.Empty;
		}
		if (!text.StartsWith("ENC:", StringComparison.Ordinal))
		{
			return text;
		}
		return DecryptFromText(text.Substring("ENC:".Length));
	}

	private static string EncryptToText(string plain)
	{
		byte[] array = new byte[16];
		RandomNumberGenerator.Fill(array);
		using Aes aes = Aes.Create();
		aes.Key = Key;
		aes.IV = array;
		aes.Mode = CipherMode.CBC;
		aes.Padding = PaddingMode.PKCS7;
		using ICryptoTransform cryptoTransform = aes.CreateEncryptor();
		byte[] bytes = Encoding.UTF8.GetBytes(plain);
		byte[] array2 = cryptoTransform.TransformFinalBlock(bytes, 0, bytes.Length);
		byte[] array3 = new byte[array.Length + array2.Length];
		Buffer.BlockCopy(array, 0, array3, 0, array.Length);
		Buffer.BlockCopy(array2, 0, array3, array.Length, array2.Length);
		return "ENC:" + Convert.ToBase64String(array3);
	}

	private static string DecryptFromText(string base64)
	{
		byte[] array = Convert.FromBase64String(base64);
		if (array.Length < 17)
		{
			return string.Empty;
		}
		byte[] array2 = new byte[16];
		byte[] array3 = new byte[array.Length - 16];
		Buffer.BlockCopy(array, 0, array2, 0, 16);
		Buffer.BlockCopy(array, 16, array3, 0, array3.Length);
		using Aes aes = Aes.Create();
		aes.Key = Key;
		aes.IV = array2;
		aes.Mode = CipherMode.CBC;
		aes.Padding = PaddingMode.PKCS7;
		using ICryptoTransform cryptoTransform = aes.CreateDecryptor();
		byte[] bytes = cryptoTransform.TransformFinalBlock(array3, 0, array3.Length);
		return Encoding.UTF8.GetString(bytes);
	}

	private static byte[] DeriveKey(string passphrase)
	{
		using SHA256 sHA = SHA256.Create();
		return sHA.ComputeHash(Encoding.UTF8.GetBytes(passphrase ?? string.Empty));
	}

	private static void EnsureDirectory(string filePath)
	{
		string directoryName = Path.GetDirectoryName(filePath);
		if (!string.IsNullOrEmpty(directoryName) && !Directory.Exists(directoryName))
		{
			Directory.CreateDirectory(directoryName);
		}
	}
}
