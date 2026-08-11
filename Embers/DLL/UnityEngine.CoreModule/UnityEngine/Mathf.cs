using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using Unity.IL2CPP.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Internal;
using UnityEngineInternal;

namespace UnityEngine;

[StructLayout(LayoutKind.Sequential, Size = 1)]
[NativeHeader("Runtime/Math/ColorSpaceConversion.h")]
[NativeHeader("Runtime/Math/PerlinNoise.h")]
[NativeHeader("Runtime/Math/FloatConversion.h")]
[Il2CppEagerStaticClassConstruction]
[NativeHeader("Runtime/Utilities/BitUtility.h")]
public struct Mathf
{
	public const float PI = MathF.PI;

	public const float Infinity = float.PositiveInfinity;

	public const float NegativeInfinity = float.NegativeInfinity;

	public const float Deg2Rad = MathF.PI / 180f;

	public const float Rad2Deg = 57.29578f;

	public static readonly float Epsilon = (MathfInternal.IsFlushToZeroEnabled ? MathfInternal.FloatMinNormal : MathfInternal.FloatMinDenormal);

	[MethodImpl((MethodImplOptions)256)]
	public static float Sin(float f)
	{
		return (float)Math.Sin(f);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Cos(float f)
	{
		return (float)Math.Cos(f);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Tan(float f)
	{
		return (float)Math.Tan(f);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Asin(float f)
	{
		return (float)Math.Asin(f);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Acos(float f)
	{
		return (float)Math.Acos(f);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Atan(float f)
	{
		return (float)Math.Atan(f);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Atan2(float y, float x)
	{
		return (float)Math.Atan2(y, x);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Sqrt(float f)
	{
		return (float)Math.Sqrt(f);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Abs(float f)
	{
		return Math.Abs(f);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int Abs(int value)
	{
		return Math.Abs(value);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Min(float a, float b)
	{
		return (a < b) ? a : b;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Min(params float[] values)
	{
		int num = values.Length;
		if (num == 0)
		{
			return 0f;
		}
		float num2 = values[0];
		for (int i = 1; i < num; i++)
		{
			if (values[i] < num2)
			{
				num2 = values[i];
			}
		}
		return num2;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int Min(int a, int b)
	{
		return (a < b) ? a : b;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int Min(params int[] values)
	{
		int num = values.Length;
		if (num == 0)
		{
			return 0;
		}
		int num2 = values[0];
		for (int i = 1; i < num; i++)
		{
			if (values[i] < num2)
			{
				num2 = values[i];
			}
		}
		return num2;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Max(float a, float b)
	{
		return (a > b) ? a : b;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Max(params float[] values)
	{
		int num = values.Length;
		if (num == 0)
		{
			return 0f;
		}
		float num2 = values[0];
		for (int i = 1; i < num; i++)
		{
			if (values[i] > num2)
			{
				num2 = values[i];
			}
		}
		return num2;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int Max(int a, int b)
	{
		return (a > b) ? a : b;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int Max(params int[] values)
	{
		int num = values.Length;
		if (num == 0)
		{
			return 0;
		}
		int num2 = values[0];
		for (int i = 1; i < num; i++)
		{
			if (values[i] > num2)
			{
				num2 = values[i];
			}
		}
		return num2;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Pow(float f, float p)
	{
		return (float)Math.Pow(f, p);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Exp(float power)
	{
		return (float)Math.Exp(power);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Log(float f, float p)
	{
		return (float)Math.Log(f, p);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Log(float f)
	{
		return (float)Math.Log(f);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Log10(float f)
	{
		return (float)Math.Log10(f);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Ceil(float f)
	{
		return (float)Math.Ceiling(f);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Floor(float f)
	{
		return (float)Math.Floor(f);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Round(float f)
	{
		return (float)Math.Round(f);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int CeilToInt(float f)
	{
		return (int)Math.Ceiling(f);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int FloorToInt(float f)
	{
		return (int)Math.Floor(f);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int RoundToInt(float f)
	{
		return (int)Math.Round(f);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Sign(float f)
	{
		return (f >= 0f) ? 1f : (-1f);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Clamp(float value, float min, float max)
	{
		if (value < min)
		{
			value = min;
		}
		else if (value > max)
		{
			value = max;
		}
		return value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int Clamp(int value, int min, int max)
	{
		if (value < min)
		{
			value = min;
		}
		else if (value > max)
		{
			value = max;
		}
		return value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Clamp01(float value)
	{
		if (value < 0f)
		{
			return 0f;
		}
		if (value > 1f)
		{
			return 1f;
		}
		return value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Lerp(float a, float b, float t)
	{
		return a + (b - a) * Clamp01(t);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float LerpUnclamped(float a, float b, float t)
	{
		return a + (b - a) * t;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float LerpAngle(float a, float b, float t)
	{
		float num = Repeat(b - a, 360f);
		if (num > 180f)
		{
			num -= 360f;
		}
		return a + num * Clamp01(t);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float MoveTowards(float current, float target, float maxDelta)
	{
		if (Abs(target - current) <= maxDelta)
		{
			return target;
		}
		return current + Sign(target - current) * maxDelta;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float MoveTowardsAngle(float current, float target, float maxDelta)
	{
		float num = DeltaAngle(current, target);
		if (0f - maxDelta < num && num < maxDelta)
		{
			return target;
		}
		target = current + num;
		return MoveTowards(current, target, maxDelta);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float SmoothStep(float from, float to, float t)
	{
		t = Clamp01(t);
		t = -2f * t * t * t + 3f * t * t;
		return to * t + from * (1f - t);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Gamma(float value, float absmax, float gamma)
	{
		bool flag = value < 0f;
		float num = Abs(value);
		if (num > absmax)
		{
			return flag ? (0f - num) : num;
		}
		float num2 = Pow(num / absmax, gamma) * absmax;
		return flag ? (0f - num2) : num2;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool Approximately(float a, float b)
	{
		return Abs(b - a) < Max(1E-06f * Max(Abs(a), Abs(b)), Epsilon * 8f);
	}

	[MethodImpl((MethodImplOptions)256)]
	[ExcludeFromDocs]
	public static float SmoothDamp(float current, float target, ref float currentVelocity, float smoothTime, float maxSpeed)
	{
		float deltaTime = Time.deltaTime;
		return SmoothDamp(current, target, ref currentVelocity, smoothTime, maxSpeed, deltaTime);
	}

	[MethodImpl((MethodImplOptions)256)]
	[ExcludeFromDocs]
	public static float SmoothDamp(float current, float target, ref float currentVelocity, float smoothTime)
	{
		float deltaTime = Time.deltaTime;
		float maxSpeed = float.PositiveInfinity;
		return SmoothDamp(current, target, ref currentVelocity, smoothTime, maxSpeed, deltaTime);
	}

	public static float SmoothDamp(float current, float target, ref float currentVelocity, float smoothTime, [DefaultValue("Mathf.Infinity")] float maxSpeed, [DefaultValue("Time.deltaTime")] float deltaTime)
	{
		smoothTime = Max(0.0001f, smoothTime);
		float num = 2f / smoothTime;
		float num2 = num * deltaTime;
		float num3 = 1f / (1f + num2 + 0.48f * num2 * num2 + 0.235f * num2 * num2 * num2);
		float value = current - target;
		float num4 = target;
		float num5 = maxSpeed * smoothTime;
		value = Clamp(value, 0f - num5, num5);
		target = current - value;
		float num6 = (currentVelocity + num * value) * deltaTime;
		currentVelocity = (currentVelocity - num * num6) * num3;
		float num7 = target + (value + num6) * num3;
		if (num4 - current > 0f == num7 > num4)
		{
			num7 = num4;
			currentVelocity = (num7 - num4) / deltaTime;
		}
		return num7;
	}

	[MethodImpl((MethodImplOptions)256)]
	[ExcludeFromDocs]
	public static float SmoothDampAngle(float current, float target, ref float currentVelocity, float smoothTime, float maxSpeed)
	{
		float deltaTime = Time.deltaTime;
		return SmoothDampAngle(current, target, ref currentVelocity, smoothTime, maxSpeed, deltaTime);
	}

	[MethodImpl((MethodImplOptions)256)]
	[ExcludeFromDocs]
	public static float SmoothDampAngle(float current, float target, ref float currentVelocity, float smoothTime)
	{
		float deltaTime = Time.deltaTime;
		float maxSpeed = float.PositiveInfinity;
		return SmoothDampAngle(current, target, ref currentVelocity, smoothTime, maxSpeed, deltaTime);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float SmoothDampAngle(float current, float target, ref float currentVelocity, float smoothTime, [DefaultValue("Mathf.Infinity")] float maxSpeed, [DefaultValue("Time.deltaTime")] float deltaTime)
	{
		target = current + DeltaAngle(current, target);
		return SmoothDamp(current, target, ref currentVelocity, smoothTime, maxSpeed, deltaTime);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Repeat(float t, float length)
	{
		return Clamp(t - Floor(t / length) * length, 0f, length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float PingPong(float t, float length)
	{
		t = Repeat(t, length * 2f);
		return length - Abs(t - length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float InverseLerp(float a, float b, float value)
	{
		if (a != b)
		{
			return Clamp01((value - a) / (b - a));
		}
		return 0f;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float DeltaAngle(float current, float target)
	{
		float num = Repeat(target - current, 360f);
		if (num > 180f)
		{
			num -= 360f;
		}
		return num;
	}

	internal static bool LineIntersection(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, ref Vector2 result)
	{
		float num = p2.x - p1.x;
		float num2 = p2.y - p1.y;
		float num3 = p4.x - p3.x;
		float num4 = p4.y - p3.y;
		float num5 = num * num4 - num2 * num3;
		if (num5 == 0f)
		{
			return false;
		}
		float num6 = p3.x - p1.x;
		float num7 = p3.y - p1.y;
		float num8 = (num6 * num4 - num7 * num3) / num5;
		result.x = p1.x + num8 * num;
		result.y = p1.y + num8 * num2;
		return true;
	}

	internal static bool LineSegmentIntersection(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, ref Vector2 result)
	{
		float num = p2.x - p1.x;
		float num2 = p2.y - p1.y;
		float num3 = p4.x - p3.x;
		float num4 = p4.y - p3.y;
		float num5 = num * num4 - num2 * num3;
		if (num5 == 0f)
		{
			return false;
		}
		float num6 = p3.x - p1.x;
		float num7 = p3.y - p1.y;
		float num8 = (num6 * num4 - num7 * num3) / num5;
		if (num8 < 0f || num8 > 1f)
		{
			return false;
		}
		float num9 = (num6 * num2 - num7 * num) / num5;
		if (num9 < 0f || num9 > 1f)
		{
			return false;
		}
		result.x = p1.x + num8 * num;
		result.y = p1.y + num8 * num2;
		return true;
	}

	internal static long RandomToLong(System.Random r)
	{
		byte[] array = new byte[8];
		r.NextBytes(array);
		return (long)(BitConverter.ToUInt64(array, 0) & 0x7FFFFFFFFFFFFFFFL);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern int ClosestPowerOfTwo(int value);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern bool IsPowerOfTwo(int value);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern int NextPowerOfTwo(int value);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern float GammaToLinearSpace(float value);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern float LinearToGammaSpace(float value);

	[FreeFunction(IsThreadSafe = true)]
	public static Color CorrelatedColorTemperatureToRGB(float kelvin)
	{
		CorrelatedColorTemperatureToRGB_Injected(kelvin, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern ushort FloatToHalf(float val);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern float HalfToFloat(ushort val);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("PerlinNoise::NoiseNormalized", IsThreadSafe = true)]
	public static extern float PerlinNoise(float x, float y);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void CorrelatedColorTemperatureToRGB_Injected(float kelvin, out Color ret);
}
