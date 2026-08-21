using System;
using System.Runtime.CompilerServices;
using System.Security.Cryptography;

namespace Mono.Security.Cryptography;

internal sealed class PKCS1
{
	private static byte[] emptySHA1;

	private static byte[] emptySHA256;

	private static byte[] emptySHA384;

	private static byte[] emptySHA512;

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

	private static byte[] xor(byte[] array1, byte[] array2)
	{
		byte[] array3 = new byte[array1.Length];
		for (int i = 0; i < array3.Length; i++)
		{
			array3[i] = (byte)(array1[i] ^ array2[i]);
		}
		return array3;
	}

	private static byte[] GetEmptyHash(HashAlgorithm hash)
	{
		if (hash is SHA1)
		{
			return emptySHA1;
		}
		if (hash is SHA256)
		{
			return emptySHA256;
		}
		if (hash is SHA384)
		{
			return emptySHA384;
		}
		if (hash is SHA512)
		{
			return emptySHA512;
		}
		return hash.ComputeHash((byte[])null);
	}

	public static byte[] I2OSP(int x, int size)
	{
		byte[] bytes = BitConverterLE.GetBytes(x);
		Array.Reverse(bytes, 0, bytes.Length);
		return I2OSP(bytes, size);
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

	public static byte[] RSAEP(RSA rsa, byte[] m)
	{
		return rsa.EncryptValue(m);
	}

	public static byte[] RSADP(RSA rsa, byte[] c)
	{
		return rsa.DecryptValue(c);
	}

	public static byte[] RSAVP1(RSA rsa, byte[] s)
	{
		return rsa.EncryptValue(s);
	}

	public static byte[] Encrypt_OAEP(RSA rsa, HashAlgorithm hash, RandomNumberGenerator rng, byte[] M)
	{
		int num = rsa.KeySize / 8;
		int num2 = hash.HashSize / 8;
		if (M.Length > num - 2 * num2 - 2)
		{
			throw new CryptographicException("message too long");
		}
		byte[] emptyHash = GetEmptyHash(hash);
		int num3 = num - M.Length - 2 * num2 - 2;
		byte[] array = new byte[emptyHash.Length + num3 + 1 + M.Length];
		Buffer.BlockCopy(emptyHash, 0, array, 0, emptyHash.Length);
		array[emptyHash.Length + num3] = 1;
		Buffer.BlockCopy(M, 0, array, array.Length - M.Length, M.Length);
		byte[] array2 = new byte[num2];
		rng.GetBytes(array2);
		byte[] array3 = MGF1(hash, array2, num - num2 - 1);
		byte[] array4 = xor(array, array3);
		byte[] array5 = MGF1(hash, array4, num2);
		byte[] array6 = xor(array2, array5);
		byte[] array7 = new byte[array6.Length + array4.Length + 1];
		Buffer.BlockCopy(array6, 0, array7, 1, array6.Length);
		Buffer.BlockCopy(array4, 0, array7, array6.Length + 1, array4.Length);
		byte[] m = OS2IP(array7);
		return I2OSP(RSAEP(rsa, m), num);
	}

	public static byte[] Decrypt_OAEP(RSA rsa, HashAlgorithm hash, byte[] C)
	{
		int num = rsa.KeySize / 8;
		int num2 = hash.HashSize / 8;
		if (num < 2 * num2 + 2 || C.Length != num)
		{
			throw new CryptographicException("decryption error");
		}
		byte[] c = OS2IP(C);
		byte[] array = I2OSP(RSADP(rsa, c), num);
		byte[] array2 = new byte[num2];
		Buffer.BlockCopy(array, 1, array2, 0, array2.Length);
		byte[] array3 = new byte[num - num2 - 1];
		Buffer.BlockCopy(array, array.Length - array3.Length, array3, 0, array3.Length);
		byte[] array4 = MGF1(hash, array3, num2);
		byte[] mgfSeed = xor(array2, array4);
		byte[] array5 = MGF1(hash, mgfSeed, num - num2 - 1);
		byte[] array6 = xor(array3, array5);
		byte[] emptyHash = GetEmptyHash(hash);
		byte[] array7 = new byte[emptyHash.Length];
		Buffer.BlockCopy(array6, 0, array7, 0, array7.Length);
		bool flag = Compare(emptyHash, array7);
		int i;
		for (i = emptyHash.Length; array6[i] == 0; i++)
		{
		}
		int num3 = array6.Length - i - 1;
		byte[] array8 = new byte[num3];
		Buffer.BlockCopy(array6, i + 1, array8, 0, num3);
		if (array[0] != 0 || !flag || array6[i] != 1)
		{
			return null;
		}
		return array8;
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

	public static byte[] MGF1(HashAlgorithm hash, byte[] mgfSeed, int maskLen)
	{
		if (maskLen < 0)
		{
			throw new OverflowException();
		}
		int num = mgfSeed.Length;
		int num2 = hash.HashSize >> 3;
		int num3 = maskLen / num2;
		if (maskLen % num2 != 0)
		{
			num3++;
		}
		byte[] array = new byte[num3 * num2];
		byte[] array2 = new byte[num + 4];
		int num4 = 0;
		for (int i = 0; i < num3; i++)
		{
			byte[] src = I2OSP(i, 4);
			Buffer.BlockCopy(mgfSeed, 0, array2, 0, num);
			Buffer.BlockCopy(src, 0, array2, num, 4);
			Buffer.BlockCopy(hash.ComputeHash(array2), 0, array, num4, num2);
			num4 += num2;
		}
		byte[] array3 = new byte[maskLen];
		Buffer.BlockCopy(array, 0, array3, 0, maskLen);
		return array3;
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

	static PKCS1()
	{
		//IL_0052: Field data (rva=0x490) could not be found in any section!
		//IL_0052: Field data (rva=0x490) could not be found in any section!
		emptySHA1 = new byte[20]
		{
			55, 89, 110, 55, 109, 183, 218, 109, 141, 140,
			1, 141, 213, 100, 177, 213, 78, 210, 156, 78
		};
		emptySHA256 = new byte[32]
		{
			0, 0, 0, 0, 0, 0, 0, 0, 46, 46,
			46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
			43, 21, 0, 0, 6, 6, 6, 6, 6, 6,
			6, 9
		};
		emptySHA384 = new byte[48]
		{
			28, 0, 0, 0, 80, 173, 0, 0, 0, 0,
			0, 0, 2, 0, 0, 0, 15, 0, 0, 0,
			80, 171, 0, 0, 0, 0, 0, 0, 2, 0,
			0, 0, 5, 0, 0, 0, 96, 77, 0, 0,
			4, 0, 0, 0, 1, 0, 0, 0
		};
		byte[] array = new byte[64];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		emptySHA512 = array;
	}
}
