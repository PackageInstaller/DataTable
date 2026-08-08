using System;
using System.Collections.Generic;
using UnityEngine;

namespace Capture.Library;

public static class MathHelper
{
	private static List<Vector2> point;

	private static Point2DCompare compareContainer = new Point2DCompare();

	public static Shape2D_10Point GetRectConvexHull(Rect3D rect)
	{
		if (point == null)
		{
			point = new List<Vector2>(9);
		}
		Span<int> span = stackalloc int[9];
		Span<bool> span2 = stackalloc bool[9];
		point.Clear();
		for (int i = 0; i < 8; i++)
		{
			point.Add(new Vector2(rect[i].x, rect[i].y));
		}
		int num = 0;
		point.Sort(compareContainer);
		span[++num] = 0;
		for (int j = 1; j < 8; j++)
		{
			while (num >= 2 && CrossVector2(point[span[num]] - point[span[num - 1]], point[j] - point[span[num]]) <= 0f)
			{
				span2[span[num--]] = false;
			}
			span2[j] = true;
			span[++num] = j;
		}
		int num2 = num;
		for (int num3 = 7; num3 >= 0; num3--)
		{
			if (!span2[num3])
			{
				while (num > num2 && CrossVector2(point[span[num]] - point[span[num - 1]], point[num3] - point[span[num]]) <= 0f)
				{
					span2[span[num--]] = false;
				}
				span2[num3] = true;
				span[++num] = num3;
			}
		}
		Shape2D_10Point result = new Shape2D_10Point
		{
			vertextCount = num
		};
		for (int k = 0; k < num; k++)
		{
			result[k] = point[span[k]];
		}
		return result;
	}

	public static float CrossVector2(Vector2 a, Vector2 b)
	{
		return a.x * b.y - a.y * b.x;
	}
}
