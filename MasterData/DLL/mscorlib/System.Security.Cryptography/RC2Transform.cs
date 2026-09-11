using Mono.Security.Cryptography;

namespace System.Security.Cryptography;

internal class RC2Transform : SymmetricTransform
{
	private ushort R0;

	private ushort R1;

	private ushort R2;

	private ushort R3;

	private ushort[] K;

	private int j;

	private static readonly byte[] pitable = new byte[256]
	{
		0, 5, 0, 0, 0, 154, 0, 0, 0, 7,
		0, 0, 0, 18, 0, 0, 0, 128, 0, 0,
		0, 226, 0, 0, 0, 235, 0, 0, 0, 39,
		0, 0, 0, 178, 0, 0, 0, 117, 0, 0,
		0, 9, 0, 0, 0, 131, 0, 0, 0, 44,
		0, 0, 0, 26, 0, 0, 0, 27, 0, 0,
		0, 110, 0, 0, 0, 90, 0, 0, 0, 160,
		0, 0, 0, 82, 0, 0, 0, 59, 0, 0,
		0, 214, 0, 0, 0, 179, 0, 0, 0, 41,
		0, 0, 0, 227, 0, 0, 0, 47, 0, 0,
		0, 132, 0, 0, 0, 83, 0, 0, 0, 209,
		0, 0, 0, 0, 0, 0, 0, 237, 0, 0,
		0, 32, 0, 0, 0, 252, 0, 0, 0, 177,
		0, 0, 0, 91, 0, 0, 0, 106, 0, 0,
		0, 203, 0, 0, 0, 190, 0, 0, 0, 57,
		0, 0, 0, 74, 0, 0, 0, 76, 0, 0,
		0, 88, 0, 0, 0, 207, 0, 0, 0, 208,
		0, 0, 0, 239, 0, 0, 0, 170, 0, 0,
		0, 251, 0, 0, 0, 67, 0, 0, 0, 77,
		0, 0, 0, 51, 0, 0, 0, 133, 0, 0,
		0, 69, 0, 0, 0, 249, 0, 0, 0, 2,
		0, 0, 0, 127, 0, 0, 0, 80, 0, 0,
		0, 60, 0, 0, 0, 159, 0, 0, 0, 168,
		0, 0, 0, 81, 0, 0, 0, 163, 0, 0,
		0, 64, 0, 0, 0, 143, 0, 0, 0, 146,
		0, 0, 0, 157, 0, 0
	};

	public RC2Transform(RC2 rc2Algo, bool encryption, byte[] key, byte[] iv)
		: base(rc2Algo, encryption, iv)
	{
		int num = rc2Algo.EffectiveKeySize;
		if (key == null)
		{
			key = KeyBuilder.Key(rc2Algo.KeySize >> 3);
		}
		else
		{
			key = (byte[])key.Clone();
			num = Math.Min(num, key.Length << 3);
		}
		int num2 = key.Length;
		if (!KeySizes.IsLegalKeySize(rc2Algo.LegalKeySizes, num2 << 3))
		{
			throw new CryptographicException(Locale.GetText("Key is too small ({0} bytes), it should be between {1} and {2} bytes long.", num2, 5, 16));
		}
		byte[] array = new byte[128];
		int num3 = num + 7 >> 3;
		int num4 = 255 % (2 << 8 + num - (num3 << 3) - 1);
		for (int i = 0; i < num2; i++)
		{
			array[i] = key[i];
		}
		for (int j = num2; j < 128; j++)
		{
			array[j] = pitable[(array[j - 1] + array[j - num2]) & 0xFF];
		}
		array[128 - num3] = pitable[array[128 - num3] & num4];
		for (int num5 = 127 - num3; num5 >= 0; num5--)
		{
			array[num5] = pitable[array[num5 + 1] ^ array[num5 + num3]];
		}
		K = new ushort[64];
		int num6 = 0;
		for (int k = 0; k < 64; k++)
		{
			K[k] = (ushort)(array[num6++] + (array[num6++] << 8));
		}
	}

