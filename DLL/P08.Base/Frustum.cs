using System;
using UnityEngine;

public class Frustum
{
	public enum E_Location
	{
		Outside,
		Intersect,
		Inside
	}

	private static Vector3 position;

	private static Vector3 forward;

	private static Vector3 right;

	private static Vector3 up;

	private static float near;

	private static float far;

	private static float ratio;

	private static float tan;

	public static E_Location PointInFrustum(Vector3 p)
	{
		Vector3 lhs = p - position;
		float num = Vector3.Dot(lhs, forward);
		if (num < near || num > far)
		{
			return E_Location.Outside;
		}
		float num2 = num * tan;
		float num3 = Vector3.Dot(lhs, up);
		if (num3 > num2 || num3 < 0f - num2)
		{
			return E_Location.Outside;
		}
		float num4 = Vector3.Dot(lhs, right);
		num2 *= ratio;
		if (num4 > num2 || num4 < 0f - num2)
		{
			return E_Location.Outside;
		}
		return E_Location.Inside;
	}

	public static E_Location SquareInFrustumFast(Vector3 inCenter, float inRadius)
	{
		Vector3 lineStart = inCenter;
		Vector3 lineEnd = inCenter;
		lineStart.x -= inRadius;
		lineEnd.x += inRadius;
		if (LineInFrustumFast(lineStart, lineEnd) != E_Location.Outside)
		{
			return E_Location.Inside;
		}
		Vector3 lineStart2 = inCenter;
		Vector3 lineEnd2 = inCenter;
		lineStart2.z -= inRadius;
		lineEnd2.z += inRadius;
		if (LineInFrustumFast(lineStart2, lineEnd2) != E_Location.Outside)
		{
			return E_Location.Inside;
		}
		return E_Location.Outside;
	}

	public static E_Location LineInFrustumFast(Vector3 lineStart, Vector3 lineEnd)
	{
		if (PointInFrustum(lineStart) != E_Location.Outside)
		{
			return E_Location.Inside;
		}
		if (PointInFrustum(lineEnd) != E_Location.Outside)
		{
			return E_Location.Inside;
		}
		return PointInFrustum(PointOfTwoLines(lineStart, lineEnd, position, position + forward * far));
	}

	private static void SetCameraInternals(float inFov, float inRatio, float inNear, float inFar)
	{
		ratio = inRatio;
		near = inNear;
		far = inFar;
		tan = Mathf.Tan(MathF.PI / 180f * inFov * 0.5f);
	}

	private static void SetCameraTransform(Vector3 inPos, Vector3 inForward, Vector3 inRight, Vector3 inUp)
	{
		position = inPos;
		forward = inForward;
		right = inRight;
		up = inUp;
	}

	public static Vector3 PointOfTwoLines(Vector3 start1, Vector3 end1, Vector3 start2, Vector3 end2)
	{
		Vector3 vector = end1 - start1;
		Vector3 vector2 = end2 - start2;
		Vector3 rhs = start1 - start2;
		float num = Vector3.Dot(vector, vector);
		float num2 = Vector3.Dot(vector, vector2);
		float num3 = Vector3.Dot(vector2, vector2);
		float num4 = Vector3.Dot(vector, rhs);
		float num5 = Vector3.Dot(vector2, rhs);
		float num6 = num * num3 - num2 * num2;
		float num7 = ((!(num6 < Mathf.Epsilon)) ? ((num2 * num5 - num3 * num4) / num6) : 0f);
		if (num7 < 0f)
		{
			return start1;
		}
		if (num7 * num7 > vector.sqrMagnitude)
		{
			return end1;
		}
		return start1 + vector * num7;
	}
}
