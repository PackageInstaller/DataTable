using System;
using System.IO;
using System.Text;

public class XXTEA
{
	private static bool hasObb = false;

	private const uint delta = 2654435769u;

	private static readonly UTF8Encoding utf8 = new UTF8Encoding();

	public static void EncryptFile(string fileName, string key, ref byte[] outData)
	{
		byte[] text = File.ReadAllBytes(fileName);
		outData = Encrypt(text, key);
	}

	public static void DecryptFile(string fileName, string key, ref byte[] outData)
	{
		byte[] array = null;
		array = File.ReadAllBytes(fileName);
		outData = DecryptAsset(array, key);
	}

	public static byte[] DecryptAsset(byte[] ciphertBytes, string password)
	{
		if (ciphertBytes.Length == 0)
		{
			return null;
		}
		uint[] array = ToLongs(ciphertBytes);
		uint[] array2 = ToLongs(new UTF8Encoding().GetBytes(password.Substring(0, 16)));
		uint num = (uint)array.Length;
		uint num2 = array[num - 1];
		uint num3 = array[0];
		uint num4 = 2654435769u;
		uint num5 = (6 + 52 / num) * num4;
		uint num6 = 0u;
		while (num5 != 0)
		{
			uint num7 = (num5 >> 2) & 3;
			for (num6 = num - 1; num6 != 0; num6--)
			{
				num2 = array[num6 - 1];
				num3 = (array[num6] -= (((num2 >> 5) ^ (num3 << 2)) + ((num3 >> 3) ^ (num2 << 4))) ^ ((num5 ^ num3) + (array2[(num6 & 3) ^ num7] ^ num2)));
			}
			num2 = array[num - 1];
			num3 = (array[0] -= (((num2 >> 5) ^ (num3 << 2)) + ((num3 >> 3) ^ (num2 << 4))) ^ ((num5 ^ num3) + (array2[(num6 & 3) ^ num7] ^ num2)));
			num5 -= num4;
		}
		return ToBytes(array, isPading: true);
	}

	public static byte[] Encrypt(byte[] text, string password)
	{
		if (text.Length == 0)
		{
			return null;
		}
		if (password.Length < 8)
		{
			throw new ArgumentException("The salt for encryption is too short");
		}
		while (password.Length < 16)
		{
			password += password;
		}
		return Encrypt(text, utf8.GetBytes(password));
	}

	public static byte[] Encrypt(byte[] data, byte[] key)
	{
		if (data.Length == 0)
		{
			return data;
		}
		return ToByteArray(Encrypt(ToUInt32Array(data, includeLength: true), ToUInt32Array(FixKey(key), includeLength: false)), includeLength: false);
	}

	private static uint[] Encrypt(uint[] v, uint[] k)
	{
		int num = v.Length - 1;
		if (num < 1)
		{
			return v;
		}
		uint z = v[num];
		uint num2 = 0u;
		int num3 = 6 + 52 / (num + 1);
		while (0 < num3--)
		{
			num2 += 2654435769u;
			uint e = (num2 >> 2) & 3;
			int i;
			uint y;
			for (i = 0; i < num; i++)
			{
				y = v[i + 1];
				z = (v[i] += MX(num2, y, z, i, e, k));
			}
			y = v[0];
			z = (v[num] += MX(num2, y, z, i, e, k));
		}
		return v;
	}

	private static uint MX(uint sum, uint y, uint z, int p, uint e, uint[] k)
	{
		return (((z >> 5) ^ (y << 2)) + ((y >> 3) ^ (z << 4))) ^ ((sum ^ y) + (k[(p & 3) ^ e] ^ z));
	}

	public static byte[] Decrypt(byte[] ciphertBytes, string password)
	{
		if (ciphertBytes.Length == 0)
		{
			return ciphertBytes;
		}
		return ToByteArray(Decrypt(ToUInt32Array(ciphertBytes, includeLength: false), ToUInt32Array(FixKey(utf8.GetBytes(password)), includeLength: false)), includeLength: true);
	}

