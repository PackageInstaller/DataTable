using UnityEngine;

namespace ACT.Utility;

public static class MathUtility
{
	public static float Clamp180(float degree)
	{
		while (degree < -180f)
		{
			degree += 360f;
		}
		while (degree >= 180f)
		{
			degree -= 360f;
		}
		return degree;
	}

	public static float Clamp360(float degree)
	{
		return Mathf.Repeat(degree, 360f);
	}

	public static float MoveTowardsAngle(float current, float target, float max)
	{
		if (Mathf.Abs(current - target) > 180f)
		{
			current = ((!(current < target)) ? (current - 360f) : (current + 360f));
			current = Mathf.MoveTowards(current, target, max);
			return Clamp360(current);
		}
		return Mathf.MoveTowards(current, target, max);
	}
}
