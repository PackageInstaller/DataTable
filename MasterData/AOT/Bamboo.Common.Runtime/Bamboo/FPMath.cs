using System;

namespace Bamboo;

public sealed class FPMath
{
	public static readonly FPFloat Pi = FPFloat.Pi;

	public static readonly FPFloat PiOver2 = FPFloat.PiOver2;

	public static readonly FPFloat Epsilon = FPFloat.Epsilon;

	public static readonly FPFloat Deg2Rad = FPFloat.Deg2Rad;

	public static readonly FPFloat Rad2Deg = FPFloat.Rad2Deg;

	public static readonly FPFloat Infinity = FPFloat.MaxValue;

	public static FPFloat Sqrt(FPFloat number)
	{
		return FPFloat.Sqrt(number);
	}

	public static FPFloat Max(FPFloat val1, FPFloat val2)
	{
		if (!(val1 > val2))
		{
			return val2;
		}
		return val1;
	}

	public static FPFloat Min(FPFloat val1, FPFloat val2)
	{
		if (!(val1 < val2))
		{
			return val2;
		}
		return val1;
	}

	public static FPFloat Min(FPFloat val1, FPFloat val2, FPFloat val3)
	{
		FPFloat fPFloat = ((val1 < val2) ? val1 : val2);
		if (!(fPFloat < val3))
		{
			return val3;
		}
		return fPFloat;
	}

	public static FPFloat Max(FPFloat val1, FPFloat val2, FPFloat val3)
	{
		FPFloat fPFloat = ((val1 > val2) ? val1 : val2);
		if (!(fPFloat > val3))
		{
			return val3;
		}
		return fPFloat;
	}

	public static FPFloat Clamp(FPFloat value, FPFloat min, FPFloat max)
	{
		if (value < min)
		{
			value = min;
			return value;
		}
		if (value > max)
		{
			value = max;
		}
		return value;
	}

	public static FPFloat Clamp01(FPFloat value)
	{
		if (value < FPFloat.Zero)
		{
			return FPFloat.Zero;
		}
		if (value > FPFloat.One)
		{
			return FPFloat.One;
		}
		return value;
	}

	public static void Absolute(ref FPMatrix matrix, out FPMatrix result)
	{
		result.M11 = FPFloat.Abs(matrix.M11);
		result.M12 = FPFloat.Abs(matrix.M12);
		result.M13 = FPFloat.Abs(matrix.M13);
		result.M21 = FPFloat.Abs(matrix.M21);
		result.M22 = FPFloat.Abs(matrix.M22);
		result.M23 = FPFloat.Abs(matrix.M23);
		result.M31 = FPFloat.Abs(matrix.M31);
		result.M32 = FPFloat.Abs(matrix.M32);
		result.M33 = FPFloat.Abs(matrix.M33);
	}

	public static FPFloat Sin(FPFloat value)
	{
		return FPFloat.FastSin(value);
	}

	public static FPFloat Cos(FPFloat value)
	{
		return FPFloat.FastCos(value);
	}

	public static FPFloat Tan(FPFloat value)
	{
		return FPFloat.Tan(value);
	}

	public static FPFloat Asin(FPFloat value)
	{
		return FPFloat.Asin(value);
	}

	public static FPFloat Acos(FPFloat value)
	{
		return FPFloat.Acos(value);
	}

	public static FPFloat Atan(FPFloat value)
	{
		return FPFloat.Atan(value);
	}

	public static FPFloat Atan2(FPFloat y, FPFloat x)
	{
		return FPFloat.Atan2(y, x);
	}

	public static FPFloat Floor(FPFloat value)
	{
		return FPFloat.Floor(value);
	}

	public static FPFloat Ceiling(FPFloat value)
	{
		return FPFloat.Ceiling(value);
	}

	public static FPFloat Round(FPFloat value)
	{
		return FPFloat.Round(value);
	}

	public static int Sign(FPFloat value)
	{
		return FPFloat.Sign(value);
	}

	public static FPFloat Abs(FPFloat value)
	{
		return FPFloat.Abs(value);
	}

