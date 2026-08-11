using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public static class VectorExtensions
{
	public static readonly Vector3 OriginPos = Vector3.zero;

	public static readonly Vector3 ScreenOutPos = new Vector3(-99999f, 0f, 0f);

	public static List<Vector3> FilterClosePoints(List<Vector3> points, float minDistance)
	{
		List<Vector3> list = new List<Vector3>();
		foreach (Vector3 point in points)
		{
			bool flag = false;
			foreach (Vector3 item in list)
			{
				if (Vector3.Distance(point, item) <= minDistance)
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				list.Add(point);
			}
		}
		return list;
	}

	public static Vector3 ToRound2(this Vector3 point)
	{
		return new Vector3((float)Math.Round(point.x, 2), (float)Math.Round(point.y, 2), (float)Math.Round(point.z, 2));
	}

	public static bool CompareVector3(this Vector3 v1, Vector3 v2)
	{
		if (v1.x == v2.x && v1.y == v2.y)
		{
			return v1.z == v2.z;
		}
		return false;
	}

	public static Vector3 GetTargetPointDirection(Vector3 point, Vector3 targetPoint)
	{
		return targetPoint - point;
	}

	public static Vector3 GetBetweenPoint(Vector3 post1, Vector3 post2, float distance)
	{
		_ = Vector3.zero;
		Vector3 normalized = (post2 - post1).normalized;
		return post2 - normalized * distance;
	}

	public static Vector3 GetEntityRelativePoint(Vector3 position, Quaternion rotation, float distance)
	{
		Vector3 vector = rotation * Vector3.forward;
		return position + vector * distance;
	}

	public static Vector2 GetCameraOffsetDirect(Vector2 position, float angleY, bool useCameraDirect = false)
	{
		if (useCameraDirect)
		{
			position = (Quaternion.Euler(0f, angleY, 0f) * position.ToVector3()).ToVector2();
		}
		return position;
	}

	public static Vector3 GetCameraOffsetDirect(Vector3 position, float angleY, bool useCameraDirect = false)
	{
		if (useCameraDirect)
		{
			position = Quaternion.Euler(0f, angleY, 0f) * position;
		}
		return position;
	}
}
