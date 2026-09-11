namespace FixedPoint;

public sealed class TSMath
{
	public static FP Pi = FP.Pi;

	public static FP PiOver2 = FP.PiOver2;

	public static FP Epsilon = FP.Epsilon;

	public static FP Deg2Rad = FP.Deg2Rad;

	public static FP Rad2Deg = FP.Rad2Deg;

	public static FP Sqrt(FP number)
	{
		return FP.Sqrt(number);
	}

	public static FP Max(FP val1, FP val2)
	{
		if (!(val1 > val2))
		{
			return val2;
		}
		return val1;
	}

	public static FP Min(FP val1, FP val2)
	{
		if (!(val1 < val2))
		{
			return val2;
		}
		return val1;
	}

	public static FP Max(FP val1, FP val2, FP val3)
	{
		FP fP = ((val1 > val2) ? val1 : val2);
		if (!(fP > val3))
		{
			return val3;
		}
		return fP;
	}

	public static FP Clamp(FP value, FP min, FP max)
	{
		value = ((value > max) ? max : value);
		value = ((value < min) ? min : value);
		return value;
	}

	public static FP Clamp01(FP value)
	{
		return Clamp(value, 0, 1);
	}

	public static void Absolute(ref TSMatrix matrix, out TSMatrix result)
	{
		result.M11 = FP.Abs(matrix.M11);
		result.M12 = FP.Abs(matrix.M12);
		result.M13 = FP.Abs(matrix.M13);
		result.M21 = FP.Abs(matrix.M21);
		result.M22 = FP.Abs(matrix.M22);
		result.M23 = FP.Abs(matrix.M23);
		result.M31 = FP.Abs(matrix.M31);
		result.M32 = FP.Abs(matrix.M32);
		result.M33 = FP.Abs(matrix.M33);
	}

	public static FP Sin(FP value)
	{
		return FP.Sin(value);
	}

	public static FP Cos(FP value)
	{
		return FP.Cos(value);
	}

	public static FP Tan(FP value)
	{
		return FP.Tan(value);
	}

	public static FP Asin(FP value)
	{
		return FP.Asin(value);
	}

	public static FP Acos(FP value)
	{
		return FP.Acos(value);
	}

	public static FP Atan(FP value)
	{
		return FP.Atan(value);
	}

	public static FP Atan2(FP y, FP x)
	{
		return FP.Atan2(y, x);
	}

	public static FP Floor(FP value)
	{
		return FP.Floor(value);
	}

	public static FP Ceiling(FP value)
	{
		return value;
	}

	public static FP Round(FP value)
	{
		return FP.Round(value);
	}

	public static int Sign(FP value)
	{
		return FP.Sign(value);
	}

	public static FP Abs(FP value)
	{
		return FP.Abs(value);
	}

	public static FP Barycentric(FP value1, FP value2, FP value3, FP amount1, FP amount2)
	{
		return value1 + (value2 - value1) * amount1 + (value3 - value1) * amount2;
	}

	public static FP CatmullRom(FP value1, FP value2, FP value3, FP value4, FP amount)
	{
		FP fP = amount * amount;
		FP fP2 = fP * amount;
		return 0.5 * (2.0 * value2 + (value3 - value1) * amount + (2.0 * value1 - 5.0 * value2 + 4.0 * value3 - value4) * fP + (3.0 * value2 - value1 - 3.0 * value3 + value4) * fP2);
	}

	public static FP Distance(FP value1, FP value2)
	{
		return FP.Abs(value1 - value2);
	}

	public static FP Sqr(FP value)
	{
		return value * value;
	}

	public static FP Exp(FP power)
	{
		return 0;
	}

	public static FP Hermite(FP value1, FP tangent1, FP value2, FP tangent2, FP amount)
	{
		FP fP = amount * amount * amount;
		FP fP2 = amount * amount;
		if (amount == 0f)
		{
			return value1;
		}
		if (amount == 1f)
		{
			return value2;
		}
		return (2 * value1 - 2 * value2 + tangent2 + tangent1) * fP + (3 * value2 - 3 * value1 - 2 * tangent1 - tangent2) * fP2 + tangent1 * amount + value1;
	}

	public static FP Lerp(FP value1, FP value2, FP amount)
	{
		return value1 + (value2 - value1) * amount;
	}

	public static FP SmoothStep(FP value1, FP value2, FP amount)
	{
		FP amount2 = Clamp(amount, 0f, 1f);
		return Hermite(value1, 0f, value2, 0f, amount2);
	}
}
