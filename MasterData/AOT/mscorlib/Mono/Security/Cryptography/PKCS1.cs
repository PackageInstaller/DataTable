using System;
using System.Security.Cryptography;

namespace Mono.Security.Cryptography;

internal sealed class PKCS1
{
	private static byte[] emptySHA1 = new byte[20]
	{
		218, 57, 163, 238, 94, 107, 75, 13, 50, 85,
		191, 239, 149, 96, 24, 144, 175, 216, 7, 9
	};

	private static byte[] emptySHA256 = new byte[32]
	{
		227, 176, 196, 66, 152, 252, 28, 20, 154, 251,
		244, 200, 153, 111, 185, 36, 39, 174, 65, 228,
		100, 155, 147, 76, 164, 149, 153, 27, 120, 82,
		184, 85
	};

	private static byte[] emptySHA384 = new byte[48]
	{
		56, 176, 96, 167, 81, 172, 150, 56, 76, 217,
		50, 126, 177, 177, 227, 106, 33, 253, 183, 17,
		20, 190, 7, 67, 76, 12, 199, 191, 99, 246,
		225, 218, 39, 78, 222, 191, 231, 111, 101, 251,
		213, 26, 210, 241, 72, 152, 185, 91
	};

	private static byte[] emptySHA512 = new byte[64]
	{
		207, 131, 225, 53, 126, 239, 184, 189, 241, 84,
		40, 80, 214, 109, 128, 7, 214, 32, 228, 5,
		11, 87, 21, 220, 131, 244, 169, 33, 211, 108,
		233, 206, 71, 208, 209, 60, 93, 133, 242, 176,
		255, 131, 24, 210, 135, 126, 236, 47, 99, 185,
		49, 189, 71, 65, 122, 129, 165, 56, 50, 122,
		249, 39, 218, 62
	};

	private static bool Compare(byte[] array1, byte[] array2)
	{
		bool flag = array1.Length == array2.Length;
		if (flag)
		{
			for (int i = 0; i < array1.Length; i++)
			{
				if (array1[i] != array2[i])
				{
					return false;
				}
			}
		}
		return flag;
	}

	public static byte[] I2OSP(byte[] x, int size)
	{
		byte[] array = new byte[size];
		Buffer.BlockCopy(x, 0, array, array.Length - x.Length, x.Length);
		return array;
	}

	public static byte[] OS2IP(byte[] x)
	{
		int num = 0;
		while (x[num++] == 0 && num < x.Length)
		{
		}
		num--;
		if (num > 0)
		{
			byte[] array = new byte[x.Length - num];
			Buffer.BlockCopy(x, num, array, 0, array.Length);
			return array;
		}
		return x;
	}

	public static byte[] RSAVP1(RSA rsa, byte[] s)
	{
		return rsa.EncryptValue(s);
	}

	public static bool Verify_v15(RSA rsa, HashAlgorithm hash, byte[] hashValue, byte[] signature)
	{
		return Verify_v15(rsa, hash, hashValue, signature, tryNonStandardEncoding: false);
	}

	internal static bool Verify_v15(RSA rsa, string hashName, byte[] hashValue, byte[] signature)
	{
		using HashAlgorithm hash = CreateFromName(hashName);
		return Verify_v15(rsa, hash, hashValue, signature, tryNonStandardEncoding: false);
	}

	public static bool Verify_v15(RSA rsa, HashAlgorithm hash, byte[] hashValue, byte[] signature, bool tryNonStandardEncoding)
	{
		int num = rsa.KeySize >> 3;
		byte[] s = OS2IP(signature);
		byte[] array = I2OSP(RSAVP1(rsa, s), num);
		bool flag = Compare(Encode_v15(hash, hashValue, num), array);
		if (flag || !tryNonStandardEncoding)
		{
			return flag;
		}
		if (array[0] != 0 || array[1] != 1)
		{
			return false;
		}
		int i;
		for (i = 2; i < array.Length - hashValue.Length - 1; i++)
		{
			if (array[i] != byte.MaxValue)
			{
				return false;
			}
		}
		if (array[i++] != 0)
		{
			return false;
		}
		byte[] array2 = new byte[hashValue.Length];
		Buffer.BlockCopy(array, i, array2, 0, array2.Length);
		return Compare(array2, hashValue);
	}

	public static byte[] Encode_v15(HashAlgorithm hash, byte[] hashValue, int emLength)
	{
		if (hashValue.Length != hash.HashSize >> 3)
		{
			throw new CryptographicException("bad hash length for " + hash.ToString());
		}
		byte[] array = null;
		string text = CryptoConfig.MapNameToOID(hash.ToString());
		if (text != null)
		{
			ASN1 aSN = new ASN1(48);
			aSN.Add(new ASN1(CryptoConfig.EncodeOID(text)));
			aSN.Add(new ASN1(5));
			ASN1 asn = new ASN1(4, hashValue);
			ASN1 aSN2 = new ASN1(48);
			aSN2.Add(aSN);
			aSN2.Add(asn);
			array = aSN2.GetBytes();
		}
		else
		{
			array = hashValue;
		}
		Buffer.BlockCopy(hashValue, 0, array, array.Length - hashValue.Length, hashValue.Length);
		int num = System.Math.Max(8, emLength - array.Length - 3);
		byte[] array2 = new byte[num + array.Length + 3];
		array2[1] = 1;
		for (int i = 2; i < num + 2; i++)
		{
			array2[i] = byte.MaxValue;
		}
		Buffer.BlockCopy(array, 0, array2, num + 3, array.Length);
		return array2;
	}

	internal static HashAlgorithm CreateFromName(string name)
	{
		switch (name)
		{
		case "MD2":
			return MD2.Create();
		case "MD4":
			return MD4.Create();
		case "MD5":
			return MD5.Create();
		case "SHA1":
			return SHA1.Create();
		case "SHA256":
			return SHA256.Create();
		case "SHA384":
			return SHA384.Create();
		case "SHA512":
			return SHA512.Create();
		case "RIPEMD160":
			return RIPEMD160.Create();
		default:
			try
			{
				return (HashAlgorithm)Activator.CreateInstance(Type.GetType(name));
			}
			catch
			{
				throw new CryptographicException("Unsupported hash algorithm: " + name);
			}
		}
	}
}
