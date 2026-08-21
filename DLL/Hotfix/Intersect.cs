using UnityEngine;

public static class Intersect
{
	public static bool IsSegmentsIntersect(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4)
	{
		float num = Mathf.Max(p1.x, p2.x);
		float num2 = Mathf.Min(p1.x, p2.x);
		float num3 = Mathf.Max(p1.y, p2.y);
		float num4 = Mathf.Min(p1.y, p2.y);
		float num5 = Mathf.Max(p3.x, p4.x);
		float num6 = Mathf.Min(p3.x, p4.x);
		float num7 = Mathf.Max(p3.y, p4.y);
		float num8 = Mathf.Min(p3.y, p4.y);
		if (num < num6 || num5 < num2 || num3 < num8 || num7 < num4)
		{
			return false;
		}
		float num9 = (p3.x - p1.x) * (p2.y - p1.y) - (p3.y - p1.y) * (p2.x - p1.x);
		float num10 = (p4.x - p1.x) * (p2.y - p1.y) - (p4.y - p1.y) * (p2.x - p1.x);
		float num11 = (p1.x - p3.x) * (p4.y - p3.y) - (p1.y - p3.y) * (p4.x - p3.x);
		float num12 = (p2.x - p3.x) * (p4.y - p3.y) - (p2.y - p3.y) * (p4.x - p3.x);
		if (num9 * num10 <= 0f)
		{
			return num11 * num12 <= 0f;
		}
		return false;
	}

	public static Vector2 GetIntersectionPoint(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4)
	{
		float x = p1.x;
		float y = p1.y;
		float x2 = p2.x;
		float y2 = p2.y;
		float x3 = p3.x;
		float y3 = p3.y;
		float x4 = p4.x;
		float y4 = p4.y;
		float num = (x - x2) * (y3 - y4) - (y - y2) * (x3 - x4);
		float num2 = ((x - x3) * (y3 - y4) - (y - y3) * (x3 - x4)) / num;
		return new Vector2(x + num2 * (x2 - x), y + num2 * (y2 - y));
	}
}
