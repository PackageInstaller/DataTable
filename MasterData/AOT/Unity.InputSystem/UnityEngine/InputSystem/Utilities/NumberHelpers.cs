using System;
using System.Runtime.CompilerServices;

namespace UnityEngine.InputSystem.Utilities;

internal static class NumberHelpers
{
	[MethodImpl((MethodImplOptions)256)]
	public static int AlignToMultipleOf(this int number, int alignment)
	{
		int num = number % alignment;
		if (num == 0)
		{
			return number;
		}
		return number + alignment - num;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static long AlignToMultipleOf(this long number, long alignment)
	{
		long num = number % alignment;
		if (num == 0L)
		{
			return number;
		}
		return number + alignment - num;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static uint AlignToMultipleOf(this uint number, uint alignment)
	{
		uint num = number % alignment;
		if (num == 0)
		{
			return number;
		}
		return number + alignment - num;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool Approximately(double a, double b)
	{
		return Math.Abs(b - a) < Math.Max(1E-06 * Math.Max(Math.Abs(a), Math.Abs(b)), 4E-323);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float IntToNormalizedFloat(int value, int minValue, int maxValue)
	{
		if (value <= minValue)
		{
			return 0f;
		}
		if (value >= maxValue)
		{
			return 1f;
		}
		return (float)(((double)value - (double)minValue) / ((double)maxValue - (double)minValue));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int NormalizedFloatToInt(float value, int intMinValue, int intMaxValue)
	{
		if (value <= 0f)
		{
			return intMinValue;
		}
		if (value >= 1f)
		{
			return intMaxValue;
		}
		return (int)((double)value * ((double)intMaxValue - (double)intMinValue) + (double)intMinValue);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float UIntToNormalizedFloat(uint value, uint minValue, uint maxValue)
	{
		if (value <= minValue)
		{
			return 0f;
		}
		if (value >= maxValue)
		{
			return 1f;
		}
		return (float)(((double)value - (double)minValue) / ((double)maxValue - (double)minValue));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static uint NormalizedFloatToUInt(float value, uint uintMinValue, uint uintMaxValue)
	{
		if (value <= 0f)
		{
			return uintMinValue;
		}
		if (value >= 1f)
		{
			return uintMaxValue;
		}
		return (uint)((double)value * ((double)uintMaxValue - (double)uintMinValue) + (double)uintMinValue);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static uint RemapUIntBitsToNormalizeFloatToUIntBits(uint value, uint inBitSize, uint outBitSize)
	{
		uint maxValue = (uint)((1L << (int)inBitSize) - 1);
		uint uintMaxValue = (uint)((1L << (int)outBitSize) - 1);
		return NormalizedFloatToUInt(UIntToNormalizedFloat(value, 0u, maxValue), 0u, uintMaxValue);
	}
}