	public static FPFloat Barycentric(FPFloat value1, FPFloat value2, FPFloat value3, FPFloat amount1, FPFloat amount2)
	{
		return value1 + (value2 - value1) * amount1 + (value3 - value1) * amount2;
	}

	public static FPFloat CatmullRom(FPFloat value1, FPFloat value2, FPFloat value3, FPFloat value4, FPFloat amount)
	{
		FPFloat fPFloat = amount * amount;
		FPFloat fPFloat2 = fPFloat * amount;
		return 0.5 * (2.0 * value2 + (value3 - value1) * amount + (2.0 * value1 - 5.0 * value2 + 4.0 * value3 - value4) * fPFloat + (3.0 * value2 - value1 - 3.0 * value3 + value4) * fPFloat2);
	}

	public static FPFloat Distance(FPFloat value1, FPFloat value2)
	{
		return FPFloat.Abs(value1 - value2);
	}

	public static FPFloat Hermite(FPFloat value1, FPFloat tangent1, FPFloat value2, FPFloat tangent2, FPFloat amount)
	{
		FPFloat fPFloat = amount * amount * amount;
		FPFloat fPFloat2 = amount * amount;
		if (amount == 0f)
		{
			return value1;
		}
		if (amount == 1f)
		{
			return value2;
		}
		return (2 * value1 - 2 * value2 + tangent2 + tangent1) * fPFloat + (3 * value2 - 3 * value1 - 2 * tangent1 - tangent2) * fPFloat2 + tangent1 * amount + value1;
	}

	public static FPFloat Lerp(FPFloat value1, FPFloat value2, FPFloat amount)
	{
		return value1 + (value2 - value1) * Clamp01(amount);
	}

	public static FPFloat InverseLerp(FPFloat value1, FPFloat value2, FPFloat amount)
	{
		if (value1 != value2)
		{
			return Clamp01((amount - value1) / (value2 - value1));
		}
		return FPFloat.Zero;
	}

	public static FPFloat SmoothStep(FPFloat value1, FPFloat value2, FPFloat amount)
	{
		FPFloat amount2 = Clamp(amount, 0f, 1f);
		return Hermite(value1, 0f, value2, 0f, amount2);
	}

	internal static FPFloat Pow2(FPFloat x)
	{
		if (x.RawValue == 0L)
		{
			return FPFloat.One;
		}
		bool flag = x.RawValue < 0;
		if (flag)
		{
			x = -x;
		}
		if (x == FPFloat.One)
		{
			if (!flag)
			{
				return 2;
			}
			return FPFloat.One / 2;
		}
		if (x >= FPFloat.Log2Max)
		{
			if (!flag)
			{
				return FPFloat.MaxValue;
			}
			return FPFloat.One / FPFloat.MaxValue;
		}
		if (x <= FPFloat.Log2Min)
		{
			if (!flag)
			{
				return FPFloat.Zero;
			}
			return FPFloat.MaxValue;
		}
		int num = (int)(long)Floor(x);
		x = FPFloat.FromRaw(x.RawValue & 0xFFFFFFFFu);
		FPFloat one = FPFloat.One;
		FPFloat fPFloat = FPFloat.One;
		int num2 = 1;
		while (fPFloat.RawValue != 0L)
		{
			fPFloat = FPFloat.FastMul(FPFloat.FastMul(x, fPFloat), FPFloat.Ln2) / num2;
			one += fPFloat;
			num2++;
		}
		one = FPFloat.FromRaw(one.RawValue << num);
		if (flag)
		{
			one = FPFloat.One / one;
		}
		return one;
	}

	internal static FPFloat Log2(FPFloat x)
	{
		if (x.RawValue <= 0)
		{
			throw new ArgumentOutOfRangeException("Non-positive value passed to Ln", "x");
		}
		long num = 2147483648L;
		long num2 = 0L;
		long num3 = x.RawValue;
		while (num3 < 4294967296L)
		{
			num3 <<= 1;
			num2 -= 4294967296L;
		}
		while (num3 >= 8589934592L)
		{
			num3 >>= 1;
			num2 += 4294967296L;
		}
		FPFloat fPFloat = FPFloat.FromRaw(num3);
		for (int i = 0; i < 32; i++)
		{
			fPFloat = FPFloat.FastMul(fPFloat, fPFloat);
			if (fPFloat.RawValue >= 8589934592L)
			{
				fPFloat = FPFloat.FromRaw(fPFloat.RawValue >> 1);
				num2 += num;
			}
			num >>= 1;
		}
		return FPFloat.FromRaw(num2);
	}

