using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.Versioning;

namespace System;

public static class Math
{
	public const double E = 2.718281828459045;

	public const double PI = 3.141592653589793;

	private const int maxRoundingDigits = 15;

	private static double doubleRoundLimit = 10000000000000000.0;

	private static double[] roundPower10Double = new double[16]
	{
		1.0, 10.0, 100.0, 1000.0, 10000.0, 100000.0, 1000000.0, 10000000.0, 100000000.0, 1000000000.0,
		10000000000.0, 100000000000.0, 1000000000000.0, 10000000000000.0, 100000000000000.0, 1000000000000000.0
	};

	[MethodImpl((MethodImplOptions)256)]
	public static short Abs(short value)
	{
		if (value < 0)
		{
			value = (short)(-value);
			if (value < 0)
			{
				ThrowAbsOverflow();
			}
		}
		return value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int Abs(int value)
	{
		if (value < 0)
		{
			value = -value;
			if (value < 0)
			{
				ThrowAbsOverflow();
			}
		}
		return value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static long Abs(long value)
	{
		if (value < 0)
		{
			value = -value;
			if (value < 0)
			{
				ThrowAbsOverflow();
			}
		}
		return value;
	}

	[MethodImpl((MethodImplOptions)256)]
	[CLSCompliant(false)]
	public static sbyte Abs(sbyte value)
	{
		if (value < 0)
		{
			value = (sbyte)(-value);
			if (value < 0)
			{
				ThrowAbsOverflow();
			}
		}
		return value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static decimal Abs(decimal value)
	{
		return decimal.Abs(ref value);
	}

	[StackTraceHidden]
	private static void ThrowAbsOverflow()
	{
		throw new OverflowException("Negating the minimum value of a twos complement number is invalid.");
	}

	public static long BigMul(int a, int b)
	{
		return (long)a * (long)b;
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

	internal static uint DivRem(uint a, uint b, out uint result)
	{
		uint num = a / b;
		result = a - num * b;
		return num;
	}

	internal static ulong DivRem(ulong a, ulong b, out ulong result)
	{
		ulong num = a / b;
		result = a - num * b;
		return num;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static decimal Ceiling(decimal d)
	{
		return decimal.Ceiling(d);
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
	[CLSCompliant(false)]
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
	[CLSCompliant(false)]
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
	[CLSCompliant(false)]
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
	[CLSCompliant(false)]
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

	[MethodImpl((MethodImplOptions)256)]
	public static decimal Floor(decimal d)
	{
		return decimal.Floor(d);
	}

	public static double IEEERemainder(double x, double y)
	{
		if (double.IsNaN(x))
		{
			return x;
		}
		if (double.IsNaN(y))
		{
			return y;
		}
		double num = x % y;
		if (double.IsNaN(num))
		{
			return double.NaN;
		}
		if (num == 0.0 && double.IsNegative(x))
		{
			return -0.0;
		}
		double num2 = num - Abs(y) * (double)Sign(x);
		if (Abs(num2) == Abs(num))
		{
			double num3 = x / y;
			if (Abs(Round(num3)) > Abs(num3))
			{
				return num2;
			}
			return num;
		}
		if (Abs(num2) < Abs(num))
		{
			return num2;
		}
		return num;
	}

	public static double Log(double a, double newBase)
	{
		if (double.IsNaN(a))
		{
			return a;
		}
		if (double.IsNaN(newBase))
		{
			return newBase;
		}
		if (newBase == 1.0)
		{
			return double.NaN;
		}
		if (a != 1.0 && (newBase == 0.0 || double.IsPositiveInfinity(newBase)))
		{
			return double.NaN;
		}
		return Log(a) / Log(newBase);
	}

	[NonVersionable]
	public static byte Max(byte val1, byte val2)
	{
		if (val1 < val2)
		{
			return val2;
		}
		return val1;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static decimal Max(decimal val1, decimal val2)
	{
		return decimal.Max(ref val1, ref val2);
	}

	public static double Max(double val1, double val2)
	{
		if (val1 > val2)
		{
			return val1;
		}
		if (double.IsNaN(val1))
		{
			return val1;
		}
		return val2;
	}

	[NonVersionable]
	public static short Max(short val1, short val2)
	{
		if (val1 < val2)
		{
			return val2;
		}
		return val1;
	}

	[NonVersionable]
	public static int Max(int val1, int val2)
	{
		if (val1 < val2)
		{
			return val2;
		}
		return val1;
	}

	[NonVersionable]
	public static long Max(long val1, long val2)
	{
		if (val1 < val2)
		{
			return val2;
		}
		return val1;
	}

	[NonVersionable]
	[CLSCompliant(false)]
	public static sbyte Max(sbyte val1, sbyte val2)
	{
		if (val1 < val2)
		{
			return val2;
		}
		return val1;
	}

	public static float Max(float val1, float val2)
	{
		if (val1 > val2)
		{
			return val1;
		}
		if (float.IsNaN(val1))
		{
			return val1;
		}
		return val2;
	}

	[CLSCompliant(false)]
	[NonVersionable]
	public static ushort Max(ushort val1, ushort val2)
	{
		if (val1 < val2)
		{
			return val2;
		}
		return val1;
	}

	[NonVersionable]
	[CLSCompliant(false)]
	public static uint Max(uint val1, uint val2)
	{
		if (val1 < val2)
		{
			return val2;
		}
		return val1;
	}

	[CLSCompliant(false)]
	[NonVersionable]
	public static ulong Max(ulong val1, ulong val2)
	{
		if (val1 < val2)
		{
			return val2;
		}
		return val1;
	}

	[NonVersionable]
	public static byte Min(byte val1, byte val2)
	{
		if (val1 > val2)
		{
			return val2;
		}
		return val1;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static decimal Min(decimal val1, decimal val2)
	{
		return decimal.Min(ref val1, ref val2);
	}

	public static double Min(double val1, double val2)
	{
		if (val1 < val2)
		{
			return val1;
		}
		if (double.IsNaN(val1))
		{
			return val1;
		}
		return val2;
	}

	[NonVersionable]
	public static short Min(short val1, short val2)
	{
		if (val1 > val2)
		{
			return val2;
		}
		return val1;
	}

	[NonVersionable]
	public static int Min(int val1, int val2)
	{
		if (val1 > val2)
		{
			return val2;
		}
		return val1;
	}

	[NonVersionable]
	public static long Min(long val1, long val2)
	{
		if (val1 > val2)
		{
			return val2;
		}
		return val1;
	}

	[NonVersionable]
	[CLSCompliant(false)]
	public static sbyte Min(sbyte val1, sbyte val2)
	{
		if (val1 > val2)
		{
			return val2;
		}
		return val1;
	}

	public static float Min(float val1, float val2)
	{
		if (val1 < val2)
		{
			return val1;
		}
		if (float.IsNaN(val1))
		{
			return val1;
		}
		return val2;
	}

	[CLSCompliant(false)]
	[NonVersionable]
	public static ushort Min(ushort val1, ushort val2)
	{
		if (val1 > val2)
		{
			return val2;
		}
		return val1;
	}

	[NonVersionable]
	[CLSCompliant(false)]
	public static uint Min(uint val1, uint val2)
	{
		if (val1 > val2)
		{
			return val2;
		}
		return val1;
	}

	[NonVersionable]
	[CLSCompliant(false)]
	public static ulong Min(ulong val1, ulong val2)
	{
		if (val1 > val2)
		{
			return val2;
		}
		return val1;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static decimal Round(decimal d)
	{
		return decimal.Round(d, 0);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static decimal Round(decimal d, int decimals)
	{
		return decimal.Round(d, decimals);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static decimal Round(decimal d, MidpointRounding mode)
	{
		return decimal.Round(d, 0, mode);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static decimal Round(decimal d, int decimals, MidpointRounding mode)
	{
		return decimal.Round(d, decimals, mode);
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Round(double a);

	[MethodImpl((MethodImplOptions)256)]
	public static double Round(double value, int digits)
	{
		return Round(value, digits, MidpointRounding.ToEven);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static double Round(double value, MidpointRounding mode)
	{
		return Round(value, 0, mode);
	}

	public unsafe static double Round(double value, int digits, MidpointRounding mode)
	{
		if (digits < 0 || digits > 15)
		{
			throw new ArgumentOutOfRangeException("digits", "Rounding digits must be between 0 and 15, inclusive.");
		}
		if (mode < MidpointRounding.ToEven || mode > MidpointRounding.AwayFromZero)
		{
			throw new ArgumentException(SR.Format("The value '{0}' is not valid for this usage of the type {1}.", mode, "MidpointRounding"), "mode");
		}
		if (Abs(value) < doubleRoundLimit)
		{
			double num = roundPower10Double[digits];
			value *= num;
			if (mode == MidpointRounding.AwayFromZero)
			{
				double value2 = ModF(value, &value);
				if (Abs(value2) >= 0.5)
				{
					value += (double)Sign(value2);
				}
			}
			else
			{
				value = Round(value);
			}
			value /= num;
		}
		return value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int Sign(decimal value)
	{
		return decimal.Sign(ref value);
	}

	public static int Sign(double value)
	{
		if (value < 0.0)
		{
			return -1;
		}
		if (value > 0.0)
		{
			return 1;
		}
		if (value == 0.0)
		{
			return 0;
		}
		throw new ArithmeticException("Function does not accept floating point Not-a-Number values.");
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int Sign(short value)
	{
		return Sign((int)value);
	}

	public static int Sign(int value)
	{
		return (value >> 31) | (-value >>> 31);
	}

	public static int Sign(long value)
	{
		return (int)((value >> 63) | (-value >>> 63));
	}

	[MethodImpl((MethodImplOptions)256)]
	[CLSCompliant(false)]
	public static int Sign(sbyte value)
	{
		return Sign((int)value);
	}

	public static int Sign(float value)
	{
		if (value < 0f)
		{
			return -1;
		}
		if (value > 0f)
		{
			return 1;
		}
		if (value == 0f)
		{
			return 0;
		}
		throw new ArithmeticException("Function does not accept floating point Not-a-Number values.");
	}

	[MethodImpl((MethodImplOptions)256)]
	public static decimal Truncate(decimal d)
	{
		return decimal.Truncate(d);
	}

	public unsafe static double Truncate(double d)
	{
		ModF(d, &d);
		return d;
	}

	private static double copysign(double x, double y)
	{
		long num = BitConverter.DoubleToInt64Bits(x);
		long num2 = BitConverter.DoubleToInt64Bits(y);
		if ((num ^ num2) >> 63 != 0L)
		{
			return BitConverter.Int64BitsToDouble(num ^ long.MinValue);
		}
		return x;
	}

	private static void ThrowMinMaxException<T>(T min, T max)
	{
		throw new ArgumentException(SR.Format("'{0}' cannot be greater than {1}.", min, max));
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Abs(double value);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Abs(float value);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Acos(double d);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Acosh(double d);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Asin(double d);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Asinh(double d);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Atan(double d);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Atan2(double y, double x);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Atanh(double d);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Cbrt(double d);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Ceiling(double a);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Cos(double d);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Cosh(double value);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Exp(double d);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Floor(double d);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Log(double d);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Log10(double d);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Pow(double x, double y);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Sin(double a);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Sinh(double value);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Sqrt(double d);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Tan(double a);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Tanh(double value);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern double FMod(double x, double y);

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern double ModF(double x, double* intptr);
}
