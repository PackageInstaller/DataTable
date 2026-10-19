using System;
using System.Globalization;
using System.Security.Cryptography;
using System.Text;

namespace Mono.Security.Cryptography;

internal sealed class CryptoConvert
{
	private static int ToInt32LE(byte[] bytes, int offset)
	{
		return (bytes[offset + 3] << 24) | (bytes[offset + 2] << 16) | (bytes[offset + 1] << 8) | bytes[offset];
	}

	private static uint ToUInt32LE(byte[] bytes, int offset)
	{
		return (uint)((bytes[offset + 3] << 24) | (bytes[offset + 2] << 16) | (bytes[offset + 1] << 8) | bytes[offset]);
	}

	private static byte[] Trim(byte[] array)
	{
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i] != 0)
			{
				byte[] array2 = new byte[array.Length - i];
				Buffer.BlockCopy(array, i, array2, 0, array2.Length);
				return array2;
			}
		}
		return null;
	}

	public static RSA FromCapiPrivateKeyBlob(byte[] blob, int offset)
	{
		RSAParameters parametersFromCapiPrivateKeyBlob = GetParametersFromCapiPrivateKeyBlob(blob, offset);
		RSA rSA = RSA.Create();
		rSA.ImportParameters(parametersFromCapiPrivateKeyBlob);
		return rSA;
	}

	private static RSAParameters GetParametersFromCapiPrivateKeyBlob(byte[] blob, int offset)
	{
		if (blob == null)
		{
			throw new ArgumentNullException("blob");
		}
		if (offset >= blob.Length)
		{
			throw new ArgumentException("blob is too small.");
		}
		RSAParameters result = default;
		try
		{
			if (blob[offset] != 7 || blob[offset + 1] != 2 || blob[offset + 2] != 0 || blob[offset + 3] != 0 || ToUInt32LE(blob, offset + 8) != 843141970)
			{
				throw new CryptographicException("Invalid blob header");
			}
			int num = ToInt32LE(blob, offset + 12);
			byte[] array = new byte[4];
			Buffer.BlockCopy(blob, offset + 16, array, 0, 4);
			Array.Reverse(array);
			result.Exponent = Trim(array);
			int num2 = offset + 20;
			int num3 = num >> 3;
			result.Modulus = new byte[num3];
			Buffer.BlockCopy(blob, num2, result.Modulus, 0, num3);
			Array.Reverse(result.Modulus);
			num2 += num3;
			int num4 = num3 >> 1;
			result.P = new byte[num4];
			Buffer.BlockCopy(blob, num2, result.P, 0, num4);
			Array.Reverse(result.P);
			num2 += num4;
			result.Q = new byte[num4];
			Buffer.BlockCopy(blob, num2, result.Q, 0, num4);
			Array.Reverse(result.Q);
			num2 += num4;
			result.DP = new byte[num4];
			Buffer.BlockCopy(blob, num2, result.DP, 0, num4);
			Array.Reverse(result.DP);
			num2 += num4;
			result.DQ = new byte[num4];
			Buffer.BlockCopy(blob, num2, result.DQ, 0, num4);
			Array.Reverse(result.DQ);
			num2 += num4;
			result.InverseQ = new byte[num4];
			Buffer.BlockCopy(blob, num2, result.InverseQ, 0, num4);
			Array.Reverse(result.InverseQ);
			num2 += num4;
			result.D = new byte[num3];
			if (num2 + num3 + offset <= blob.Length)
			{
				Buffer.BlockCopy(blob, num2, result.D, 0, num3);
				Array.Reverse(result.D);
			}
			return result;
		}
		catch (Exception inner)
		{
			throw new CryptographicException("Invalid blob.", inner);
		}
	}

	public static RSA FromCapiPublicKeyBlob(byte[] blob, int offset)
	{
		RSAParameters parametersFromCapiPublicKeyBlob = GetParametersFromCapiPublicKeyBlob(blob, offset);
		try
		{
			RSA rSA = RSA.Create();
			rSA.ImportParameters(parametersFromCapiPublicKeyBlob);
			return rSA;
		}
		catch (Exception inner)
		{
			throw new CryptographicException("Invalid blob.", inner);
		}
	}

	private static RSAParameters GetParametersFromCapiPublicKeyBlob(byte[] blob, int offset)
	{
		if (blob == null)
		{
			throw new ArgumentNullException("blob");
		}
		if (offset >= blob.Length)
		{
			throw new ArgumentException("blob is too small.");
		}
		try
		{
			if (blob[offset] != 6 || blob[offset + 1] != 2 || blob[offset + 2] != 0 || blob[offset + 3] != 0 || ToUInt32LE(blob, offset + 8) != 826364754)
			{
				throw new CryptographicException("Invalid blob header");
			}
			int num = ToInt32LE(blob, offset + 12);
			RSAParameters result = new RSAParameters
			{
				Exponent = new byte[3]
			};
			result.Exponent[0] = blob[offset + 18];
			result.Exponent[1] = blob[offset + 17];
			result.Exponent[2] = blob[offset + 16];
			int srcOffset = offset + 20;
			int num2 = num >> 3;
			result.Modulus = new byte[num2];
			Buffer.BlockCopy(blob, srcOffset, result.Modulus, 0, num2);
			Array.Reverse(result.Modulus);
			return result;
		}
		catch (Exception inner)
		{
			throw new CryptographicException("Invalid blob.", inner);
		}
	}

	public static RSA FromCapiKeyBlob(byte[] blob)
	{
		return FromCapiKeyBlob(blob, 0);
	}

	public static RSA FromCapiKeyBlob(byte[] blob, int offset)
	{
		if (blob == null)
		{
			throw new ArgumentNullException("blob");
		}
		if (offset >= blob.Length)
		{
			throw new ArgumentException("blob is too small.");
		}
		switch (blob[offset])
		{
		case 0:
			if (blob[offset + 12] == 6)
			{
				return FromCapiPublicKeyBlob(blob, offset + 12);
			}
			break;
		case 6:
			return FromCapiPublicKeyBlob(blob, offset);
		case 7:
			return FromCapiPrivateKeyBlob(blob, offset);
		}
		throw new CryptographicException("Unknown blob format.");
	}

	public static string ToHex(byte[] input)
	{
		if (input == null)
		{
			return null;
		}
		StringBuilder stringBuilder = new StringBuilder(input.Length * 2);
		foreach (byte b in input)
		{
			stringBuilder.Append(b.ToString("X2", CultureInfo.InvariantCulture));
		}
		return stringBuilder.ToString();
	}
}
