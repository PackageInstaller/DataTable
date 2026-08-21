using System;

public static class CLZF2
{
	private static readonly uint HLOG = 14u;

	private static readonly uint HSIZE = 16384u;

	private static readonly uint MAX_LIT = 32u;

	private static readonly uint MAX_OFF = 8192u;

	private static readonly uint MAX_REF = 264u;

	private static readonly long[] HashTable = new long[HSIZE];

	public static byte[] Compress(byte[] inputBytes)
	{
		int num = inputBytes.Length * 2;
		byte[] output = new byte[num];
		int num2;
		for (num2 = lzf_compress(inputBytes, ref output); num2 == 0; num2 = lzf_compress(inputBytes, ref output))
		{
			num *= 2;
			output = new byte[num];
		}
		byte[] array = new byte[num2];
		Buffer.BlockCopy(output, 0, array, 0, num2);
		return array;
	}

	public static byte[] Decompress(byte[] inputBytes)
	{
		int num = inputBytes.Length * 2;
		byte[] output = new byte[num];
		int num2;
		for (num2 = lzf_decompress(inputBytes, ref output); num2 == 0; num2 = lzf_decompress(inputBytes, ref output))
		{
			num *= 2;
			output = new byte[num];
		}
		byte[] array = new byte[num2];
		Buffer.BlockCopy(output, 0, array, 0, num2);
		return array;
	}

	private static int lzf_compress(byte[] input, ref byte[] output)
	{
		int num = input.Length;
		int num2 = output.Length;
		Array.Clear(HashTable, 0, (int)HSIZE);
		uint num3 = 0u;
		uint num4 = 0u;
		uint num5 = (uint)((input[num3] << 8) | input[num3 + 1]);
		int num6 = 0;
		while (true)
		{
			if (num3 < num - 2)
			{
				num5 = (num5 << 8) | input[num3 + 2];
				long num7 = ((num5 ^ (num5 << 5)) >> (int)(24 - HLOG - num5 * 5)) & (HSIZE - 1);
				long num8 = HashTable[num7];
				HashTable[num7] = num3;
				long num9;
				if ((num9 = num3 - num8 - 1) < MAX_OFF && num3 + 4 < num && num8 > 0 && input[num8] == input[num3] && input[num8 + 1] == input[num3 + 1] && input[num8 + 2] == input[num3 + 2])
				{
					uint num10 = 2u;
					uint num11 = (uint)(num - (int)num3) - num10;
					num11 = ((num11 > MAX_REF) ? MAX_REF : num11);
					if (num4 + num6 + 1 + 3 >= num2)
					{
						return 0;
					}
					do
					{
						num10++;
					}
					while (num10 < num11 && input[num8 + num10] == input[num3 + num10]);
					if (num6 != 0)
					{
						output[num4++] = (byte)(num6 - 1);
						num6 = -num6;
						do
						{
							output[num4++] = input[num3 + num6];
						}
						while (++num6 != 0);
					}
					num10 -= 2;
					num3++;
					if (num10 < 7)
					{
						output[num4++] = (byte)((num9 >> 8) + (num10 << 5));
					}
					else
					{
						output[num4++] = (byte)((num9 >> 8) + 224);
						output[num4++] = (byte)(num10 - 7);
					}
					output[num4++] = (byte)num9;
					num3 += num10 - 1;
					num5 = (uint)((input[num3] << 8) | input[num3 + 1]);
					num5 = (num5 << 8) | input[num3 + 2];
					HashTable[((num5 ^ (num5 << 5)) >> (int)(24 - HLOG - num5 * 5)) & (HSIZE - 1)] = num3;
					num3++;
					num5 = (num5 << 8) | input[num3 + 2];
					HashTable[((num5 ^ (num5 << 5)) >> (int)(24 - HLOG - num5 * 5)) & (HSIZE - 1)] = num3;
					num3++;
					continue;
				}
			}
			else if (num3 == num)
			{
				break;
			}
			num6++;
			num3++;
			if (num6 == MAX_LIT)
			{
				if (num4 + 1 + MAX_LIT >= num2)
				{
					return 0;
				}
				output[num4++] = (byte)(MAX_LIT - 1);
				num6 = -num6;
				do
				{
					output[num4++] = input[num3 + num6];
				}
				while (++num6 != 0);
			}
		}
		if (num6 != 0)
		{
			if (num4 + num6 + 1 >= num2)
			{
				return 0;
			}
			output[num4++] = (byte)(num6 - 1);
			num6 = -num6;
			do
			{
				output[num4++] = input[num3 + num6];
			}
			while (++num6 != 0);
		}
		return (int)num4;
	}

	private static int lzf_decompress(byte[] input, ref byte[] output)
	{
		int num = input.Length;
		int num2 = output.Length;
		uint num3 = 0u;
		uint num4 = 0u;
		do
		{
			uint num5 = input[num3++];
			if (num5 < 32)
			{
				num5++;
				if (num4 + num5 > num2)
				{
					return 0;
				}
				do
				{
					output[num4++] = input[num3++];
				}
				while (--num5 != 0);
				continue;
			}
			uint num6 = num5 >> 5;
			int num7 = (int)(num4 - ((num5 & 0x1F) << 8) - 1);
			if (num6 == 7)
			{
				num6 += input[num3++];
			}
			num7 -= input[num3++];
			if (num4 + num6 + 2 > num2)
			{
				return 0;
			}
			if (num7 < 0)
			{
				return 0;
			}
			output[num4++] = output[num7++];
			output[num4++] = output[num7++];
			do
			{
				output[num4++] = output[num7++];
			}
			while (--num6 != 0);
		}
		while (num3 < num);
		return (int)num4;
	}
}
