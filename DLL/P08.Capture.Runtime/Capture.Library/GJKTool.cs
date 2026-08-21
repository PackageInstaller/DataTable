using System.Collections.Generic;
using UnityEngine;

namespace Capture.Library;

public static class GJKTool
{
	public static int whitchSide(Vector2 a, Vector2 b, Vector2 c)
	{
		Vector2 vector = b - a;
		Vector2 vector2 = c - a;
		float num = vector.x * vector2.y - vector.y * vector2.x;
		if (!(num > 0f))
		{
			if (!(num < 0f))
			{
				return 0;
			}
			return -1;
		}
		return 1;
	}

	public static Vector2 getClosestPointToOrigin(Vector2 a, Vector2 b)
	{
		Vector2 vector = b - a;
		Vector2 rhs = Vector2.zero - a;
		float num = Vector2.Dot(vector, rhs) / vector.sqrMagnitude;
		if (num < 0f)
		{
			return a;
		}
		if (num > 1f)
		{
			return b;
		}
		return a + vector * num;
	}

	public static Vector2 getPerpendicularToOrigin(Vector2 a, Vector2 b)
	{
		Vector2 vector = b - a;
		Vector2 rhs = Vector2.zero - a;
		float num = Vector2.Dot(vector, rhs) / vector.sqrMagnitude;
		return a + vector * num;
	}

	public static bool contains(List<Vector2> points, Vector2 point)
	{
		int count = points.Count;
		if (count < 3)
		{
			return false;
		}
		int num = whitchSide(points[0], points[1], points[2]);
		for (int i = 0; i < count; i++)
		{
			int index = (i + 1) % count;
			int num2 = whitchSide(points[i], points[index], point);
			if (num2 == 0)
			{
				return true;
			}
			if (num2 != num)
			{
				return false;
			}
		}
		return true;
	}

	public static Vector2 getFarthestPointInDirection(this Shape2D_10Point shape, Vector2 dir)
	{
		float num = float.MinValue;
		int index = 0;
		for (int i = 0; i < shape.vertextCount; i++)
		{
			float num2 = Vector2.Dot(shape[i], dir);
			if (num2 > num)
			{
				num = num2;
				index = i;
			}
		}
		return shape[index];
	}
}
