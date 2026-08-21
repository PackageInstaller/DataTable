using System;

namespace Spine;

public static class MathUtils
{
	public const float PI = MathF.PI;

	public const float PI2 = MathF.PI * 2f;

	public const float InvPI2 = 1f / (2f * MathF.PI);

	public const float RadDeg = 180f / MathF.PI;

	public const float DegRad = MathF.PI / 180f;

	private static Random random = new Random();

	public static float Sin(float radians)
	{
		return (float)Math.Sin(radians);
	}

	public static float Cos(float radians)
	{
		return (float)Math.Cos(radians);
	}

	public static float SinDeg(float degrees)
	{
		return (float)Math.Sin(degrees * (MathF.PI / 180f));
	}

	public static float CosDeg(float degrees)
	{
		return (float)Math.Cos(degrees * (MathF.PI / 180f));
	}

	public static float Atan2Deg(float y, float x)
	{
		return (float)Math.Atan2(y, x) * (180f / MathF.PI);
	}

	public static float Atan2(float y, float x)
	{
		return (float)Math.Atan2(y, x);
	}

	public static float Clamp(float value, float min, float max)
	{
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

	public static float RandomTriangle(float min, float max)
	{
		return RandomTriangle(min, max, (min + max) * 0.5f);
	}

	public static float RandomTriangle(float min, float max, float mode)
	{
		float num = (float)random.NextDouble();
		float num2 = max - min;
		if (num <= (mode - min) / num2)
		{
			return min + (float)Math.Sqrt(num * num2 * (mode - min));
		}
		return max - (float)Math.Sqrt((1f - num) * num2 * (max - mode));
	}
}
