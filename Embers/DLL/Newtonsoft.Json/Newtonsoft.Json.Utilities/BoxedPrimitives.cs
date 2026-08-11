namespace Newtonsoft.Json.Utilities;

internal static class BoxedPrimitives
{
	internal static readonly object BooleanTrue = true;

	internal static readonly object BooleanFalse = false;

	internal static readonly object Int32_M1 = -1;

	internal static readonly object Int32_0 = 0;

	internal static readonly object Int32_1 = 1;

	internal static readonly object Int32_2 = 2;

	internal static readonly object Int32_3 = 3;

	internal static readonly object Int32_4 = 4;

	internal static readonly object Int32_5 = 5;

	internal static readonly object Int32_6 = 6;

	internal static readonly object Int32_7 = 7;

	internal static readonly object Int32_8 = 8;

	internal static readonly object Int64_M1 = -1L;

	internal static readonly object Int64_0 = 0L;

	internal static readonly object Int64_1 = 1L;

	internal static readonly object Int64_2 = 2L;

	internal static readonly object Int64_3 = 3L;

	internal static readonly object Int64_4 = 4L;

	internal static readonly object Int64_5 = 5L;

	internal static readonly object Int64_6 = 6L;

	internal static readonly object Int64_7 = 7L;

	internal static readonly object Int64_8 = 8L;

	private static readonly object DecimalZero = 0m;

	internal static readonly object DoubleNaN = double.NaN;

	internal static readonly object DoublePositiveInfinity = double.PositiveInfinity;

	internal static readonly object DoubleNegativeInfinity = double.NegativeInfinity;

	internal static readonly object DoubleZero = 0.0;

	internal static object Get(bool value)
	{
		if (!value)
		{
			return BooleanFalse;
		}
		return BooleanTrue;
	}

	internal static object Get(int value)
	{
		return value switch
		{
			-1 => Int32_M1, 
			0 => Int32_0, 
			1 => Int32_1, 
			2 => Int32_2, 
			3 => Int32_3, 
			4 => Int32_4, 
			5 => Int32_5, 
			6 => Int32_6, 
			7 => Int32_7, 
			8 => Int32_8, 
			_ => value, 
		};
	}

	internal static object Get(long value)
	{
		long num = value - -1;
		if ((ulong)num <= 9uL)
		{
			switch ((int)num)
			{
			case 0:
				return Int64_M1;
			case 1:
				return Int64_0;
			case 2:
				return Int64_1;
			case 3:
				return Int64_2;
			case 4:
				return Int64_3;
			case 5:
				return Int64_4;
			case 6:
				return Int64_5;
			case 7:
				return Int64_6;
			case 8:
				return Int64_7;
			case 9:
				return Int64_8;
			}
		}
		return value;
	}

	internal static object Get(decimal value)
	{
		if (!(value == 0m))
		{
			return value;
		}
		return DecimalZero;
	}

	internal static object Get(double value)
	{
		if (value == 0.0)
		{
			return DoubleZero;
		}
		if (double.IsInfinity(value))
		{
			if (!double.IsPositiveInfinity(value))
			{
				return DoubleNegativeInfinity;
			}
			return DoublePositiveInfinity;
		}
		if (double.IsNaN(value))
		{
			return DoubleNaN;
		}
		return value;
	}
}
