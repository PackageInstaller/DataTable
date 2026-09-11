using System;
using System.Security.Cryptography;
using System.Text;

public class AESEncryptor
{
	public string mKey;

	public AESEncryptor(string key)
	{
		mKey = key;
	}

	public byte[] AESEncrypt(byte[] buffers)
	{
		if (buffers.Length == 0)
		{
			return buffers;
		}
		using RijndaelManaged rijndaelManaged = new RijndaelManaged();
		rijndaelManaged.Mode = CipherMode.CBC;
		rijndaelManaged.Padding = PaddingMode.PKCS7;
		rijndaelManaged.KeySize = 128;
		rijndaelManaged.BlockSize = 128;
		byte[] bytes = Encoding.UTF8.GetBytes(mKey);
		byte[] array = new byte[16];
		int num = bytes.Length;
		if (num > array.Length)
		{
			num = array.Length;
		}
		Array.Copy(bytes, array, num);
		rijndaelManaged.Key = array;
		rijndaelManaged.IV = new byte[16];
		ICryptoTransform cryptoTransform = rijndaelManaged.CreateEncryptor();
		return cryptoTransform.TransformFinalBlock(buffers, 0, buffers.Length);
	}

	public byte[] AESDecrypt(byte[] buffers)
	{
		if (buffers.Length == 0)
		{
			return buffers;
		}
		using RijndaelManaged rijndaelManaged = new RijndaelManaged();
		rijndaelManaged.Mode = CipherMode.CBC;
		rijndaelManaged.Padding = PaddingMode.PKCS7;
		rijndaelManaged.KeySize = 128;
		rijndaelManaged.BlockSize = 128;
		byte[] bytes = Encoding.UTF8.GetBytes(mKey);
		byte[] array = new byte[16];
		int num = bytes.Length;
		if (num > array.Length)
		{
			num = array.Length;
		}
		Array.Copy(bytes, array, num);
		rijndaelManaged.Key = array;
		rijndaelManaged.IV = new byte[16];
		ICryptoTransform cryptoTransform = rijndaelManaged.CreateDecryptor();
		return cryptoTransform.TransformFinalBlock(buffers, 0, buffers.Length);
	}
}
