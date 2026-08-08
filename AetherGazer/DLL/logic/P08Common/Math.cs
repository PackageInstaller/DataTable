using System;
using System.Runtime.CompilerServices;

namespace P08Common;

public static class Math
{
	public const float FLOAT_PRECISION = 1E-07f;

	public const float EPSILON = 1E-06f;

	public const float EPSILON_SQR = 1E-12f;

	public const double DOUBLE_EPSILON = 1E-08;

	public const float PI = 3.141593f;

	public const float DEG_TO_RAD = 0.01745329f;

	private static float[] _FastAngles;

	public static int Square(int i)
	{
		return i * i;
	}

	public static float Square(float f)
	{
		return f * f;
	}

	public static double Square(double d)
	{
		return d * d;
	}

	public static float Sqrt(float f)
	{
		return (float)System.Math.Sqrt(f);
	}

	public static double Sqrt(double d)
	{
		return System.Math.Sqrt(d);
	}

	public static int Abs(int i)
	{
		if (i >= 0)
		{
			return i;
		}
		return -i;
	}

	public static long Abs(long i)
	{
		if (i >= 0)
		{
			return i;
		}
		return -i;
	}

	public static float Abs(float f)
	{
		if (!(f < 0f))
		{
			return f;
		}
		return 0f - f;
	}

	public static double Abs(double d)
	{
		if (!(d < 0.0))
		{
			return d;
		}
		return 0.0 - d;
	}

	public static int Previous(int i, int min, int max)
	{
		if (i == min)
		{
			return max;
		}
		return i - 1;
	}

	public static int Next(int i, int min, int max)
	{
		if (i == max)
		{
			return min;
		}
		return i + 1;
	}

	public static int NextInLoop(int i, int max)
	{
		return (i + 1) % max;
	}

	public static int Min(int a, int b)
	{
		if (a >= b)
		{
			return b;
		}
		return a;
	}

	public static long Min(long a, long b)
	{
		if (b >= a)
		{
			return a;
		}
		return b;
	}

	public static float Min(float a, float b)
	{
		if (!(a < b))
		{
			return b;
		}
		return a;
	}

	public static double Min(double a, double b)
	{
		if (!(a < b))
		{
			return b;
		}
		return a;
	}

	public static float Min(float a, float b, float c)
	{
		return Min(a, Min(b, c));
	}

	public static float Min(float a, float b, float c, float d)
	{
		return Min(Min(a, b), Min(c, d));
	}

	public static double Min(double a, double b, double c, double d)
	{
		return Min(Min(a, b), Min(c, d));
	}

	public static int Max(int a, int b)
	{
		if (a <= b)
		{
			return b;
		}
		return a;
	}

	public static int Max(int a, int b, int c)
	{
		if (a <= b)
		{
			return Max(b, c);
		}
		return Max(a, c);
	}

	public static long Max(long a, long b)
	{
		if (a <= b)
		{
			return b;
		}
		return a;
	}

	public static float Max(float a, float b)
	{
		if (!(a > b))
		{
			return b;
		}
		return a;
	}

	public static float Max(float a, float b, float c)
	{
		if (a > b)
		{
			if (!(a > c))
			{
				return c;
			}
			return a;
		}
		if (!(b > c))
		{
			return c;
		}
		return b;
	}

	public static float Max(float a, float b, float c, float d)
	{
		return Max(Max(a, b), Max(c, d));
	}

	public static double Max(double a, double b)
	{
		if (!(b > a))
		{
			return a;
		}
		return b;
	}

	public static float Cos(float radAngle)
	{
		return (float)System.Math.Cos(radAngle);
	}

	public static float Sin(float radAngle)
	{
		return (float)System.Math.Sin(radAngle);
	}

	public static float Tan(float radAngle)
	{
		return (float)System.Math.Tan(radAngle);
	}

	public static float Acos(float cos)
	{
		return (float)System.Math.Acos(cos);
	}

	public static double Acos(double cos)
	{
		return System.Math.Acos(cos);
	}

	public static float Asin(float sin)
	{
		return (float)System.Math.Asin(sin);
	}

	public static double ASin(double sin)
	{
		return System.Math.Asin(sin);
	}

	public static float FastAngle(float cos)
	{
		if (cos >= 1f)
		{
			return 0f;
		}
		if (cos <= -1f)
		{
			return 3.141593f;
		}
		return _FastAngles[(int)(cos * 180f) + 180];
	}

	public static double FastAngle(double cos)
	{
		if (cos >= 1.0)
		{
			return 0.0;
		}
		if (cos <= -1.0)
		{
			return System.Math.PI;
		}
		return _FastAngles[(int)(cos * 180.0) + 180];
	}

	public static float Clamp01(float f)
	{
		if (f < 0f)
		{
			return 0f;
		}
		if (f > 1f)
		{
			return 1f;
		}
		return f;
	}

	public static float Clamp(float f, float min, float max)
	{
		if (f < min)
		{
			return min;
		}
		if (!(f > max))
		{
			return f;
		}
		return max;
	}

	public static double Clamp(double d, double min, double max)
	{
		if (d < min)
		{
			return min;
		}
		if (!(d > max))
		{
			return d;
		}
		return max;
	}

	public static int Clamp(int i, int min, int max)
	{
		if (i < min)
		{
			return min;
		}
		if (i <= max)
		{
			return i;
		}
		return max;
	}

	public static float FloatPrecision(float reference)
	{
		return reference * 1E-07f;
	}

	static Math()
	{
		//IL_0010: Field data (rva=0x890) could not be found in any section!
		//IL_0010: Field data (rva=0x890) could not be found in any section!
		float[] array = new float[361];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		_FastAngles = array;
	}
}
