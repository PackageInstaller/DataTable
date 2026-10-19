using System;

namespace Mono.Security.Cryptography;

internal class MD2Managed : MD2
{
	private byte[] state;

	private byte[] checksum;

	private byte[] buffer;

	private int count;

	private byte[] x;

	private static readonly byte[] PI_SUBST = new byte[256]
	{
		41, 46, 67, 201, 162, 216, 124, 1, 61, 54,
		84, 161, 236, 240, 6, 19, 98, 167, 5, 243,
		192, 199, 115, 140, 152, 147, 43, 217, 188, 76,
		130, 202, 30, 155, 87, 60, 253, 212, 224, 22,
		103, 66, 111, 24, 138, 23, 229, 18, 190, 78,
		196, 214, 218, 158, 222, 73, 160, 251, 245, 142,
		187, 47, 238, 122, 169, 104, 121, 145, 21, 178,
		7, 63, 148, 194, 16, 137, 11, 34, 95, 33,
		128, 127, 93, 154, 90, 144, 50, 39, 53, 62,
		204, 231, 191, 247, 151, 3, 255, 25, 48, 179,
		72, 165, 181, 209, 215, 94, 146, 42, 172, 86,
		170, 198, 79, 184, 56, 210, 150, 164, 125, 182,
		118, 252, 107, 226, 156, 116, 4, 241, 69, 157,
		112, 89, 100, 113, 135, 32, 134, 91, 207, 101,
		230, 45, 168, 2, 27, 96, 37, 173, 174, 176,
		185, 246, 28, 70, 97, 105, 52, 64, 126, 15,
		85, 71, 163, 35, 221, 81, 175, 58, 195, 92,
		249, 206, 186, 197, 234, 38, 44, 83, 13, 110,
		133, 40, 132, 9, 211, 223, 205, 244, 65, 129,
		77, 82, 106, 220, 55, 200, 108, 193, 171, 250,
		36, 225, 123, 8, 12, 189, 177, 74, 120, 136,
		149, 139, 227, 99, 232, 109, 233, 203, 213, 254,
		59, 0, 29, 57, 242, 239, 183, 14, 102, 88,
		208, 228, 166, 119, 114, 248, 235, 117, 75, 10,
		49, 68, 80, 180, 143, 237, 31, 26, 219, 153,
		141, 51, 159, 17, 131, 20
	};

	private byte[] Padding(int nLength)
	{
		if (nLength > 0)
		{
			byte[] array = new byte[nLength];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = (byte)nLength;
			}
			return array;
		}
		return null;
	}

	public MD2Managed()
	{
		state = new byte[16];
		checksum = new byte[16];
		buffer = new byte[16];
		x = new byte[48];
		Initialize();
	}

	public override void Initialize()
	{
		count = 0;
		Array.Clear(state, 0, 16);
		Array.Clear(checksum, 0, 16);
		Array.Clear(buffer, 0, 16);
		Array.Clear(x, 0, 48);
	}

	protected override void HashCore(byte[] array, int ibStart, int cbSize)
	{
		int num = count;
		count = (num + cbSize) & 0xF;
		int num2 = 16 - num;
		int i;
		if (cbSize >= num2)
		{
			Buffer.BlockCopy(array, ibStart, buffer, num, num2);
			MD2Transform(state, checksum, buffer, 0);
			for (i = num2; i + 15 < cbSize; i += 16)
			{
				MD2Transform(state, checksum, array, ibStart + i);
			}
			num = 0;
		}
		else
		{
			i = 0;
		}
		Buffer.BlockCopy(array, ibStart + i, buffer, num, cbSize - i);
	}

	protected override byte[] HashFinal()
	{
		int num = count;
		int num2 = 16 - num;
		if (num2 > 0)
		{
			HashCore(Padding(num2), 0, num2);
		}
		HashCore(checksum, 0, 16);
		byte[] result = (byte[])state.Clone();
		Initialize();
		return result;
	}

	private void MD2Transform(byte[] state, byte[] checksum, byte[] block, int index)
	{
		Buffer.BlockCopy(state, 0, x, 0, 16);
		Buffer.BlockCopy(block, index, x, 16, 16);
		for (int i = 0; i < 16; i++)
		{
			x[i + 32] = (byte)(state[i] ^ block[index + i]);
		}
		int num = 0;
		for (int j = 0; j < 18; j++)
		{
			for (int k = 0; k < 48; k++)
			{
				num = (x[k] ^= PI_SUBST[num]);
			}
			num = (num + j) & 0xFF;
		}
		Buffer.BlockCopy(x, 0, state, 0, 16);
		num = checksum[15];
		for (int l = 0; l < 16; l++)
		{
			num = (checksum[l] ^= PI_SUBST[block[index + l] ^ num]);
		}
	}
}
