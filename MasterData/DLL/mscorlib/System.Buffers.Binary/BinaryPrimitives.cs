using System.Runtime.CompilerServices;

namespace System.Buffers.Binary;

public static class BinaryPrimitives
{
	[MethodImpl((MethodImplOptions)256)]
	public static short ReverseEndianness(short value)
	{
		return (short)(((value & 0xFF) << 8) | ((value & 0xFF00) >> 8));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int ReverseEndianness(int value)
	{
		return (int)ReverseEndianness((uint)value);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static long ReverseEndianness(long value)
	{
		return (long)ReverseEndianness((ulong)value);
	}

	[MethodImpl((MethodImplOptions)256)]
	[CLSCompliant(false)]
	public static ushort ReverseEndianness(ushort value)
	{
		return (ushort)((value >> 8) + (value << 8));
	}

	[MethodImpl((MethodImplOptions)256)]
	[CLSCompliant(false)]
	public static uint ReverseEndianness(uint value)
	{
		uint num = value & 0xFF00FF;
		uint num2 = value & 0xFF00FF00u;
		return ((num >> 8) | (num << 24)) + ((num2 << 8) | (num2 >> 24));
	}

	[MethodImpl((MethodImplOptions)256)]
	[CLSCompliant(false)]
	public static ulong ReverseEndianness(ulong value)
	{
		return ((ulong)ReverseEndianness((uint)value) << 32) + ReverseEndianness((uint)(value >> 32));
	}
}
