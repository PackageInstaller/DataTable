using System;
using UnityEngine;

namespace frame8.Logic.Misc.Other.Extensions;

public static class VectorExtensions
{
	public static bool HasComponentsWithin01(this Vector2 v)
	{
		if (v.x < 0f || v.x > 1f || v.y < 0f || v.y > 1f)
		{
			return false;
		}
		return true;
	}

	public static Vector2 Rotate(this Vector2 v, float degreesCounterClockwise)
	{
		float f = degreesCounterClockwise * (MathF.PI / 180f);
		float num = Mathf.Cos(f);
		float num2 = Mathf.Sin(f);
		float x = v.x;
		float y = v.y;
		v.x = num * x - num2 * y;
		v.y = num2 * x + num * y;
		return v;
	}
}
