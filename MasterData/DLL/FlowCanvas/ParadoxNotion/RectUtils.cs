using UnityEngine;

namespace ParadoxNotion;

public static class RectUtils
{
	public static Rect GetBoundRect(params Rect[] rects)
	{
		float num = float.PositiveInfinity;
		float num2 = float.NegativeInfinity;
		float num3 = float.PositiveInfinity;
		float num4 = float.NegativeInfinity;
		for (int i = 0; i < rects.Length; i++)
		{
			num = Mathf.Min(num, rects[i].xMin);
			num2 = Mathf.Max(num2, rects[i].xMax);
			num3 = Mathf.Min(num3, rects[i].yMin);
			num4 = Mathf.Max(num4, rects[i].yMax);
		}
		return Rect.MinMaxRect(num, num3, num2, num4);
	}

	public static Rect GetBoundRect(params Vector2[] positions)
	{
		float num = float.PositiveInfinity;
		float num2 = float.NegativeInfinity;
		float num3 = float.PositiveInfinity;
		float num4 = float.NegativeInfinity;
		for (int i = 0; i < positions.Length; i++)
		{
			num = Mathf.Min(num, positions[i].x);
			num2 = Mathf.Max(num2, positions[i].x);
			num3 = Mathf.Min(num3, positions[i].y);
			num4 = Mathf.Max(num4, positions[i].y);
		}
		return Rect.MinMaxRect(num, num3, num2, num4);
	}

	public static bool Encapsulates(this Rect a, Rect b)
	{
		if (a.x < b.x && a.xMax > b.xMax && a.y < b.y)
		{
			return a.yMax > b.yMax;
		}
		return false;
	}

	public static Rect ExpandBy(this Rect rect, float margin)
	{
		return rect.ExpandBy(margin, margin);
	}

	public static Rect ExpandBy(this Rect rect, float xMargin, float yMargin)
	{
		return rect.ExpandBy(xMargin, yMargin, xMargin, yMargin);
	}

	public static Rect ExpandBy(this Rect rect, float left, float top, float right, float bottom)
	{
		return Rect.MinMaxRect(rect.xMin - left, rect.yMin - top, rect.xMax + right, rect.yMax + bottom);
	}

	public static Rect TransformSpace(this Rect rect, Rect oldContainer, Rect newContainer)
	{
		return new Rect
		{
			xMin = Mathf.Lerp(newContainer.xMin, newContainer.xMax, Mathf.InverseLerp(oldContainer.xMin, oldContainer.xMax, rect.xMin)),
			xMax = Mathf.Lerp(newContainer.xMin, newContainer.xMax, Mathf.InverseLerp(oldContainer.xMin, oldContainer.xMax, rect.xMax)),
			yMin = Mathf.Lerp(newContainer.yMin, newContainer.yMax, Mathf.InverseLerp(oldContainer.yMin, oldContainer.yMax, rect.yMin)),
			yMax = Mathf.Lerp(newContainer.yMin, newContainer.yMax, Mathf.InverseLerp(oldContainer.yMin, oldContainer.yMax, rect.yMax))
		};
	}

	public static Vector2 TransformSpace(this Vector2 vector, Rect oldContainer, Rect newContainer)
	{
		return new Vector2
		{
			x = Mathf.Lerp(newContainer.xMin, newContainer.xMax, Mathf.InverseLerp(oldContainer.xMin, oldContainer.xMax, vector.x)),
			y = Mathf.Lerp(newContainer.yMin, newContainer.yMax, Mathf.InverseLerp(oldContainer.yMin, oldContainer.yMax, vector.y))
		};
	}
}
