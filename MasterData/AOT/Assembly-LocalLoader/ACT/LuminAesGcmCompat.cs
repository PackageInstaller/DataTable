using System;
using System.Security.Cryptography;

namespace ACT;

internal static class LuminAesGcmCompat
{
	public const int NonceSize = 12;

	public const int TagSize = 16;

	public static void Encrypt(byte[] key, ReadOnlySpan<byte> nonce, ReadOnlySpan<byte> plaintext, Span<byte> ciphertext, Span<byte> tag)
	{
		if (nonce.Length != 12)
		{
			throw new ArgumentException("Nonce must be 12 bytes.", "nonce");
		}
		if (tag.Length != 16)
		{
			throw new ArgumentException("Tag must be 16 bytes.", "tag");
		}
		if (ciphertext.Length != plaintext.Length)
		{
			throw new ArgumentException("Ciphertext length must match plaintext length.", "ciphertext");
		}
		using Aes aes = Aes.Create();
		aes.Mode = CipherMode.ECB;
		aes.Padding = PaddingMode.None;
		aes.Key = key;
		using ICryptoTransform cryptoTransform = aes.CreateEncryptor();
		byte[] array = new byte[16];
		cryptoTransform.TransformBlock(new byte[16], 0, 16, array, 0);
		byte[] array2 = new byte[16];
		nonce.CopyTo(array2);
		array2[15] = 1;
		byte[] array3 = new byte[16];
		cryptoTransform.TransformBlock(array2, 0, 16, array3, 0);
		byte[] array4 = (byte[])array2.Clone();
		Inc32(array4);
		byte[] array5 = new byte[16];
		int num = plaintext.Length / 16;
		int num2 = plaintext.Length % 16;
		for (int i = 0; i < num; i++)
		{
			cryptoTransform.TransformBlock(array4, 0, 16, array5, 0);
			int num3 = i * 16;
			for (int j = 0; j < 16; j++)
			{
				ciphertext[num3 + j] = (byte)(plaintext[num3 + j] ^ array5[j]);
			}
			Inc32(array4);
		}
		if (num2 > 0)
		{
			cryptoTransform.TransformBlock(array4, 0, 16, array5, 0);
			int num4 = num * 16;
			for (int k = 0; k < num2; k++)
			{
				ciphertext[num4 + k] = (byte)(plaintext[num4 + k] ^ array5[k]);
			}
		}
		Span<byte> span = ciphertext;
		byte[] array6 = ComputeGHash(array, span.Slice(0, plaintext.Length));
		for (int l = 0; l < 16; l++)
		{
			tag[l] = (byte)(array6[l] ^ array3[l]);
		}
	}

	public static void Decrypt(byte[] key, ReadOnlySpan<byte> nonce, ReadOnlySpan<byte> ciphertext, ReadOnlySpan<byte> tag, Span<byte> plaintext)
	{
		if (nonce.Length != 12)
		{
			throw new ArgumentException("Nonce must be 12 bytes.", "nonce");
		}
		if (tag.Length != 16)
		{
			throw new ArgumentException("Tag must be 16 bytes.", "tag");
		}
		if (plaintext.Length != ciphertext.Length)
		{
			throw new ArgumentException("Plaintext length must match ciphertext length.", "plaintext");
		}
		using Aes aes = Aes.Create();
		aes.Mode = CipherMode.ECB;
		aes.Padding = PaddingMode.None;
		aes.Key = key;
		using ICryptoTransform cryptoTransform = aes.CreateEncryptor();
		byte[] array = new byte[16];
		cryptoTransform.TransformBlock(new byte[16], 0, 16, array, 0);
		byte[] array2 = new byte[16];
		nonce.CopyTo(array2);
		array2[15] = 1;
		byte[] array3 = new byte[16];
		cryptoTransform.TransformBlock(array2, 0, 16, array3, 0);
		byte[] array4 = new byte[16];
		byte[] array5 = ComputeGHash(array, ciphertext);
		for (int i = 0; i < 16; i++)
		{
			array4[i] = (byte)(array5[i] ^ array3[i]);
		}
		if (!FixedTimeEquals(array4, tag))
		{
			throw new CryptographicException("The computed authentication tag did not match the input authentication tag.");
		}
		byte[] array6 = (byte[])array2.Clone();
		Inc32(array6);
		byte[] array7 = new byte[16];
		int num = ciphertext.Length / 16;
		int num2 = ciphertext.Length % 16;
		for (int j = 0; j < num; j++)
		{
			cryptoTransform.TransformBlock(array6, 0, 16, array7, 0);
			int num3 = j * 16;
			for (int k = 0; k < 16; k++)
			{
				plaintext[num3 + k] = (byte)(ciphertext[num3 + k] ^ array7[k]);
			}
			Inc32(array6);
		}
		if (num2 > 0)
		{
			cryptoTransform.TransformBlock(array6, 0, 16, array7, 0);
			int num4 = num * 16;
			for (int l = 0; l < num2; l++)
			{
				plaintext[num4 + l] = (byte)(ciphertext[num4 + l] ^ array7[l]);
			}
		}
	}

	private static byte[] ComputeGHash(byte[] h, ReadOnlySpan<byte> ciphertext)
	{
		byte[] array = new byte[16];
		int num = (ciphertext.Length + 15) / 16;
		for (int i = 0; i < num; i++)
		{
			byte[] array2 = new byte[16];
			int num2 = i * 16;
			int length = Math.Min(16, ciphertext.Length - num2);
			ciphertext.Slice(num2, length).CopyTo(array2);
			XorBlock(array, array2);
			array = GfMultiply(array, h);
		}
		byte[] array3 = new byte[16];
		ulong value = (ulong)ciphertext.Length * 8uL;
		WriteUInt64BigEndian(array3, 8, value);
		XorBlock(array, array3);
		return GfMultiply(array, h);
	}

	private static byte[] GfMultiply(byte[] x, byte[] y)
	{
		byte[] array = new byte[16];
		byte[] array2 = (byte[])y.Clone();
		for (int i = 0; i < 128; i++)
		{
			if ((x[i / 8] & (1 << 7 - i % 8)) != 0)
			{
				XorBlock(array, array2);
			}
			bool flag = (array2[15] & 1) != 0;
			ShiftRightOneBit(array2);
			if (flag)
			{
				array2[0] ^= 225;
			}
		}
		return array;
	}

	private static void ShiftRightOneBit(byte[] block)
	{
		byte b = 0;
		for (int i = 0; i < block.Length; i++)
		{
			byte b2 = (byte)(block[i] & 1);
			block[i] = (byte)((block[i] >> 1) | (b << 7));
			b = b2;
		}
	}

	private static void XorBlock(byte[] target, byte[] source)
	{
		for (int i = 0; i < 16; i++)
		{
			target[i] ^= source[i];
		}
	}

	private static void Inc32(byte[] counter)
	{
		int num = 15;
		while (num >= 12)
		{
			counter[num]++;
			if (counter[num] == 0)
			{
				num--;
				continue;
			}
			break;
		}
	}

	private static void WriteUInt64BigEndian(byte[] buffer, int offset, ulong value)
	{
		for (int num = 7; num >= 0; num--)
		{
			buffer[offset + num] = (byte)(value & 0xFF);
			value >>= 8;
		}
	}

	private static bool FixedTimeEquals(ReadOnlySpan<byte> left, ReadOnlySpan<byte> right)
	{
		if (left.Length != right.Length)
		{
			return false;
		}
		int num = 0;
		for (int i = 0; i < left.Length; i++)
		{
			num |= left[i] ^ right[i];
		}
		return num == 0;
	}
}
