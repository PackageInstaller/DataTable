using System;
using UnityEngine;

namespace Sirenix.Utilities;

public static class MathUtilities
{
	private const float ZERO_TOLERANCE = 1E-06f;

	public static float PointDistanceToLine(Vector3 point, Vector3 a, Vector3 b)
	{
		return Mathf.Abs((b.x - a.x) * (a.y - point.y) - (a.x - point.x) * (b.y - a.y)) / Mathf.Sqrt(Mathf.Pow(b.x - a.x, 2f) + Mathf.Pow(b.y - a.y, 2f));
	}

	public static float Hermite(float start, float end, float t)
	{
		return Mathf.Lerp(start, end, t * t * (3f - 2f * t));
	}

	public static float StackHermite(float start, float end, float t, int count)
	{
		for (int i = 0; i < count; i++)
		{
			t = Hermite(start, end, t);
		}
		return t;
	}

	public static float Fract(float value)
	{
		return value - (float)Math.Truncate(value);
	}

	public static Vector2 Fract(Vector2 value)
	{
		return new Vector3(Fract(value.x), Fract(value.y));
	}

	public static Vector3 Fract(Vector3 value)
	{
		return new Vector3(Fract(value.x), Fract(value.y), Fract(value.z));
	}

	public static float BounceEaseInFastOut(float t)
	{
		return Mathf.Cos(t * t * MathF.PI * 2f) * -0.5f + 0.5f;
	}

	public static float Hermite01(float t)
	{
		return Mathf.Lerp(0f, 1f, t * t * (3f - 2f * t));
	}

	public static float StackHermite01(float t, int count)
	{
		for (int i = 0; i < count; i++)
		{
			t = Hermite01(t);
		}
		return t;
	}

	public static Vector3 LerpUnclamped(Vector3 from, Vector3 to, float amount)
	{
		return from + (to - from) * amount;
	}

	public static Vector2 LerpUnclamped(Vector2 from, Vector2 to, float amount)
	{
		return from + (to - from) * amount;
	}

	public static float Bounce(float value)
	{
		return Mathf.Abs(Mathf.Sin(value % 1f * MathF.PI));
	}

	public static float EaseInElastic(float value, float amplitude = 0.25f, float length = 0.6f)
	{
		value = Mathf.Clamp01(value);
		float num = Mathf.Clamp01(value * 7.5f);
		float num2 = 1f - num * num * (3f - 2f * num);
		float num3 = Mathf.Pow(1f - Mathf.Sin(Mathf.Min(value * (1f - length), 0.5f) * MathF.PI), 2f);
		float num4 = Mathf.Cos(MathF.PI + value * 23f) * amplitude + num2 * (0f - (1f - amplitude));
		return 1f + num4 * num3;
	}

	public static Vector3 Pow(this Vector3 v, float p)
	{
		v.x = Mathf.Pow(v.x, p);
		v.y = Mathf.Pow(v.y, p);
		v.z = Mathf.Pow(v.z, p);
		return v;
	}

	public static Vector3 Abs(this Vector3 v)
	{
		v.x = Mathf.Abs(v.x);
		v.y = Mathf.Abs(v.y);
		v.z = Mathf.Abs(v.z);
		return v;
	}

	public static Vector3 Sign(this Vector3 v)
	{
		return new Vector3(Mathf.Sign(v.x), Mathf.Sign(v.y), Mathf.Sign(v.z));
	}

	public static float EaseOutElastic(float value, float amplitude = 0.25f, float length = 0.6f)
	{
		return 1f - EaseInElastic(1f - value, amplitude, length);
	}

	public static float EaseInOut(float t)
	{
		t = 1f - Mathf.Abs(Mathf.Clamp01(t) * 2f - 1f);
		t = t * t * (3f - 2f * t);
		return t;
	}

	public static Vector3 Clamp(this Vector3 value, Vector3 min, Vector3 max)
	{
		return new Vector3(Mathf.Clamp(value.x, min.x, max.x), Mathf.Clamp(value.y, min.y, max.y), Mathf.Clamp(value.z, min.z, max.z));
	}

