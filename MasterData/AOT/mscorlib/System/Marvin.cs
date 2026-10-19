using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace System;

internal static class Marvin
{
	public static ulong DefaultSeed { get; } = GenerateSeed();

	[MethodImpl((MethodImplOptions)256)]
	public static int ComputeHash32(ReadOnlySpan<byte> data, ulong seed)
	{
		return ComputeHash32(ref MemoryMarshal.GetReference(data), data.Length, seed);
	}

	public static int ComputeHash32(ref byte data, int count, ulong seed)
	{
		ulong num = (ulong)count;
		uint rp = (uint)seed;
		uint rp2 = (uint)(seed >> 32);
		ulong num2 = 0uL;
		while (num >= 8)
		{
			rp += Unsafe.ReadUnaligned<uint>(ref Unsafe.AddByteOffset(ref data, num2));
			Block(ref rp, ref rp2);
			rp += Unsafe.ReadUnaligned<uint>(ref Unsafe.AddByteOffset(ref data, num2 + 4));
			Block(ref rp, ref rp2);
			num2 += 8;
			num -= 8;
		}
		ulong num3 = num;
		if (num3 <= 7)
		{
			switch ((uint)num3)
			{
			case 4u:
				rp += Unsafe.ReadUnaligned<uint>(ref Unsafe.AddByteOffset(ref data, num2));
				Block(ref rp, ref rp2);
				goto case 0u;
			case 0u:
				rp += 128;
				break;
			case 5u:
				rp += Unsafe.ReadUnaligned<uint>(ref Unsafe.AddByteOffset(ref data, num2));
				num2 += 4;
				Block(ref rp, ref rp2);
				goto case 1u;
			case 1u:
				rp += (uint)(0x8000 | Unsafe.AddByteOffset(ref data, num2));
				break;
			case 6u:
				rp += Unsafe.ReadUnaligned<uint>(ref Unsafe.AddByteOffset(ref data, num2));
				num2 += 4;
				Block(ref rp, ref rp2);
				goto case 2u;
			case 2u:
				rp += (uint)(0x800000 | Unsafe.ReadUnaligned<ushort>(ref Unsafe.AddByteOffset(ref data, num2)));
				break;
			case 7u:
				rp += Unsafe.ReadUnaligned<uint>(ref Unsafe.AddByteOffset(ref data, num2));
				num2 += 4;
				Block(ref rp, ref rp2);
				goto case 3u;
			case 3u:
				rp += (uint)(int.MinValue | (Unsafe.AddByteOffset(ref data, num2 + 2) << 16) | Unsafe.ReadUnaligned<ushort>(ref Unsafe.AddByteOffset(ref data, num2)));
				break;
			}
		}
		Block(ref rp, ref rp2);
		Block(ref rp, ref rp2);
		return (int)(rp2 ^ rp);
	}

	[MethodImpl((MethodImplOptions)256)]
	private static void Block(ref uint rp0, ref uint rp1)
	{
		uint num = rp0;
		uint num2 = rp1;
		num2 ^= num;
		num = _rotl(num, 20);
		num += num2;
		num2 = _rotl(num2, 9);
		num2 ^= num;
		num = _rotl(num, 27);
		num += num2;
		num2 = _rotl(num2, 19);
		rp0 = num;
		rp1 = num2;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static uint _rotl(uint value, int shift)
	{
		return (value << shift) | (value >> 32 - shift);
	}

	private static ulong GenerateSeed()
	{
		return 12874512uL;
	}
}
