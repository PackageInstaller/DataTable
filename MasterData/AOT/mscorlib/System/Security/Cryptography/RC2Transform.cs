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
		217, 120, 249, 196, 25, 221, 181, 237, 40, 233,
		253, 121, 74, 160, 216, 157, 198, 126, 55, 131,
		43, 118, 83, 142, 98, 76, 100, 136, 68, 139,
		251, 162, 23, 154, 89, 245, 135, 179, 79, 19,
		97, 69, 109, 141, 9, 129, 125, 50, 189, 143,
		64, 235, 134, 183, 123, 11, 240, 149, 33, 34,
		92, 107, 78, 130, 84, 214, 101, 147, 206, 96,
		178, 28, 115, 86, 192, 20, 167, 140, 241, 220,
		18, 117, 202, 31, 59, 190, 228, 209, 66, 61,
		212, 48, 163, 60, 182, 38, 111, 191, 14, 218,
		70, 105, 7, 87, 39, 242, 29, 155, 188, 148,
		67, 3, 248, 17, 199, 246, 144, 239, 62, 231,
		6, 195, 213, 47, 200, 102, 30, 215, 8, 232,
		234, 222, 128, 82, 238, 247, 132, 170, 114, 172,
		53, 77, 106, 42, 150, 26, 210, 113, 90, 21,
		73, 116, 75, 159, 208, 94, 4, 24, 164, 236,
		194, 224, 65, 110, 15, 81, 203, 204, 36, 145,
		175, 80, 161, 244, 112, 57, 153, 124, 58, 133,
		35, 184, 180, 122, 252, 2, 54, 91, 37, 85,
		151, 49, 45, 93, 250, 152, 227, 138, 146, 174,
		5, 223, 41, 16, 103, 108, 186, 201, 211, 0,
		230, 207, 225, 158, 168, 44, 99, 22, 1, 63,
		88, 226, 137, 169, 13, 56, 52, 27, 171, 51,
		255, 176, 187, 72, 12, 95, 185, 177, 205, 46,
		197, 243, 219, 71, 229, 165, 156, 119, 10, 166,
		32, 104, 254, 127, 193, 173
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
