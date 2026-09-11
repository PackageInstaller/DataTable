using System;
using UnityEngine;

namespace Capture.Library;

public static class OverlapHelper
{
	public static bool OverlapOBB(this OBB obb, OBB other)
	{
		if (obb.ProjectionIsNotIntersect(other, obb.XAxis))
		{
			return false;
		}
		if (obb.ProjectionIsNotIntersect(other, obb.YAxis))
		{
			return false;
		}
		if (obb.ProjectionIsNotIntersect(other, obb.ZAxis))
		{
			return false;
		}
		if (other.ProjectionIsNotIntersect(obb, other.XAxis))
		{
			return false;
		}
		if (other.ProjectionIsNotIntersect(obb, other.YAxis))
		{
			return false;
		}
		if (other.ProjectionIsNotIntersect(obb, other.ZAxis))
		{
			return false;
		}
		return true;
	}

	public static bool ProjectionIsNotIntersect(this OBB x, OBB y, Vector3 axis)
	{
		Span<float> span = stackalloc float[8];
		Span<float> span2 = stackalloc float[8];
		for (int i = 0; i < 8; i++)
		{
			span[i] = GetSignProjectValue(x.rect[i], axis);
			span2[i] = GetSignProjectValue(y.rect[i], axis);
		}
		float num = span[0];
		float num2 = span[0];
		float num3 = span2[0];
		float num4 = span2[0];
		for (int j = 1; j < 8; j++)
		{
			num = MathF.Min(num, span[j]);
			num2 = MathF.Max(num2, span[j]);
			num3 = MathF.Min(num3, span2[j]);
			num4 = MathF.Max(num4, span2[j]);
		}
		if (num3 >= num && num3 <= num2)
		{
			return false;
		}
		if (num4 >= num && num4 <= num2)
		{
			return false;
		}
		if (num >= num3 && num <= num4)
		{
			return false;
		}
		if (num2 >= num3 && num2 <= num4)
		{
			return false;
		}
		return true;
	}

	public static float GetSignProjectValue(Vector3 point, Vector3 axis)
	{
		Vector3 lhs = Vector3.Project(point, axis);
		return lhs.magnitude * Mathf.Sign(Vector3.Dot(lhs, axis));
	}

	public static bool OverlapOBB(this AABB aabb, OBB other)
	{
		return StructHelper.GetOBBFromAABB(aabb).OverlapOBB(other);
	}

	public static bool OverlapAABB(this AABB aabb, AABB other)
	{
		return aabb.aabb.Intersects(other.aabb);
	}

	public static bool OverlapAABB(this OBB obb, AABB other)
	{
		return other.OverlapOBB(obb);
	}

	public static bool IsInCamera(this OBB obb, int maxOverPoint = 2)
	{
		Rect3D rect3D = obb.rect.ConvertToProjection();
		int num = 0;
		for (int i = 0; i < 8; i++)
		{
			if (!rect3D[i].PointInProjection())
			{
				num++;
			}
			if (num > maxOverPoint)
			{
				return false;
			}
		}
		return true;
	}

	public static bool PointInProjection(this Vector3 proj)
	{
		if (proj.x > 1f || proj.x < -1f)
		{
			return false;
		}
		if (proj.y > 1f || proj.y < -1f)
		{
			return false;
		}
		if (proj.z > 1f || proj.z < -1f)
		{
			return false;
		}
		return true;
	}
}
