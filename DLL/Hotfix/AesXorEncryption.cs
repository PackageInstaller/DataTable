using System;

public static class AesXorEncryption
{
	private const uint INITIAL_KEY = 2654435769u;

	public static byte[] DecryptAllData(byte[] encryptedData)
	{
		if (encryptedData == null || encryptedData.Length == 0)
		{
			return encryptedData;
		}
		byte[] array = new byte[encryptedData.Length];
		uint num = 2654435769u;
		for (int i = 0; i < 8; i++)
		{
			num = (num << 1) | (num >> 31);
			num ^= (uint)encryptedData.Length;
		}
		uint num2 = num;
		for (int j = 0; j < encryptedData.Length; j++)
		{
			byte b = (byte)(num2 & 0xFF);
			array[j] = (byte)(encryptedData[j] ^ b);
			num2 = num2 * 1103515245 + 12345;
		}
		return array;
	}

	public static byte[] EncryptAllData(byte[] data)
	{
		if (data == null || data.Length == 0)
		{
			return data;
		}
		byte[] array = new byte[data.Length];
		uint num = 2654435769u;
		for (int i = 0; i < 8; i++)
		{
			num = (num << 1) | (num >> 31);
			num ^= (uint)data.Length;
		}
		uint num2 = num;
		for (int j = 0; j < data.Length; j++)
		{
			byte b = (byte)(num2 & 0xFF);
			array[j] = (byte)(data[j] ^ b);
			num2 = num2 * 1103515245 + 12345;
		}
		return array;
	}

	public static bool TestEncryption()
	{
		byte[] array = new byte[5] { 1, 2, 3, 4, 5 };
		Console.WriteLine("原始数据: " + BitConverter.ToString(array));
		byte[] array2 = EncryptAllData(array);
		Console.WriteLine("加密后: " + BitConverter.ToString(array2));
		byte[] array3 = DecryptAllData(array2);
		Console.WriteLine("解密后: " + BitConverter.ToString(array3));
		if (array.Length != array3.Length)
		{
			Console.WriteLine("长度不匹配！");
			return false;
		}
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i] != array3[i])
			{
				Console.WriteLine($"第{i}个字节不匹配: {array[i]} != {array3[i]}");
				return false;
			}
		}
		Console.WriteLine("测试通过！");
		return true;
	}
}
