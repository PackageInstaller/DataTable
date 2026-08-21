using System;
using UnityEngine;

namespace Ase;

public static class TSUtil
{
	public static int GetLongByBinary(int aBinary, int bitRemove, int bitNeed)
	{
		return (aBinary >> bitRemove) - (aBinary >> bitRemove + bitNeed << bitNeed);
	}

	public static float Harf2Full(float harf)
	{
		if (harf < 0f)
		{
			return harf + 360f;
		}
		if (harf > 360f)
		{
			return harf - 360f;
		}
		return harf;
	}

	public static Vector3 TransformPoint(Vector3 centerPos, Vector3 rotation, Vector3 scale, Vector3 pos)
	{
		return Matrix4x4.TRS(centerPos, Quaternion.Euler(rotation), scale).MultiplyPoint3x4(pos);
	}

	public static Vector3 MoveForward2D(Vector3 position, float rotation, float distance)
	{
		float f = (float)((double)rotation * (Math.PI / 180.0));
		float num = Mathf.Sin(f) * distance;
		float num2 = Mathf.Cos(f) * distance;
		position.x += num;
		position.z += num2;
		return position;
	}

	public static float TargetFwdAngleToSelf(Vector3 selfPos, float selfRot, Vector3 targetPos)
	{
		Vector2 diff = new Vector2(selfPos.x - targetPos.x, selfPos.z - targetPos.z);
		selfRot = Angle2Limit(selfRot);
		float num = Vector2Angle(diff);
		float num2 = Full2Half(selfRot);
		return Full2Half(Angle2Limit(num - num2));
	}

	public static float GetAngleBetween(Vector2 selfPos, float selfRot, Vector2 targetPos)
	{
		float f = selfRot * (MathF.PI / 180f);
		Vector2 lhs = new Vector2(Mathf.Sin(f), Mathf.Cos(f));
		Vector2 normalized = (targetPos - selfPos).normalized;
		float x = Vector2.Dot(lhs, normalized);
		return Mathf.Atan2(lhs.x * normalized.y - lhs.y * normalized.x, x) * 57.29578f;
	}

	public static float NormalizeAngle(float angle)
	{
		while (angle > 180f)
		{
			angle -= 360f;
		}
		while (angle < -180f)
		{
			angle += 360f;
		}
		return angle;
	}

	public static float Vector2Angle(Vector2 diff)
	{
		diff.Normalize();
		return 57.29578f * Mathf.Atan2(diff.x, diff.y);
	}

	public static float Angle2Limit(float value)
	{
		if (value > 360f)
		{
			return value % 360f;
		}
		while (true)
		{
			if (value < 0f)
			{
				value += 360f;
				continue;
			}
			if (!(value > 360f))
			{
				break;
			}
			value -= 360f;
		}
		return value;
	}

	public static float Full2Half(float full)
	{
		if (full > 180f)
		{
			return full - 360f;
		}
		return full;
	}

	public static Vector2 Vec2RotateAAngle(Vector2 targetVec, float angle)
	{
		if (targetVec.Equals(Vector2.zero))
		{
			return targetVec;
		}
		float f = MathF.PI / 180f * (0f - angle);
		return new Vector2(targetVec.x * Mathf.Cos(f) - targetVec.y * Mathf.Sin(f), targetVec.x * Mathf.Sin(f) + targetVec.y * Mathf.Cos(f));
	}

	public static bool IsPointInsideBox(Vector3 boxCener, Vector3 size, Vector3 point, float yAngle)
	{
		Vector3 vector = point - boxCener;
		float f = yAngle * (MathF.PI / 180f);
		float num = Mathf.Cos(f);
		float num2 = Mathf.Sin(f);
		Vector3 vector2 = default(Vector3);
		vector2.x = num * vector.x - num2 * vector.z;
		vector2.y = vector.y;
		vector2.z = num2 * vector.x + num * vector.z;
		bool num3 = Mathf.Abs(vector2.x) <= size.x;
		bool flag = Mathf.Abs(vector2.y) <= size.y;
		bool flag2 = Mathf.Abs(vector2.z) <= size.z;
		return num3 & flag & flag2;
	}

	public static bool IsPointInsideBox(double centerX, double centerY, double centerZ, double halfLength, double halfWidth, double halfHeight, double pointX, double pointY, double pointZ)
	{
		double num = centerX - halfLength;
		double num2 = centerX + halfLength;
		double num3 = centerY - halfWidth;
		double num4 = centerY + halfWidth;
		double num5 = centerZ - halfHeight;
		double num6 = centerZ + halfHeight;
		if (pointX >= num && pointX <= num2 && pointY >= num3 && pointY <= num4 && pointZ >= num5 && pointZ <= num6)
		{
			return true;
		}
		return false;
	}

	public static long SetBitValue(int index, int setValue, long value)
	{
		value = ((setValue != 0) ? (value | (1L << index)) : (value & ~(1L << index)));
		return value;
	}

	public static int GetBitValue(int index, long value)
	{
		if ((value & (1L << index)) == 0L)
		{
			return 0;
		}
		return 1;
	}

	public static int SetBitValue(int index, int setValue, int value)
	{
		value = ((setValue != 0) ? (value | (1 << index)) : (value & ~(1 << index)));
		return value;
	}

	public static int GetBitValue(int index, int value)
	{
		if ((value & (1 << index)) == 0)
		{
			return 0;
		}
		return 1;
	}

	public static string GetFullPath(this Transform transform)
	{
		if (transform == null)
		{
			return string.Empty;
		}
		string path = transform.name;
		GetAllPath(transform, ref path);
		return path;
	}

	private static void GetAllPath(Transform transform, ref string path)
	{
		if (transform.parent != null)
		{
			path = transform.parent.name + "/" + path;
			GetAllPath(transform.parent, ref path);
		}
	}

	public static float MoveSpeedLerp(float speed1, float speed2, float t)
	{
		float num = Mathf.Lerp(speed1, speed2, t);
		num = Mathf.Round(num * 100f) / 100f;
		if (Mathf.Approximately(num, speed1))
		{
			num = speed2;
		}
		return num;
	}

	public static float Vector3DistanceSqr(Vector3 v1, Vector3 v2)
	{
		float num = v1.x - v2.x;
		float num2 = v1.y - v2.y;
		float num3 = v1.z - v2.z;
		return num * num + num2 * num2 + num3 * num3;
	}
}
