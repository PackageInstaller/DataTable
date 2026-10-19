using UnityEngine;

namespace EasyCharacterMovement;

public static class MathLib
{
	public static float Square(float value)
	{
		return value * value;
	}

	public static Vector3 GetTangent(Vector3 direction, Vector3 normal, Vector3 up)
	{
		Vector3 otherVector = direction.perpendicularTo(up);
		return normal.perpendicularTo(otherVector);
	}

	public static Vector3 ProjectPointOnPlane(Vector3 point, Vector3 planeOrigin, Vector3 planeNormal)
	{
		Vector3 vector = Vector3.Project(point - planeOrigin, planeNormal);
		return point - vector;
	}

	public static float Clamp0360(float eulerAngles)
	{
		float num = eulerAngles - (float)Mathf.CeilToInt(eulerAngles / 360f) * 360f;
		if (num < 0f)
		{
			num += 360f;
		}
		return num;
	}

	public static float FixedTurn(float current, float target, float maxDegreesDelta)
	{
		if (maxDegreesDelta == 0f)
		{
			return Clamp0360(current);
		}
		if (maxDegreesDelta >= 360f)
		{
			return Clamp0360(target);
		}
		float num = Clamp0360(current);
		current = num;
		target = Clamp0360(target);
		if (current > target)
		{
			num = ((!(current - target < 180f)) ? (num + Mathf.Min(target + 360f - current, Mathf.Abs(maxDegreesDelta))) : (num - Mathf.Min(current - target, Mathf.Abs(maxDegreesDelta))));
		}
		else
		{
			num = ((!(target - current < 180f)) ? (num - Mathf.Min(current + 360f - target, Mathf.Abs(maxDegreesDelta))) : (num + Mathf.Min(target - current, Mathf.Abs(maxDegreesDelta))));
		}
		return Clamp0360(num);
	}
}
