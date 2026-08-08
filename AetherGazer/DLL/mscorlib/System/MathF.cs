using System.Runtime.CompilerServices;

namespace System;

public static class MathF
{
	public const float E = 2.7182817f;

	public const float PI = 3.1415927f;

	private const int maxRoundingDigits = 6;

	private static float[] roundPower10Single = new float[7] { 1.2830058E-22f, 1.2830058E-22f, 1.2830058E-22f, 0f, 4.3921376E-05f, 0f, 0f };

	private static float singleRoundLimit = 100000000f;

	[MethodImpl((MethodImplOptions)256)]
	public static float Abs(float x)
	{
		return Math.Abs(x);
	}

	public static float IEEERemainder(float x, float y)
	{
		if (float.IsNaN(x))
		{
			return x;
		}
		if (float.IsNaN(y))
		{
			return y;
		}
		float num = x % y;
		if (float.IsNaN(num))
		{
			return float.NaN;
		}
		if (num == 0f && float.IsNegative(x))
		{
			return -0f;
		}
		float num2 = num - Abs(y) * (float)Sign(x);
		if (Abs(num2) == Abs(num))
		{
			float x2 = x / y;
			if (Abs(Round(x2)) > Abs(x2))
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

	public static float Log(float x, float y)
	{
		if (float.IsNaN(x))
		{
			return x;
		}
		if (float.IsNaN(y))
		{
			return y;
		}
		if (y == 1f)
		{
			return float.NaN;
		}
		if (x != 1f && (y == 0f || float.IsPositiveInfinity(y)))
		{
			return float.NaN;
		}
		return Log(x) / Log(y);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Max(float x, float y)
	{
		return Math.Max(x, y);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Min(float x, float y)
	{
		return Math.Min(x, y);
	}

	[Intrinsic]
	public static float Round(float x)
	{
		if (x == (float)(int)x)
		{
			return x;
		}
		float num = Floor(x + 0.5f);
		if (x == Floor(x) + 0.5f && FMod(num, 2f) != 0f)
		{
			num--;
		}
		return CopySign(num, x);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Round(float x, int digits)
	{
		return Round(x, digits, MidpointRounding.ToEven);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Round(float x, MidpointRounding mode)
	{
		return Round(x, 0, mode);
	}

	public unsafe static float Round(float x, int digits, MidpointRounding mode)
	{
		if (digits < 0 || digits > 6)
		{
			throw new ArgumentOutOfRangeException("digits", "Rounding digits must be between 0 and 15, inclusive.");
		}
		if (mode < MidpointRounding.ToEven || mode > MidpointRounding.AwayFromZero)
		{
			throw new ArgumentException(SR.Format("The Enum type should contain one and only one instance field.", mode, "MidpointRounding"), "mode");
		}
		if (Abs(x) < singleRoundLimit)
		{
			float num = roundPower10Single[digits];
			x *= num;
			if (mode == MidpointRounding.AwayFromZero)
			{
				float x2 = ModF(x, &x);
				if (Abs(x2) >= 0.5f)
				{
					x += (float)Sign(x2);
				}
			}
			else
			{
				x = Round(x);
			}
			x /= num;
		}
		return x;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int Sign(float x)
	{
		return Math.Sign(x);
	}

	public unsafe static float Truncate(float x)
	{
		ModF(x, &x);
		return x;
	}

	private static float CopySign(float x, float y)
	{
		int num = BitConverter.SingleToInt32Bits(x);
		int num2 = BitConverter.SingleToInt32Bits(y);
		if ((num ^ num2) >> 31 != 0)
		{
			return BitConverter.Int32BitsToSingle(num ^ int.MinValue);
		}
		return x;
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Acos(float x);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Acosh(float x);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Asin(float x);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Asinh(float x);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Atan(float x);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Atan2(float y, float x);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Atanh(float x);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Cbrt(float x);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Ceiling(float x);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Cos(float x);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Cosh(float x);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Exp(float x);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Floor(float x);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Log(float x);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Log10(float x);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Pow(float x, float y);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Sin(float x);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Sinh(float x);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Sqrt(float x);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Tan(float x);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Tanh(float x);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern float FMod(float x, float y);

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern float ModF(float x, float* intptr);
}