	public static Vector2 Clamp(this Vector2 value, Vector2 min, Vector2 max)
	{
		return new Vector2(Mathf.Clamp(value.x, min.x, max.x), Mathf.Clamp(value.y, min.y, max.y));
	}

	public static int ComputeByteArrayHash(byte[] data)
	{
		int num = -2128831035;
		for (int i = 0; i < data.Length; i++)
		{
			num = (num ^ data[i]) * 16777619;
		}
		num += num << 13;
		num ^= num >> 7;
		num += num << 3;
		num ^= num >> 17;
		return num + (num << 5);
	}

	public static Vector3 InterpolatePoints(Vector3[] path, float t)
	{
		t = Mathf.Clamp01(t * (1f - 1f / (float)path.Length));
		int b = path.Length - 1;
		int num = Mathf.FloorToInt(t * (float)path.Length);
		float num2 = t * (float)path.Length - (float)num;
		Vector3 vector = path[Mathf.Max(0, --num)];
		Vector3 vector2 = path[Mathf.Min(num + 1, b)];
		Vector3 vector3 = path[Mathf.Min(num + 2, b)];
		Vector3 vector4 = path[Mathf.Min(num + 3, b)];
		return 0.5f * ((-vector + 3f * vector2 - 3f * vector3 + vector4) * (num2 * num2 * num2) + (2f * vector - 5f * vector2 + 4f * vector3 - vector4) * (num2 * num2) + (-vector + vector3) * num2 + 2f * vector2);
	}

	public static bool LineIntersectsLine(Vector2 a1, Vector2 a2, Vector2 b1, Vector2 b2, out Vector2 intersection)
	{
		intersection = Vector2.zero;
		Vector2 vector = new Vector2((b1.x < b2.x) ? b1.x : b2.x, (b1.y > b2.y) ? b1.y : b2.y);
		Vector2 vector2 = new Vector2((b1.x > b2.x) ? b1.x : b2.x, (b1.y < b2.y) ? b1.y : b2.y);
		if ((a1.x < vector.x && a2.x < vector.x) || (a1.y > vector.y && a2.y > vector.y) || (a1.x > vector2.x && a2.x > vector2.x) || (a1.y < vector2.y && a2.y < vector2.y))
		{
			return false;
		}
		Vector2 vector3 = a2 - a1;
		Vector2 vector4 = b2 - b1;
		float num = vector3.x * vector4.y - vector3.y * vector4.x;
		if (num == 0f)
		{
			return false;
		}
		Vector2 vector5 = b1 - a1;
		float num2 = (vector5.x * vector4.y - vector5.y * vector4.x) / num;
		if (num2 < 0f || num2 > 1f)
		{
			return false;
		}
		float num3 = (vector5.x * vector3.y - vector5.y * vector3.x) / num;
		if (num3 < 0f || num3 > 1f)
		{
			return false;
		}
		intersection = a1 + num2 * vector3;
		return true;
	}

	public static Vector2 InfiniteLineIntersect(Vector2 ps1, Vector2 pe1, Vector2 ps2, Vector2 pe2)
	{
		float num = pe1.y - ps1.y;
		float num2 = ps1.x - pe1.x;
		float num3 = num * ps1.x + num2 * ps1.y;
		float num4 = pe2.y - ps2.y;
		float num5 = ps2.x - pe2.x;
		float num6 = num4 * ps2.x + num5 * ps2.y;
		float num7 = num * num5 - num4 * num2;
		if (num7 == 0f)
		{
			throw new Exception("Lines are parallel");
		}
		return new Vector2((num5 * num3 - num2 * num6) / num7, (num * num6 - num4 * num3) / num7);
	}

	public static float LineDistToPlane(Vector3 planeOrigin, Vector3 planeNormal, Vector3 lineOrigin, Vector3 lineDirectionNormalized)
	{
		return Vector3.Dot(lineDirectionNormalized, planeNormal) * Vector3.Distance(planeOrigin, lineOrigin);
	}

