using UnityEngine;

public static class Vector2Extension
{
	public static float SignedAngle(this Vector2 v1, Vector2 v2)
	{
		Vector2 normalized = v1.normalized;
		Vector2 normalized2 = v2.normalized;
		float num = Vector2.Dot(normalized, normalized2);
		if (num > 1f)
		{
			num = 1f;
		}
		if (num < -1f)
		{
			num = -1f;
		}
		float num2 = Mathf.Acos(num);
		if (Vector2.Dot(new Vector2(0f - normalized.y, normalized.x), normalized2) >= 0f)
		{
			return num2;
		}
		return 0f - num2;
	}

	public static Vector2 Rotate(this Vector2 v, float theta)
	{
		float num = Mathf.Cos(theta);
		float num2 = Mathf.Sin(theta);
		float x = v.x * num - v.y * num2;
		float y = v.x * num2 + v.y * num;
		return new Vector2(x, y);
	}
}
