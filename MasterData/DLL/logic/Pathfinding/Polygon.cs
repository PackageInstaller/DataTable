using System;
using System.Collections.Generic;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding;

public static class Polygon
{
	private static readonly Dictionary<Int3, int> cached_Int3_int_dict = new Dictionary<Int3, int>();

	[Obsolete("Use VectorMath.SignedTriangleAreaTimes2XZ instead")]
	public static long TriangleArea2(Int3 a, Int3 b, Int3 c)
	{
		return VectorMath.SignedTriangleAreaTimes2XZ(a, b, c);
	}

	[Obsolete("Use VectorMath.SignedTriangleAreaTimes2XZ instead")]
	public static float TriangleArea2(Vector3 a, Vector3 b, Vector3 c)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.SignedTriangleAreaTimes2XZ(a, b, c);
	}

	[Obsolete("Use TriangleArea2 instead to avoid confusion regarding the factor 2")]
	public static long TriangleArea(Int3 a, Int3 b, Int3 c)
	{
		return TriangleArea2(a, b, c);
	}

	[Obsolete("Use TriangleArea2 instead to avoid confusion regarding the factor 2")]
	public static float TriangleArea(Vector3 a, Vector3 b, Vector3 c)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return TriangleArea2(a, b, c);
	}

	[Obsolete("Use ContainsPointXZ instead")]
	public static bool ContainsPoint(Vector3 a, Vector3 b, Vector3 c, Vector3 p)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		return ContainsPointXZ(a, b, c, p);
	}

	public static bool ContainsPointXZ(Vector3 a, Vector3 b, Vector3 c, Vector3 p)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		if (VectorMath.IsClockwiseMarginXZ(a, b, p) && VectorMath.IsClockwiseMarginXZ(b, c, p))
		{
			return VectorMath.IsClockwiseMarginXZ(c, a, p);
		}
		return false;
	}

	[Obsolete("Use ContainsPointXZ instead")]
	public static bool ContainsPoint(Int3 a, Int3 b, Int3 c, Int3 p)
	{
		return ContainsPointXZ(a, b, c, p);
	}

	public static bool ContainsPointXZ(Int3 a, Int3 b, Int3 c, Int3 p)
	{
		if (VectorMath.IsClockwiseOrColinearXZ(a, b, p) && VectorMath.IsClockwiseOrColinearXZ(b, c, p))
		{
			return VectorMath.IsClockwiseOrColinearXZ(c, a, p);
		}
		return false;
	}

	public static bool ContainsPoint(Int2 a, Int2 b, Int2 c, Int2 p)
	{
		if (VectorMath.IsClockwiseOrColinear(a, b, p) && VectorMath.IsClockwiseOrColinear(b, c, p))
		{
			return VectorMath.IsClockwiseOrColinear(c, a, p);
		}
		return false;
	}

	[Obsolete("Use ContainsPointXZ instead")]
	public static bool ContainsPoint(Vector3[] polyPoints, Vector3 p)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		return ContainsPointXZ(polyPoints, p);
	}

	public static bool ContainsPoint(Vector2[] polyPoints, Vector2 p)
	{
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_004b: Unknown result type (might be due to invalid IL or missing references)
		//IL_005f: Unknown result type (might be due to invalid IL or missing references)
		//IL_007e: Unknown result type (might be due to invalid IL or missing references)
		int num = polyPoints.Length - 1;
		bool flag = false;
		int num2 = 0;
		while (num2 < polyPoints.Length)
		{
			if (((polyPoints[num2].y <= p.y && p.y < polyPoints[num].y) || (polyPoints[num].y <= p.y && p.y < polyPoints[num2].y)) && p.x < (polyPoints[num].x - polyPoints[num2].x) * (p.y - polyPoints[num2].y) / (polyPoints[num].y - polyPoints[num2].y) + polyPoints[num2].x)
			{
				flag = !flag;
			}
			num = num2++;
		}
		return flag;
	}

	public static bool ContainsPointXZ(Vector3[] polyPoints, Vector3 p)
	{
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_004b: Unknown result type (might be due to invalid IL or missing references)
		//IL_005f: Unknown result type (might be due to invalid IL or missing references)
		//IL_007e: Unknown result type (might be due to invalid IL or missing references)
		int num = polyPoints.Length - 1;
		bool flag = false;
		int num2 = 0;
		while (num2 < polyPoints.Length)
		{
			if (((polyPoints[num2].z <= p.z && p.z < polyPoints[num].z) || (polyPoints[num].z <= p.z && p.z < polyPoints[num2].z)) && p.x < (polyPoints[num].x - polyPoints[num2].x) * (p.z - polyPoints[num2].z) / (polyPoints[num].z - polyPoints[num2].z) + polyPoints[num2].x)
			{
				flag = !flag;
			}
			num = num2++;
		}
		return flag;
	}

	[Obsolete("Use VectorMath.RightXZ instead. Note that it now uses a left handed coordinate system (same as Unity)")]
	public static bool LeftNotColinear(Vector3 a, Vector3 b, Vector3 p)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.RightXZ(a, b, p);
	}

	[Obsolete("Use VectorMath.RightOrColinearXZ instead. Note that it now uses a left handed coordinate system (same as Unity)")]
	public static bool Left(Vector3 a, Vector3 b, Vector3 p)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.RightOrColinearXZ(a, b, p);
	}

	[Obsolete("Use VectorMath.RightOrColinear instead. Note that it now uses a left handed coordinate system (same as Unity)")]
	public static bool Left(Vector2 a, Vector2 b, Vector2 p)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.RightOrColinear(a, b, p);
	}

	[Obsolete("Use VectorMath.RightOrColinearXZ instead. Note that it now uses a left handed coordinate system (same as Unity)")]
	public static bool Left(Int3 a, Int3 b, Int3 p)
	{
		return VectorMath.RightOrColinearXZ(a, b, p);
	}

	[Obsolete("Use VectorMath.RightXZ instead. Note that it now uses a left handed coordinate system (same as Unity)")]
	public static bool LeftNotColinear(Int3 a, Int3 b, Int3 p)
	{
		return VectorMath.RightXZ(a, b, p);
	}

	[Obsolete("Use VectorMath.RightOrColinear instead. Note that it now uses a left handed coordinate system (same as Unity)")]
	public static bool Left(Int2 a, Int2 b, Int2 p)
	{
		return VectorMath.RightOrColinear(a, b, p);
	}

	[Obsolete("Use VectorMath.IsClockwiseMarginXZ instead")]
	public static bool IsClockwiseMargin(Vector3 a, Vector3 b, Vector3 c)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.IsClockwiseMarginXZ(a, b, c);
	}

	[Obsolete("Use VectorMath.IsClockwiseXZ instead")]
	public static bool IsClockwise(Vector3 a, Vector3 b, Vector3 c)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.IsClockwiseXZ(a, b, c);
	}

	[Obsolete("Use VectorMath.IsClockwiseXZ instead")]
	public static bool IsClockwise(Int3 a, Int3 b, Int3 c)
	{
		return VectorMath.IsClockwiseXZ(a, b, c);
	}

	[Obsolete("Use VectorMath.IsClockwiseOrColinearXZ instead")]
	public static bool IsClockwiseMargin(Int3 a, Int3 b, Int3 c)
	{
		return VectorMath.IsClockwiseOrColinearXZ(a, b, c);
	}

	[Obsolete("Use VectorMath.IsClockwiseOrColinear instead")]
	public static bool IsClockwiseMargin(Int2 a, Int2 b, Int2 c)
	{
		return VectorMath.IsClockwiseOrColinear(a, b, c);
	}

	[Obsolete("Use VectorMath.IsColinearXZ instead")]
	public static bool IsColinear(Int3 a, Int3 b, Int3 c)
	{
		return VectorMath.IsColinearXZ(a, b, c);
	}

	[Obsolete("Use VectorMath.IsColinearAlmostXZ instead")]
	public static bool IsColinearAlmost(Int3 a, Int3 b, Int3 c)
	{
		return VectorMath.IsColinearAlmostXZ(a, b, c);
	}

	[Obsolete("Use VectorMath.IsColinearXZ instead")]
	public static bool IsColinear(Vector3 a, Vector3 b, Vector3 c)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.IsColinearXZ(a, b, c);
	}

	[Obsolete("Marked for removal since it is not used by any part of the A* Pathfinding Project")]
	public static bool IntersectsUnclamped(Vector3 a, Vector3 b, Vector3 a2, Vector3 b2)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.RightOrColinearXZ(a, b, a2) != VectorMath.RightOrColinearXZ(a, b, b2);
	}

	[Obsolete("Use VectorMath.SegmentsIntersect instead")]
	public static bool Intersects(Int2 start1, Int2 end1, Int2 start2, Int2 end2)
	{
		return VectorMath.SegmentsIntersect(start1, end1, start2, end2);
	}

	[Obsolete("Use VectorMath.SegmentsIntersectXZ instead")]
	public static bool Intersects(Int3 start1, Int3 end1, Int3 start2, Int3 end2)
	{
		return VectorMath.SegmentsIntersectXZ(start1, end1, start2, end2);
	}

	[Obsolete("Use VectorMath.SegmentsIntersectXZ instead")]
	public static bool Intersects(Vector3 start1, Vector3 end1, Vector3 start2, Vector3 end2)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.SegmentsIntersectXZ(start1, end1, start2, end2);
	}

	[Obsolete("Use VectorMath.LineDirIntersectionPointXZ instead")]
	public static Vector3 IntersectionPointOptimized(Vector3 start1, Vector3 dir1, Vector3 start2, Vector3 dir2)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		//IL_0004: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.LineDirIntersectionPointXZ(start1, dir1, start2, dir2);
	}

	[Obsolete("Use VectorMath.LineDirIntersectionPointXZ instead")]
	public static Vector3 IntersectionPointOptimized(Vector3 start1, Vector3 dir1, Vector3 start2, Vector3 dir2, out bool intersects)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.LineDirIntersectionPointXZ(start1, dir1, start2, dir2, out intersects);
	}

	[Obsolete("Use VectorMath.RaySegmentIntersectXZ instead")]
	public static bool IntersectionFactorRaySegment(Int3 start1, Int3 end1, Int3 start2, Int3 end2)
	{
		return VectorMath.RaySegmentIntersectXZ(start1, end1, start2, end2);
	}

	[Obsolete("Use VectorMath.LineIntersectionFactorXZ instead")]
	public static bool IntersectionFactor(Int3 start1, Int3 end1, Int3 start2, Int3 end2, out VFactor factor1, out VFactor factor2)
	{
		return VectorMath.LineIntersectionFactorXZ(start1, end1, start2, end2, out factor1, out factor2);
	}

	[Obsolete("Use VectorMath.LineIntersectionFactorXZ instead")]
	public static bool IntersectionFactor(Vector3 start1, Vector3 end1, Vector3 start2, Vector3 end2, out float factor1, out float factor2)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.LineIntersectionFactorXZ(start1, end1, start2, end2, out factor1, out factor2);
	}

	[Obsolete("Use VectorMath.LineRayIntersectionFactorXZ instead")]
	public static float IntersectionFactorRay(Int3 start1, Int3 end1, Int3 start2, Int3 end2)
	{
		return VectorMath.LineRayIntersectionFactorXZ(start1, end1, start2, end2);
	}

	[Obsolete("Use VectorMath.LineIntersectionFactorXZ instead")]
	public static float IntersectionFactor(Vector3 start1, Vector3 end1, Vector3 start2, Vector3 end2)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.LineIntersectionFactorXZ(start1, end1, start2, end2);
	}

	[Obsolete("Use VectorMath.LineIntersectionPointXZ instead")]
	public static Vector3 IntersectionPoint(Vector3 start1, Vector3 end1, Vector3 start2, Vector3 end2)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		//IL_0004: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.LineIntersectionPointXZ(start1, end1, start2, end2);
	}

	[Obsolete("Use VectorMath.LineIntersectionPointXZ instead")]
	public static Vector3 IntersectionPoint(Vector3 start1, Vector3 end1, Vector3 start2, Vector3 end2, out bool intersects)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.LineIntersectionPointXZ(start1, end1, start2, end2, out intersects);
	}

	[Obsolete("Use VectorMath.LineIntersectionPoint instead")]
	public static Vector2 IntersectionPoint(Vector2 start1, Vector2 end1, Vector2 start2, Vector2 end2)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		//IL_0004: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.LineIntersectionPoint(start1, end1, start2, end2);
	}

	[Obsolete("Use VectorMath.LineIntersectionPoint instead")]
	public static Vector2 IntersectionPoint(Vector2 start1, Vector2 end1, Vector2 start2, Vector2 end2, out bool intersects)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.LineIntersectionPoint(start1, end1, start2, end2, out intersects);
	}

	[Obsolete("Use VectorMath.SegmentIntersectionPointXZ instead")]
	public static Vector3 SegmentIntersectionPoint(Vector3 start1, Vector3 end1, Vector3 start2, Vector3 end2, out bool intersects)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.SegmentIntersectionPointXZ(start1, end1, start2, end2, out intersects);
	}

	[Obsolete("Use ConvexHullXZ instead")]
	public static Vector3[] ConvexHull(Vector3[] points)
	{
		return ConvexHullXZ(points);
	}

	public static Vector3[] ConvexHullXZ(Vector3[] points)
	{
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_006b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		if (points.Length == 0)
		{
			return (Vector3[])(object)new Vector3[0];
		}
		List<Vector3> list = ListPool<Vector3>.Claim();
		int num = 0;
		for (int i = 1; i < points.Length; i++)
		{
			if (points[i].x < points[num].x)
			{
				num = i;
			}
		}
		int num2 = num;
		int num3 = 0;
		do
		{
			list.Add(points[num]);
			int num4 = 0;
			for (int j = 0; j < points.Length; j++)
			{
				if (num4 == num || !VectorMath.RightOrColinearXZ(points[num], points[num4], points[j]))
				{
					num4 = j;
				}
			}
			num = num4;
			num3++;
			if (num3 > 10000)
			{
				Debug.LogWarning((object)"Infinite Loop in Convex Hull Calculation");
				break;
			}
		}
		while (num != num2);
		Vector3[] result = list.ToArray();
		ListPool<Vector3>.Release(list);
		return result;
	}

	[Obsolete("Use VectorMath.SegmentIntersectsBounds instead")]
	public static bool LineIntersectsBounds(Bounds bounds, Vector3 a, Vector3 b)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.SegmentIntersectsBounds(bounds, a, b);
	}

	[Obsolete("Scheduled for removal since it is not used by any part of the A* Pathfinding Project")]
	public static Vector3 ClosestPointOnTriangle(Vector3[] triangle, Vector3 point)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		return ClosestPointOnTriangle(triangle[0], triangle[1], triangle[2], point);
	}

	public static Vector2 ClosestPointOnTriangle(Vector2 a, Vector2 b, Vector2 c, Vector2 p)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Unknown result type (might be due to invalid IL or missing references)
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ae: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ba: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bb: Unknown result type (might be due to invalid IL or missing references)
		//IL_0068: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d3: Unknown result type (might be due to invalid IL or missing references)
		//IL_0098: Unknown result type (might be due to invalid IL or missing references)
		//IL_0099: Unknown result type (might be due to invalid IL or missing references)
		//IL_009c: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a1: Unknown result type (might be due to invalid IL or missing references)
		//IL_016b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0106: Unknown result type (might be due to invalid IL or missing references)
		//IL_0107: Unknown result type (might be due to invalid IL or missing references)
		//IL_010a: Unknown result type (might be due to invalid IL or missing references)
		//IL_010f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0156: Unknown result type (might be due to invalid IL or missing references)
		//IL_0157: Unknown result type (might be due to invalid IL or missing references)
		//IL_0158: Unknown result type (might be due to invalid IL or missing references)
		//IL_0159: Unknown result type (might be due to invalid IL or missing references)
		//IL_0160: Unknown result type (might be due to invalid IL or missing references)
		//IL_0165: Unknown result type (might be due to invalid IL or missing references)
		Vector2 val = b - a;
		Vector2 val2 = c - a;
		Vector2 val3 = p - a;
		float num = Vector2.Dot(val, val3);
		float num2 = Vector2.Dot(val2, val3);
		if (num <= 0f && num2 <= 0f)
		{
			return a;
		}
		Vector2 val4 = p - b;
		float num3 = Vector2.Dot(val, val4);
		float num4 = Vector2.Dot(val2, val4);
		if (num3 >= 0f && num4 <= num3)
		{
			return b;
		}
		if (num >= 0f && num3 <= 0f)
		{
			float num5 = num * num4 - num3 * num2;
			if (num5 <= 0f)
			{
				float num6 = num / (num - num3);
				return a + val * num6;
			}
		}
		Vector2 val5 = p - c;
		float num7 = Vector2.Dot(val, val5);
		float num8 = Vector2.Dot(val2, val5);
		if (num8 >= 0f && num7 <= num8)
		{
			return c;
		}
		if (num2 >= 0f && num8 <= 0f)
		{
			float num9 = num7 * num2 - num * num8;
			if (num9 <= 0f)
			{
				float num10 = num2 / (num2 - num8);
				return a + val2 * num10;
			}
		}
		if (num4 - num3 >= 0f && num7 - num8 >= 0f)
		{
			float num11 = num3 * num8 - num7 * num4;
			if (num11 <= 0f)
			{
				float num12 = (num4 - num3) / (num4 - num3 + (num7 - num8));
				return b + (c - b) * num12;
			}
		}
		return p;
	}

	public static Vector3 ClosestPointOnTriangleXZ(Vector3 a, Vector3 b, Vector3 c, Vector3 p)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_0044: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0051: Unknown result type (might be due to invalid IL or missing references)
		//IL_0057: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_0064: Unknown result type (might be due to invalid IL or missing references)
		//IL_006b: Unknown result type (might be due to invalid IL or missing references)
		//IL_006c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0089: Unknown result type (might be due to invalid IL or missing references)
		//IL_008f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0096: Unknown result type (might be due to invalid IL or missing references)
		//IL_009c: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b3: Unknown result type (might be due to invalid IL or missing references)
		//IL_0085: Unknown result type (might be due to invalid IL or missing references)
		//IL_0119: Unknown result type (might be due to invalid IL or missing references)
		//IL_011f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0126: Unknown result type (might be due to invalid IL or missing references)
		//IL_012c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0138: Unknown result type (might be due to invalid IL or missing references)
		//IL_0139: Unknown result type (might be due to invalid IL or missing references)
		//IL_0142: Unknown result type (might be due to invalid IL or missing references)
		//IL_0143: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cb: Unknown result type (might be due to invalid IL or missing references)
		//IL_015b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0103: Unknown result type (might be due to invalid IL or missing references)
		//IL_0104: Unknown result type (might be due to invalid IL or missing references)
		//IL_010b: Unknown result type (might be due to invalid IL or missing references)
		//IL_010c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0111: Unknown result type (might be due to invalid IL or missing references)
		//IL_021e: Unknown result type (might be due to invalid IL or missing references)
		//IL_022f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0238: Unknown result type (might be due to invalid IL or missing references)
		//IL_0242: Unknown result type (might be due to invalid IL or missing references)
		//IL_024a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0250: Unknown result type (might be due to invalid IL or missing references)
		//IL_0196: Unknown result type (might be due to invalid IL or missing references)
		//IL_0197: Unknown result type (might be due to invalid IL or missing references)
		//IL_019e: Unknown result type (might be due to invalid IL or missing references)
		//IL_019f: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a4: Unknown result type (might be due to invalid IL or missing references)
		//IL_01eb: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ec: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ed: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ee: Unknown result type (might be due to invalid IL or missing references)
		//IL_01f5: Unknown result type (might be due to invalid IL or missing references)
		//IL_01fa: Unknown result type (might be due to invalid IL or missing references)
		Vector2 val = default(Vector2);
		((Vector2)(ref val))._002Ector(b.x - a.x, b.z - a.z);
		Vector2 val2 = default(Vector2);
		((Vector2)(ref val2))._002Ector(c.x - a.x, c.z - a.z);
		Vector2 val3 = default(Vector2);
		((Vector2)(ref val3))._002Ector(p.x - a.x, p.z - a.z);
		float num = Vector2.Dot(val, val3);
		float num2 = Vector2.Dot(val2, val3);
		if (num <= 0f && num2 <= 0f)
		{
			return a;
		}
		Vector2 val4 = default(Vector2);
		((Vector2)(ref val4))._002Ector(p.x - b.x, p.z - b.z);
		float num3 = Vector2.Dot(val, val4);
		float num4 = Vector2.Dot(val2, val4);
		if (num3 >= 0f && num4 <= num3)
		{
			return b;
		}
		float num5 = num * num4 - num3 * num2;
		if (num >= 0f && num3 <= 0f && num5 <= 0f)
		{
			float num6 = num / (num - num3);
			return (1f - num6) * a + num6 * b;
		}
		Vector2 val5 = default(Vector2);
		((Vector2)(ref val5))._002Ector(p.x - c.x, p.z - c.z);
		float num7 = Vector2.Dot(val, val5);
		float num8 = Vector2.Dot(val2, val5);
		if (num8 >= 0f && num7 <= num8)
		{
			return c;
		}
		float num9 = num7 * num2 - num * num8;
		if (num2 >= 0f && num8 <= 0f && num9 <= 0f)
		{
			float num10 = num2 / (num2 - num8);
			return (1f - num10) * a + num10 * c;
		}
		float num11 = num3 * num8 - num7 * num4;
		if (num4 - num3 >= 0f && num7 - num8 >= 0f && num11 <= 0f)
		{
			float num12 = (num4 - num3) / (num4 - num3 + (num7 - num8));
			return b + (c - b) * num12;
		}
		float num13 = 1f / (num11 + num9 + num5);
		float num14 = num9 * num13;
		float num15 = num5 * num13;
		return new Vector3(p.x, (1f - num14 - num15) * a.y + num14 * b.y + num15 * c.y, p.z);
	}

	public static Int3 ClosestPointOnTriangleXZ(Int3 a, Int3 b, Int3 c, Int3 p)
	{
		Int2 a2 = new Int2(b.x - a.x, b.z - a.z);
		Int2 a3 = new Int2(c.x - a.x, c.z - a.z);
		Int2 b2 = new Int2(p.x - a.x, p.z - a.z);
		int num = IntMath.Divide(Int2.Dot(a2, b2), 1000);
		int num2 = IntMath.Divide(Int2.Dot(a3, b2), 1000);
		if (num <= 0 && num2 <= 0)
		{
			return a;
		}
		Int2 b3 = new Int2(p.x - b.x, p.z - b.z);
		int num3 = Int2.Dot(a2, b3);
		int num4 = Int2.Dot(a3, b3);
		if (num3 >= 0 && num4 <= num3)
		{
			return b;
		}
		int num5 = IntMath.Divide(num * num4 - num3 * num2, 1000);
		if (num >= 0 && num3 <= 0 && num5 <= 0)
		{
			VFactor vFactor = ((num != num3) ? new VFactor(num, num - num3) : VFactor.zero);
			return a * (VFactor.one - vFactor) + b * vFactor;
		}
		Int2 b4 = new Int2(p.x - c.x, p.z - c.z);
		int num6 = IntMath.Divide(Int2.Dot(a2, b4), 1000);
		int num7 = IntMath.Divide(Int2.Dot(a3, b4), 1000);
		if (num7 >= 0 && num6 <= num7)
		{
			return c;
		}
		int num8 = IntMath.Divide(num6 * num2 - num * num7, 1000);
		if (num2 >= 0 && num7 <= 0 && num8 <= 0)
		{
			VFactor vFactor2 = new VFactor(num2, num2 - num7);
			return a * (VFactor.one - vFactor2) + c * vFactor2;
		}
		int num9 = IntMath.Divide(num3 * num7 - num6 * num4, 1000);
		if (num4 - num3 >= 0 && num6 - num7 >= 0 && num9 <= 0)
		{
			VFactor vFactor3 = new VFactor(num4 - num3, num4 - num3 + (num6 - num7));
			return b + (c - b) * vFactor3;
		}
		VFactor vFactor4 = new VFactor(1000L, num9 + num8 + num5);
		VFactor vFactor5 = num8 * vFactor4;
		VFactor vFactor6 = num5 * vFactor4;
		return new Int3(p.x, ((Int)((VFactor.one - vFactor5 - vFactor6) * a.y + vFactor5 * b.y + vFactor6 * c.y)).i, p.z);
	}

	public static Vector3 ClosestPointOnTriangle(Vector3 a, Vector3 b, Vector3 c, Vector3 p)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Unknown result type (might be due to invalid IL or missing references)
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ae: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ba: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bb: Unknown result type (might be due to invalid IL or missing references)
		//IL_0068: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d3: Unknown result type (might be due to invalid IL or missing references)
		//IL_0098: Unknown result type (might be due to invalid IL or missing references)
		//IL_0099: Unknown result type (might be due to invalid IL or missing references)
		//IL_009c: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a1: Unknown result type (might be due to invalid IL or missing references)
		//IL_0189: Unknown result type (might be due to invalid IL or missing references)
		//IL_018a: Unknown result type (might be due to invalid IL or missing references)
		//IL_018d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0192: Unknown result type (might be due to invalid IL or missing references)
		//IL_0197: Unknown result type (might be due to invalid IL or missing references)
		//IL_019a: Unknown result type (might be due to invalid IL or missing references)
		//IL_019f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0106: Unknown result type (might be due to invalid IL or missing references)
		//IL_0107: Unknown result type (might be due to invalid IL or missing references)
		//IL_010a: Unknown result type (might be due to invalid IL or missing references)
		//IL_010f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0156: Unknown result type (might be due to invalid IL or missing references)
		//IL_0157: Unknown result type (might be due to invalid IL or missing references)
		//IL_0158: Unknown result type (might be due to invalid IL or missing references)
		//IL_0159: Unknown result type (might be due to invalid IL or missing references)
		//IL_0160: Unknown result type (might be due to invalid IL or missing references)
		//IL_0165: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = b - a;
		Vector3 val2 = c - a;
		Vector3 val3 = p - a;
		float num = Vector3.Dot(val, val3);
		float num2 = Vector3.Dot(val2, val3);
		if (num <= 0f && num2 <= 0f)
		{
			return a;
		}
		Vector3 val4 = p - b;
		float num3 = Vector3.Dot(val, val4);
		float num4 = Vector3.Dot(val2, val4);
		if (num3 >= 0f && num4 <= num3)
		{
			return b;
		}
		float num5 = num * num4 - num3 * num2;
		if (num >= 0f && num3 <= 0f && num5 <= 0f)
		{
			float num6 = num / (num - num3);
			return a + val * num6;
		}
		Vector3 val5 = p - c;
		float num7 = Vector3.Dot(val, val5);
		float num8 = Vector3.Dot(val2, val5);
		if (num8 >= 0f && num7 <= num8)
		{
			return c;
		}
		float num9 = num7 * num2 - num * num8;
		if (num2 >= 0f && num8 <= 0f && num9 <= 0f)
		{
			float num10 = num2 / (num2 - num8);
			return a + val2 * num10;
		}
		float num11 = num3 * num8 - num7 * num4;
		if (num4 - num3 >= 0f && num7 - num8 >= 0f && num11 <= 0f)
		{
			float num12 = (num4 - num3) / (num4 - num3 + (num7 - num8));
			return b + (c - b) * num12;
		}
		float num13 = 1f / (num11 + num9 + num5);
		float num14 = num9 * num13;
		float num15 = num5 * num13;
		return a + val * num14 + val2 * num15;
	}

	public static Int3 ClosestPointOnTriangle(Int3 a, Int3 b, Int3 c, Int3 p)
	{
		Int3 @int = b - a;
		Int3 int2 = c - a;
		Int3 rhs = p - a;
		int num = IntMath.Divide(Int3.Dot(@int, rhs), 1000);
		int num2 = IntMath.Divide(Int3.Dot(int2, rhs), 1000);
		if (num <= 0 && num2 <= 0)
		{
			return a;
		}
		Int3 rhs2 = p - b;
		int num3 = IntMath.Divide(Int3.Dot(@int, rhs2), 1000);
		int num4 = IntMath.Divide(Int3.Dot(int2, rhs2), 1000);
		if (num3 >= 0 && num4 <= num3)
		{
			return b;
		}
		int num5 = IntMath.Divide(num * num4 - num3 * num2, 1000);
		if (num >= 0 && num3 <= 0 && num5 <= 0)
		{
			VFactor vFactor = new VFactor(num, num - num3);
			return a + @int * vFactor;
		}
		Int3 rhs3 = p - c;
		int num6 = IntMath.Divide(Int3.Dot(@int, rhs3), 1000);
		int num7 = IntMath.Divide(Int3.Dot(int2, rhs3), 1000);
		if (num7 >= 0 && num6 <= num7)
		{
			return c;
		}
		int num8 = IntMath.Divide(num6 * num2 - num * num7, 1000);
		if (num2 >= 0 && num7 <= 0 && num8 <= 0)
		{
			VFactor vFactor2 = new VFactor(num2, num2 - num7);
			return a + int2 * vFactor2;
		}
		int num9 = IntMath.Divide(num3 * num7 - num6 * num4, 1000);
		if (num4 - num3 >= 0 && num6 - num7 >= 0 && num9 <= 0)
		{
			VFactor vFactor3 = new VFactor(num4 - num3, num4 - num3 + (num6 - num7));
			return b + (c - b) * vFactor3;
		}
		VFactor vFactor4 = new VFactor(num8, num9 + num8 + num5);
		VFactor vFactor5 = new VFactor(num5, num9 + num8 + num5);
		return a + @int * vFactor4 + int2 * vFactor5;
	}

	[Obsolete("Use VectorMath.SqrDistanceSegmentSegment instead")]
	public static float DistanceSegmentSegment3D(Vector3 s1, Vector3 e1, Vector3 s2, Vector3 e2)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.SqrDistanceSegmentSegment(s1, e1, s2, e2);
	}

	public static void CompressMesh(List<Int3> vertices, List<int> triangles, out Int3[] outVertices, out int[] outTriangles)
	{
		Dictionary<Int3, int> dictionary = cached_Int3_int_dict;
		dictionary.Clear();
		int[] array = ArrayPool<int>.Claim(vertices.Count);
		int num = 0;
		for (int i = 0; i < vertices.Count; i++)
		{
			if (!dictionary.TryGetValue(vertices[i], out var value) && !dictionary.TryGetValue(vertices[i] + new Int3(0, 1, 0), out value) && !dictionary.TryGetValue(vertices[i] + new Int3(0, -1, 0), out value))
			{
				dictionary.Add(vertices[i], num);
				array[i] = num;
				vertices[num] = vertices[i];
				num++;
			}
			else
			{
				array[i] = value;
			}
		}
		outTriangles = new int[triangles.Count];
		for (int j = 0; j < outTriangles.Length; j++)
		{
			outTriangles[j] = array[triangles[j]];
		}
		outVertices = new Int3[num];
		for (int k = 0; k < num; k++)
		{
			outVertices[k] = vertices[k];
		}
		ArrayPool<int>.Release(ref array);
	}
}
