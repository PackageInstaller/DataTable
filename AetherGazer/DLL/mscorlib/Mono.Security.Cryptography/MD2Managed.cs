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
		180, 199, 115, 180, 198, 81, 151, 198, 232, 35,
		203, 232, 221, 124, 161, 221, 116, 156, 232, 116,
		31, 33, 62, 31, 75, 221, 150, 75, 189, 220,
		97, 189, 139, 134, 13, 139, 138, 133, 15, 138,
		112, 144, 224, 112, 62, 66, 124, 62, 181, 196,
		113, 181, 102, 170, 204, 102, 72, 216, 144, 72,
		3, 5, 6, 3, 246, 1, 247, 246, 14, 18,
		28, 14, 97, 163, 194, 97, 53, 95, 106, 53,
		87, 249, 174, 87, 185, 208, 105, 185, 134, 145,
		23, 134, 193, 88, 153, 193, 29, 39, 58, 29,
		158, 185, 39, 158, 225, 56, 217, 225, 248, 19,
		235, 248, 152, 179, 43, 152, 17, 51, 34, 17,
		105, 187, 210, 105, 217, 112, 169, 217, 142, 137,
		7, 142, 148, 167, 51, 148, 155, 182, 45, 155,
		30, 34, 60, 30, 135, 146, 21, 135, 233, 32,
		201, 233, 206, 73, 135, 206, 85, 255, 170, 85,
		40, 120, 80, 40, 223, 122, 165, 223, 140, 143,
		3, 140, 161, 248, 89, 161, 137, 128, 9, 137,
		13, 23, 26, 13, 191, 218, 101, 191, 230, 49,
		215, 230, 66, 198, 132, 66, 104, 184, 208, 104,
		65, 195, 130, 65, 153, 176, 41, 153, 45, 119,
		90, 45, 15, 17, 30, 15, 176, 203, 123, 176,
		84, 252, 168, 84, 187, 214, 109, 187, 22, 58,
		44, 22, 99, 99, 165, 198, 124, 124, 132, 248,
		119, 119, 153, 238, 123, 123, 141, 246, 242, 242,
		13, 255, 107, 107, 189, 214
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