	protected override void ECB(byte[] input, byte[] output)
	{
		R0 = (ushort)(input[0] | (input[1] << 8));
		R1 = (ushort)(input[2] | (input[3] << 8));
		R2 = (ushort)(input[4] | (input[5] << 8));
		R3 = (ushort)(input[6] | (input[7] << 8));
		if (encrypt)
		{
			j = 0;
			while (j <= 16)
			{
				R0 += (ushort)(K[j++] + (R3 & R2) + (~R3 & R1));
				R0 = (ushort)((R0 << 1) | (R0 >> 15));
				R1 += (ushort)(K[j++] + (R0 & R3) + (~R0 & R2));
				R1 = (ushort)((R1 << 2) | (R1 >> 14));
				R2 += (ushort)(K[j++] + (R1 & R0) + (~R1 & R3));
				R2 = (ushort)((R2 << 3) | (R2 >> 13));
				R3 += (ushort)(K[j++] + (R2 & R1) + (~R2 & R0));
				R3 = (ushort)((R3 << 5) | (R3 >> 11));
			}
			R0 += K[R3 & 0x3F];
			R1 += K[R0 & 0x3F];
			R2 += K[R1 & 0x3F];
			R3 += K[R2 & 0x3F];
			while (j <= 40)
			{
				R0 += (ushort)(K[j++] + (R3 & R2) + (~R3 & R1));
				R0 = (ushort)((R0 << 1) | (R0 >> 15));
				R1 += (ushort)(K[j++] + (R0 & R3) + (~R0 & R2));
				R1 = (ushort)((R1 << 2) | (R1 >> 14));
				R2 += (ushort)(K[j++] + (R1 & R0) + (~R1 & R3));
				R2 = (ushort)((R2 << 3) | (R2 >> 13));
				R3 += (ushort)(K[j++] + (R2 & R1) + (~R2 & R0));
				R3 = (ushort)((R3 << 5) | (R3 >> 11));
			}
			R0 += K[R3 & 0x3F];
			R1 += K[R0 & 0x3F];
			R2 += K[R1 & 0x3F];
			R3 += K[R2 & 0x3F];
			while (j < 64)
			{
				R0 += (ushort)(K[j++] + (R3 & R2) + (~R3 & R1));
				R0 = (ushort)((R0 << 1) | (R0 >> 15));
				R1 += (ushort)(K[j++] + (R0 & R3) + (~R0 & R2));
				R1 = (ushort)((R1 << 2) | (R1 >> 14));
				R2 += (ushort)(K[j++] + (R1 & R0) + (~R1 & R3));
				R2 = (ushort)((R2 << 3) | (R2 >> 13));
				R3 += (ushort)(K[j++] + (R2 & R1) + (~R2 & R0));
				R3 = (ushort)((R3 << 5) | (R3 >> 11));
			}
		}
		else
		{
			j = 63;
			while (j >= 44)
			{
				R3 = (ushort)((R3 >> 5) | (R3 << 11));
				R3 -= (ushort)(K[j--] + (R2 & R1) + (~R2 & R0));
				R2 = (ushort)((R2 >> 3) | (R2 << 13));
				R2 -= (ushort)(K[j--] + (R1 & R0) + (~R1 & R3));
				R1 = (ushort)((R1 >> 2) | (R1 << 14));
				R1 -= (ushort)(K[j--] + (R0 & R3) + (~R0 & R2));
				R0 = (ushort)((R0 >> 1) | (R0 << 15));
				R0 -= (ushort)(K[j--] + (R3 & R2) + (~R3 & R1));
			}
			R3 -= K[R2 & 0x3F];
			R2 -= K[R1 & 0x3F];
			R1 -= K[R0 & 0x3F];
			R0 -= K[R3 & 0x3F];
			while (j >= 20)
			{
				R3 = (ushort)((R3 >> 5) | (R3 << 11));
				R3 -= (ushort)(K[j--] + (R2 & R1) + (~R2 & R0));
				R2 = (ushort)((R2 >> 3) | (R2 << 13));
				R2 -= (ushort)(K[j--] + (R1 & R0) + (~R1 & R3));
				R1 = (ushort)((R1 >> 2) | (R1 << 14));
				R1 -= (ushort)(K[j--] + (R0 & R3) + (~R0 & R2));
				R0 = (ushort)((R0 >> 1) | (R0 << 15));
				R0 -= (ushort)(K[j--] + (R3 & R2) + (~R3 & R1));
			}
			R3 -= K[R2 & 0x3F];
			R2 -= K[R1 & 0x3F];
			R1 -= K[R0 & 0x3F];
			R0 -= K[R3 & 0x3F];
			while (j >= 0)
			{
				R3 = (ushort)((R3 >> 5) | (R3 << 11));
				R3 -= (ushort)(K[j--] + (R2 & R1) + (~R2 & R0));
				R2 = (ushort)((R2 >> 3) | (R2 << 13));
				R2 -= (ushort)(K[j--] + (R1 & R0) + (~R1 & R3));
				R1 = (ushort)((R1 >> 2) | (R1 << 14));
				R1 -= (ushort)(K[j--] + (R0 & R3) + (~R0 & R2));
				R0 = (ushort)((R0 >> 1) | (R0 << 15));
				R0 -= (ushort)(K[j--] + (R3 & R2) + (~R3 & R1));
			}
		}
		output[0] = (byte)R0;
		output[1] = (byte)(R0 >> 8);
		output[2] = (byte)R1;
		output[3] = (byte)(R1 >> 8);
		output[4] = (byte)R2;
		output[5] = (byte)(R2 >> 8);
		output[6] = (byte)R3;
		output[7] = (byte)(R3 >> 8);
	}
}
