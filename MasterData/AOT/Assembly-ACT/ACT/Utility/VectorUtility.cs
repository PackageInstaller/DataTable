using UnityEngine;

namespace ACT.Utility;

public static class VectorUtility
{
	public static Vector3 GetFarthestPoint(Vector3 a, Vector3 b, Vector3 c)
	{
		float sqrMagnitude = (a - b).sqrMagnitude;
		float sqrMagnitude2 = (a - c).sqrMagnitude;
		if (!(sqrMagnitude >= sqrMagnitude2))
		{
			return c;
		}
		return b;
	}

	public static Vector3 GetClosestPoint(Vector3 a, Vector3 b, Vector3 c)
	{
		float sqrMagnitude = (a - b).sqrMagnitude;
		float sqrMagnitude2 = (a - c).sqrMagnitude;
		if (!(sqrMagnitude <= sqrMagnitude2))
		{
			return c;
		}
		return b;
	}

	public static Vector3 Flip(Vector3 vector, Vector3 onNormal)
	{
		Vector3 vector2 = Vector3.Project(vector, onNormal);
		return vector + 2f * (vector2 - vector);
	}

	public static Vector3 InverseProject(Vector3 vector, Vector3 onNormal)
	{
		Vector3 vector2 = Vector3.Project(onNormal, vector);
		if (vector2.magnitude == 0f)
		{
			return Vector3.zero;
		}
		float num = vector.magnitude / vector2.magnitude;
		num *= (float)((Vector3.Angle(vector, onNormal) < 90f) ? 1 : (-1));
		return onNormal * num;
	}

	public static Vector2 RectClamp(Rect rect, Vector2 vector)
	{
		return new Vector2(Mathf.Clamp(vector.x, rect.xMin, rect.xMax), Mathf.Clamp(vector.y, rect.yMin, rect.yMax));
	}

	public static Vector3 BondsClamp(Bounds rect, Vector3 vector)
	{
		return new Vector3(Mathf.Clamp(vector.x, rect.min.x, rect.max.x), Mathf.Clamp(vector.y, rect.min.y, rect.max.y), Mathf.Clamp(vector.z, rect.min.z, rect.max.z));
	}

	public static Vector3 HorizontalDirection(bool faceLeft, Vector3 relativeValue)
	{
		int num = ((!faceLeft) ? 1 : (-1));
		return new Vector3((float)num * relativeValue.x, relativeValue.y, (float)num * relativeValue.z);
	}

	public static Vector3 HorizontalDirection(bool faceLeft, Vector2 relativeValue)
	{
		return new Vector3((float)((!faceLeft) ? 1 : (-1)) * relativeValue.x, relativeValue.y, 0f);
	}

	public static Vector2 HorizontalDirectionVector2(bool faceLeft, Vector2 relativeValue)
	{
		return new Vector2((float)((!faceLeft) ? 1 : (-1)) * relativeValue.x, relativeValue.y);
	}

	public static Vector3 XYDirection(Vector2 XYDirection)
	{
		return new Vector3(0f, XYDirection.y, XYDirection.x);
	}

	public static Vector2 Clamp(Vector2 value, Vector2 max)
	{
		return new Vector2(Mathf.Clamp(value.x, 0f, max.x), Mathf.Clamp(value.y, 0f, max.y));
	}

	public static bool V3isZero(Vector3 vector3)
	{
		return (double)vector3.sqrMagnitude < 9.99999943962493E-11;
	}

	public static bool isZero(this Vector3 vector3)
	{
		return (double)vector3.sqrMagnitude < 9.99999943962493E-11;
	}

	public static bool InRange(this float value, Vector2 range)
	{
		if (range.x < value)
		{
			return value < range.y;
		}
		return false;
	}

	public static Vector4 ToHomogeneousCoordinatesVector(this Vector3 vector)
	{
		return new Vector4(vector.x, vector.y, vector.z, 1f);
	}

	public static bool NearlyEqual(this Vector3 vector, Vector3 other, float sqrThreshold = 1E-15f)
	{
		return (other - vector).sqrMagnitude < sqrThreshold;
	}

	public static Vector3 GetIntersectWithLineAndPlane(Vector3 point, Vector3 direct, Vector3 planeNormal, Vector3 planePoint)
	{
		float num = Vector3.Dot(direct, planeNormal);
		if (Mathf.Abs(num) > 0.0875f)
		{
			float num2 = Vector3.Dot(planePoint - point, planeNormal) / num;
			if (num2 >= 0f)
			{
				return point + num2 * direct;
			}
			return point + (0f - num2) * direct;
		}
		return planePoint;
	}
}