	public static FPFloat Ln(FPFloat x)
	{
		return FPFloat.FastMul(Log2(x), FPFloat.Ln2);
	}

	public static FPFloat Pow(FPFloat b, FPFloat exp)
	{
		if (b == FPFloat.One)
		{
			return FPFloat.One;
		}
		if (exp.RawValue == 0L)
		{
			return FPFloat.One;
		}
		if (b.RawValue == 0L)
		{
			if (exp.RawValue < 0)
			{
				return FPFloat.MaxValue;
			}
			return FPFloat.Zero;
		}
		FPFloat fPFloat = Log2(b);
		return Pow2(exp * fPFloat);
	}

	public static FPFloat MoveTowards(FPFloat current, FPFloat target, FPFloat maxDelta)
	{
		if (Abs(target - current) <= maxDelta)
		{
			return target;
		}
		return current + Sign(target - current) * maxDelta;
	}

	public static FPFloat Repeat(FPFloat t, FPFloat length)
	{
		return t - Floor(t / length) * length;
	}

	public static FPFloat DeltaAngle(FPFloat current, FPFloat target)
	{
		FPFloat fPFloat = Repeat(target - current, 360f);
		if (fPFloat > 180f)
		{
			fPFloat -= (FPFloat)360f;
		}
		return fPFloat;
	}

	public static FPFloat MoveTowardsAngle(FPFloat current, FPFloat target, float maxDelta)
	{
		target = current + DeltaAngle(current, target);
		return MoveTowards(current, target, maxDelta);
	}

	public static FPFloat SmoothDamp(FPFloat current, FPFloat target, ref FPFloat currentVelocity, FPFloat smoothTime, FPFloat maxSpeed)
	{
		FPFloat eN = FPFloat.EN2;
		return SmoothDamp(current, target, ref currentVelocity, smoothTime, maxSpeed, eN);
	}

	public static FPFloat SmoothDamp(FPFloat current, FPFloat target, ref FPFloat currentVelocity, FPFloat smoothTime)
	{
		FPFloat eN = FPFloat.EN2;
		FPFloat maxSpeed = -FPFloat.MaxValue;
		return SmoothDamp(current, target, ref currentVelocity, smoothTime, maxSpeed, eN);
	}

	public static FPFloat SmoothDamp(FPFloat current, FPFloat target, ref FPFloat currentVelocity, FPFloat smoothTime, FPFloat maxSpeed, FPFloat deltaTime)
	{
		smoothTime = Max(FPFloat.EN4, smoothTime);
		FPFloat fPFloat = 2f / smoothTime;
		FPFloat fPFloat2 = fPFloat * deltaTime;
		FPFloat fPFloat3 = FPFloat.One / (FPFloat.One + fPFloat2 + 0.48f * fPFloat2 * fPFloat2 + 0.235f * fPFloat2 * fPFloat2 * fPFloat2);
		FPFloat value = current - target;
		FPFloat fPFloat4 = target;
		FPFloat fPFloat5 = maxSpeed * smoothTime;
		value = Clamp(value, -fPFloat5, fPFloat5);
		target = current - value;
		FPFloat fPFloat6 = (currentVelocity + fPFloat * value) * deltaTime;
		currentVelocity = (currentVelocity - fPFloat * fPFloat6) * fPFloat3;
		FPFloat fPFloat7 = target + (value + fPFloat6) * fPFloat3;
		if (fPFloat4 - current > FPFloat.Zero == fPFloat7 > fPFloat4)
		{
			fPFloat7 = fPFloat4;
			currentVelocity = (fPFloat7 - fPFloat4) / deltaTime;
		}
		return fPFloat7;
	}

	public static FPFloat Cross2D(FPVector2 u, FPVector2 v)
	{
		return u.X * v.Y - u.Y * v.X;
	}
}