	public static float RayDistToPlane(Ray ray, Plane plane)
	{
		float num = Vector3.Dot(plane.normal, ray.direction);
		if (Mathf.Abs(num) < 1E-06f)
		{
			return 0f;
		}
		float num2 = Vector3.Dot(plane.normal, ray.origin);
		return (0f - plane.distance - num2) / num;
	}

	public static Vector2 RotatePoint(Vector2 point, float degrees)
	{
		float f = degrees * (MathF.PI / 180f);
		float num = Mathf.Cos(f);
		float num2 = Mathf.Sin(f);
		return new Vector2(num * point.x - num2 * point.y, num2 * point.x + num * point.y);
	}

	public static Vector2 RotatePoint(Vector2 point, Vector2 around, float degrees)
	{
		float f = degrees * (MathF.PI / 180f);
		float num = Mathf.Cos(f);
		float num2 = Mathf.Sin(f);
		return new Vector2(num * (point.x - around.x) - num2 * (point.y - around.y) + around.x, num2 * (point.x - around.x) + num * (point.y - around.y) + around.y);
	}

	public static float SmoothStep(float a, float b, float t)
	{
		t = Mathf.Clamp01((t - a) / (b - a));
		return t * t * (3f - 2f * t);
	}

	public static float LinearStep(float a, float b, float t)
	{
		return Mathf.Clamp01((t - a) / (b - a));
	}

	public static double Wrap(double value, double min, double max)
	{
		double num = max - min;
		num = ((num < 0.0) ? (0.0 - num) : num);
		if (value < min)
		{
			return value + num * Math.Ceiling(Math.Abs(value / num));
		}
		if (value >= max)
		{
			return value - num * Math.Floor(Math.Abs(value / num));
		}
		return value;
	}

	public static float Wrap(float value, float min, float max)
	{
		float num = max - min;
		num = (((double)num < 0.0) ? (0f - num) : num);
		if (value < min)
		{
			return value + num * (float)Math.Ceiling(Math.Abs(value / num));
		}
		if (value >= max)
		{
			return value - num * (float)Math.Floor(Math.Abs(value / num));
		}
		return value;
	}

	public static int Wrap(int value, int min, int max)
	{
		int num = max - min;
		num = ((num < 0) ? (-num) : num);
		if (value < min)
		{
			return value + num * (Math.Abs(value / num) + 1);
		}
		if (value >= max)
		{
			return value - num * Math.Abs(value / num);
		}
		return value;
	}

	public static double RoundBasedOnMinimumDifference(double valueToRound, double minDifference)
	{
		if (minDifference == 0.0)
		{
			return DiscardLeastSignificantDecimal(valueToRound);
		}
		return (float)Math.Round(valueToRound, GetNumberOfDecimalsForMinimumDifference(minDifference), MidpointRounding.AwayFromZero);
	}

	public static double DiscardLeastSignificantDecimal(double v)
	{
		int digits = Math.Max(0, (int)(5.0 - Math.Log10(Math.Abs(v))));
		try
		{
			return Math.Round(v, digits);
		}
		catch (ArgumentOutOfRangeException)
		{
			return 0.0;
		}
	}

	public static float ClampWrapAngle(float angle, float min, float max)
	{
		float num = 360f;
		float num2 = min;
		float num3 = max;
		float num4 = angle;
		if (num2 < 0f)
		{
			num2 = num2 % num + num;
		}
		if (num3 < 0f)
		{
			num3 = num3 % num + num;
		}
		if (num4 < 0f)
		{
			num4 = num4 % num + num;
		}
		float num5 = (float)(int)(Math.Abs(min - max) / num) * num;
		num3 += num5;
		num4 += num5;
		if (min > max)
		{
			num3 += num;
		}
		if (num4 < num2)
		{
			num4 = num2;
		}
		if (num4 > num3)
		{
			num4 = num3;
		}
		return num4;
	}

	private static int GetNumberOfDecimalsForMinimumDifference(double minDifference)
	{
		return Mathf.Clamp(-Mathf.FloorToInt(Mathf.Log10(Mathf.Abs((float)minDifference))), 0, 15);
	}
}
