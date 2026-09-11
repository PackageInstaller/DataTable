using UnityEngine;

namespace ParadoxNotion;

public static class CurveUtils
{
	private const float POS_CHECK_RES = 100f;

	private const float POS_CHECK_DISTANCE = 10f;

	public static Vector2 GetPosAlongCurve(Vector2 from, Vector2 to, Vector2 fromTangent, Vector2 toTangent, float t)
	{
		float num = 1f - t;
		float num2 = t * t;
		float num3 = num * num;
		float num4 = num3 * num;
		float num5 = num2 * t;
		return num4 * from + 3f * num3 * t * (from + fromTangent) + 3f * num * num2 * (to + toTangent) + num5 * to;
	}

	public static bool IsPosAlongCurve(Vector2 from, Vector2 to, Vector2 fromTangent, Vector2 toTangent, Vector2 targetPosition)
	{
		float norm = 0f;
		return IsPosAlongCurve(from, to, fromTangent, toTangent, targetPosition, out norm);
	}

	public static bool IsPosAlongCurve(Vector2 from, Vector2 to, Vector2 fromTangent, Vector2 toTangent, Vector2 targetPosition, out float norm)
	{
		if (RectUtils.GetBoundRect(from, to).ExpandBy(10f).Contains(targetPosition))
		{
			for (float num = 0f; num <= 100f; num++)
			{
				Vector2 posAlongCurve = GetPosAlongCurve(from, to, fromTangent, toTangent, num / 100f);
				if (Vector2.Distance(targetPosition, posAlongCurve) < 10f)
				{
					norm = num / 100f;
					return true;
				}
			}
		}
		norm = 0f;
		return false;
	}

	public static void ResolveTangents(Vector2 from, Vector2 to, float rigidMlt, PlanarDirection direction, out Vector2 fromTangent, out Vector2 toTangent)
	{
		Rect fromRect = new Rect(0f, 0f, 1f, 1f);
		Rect toRect = new Rect(0f, 0f, 1f, 1f);
		fromRect.center = from;
		toRect.center = to;
		ResolveTangents(from, to, fromRect, toRect, rigidMlt, direction, out fromTangent, out toTangent);
	}

	public static void ResolveTangents(Vector2 from, Vector2 to, Rect fromRect, Rect toRect, float rigidMlt, PlanarDirection direction, out Vector2 fromTangent, out Vector2 toTangent)
	{
		float a = Mathf.Abs(from.x - to.x) * rigidMlt;
		a = Mathf.Max(a, 25f);
		float a2 = Mathf.Abs(from.y - to.y) * rigidMlt;
		a2 = Mathf.Max(a2, 25f);
		switch (direction)
		{
		case PlanarDirection.Horizontal:
			fromTangent = new Vector2(a, 0f);
			toTangent = new Vector2(0f - a, 0f);
			break;
		case PlanarDirection.Vertical:
			fromTangent = new Vector2(0f, a2);
			toTangent = new Vector2(0f, 0f - a2);
			break;
		case PlanarDirection.Auto:
		{
			Vector2 vector = default(Vector2);
			if (from.x <= fromRect.xMin)
			{
				vector = new Vector2(0f - a, 0f);
			}
			if (from.x >= fromRect.xMax)
			{
				vector = new Vector2(a, 0f);
			}
			if (from.y <= fromRect.yMin)
			{
				vector = new Vector2(0f, 0f - a2);
			}
			if (from.y >= fromRect.yMax)
			{
				vector = new Vector2(0f, a2);
			}
			Vector2 vector2 = default(Vector2);
			if (to.x <= toRect.xMin)
			{
				vector2 = new Vector2(0f - a, 0f);
			}
			if (to.x >= toRect.xMax)
			{
				vector2 = new Vector2(a, 0f);
			}
			if (to.y <= toRect.yMin)
			{
				vector2 = new Vector2(0f, 0f - a2);
			}
			if (to.y >= toRect.yMax)
			{
				vector2 = new Vector2(0f, a2);
			}
			fromTangent = vector;
			toTangent = vector2;
			break;
		}
		default:
			fromTangent = default(Vector2);
			toTangent = default(Vector2);
			break;
		}
	}
}