	public static byte[] Decrypt(byte[] ciphertBytes, byte[] key)
	{
		if (ciphertBytes.Length == 0)
		{
			return ciphertBytes;
		}
		return ToByteArray(Decrypt(ToUInt32Array(ciphertBytes, includeLength: false), ToUInt32Array(FixKey(key), includeLength: false)), includeLength: true);
	}

	private static uint[] Decrypt(uint[] v, uint[] k)
	{
		int num = v.Length - 1;
		if (num < 1)
		{
			return v;
		}
		uint y = v[0];
		for (uint num2 = (uint)((6 + 52 / (num + 1)) * 2654435769u); num2 != 0; num2 -= 2654435769u)
		{
			uint e = (num2 >> 2) & 3;
			int num3;
			uint z;
			for (num3 = num; num3 > 0; num3--)
			{
				z = v[num3 - 1];
				y = (v[num3] -= MX(num2, y, z, num3, e, k));
			}
			z = v[num];
			y = (v[0] -= MX(num2, y, z, num3, e, k));
		}
		return v;
	}

	private static uint[] ToLongs(byte[] s)
	{
		uint[] array = new uint[(int)Math.Ceiling((decimal)s.Length / 4m)];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = (uint)(s[i * 4] + ((i * 4 + 1 < s.Length) ? (s[i * 4 + 1] << 8) : 0) + ((i * 4 + 2 < s.Length) ? (s[i * 4 + 2] << 16) : 0) + ((i * 4 + 3 < s.Length) ? (s[i * 4 + 3] << 24) : 0));
		}
		return array;
	}

	private static byte[] ToBytes(uint[] l, bool isPading)
	{
		byte[] array = new byte[l.Length * 4];
		int num = 0;
		int num2 = array.Length;
		for (int i = 0; i < l.Length; i++)
		{
			array[i * 4] = (byte)(l[i] & 0xFF);
			array[i * 4 + 1] = (byte)((l[i] >> 8) & 0xFF);
			array[i * 4 + 2] = (byte)((l[i] >> 16) & 0xFF);
			array[i * 4 + 3] = (byte)((l[i] >> 24) & 0xFF);
		}
		if (isPading)
		{
			num = array[num2 - 1];
			num2 -= num;
			if (num < 1 || num > 8)
			{
				return null;
			}
			if (num2 < 0)
			{
				return null;
			}
			for (int j = num2; j < l.Length * 4; j++)
			{
				if (array[j] != num)
				{
					return null;
				}
			}
			array[num2] = 0;
			byte[] array2 = new byte[num2];
			Array.Copy(array, array2, array2.Length);
			return array2;
		}
		return array;
	}

	private static byte[] FixKey(byte[] key)
	{
		if (key.Length == 16)
		{
			return key;
		}
		byte[] array = new byte[16];
		if (key.Length < 16)
		{
			key.CopyTo(array, 0);
		}
		else
		{
			Array.Copy(key, 0, array, 0, 16);
		}
		return array;
	}

	private static uint[] ToUInt32Array(byte[] data, bool includeLength)
	{
		int num = data.Length;
		int num2 = (((num & 3) == 0) ? (num >> 2) : ((num >> 2) + 1));
		uint[] array;
		if (includeLength)
		{
			array = new uint[num2 + 1];
			array[num2] = (uint)num;
		}
		else
		{
			array = new uint[num2];
		}
		for (int i = 0; i < num; i++)
		{
			array[i >> 2] |= (uint)(data[i] << ((i & 3) << 3));
		}
		return array;
	}

	private static byte[] ToByteArray(uint[] data, bool includeLength)
	{
		int num = data.Length << 2;
		if (includeLength)
		{
			int num2 = (int)data[data.Length - 1];
			num -= 4;
			if (num2 < num - 3 || num2 > num)
			{
				return null;
			}
			num = num2;
		}
		byte[] array = new byte[num];
		for (int i = 0; i < num; i++)
		{
			array[i] = (byte)(data[i >> 2] >> ((i & 3) << 3));
		}
		return array;
	}
}
