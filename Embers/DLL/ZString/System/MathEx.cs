using System.Runtime.CompilerServices;

namespace System;

internal static class MathEx
{
	public static uint DivRem(uint a, uint b, out uint result)
	{
		uint num = a / b;
		result = a - num * b;
		return num;
	}

	public static ulong DivRem(ulong a, ulong b, out ulong result)
	{
		ulong num = a / b;
		result = a - num * b;
		return num;
	}

	public static int DivRem(int a, int b, out int result)
	{
		int num = a / b;
		result = a - num * b;
		return num;
	}

	public static long DivRem(long a, long b, out long result)
	{
		long num = a / b;
		result = a - num * b;
		return num;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static byte Clamp(byte value, byte min, byte max)
	{
		if (min > max)
		{
			ThrowMinMaxException(min, max);
		}
		if (value < min)
		{
			return min;
		}
		if (value > max)
		{
			return max;
		}
		return value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static decimal Clamp(decimal value, decimal min, decimal max)
	{
		if (min > max)
		{
			ThrowMinMaxException(min, max);
		}
		if (value < min)
		{
			return min;
		}
		if (value > max)
		{
			return max;
		}
		return value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static double Clamp(double value, double min, double max)
	{
		if (min > max)
		{
			ThrowMinMaxException(min, max);
		}
		if (value < min)
		{
			return min;
		}
		if (value > max)
		{
			return max;
		}
		return value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static short Clamp(short value, short min, short max)
	{
		if (min > max)
		{
			ThrowMinMaxException(min, max);
		}
		if (value < min)
		{
			return min;
		}
		if (value > max)
		{
			return max;
		}
		return value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int Clamp(int value, int min, int max)
	{
		if (min > max)
		{
			ThrowMinMaxException(min, max);
		}
		if (value < min)
		{
			return min;
		}
		if (value > max)
		{
			return max;
		}
		return value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static long Clamp(long value, long min, long max)
	{
		if (min > max)
		{
			ThrowMinMaxException(min, max);
		}
		if (value < min)
		{
			return min;
		}
		if (value > max)
		{
			return max;
		}
		return value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static sbyte Clamp(sbyte value, sbyte min, sbyte max)
	{
		if (min > max)
		{
			ThrowMinMaxException(min, max);
		}
		if (value < min)
		{
			return min;
		}
		if (value > max)
		{
			return max;
		}
		return value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Clamp(float value, float min, float max)
	{
		if (min > max)
		{
			ThrowMinMaxException(min, max);
		}
		if (value < min)
		{
			return min;
		}
		if (value > max)
		{
			return max;
		}
		return value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static ushort Clamp(ushort value, ushort min, ushort max)
	{
		if (min > max)
		{
			ThrowMinMaxException(min, max);
		}
		if (value < min)
		{
			return min;
		}
		if (value > max)
		{
			return max;
		}
		return value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static uint Clamp(uint value, uint min, uint max)
	{
		if (min > max)
		{
			ThrowMinMaxException(min, max);
		}
		if (value < min)
		{
			return min;
		}
		if (value > max)
		{
			return max;
		}
		return value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static ulong Clamp(ulong value, ulong min, ulong max)
	{
		if (min > max)
		{
			ThrowMinMaxException(min, max);
		}
		if (value < min)
		{
			return min;
		}
		if (value > max)
		{
			return max;
		}
		return value;
	}

	private static void ThrowMinMaxException<T>(T min, T max)
	{
		throw new ArgumentException($"Argument_MinMaxValue, min:{min} max:{max}");
	}
}
