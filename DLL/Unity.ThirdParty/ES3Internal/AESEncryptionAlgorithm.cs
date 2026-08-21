using System.IO;
using System.Security.Cryptography;

namespace ES3Internal;

public class AESEncryptionAlgorithm : EncryptionAlgorithm
{
	private const int ivSize = 16;

	private const int keySize = 16;

	private const int pwIterations = 100;

	public override byte[] Encrypt(byte[] bytes, string password, int bufferSize)
	{
		using MemoryStream input = new MemoryStream(bytes);
		using MemoryStream memoryStream = new MemoryStream();
		Encrypt(input, memoryStream, password, bufferSize);
		return memoryStream.ToArray();
	}

	public override byte[] Decrypt(byte[] bytes, string password, int bufferSize)
	{
		using MemoryStream input = new MemoryStream(bytes);
		using MemoryStream memoryStream = new MemoryStream();
		Decrypt(input, memoryStream, password, bufferSize);
		return memoryStream.ToArray();
	}

	public override void Encrypt(Stream input, Stream output, string password, int bufferSize)
	{
		input.Position = 0L;
		using Aes aes = Aes.Create();
		aes.Mode = CipherMode.CBC;
		aes.Padding = PaddingMode.PKCS7;
		aes.GenerateIV();
		Rfc2898DeriveBytes rfc2898DeriveBytes = new Rfc2898DeriveBytes(password, aes.IV, 100);
		aes.Key = rfc2898DeriveBytes.GetBytes(16);
		output.Write(aes.IV, 0, 16);
		using ICryptoTransform transform = aes.CreateEncryptor();
		using CryptoStream output2 = new CryptoStream(output, transform, CryptoStreamMode.Write);
		EncryptionAlgorithm.CopyStream(input, output2, bufferSize);
	}

	public override void Decrypt(Stream input, Stream output, string password, int bufferSize)
	{
		using (Aes aes = Aes.Create())
		{
			byte[] array = new byte[16];
			input.Read(array, 0, 16);
			aes.IV = array;
			Rfc2898DeriveBytes rfc2898DeriveBytes = new Rfc2898DeriveBytes(password, aes.IV, 100);
			aes.Key = rfc2898DeriveBytes.GetBytes(16);
			using ICryptoTransform transform = aes.CreateDecryptor();
			using CryptoStream input2 = new CryptoStream(input, transform, CryptoStreamMode.Read);
			EncryptionAlgorithm.CopyStream(input2, output, bufferSize);
		}
		output.Position = 0L;
	}
}
