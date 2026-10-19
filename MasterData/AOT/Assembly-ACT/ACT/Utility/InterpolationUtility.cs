using UnityEngine;

namespace ACT.Utility;

public static class InterpolationUtility
{
	public static float FixedLerp(float value, float stableValue, float near)
	{
		float f = stableValue - value;
		return value + Mathf.Sign(f) * Mathf.Min(Mathf.Abs(f), near);
	}

	public static float FixedLerp(float value, float stableValue, float near, out float actualDelta)
	{
		float f = stableValue - value;
		actualDelta = Mathf.Min(Mathf.Abs(f), near);
		return value + Mathf.Sign(f) * actualDelta;
	}

	public static float SignFixedLerp(float value, float stableValue, float near, out float actualDelta)
	{
		float f = stableValue - value;
		actualDelta = Mathf.Sign(f) * Mathf.Min(Mathf.Abs(f), near);
		return value + actualDelta;
	}

	public static Vector3 FixedLerp(Vector3 value, Vector3 stableValue, float near)
	{
		Vector3 vector = stableValue - value;
		return value + vector.normalized * Mathf.Min(vector.magnitude, near);
	}

	public static Vector3 FixedLerp(Vector3 value, Vector3 stableValue, float near, out Vector3 actualDelta)
	{
		Vector3 vector = stableValue - value;
		actualDelta = vector.normalized * Mathf.Min(vector.magnitude, near);
		return value + actualDelta;
	}

	public static float HalfLife(float value, float stableValue, float deltaTime, float halfLife)
	{
		if (deltaTime == 0f)
		{
			return value;
		}
		if (halfLife == 0f)
		{
			return stableValue;
		}
		float num = value - stableValue;
		return stableValue + num * Mathf.Pow(0.5f, deltaTime / halfLife);
	}

	public static Vector3 HalfLife(Vector3 value, Vector3 stableValue, float deltaTime, float halfLife)
	{
		return new Vector3
		{
			x = HalfLife(value.x, stableValue.x, deltaTime, halfLife),
			y = HalfLife(value.y, stableValue.y, deltaTime, halfLife),
			z = HalfLife(value.z, stableValue.z, deltaTime, halfLife)
		};
	}

	public static float ExponentialInterpolation(float startValue, float endValue, float duration, float currentTime)
	{
		if (duration == 0f)
		{
			if (!(currentTime >= duration))
			{
				return startValue;
			}
			return endValue;
		}
		float f = Mathf.Clamp01(currentTime / duration);
		return Mathf.Lerp(startValue, endValue, Mathf.Pow(f, 2f));
	}
}
