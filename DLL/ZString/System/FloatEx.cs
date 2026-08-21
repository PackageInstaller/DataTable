using System.Runtime.CompilerServices;

namespace System;

internal static class FloatEx
{
	[MethodImpl((MethodImplOptions)256)]
	public static bool IsFinite(double d)
	{
		return (BitConverter.DoubleToInt64Bits(d) & 0x7FFFFFFFFFFFFFFFL) < 9218868437227405312L;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool IsNegative(double d)
	{
		return BitConverter.DoubleToInt64Bits(d) < 0;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool IsFinite(float f)
	{
		return (SingleToInt32Bits(f) & 0x7FFFFFFF) < 2139095040;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool IsNegative(float f)
	{
		return SingleToInt32Bits(f) < 0;
	}

	[MethodImpl((MethodImplOptions)256)]
	public unsafe static int SingleToInt32Bits(float value)
	{
		return *(int*)(&value);
	}
}
