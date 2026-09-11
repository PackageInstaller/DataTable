using System;
using UnityEngine;

namespace Pathfinding;

public static class VectorMath
{
	public static Vector3 ClosestPointOnLine(Vector3 lineStart, Vector3 lineEnd, Vector3 point)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = Vector3.Normalize(lineEnd - lineStart);
		float num = Vector3.Dot(point - lineStart, val);
		return lineStart + num * val;
	}

	public static float ClosestPointOnLineFactor(Vector3 lineStart, Vector3 lineEnd, Vector3 point)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = lineEnd - lineStart;
		float sqrMagnitude = ((Vector3)(ref val)).sqrMagnitude;
		if ((double)sqrMagnitude <= 1E-06)
		{
			return 0f;
		}
		return Vector3.Dot(point - lineStart, val) / sqrMagnitude;
	}

	public static VFactor ClosestPointOnLineFactor(Int3 lineStart, Int3 lineEnd, Int3 point)
	{
		Int3 rhs = lineEnd - lineStart;
		long sqrMagnitudeLong = rhs.sqrMagnitudeLong;
		int num = Int3.Dot(point - lineStart, rhs);
		if (sqrMagnitudeLong != 0L)
		{
			return new VFactor(num, sqrMagnitudeLong);
		}
		return VFactor.zero;
	}

	public static float ClosestPointOnLineFactor(Int2 lineStart, Int2 lineEnd, Int2 point)
	{
		Int2 b = lineEnd - lineStart;
		double num = b.sqrMagnitudeLong;
		double num2 = Int2.DotLong(point - lineStart, b);
		if (num != 0.0)
		{
			num2 /= num;
		}
		return (float)num2;
	}

	public static Vector3 ClosestPointOnSegment(Vector3 lineStart, Vector3 lineEnd, Vector3 point)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_002f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = lineEnd - lineStart;
		float sqrMagnitude = ((Vector3)(ref val)).sqrMagnitude;
		if ((double)sqrMagnitude <= 1E-06)
		{
			return lineStart;
		}
		float num = Vector3.Dot(point - lineStart, val) / sqrMagnitude;
		return lineStart + Mathf.Clamp01(num) * val;
	}

	public static Int3 ClosestPointOnSegment(Int3 lineStart, Int3 lineEnd, Int3 point)
	{
		Int3 @int = lineEnd - lineStart;
		long sqrMagnitudeLong = @int.sqrMagnitudeLong;
		if (sqrMagnitudeLong <= 0)
		{
			return lineStart;
		}
		VFactor a = new VFactor(Int3.Dot(point - lineStart, @int), sqrMagnitudeLong);
		return lineStart + @int * VFactor.Clamp01(a);
	}

	public static Vector3 ClosestPointOnSegmentXZ(Vector3 lineStart, Vector3 lineEnd, Vector3 point)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0047: Unknown result type (might be due to invalid IL or missing references)
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0051: Unknown result type (might be due to invalid IL or missing references)
		//IL_0056: Unknown result type (might be due to invalid IL or missing references)
		//IL_005e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0072: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		//IL_0078: Unknown result type (might be due to invalid IL or missing references)
		lineStart.y = point.y;
		lineEnd.y = point.y;
		Vector3 val = lineEnd - lineStart;
		Vector3 val2 = val;
		val2.y = 0f;
		float magnitude = ((Vector3)(ref val2)).magnitude;
		Vector3 val3 = ((magnitude > float.Epsilon) ? (val2 / magnitude) : Vector3.zero);
		float num = Vector3.Dot(point - lineStart, val3);
		return lineStart + Mathf.Clamp(num, 0f, ((Vector3)(ref val2)).magnitude) * val3;
	}

	public static float SqrDistancePointSegmentApproximate(int x, int z, int px, int pz, int qx, int qz)
	{
		float num = qx - px;
		float num2 = qz - pz;
		float num3 = x - px;
		float num4 = z - pz;
		float num5 = num * num + num2 * num2;
		float num6 = num * num3 + num2 * num4;
		if (num5 > 0f)
		{
			num6 /= num5;
		}
		if (num6 < 0f)
		{
			num6 = 0f;
		}
		else if (num6 > 1f)
		{
			num6 = 1f;
		}
		num3 = (float)px + num6 * num - (float)x;
		num4 = (float)pz + num6 * num2 - (float)z;
		return num3 * num3 + num4 * num4;
	}

	public static float SqrDistancePointSegmentApproximate(Int3 a, Int3 b, Int3 p)
	{
		float num = b.x - a.x;
		float num2 = b.z - a.z;
		float num3 = p.x - a.x;
		float num4 = p.z - a.z;
		float num5 = num * num + num2 * num2;
		float num6 = num * num3 + num2 * num4;
		if (num5 > 0f)
		{
			num6 /= num5;
		}
		if (num6 < 0f)
		{
			num6 = 0f;
		}
		else if (num6 > 1f)
		{
			num6 = 1f;
		}
		num3 = (float)a.x + num6 * num - (float)p.x;
		num4 = (float)a.z + num6 * num2 - (float)p.z;
		return num3 * num3 + num4 * num4;
	}

	public static float SqrDistancePointSegment(Vector3 a, Vector3 b, Vector3 p)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = ClosestPointOnSegment(a, b, p);
		Vector3 val2 = val - p;
		return ((Vector3)(ref val2)).sqrMagnitude;
	}

	public static float SqrDistanceSegmentSegment(Vector3 s1, Vector3 e1, Vector3 s2, Vector3 e2)
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
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0033: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		//IL_016c: Unknown result type (might be due to invalid IL or missing references)
		//IL_016f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0170: Unknown result type (might be due to invalid IL or missing references)
		//IL_0175: Unknown result type (might be due to invalid IL or missing references)
		//IL_017c: Unknown result type (might be due to invalid IL or missing references)
		//IL_017d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0182: Unknown result type (might be due to invalid IL or missing references)
		//IL_0187: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = e1 - s1;
		Vector3 val2 = e2 - s2;
		Vector3 val3 = s1 - s2;
		float num = Vector3.Dot(val, val);
		float num2 = Vector3.Dot(val, val2);
		float num3 = Vector3.Dot(val2, val2);
		float num4 = Vector3.Dot(val, val3);
		float num5 = Vector3.Dot(val2, val3);
		float num6 = num * num3 - num2 * num2;
		float num7 = num6;
		float num8 = num6;
		float num9;
		float num10;
		if (num6 < 1E-06f)
		{
			num9 = 0f;
			num7 = 1f;
			num10 = num5;
			num8 = num3;
		}
		else
		{
			num9 = num2 * num5 - num3 * num4;
			num10 = num * num5 - num2 * num4;
			if (num9 < 0f)
			{
				num9 = 0f;
				num10 = num5;
				num8 = num3;
			}
			else if (num9 > num7)
			{
				num9 = num7;
				num10 = num5 + num2;
				num8 = num3;
			}
		}
		if (num10 < 0f)
		{
			num10 = 0f;
			if (0f - num4 < 0f)
			{
				num9 = 0f;
			}
			else if (0f - num4 > num)
			{
				num9 = num7;
			}
			else
			{
				num9 = 0f - num4;
				num7 = num;
			}
		}
		else if (num10 > num8)
		{
			num10 = num8;
			if (0f - num4 + num2 < 0f)
			{
				num9 = 0f;
			}
			else if (0f - num4 + num2 > num)
			{
				num9 = num7;
			}
			else
			{
				num9 = 0f - num4 + num2;
				num7 = num;
			}
		}
		float num11 = ((Math.Abs(num9) < 1E-06f) ? 0f : (num9 / num7));
		float num12 = ((Math.Abs(num10) < 1E-06f) ? 0f : (num10 / num8));
		Vector3 val4 = val3 + num11 * val - num12 * val2;
		return ((Vector3)(ref val4)).sqrMagnitude;
	}

	public static float SqrDistanceXZ(Vector3 a, Vector3 b)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = a - b;
		return val.x * val.x + val.z * val.z;
	}

	public static long SignedTriangleAreaTimes2XZ(Int3 a, Int3 b, Int3 c)
	{
		return (long)(b.x - a.x) * (long)(c.z - a.z) - (long)(c.x - a.x) * (long)(b.z - a.z);
	}

	public static float SignedTriangleAreaTimes2XZ(Vector3 a, Vector3 b, Vector3 c)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		return (b.x - a.x) * (c.z - a.z) - (c.x - a.x) * (b.z - a.z);
	}

	public static bool RightXZ(Vector3 a, Vector3 b, Vector3 p)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		return (b.x - a.x) * (p.z - a.z) - (p.x - a.x) * (b.z - a.z) < -1E-45f;
	}

	public static bool RightXZ(Int3 a, Int3 b, Int3 p)
	{
		return (long)(b.x - a.x) * (long)(p.z - a.z) - (long)(p.x - a.x) * (long)(b.z - a.z) < 0;
	}

	public static bool RightOrColinear(Vector2 a, Vector2 b, Vector2 p)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		return (b.x - a.x) * (p.y - a.y) - (p.x - a.x) * (b.y - a.y) <= 0f;
	}

	public static bool RightOrColinear(Int2 a, Int2 b, Int2 p)
	{
		return (long)(b.x - a.x) * (long)(p.y - a.y) - (long)(p.x - a.x) * (long)(b.y - a.y) <= 0;
	}

	public static bool RightOrColinearXZ(Vector3 a, Vector3 b, Vector3 p)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		return (b.x - a.x) * (p.z - a.z) - (p.x - a.x) * (b.z - a.z) <= 0f;
	}

	public static bool RightOrColinearXZ(Int3 a, Int3 b, Int3 p)
	{
		return (long)(b.x - a.x) * (long)(p.z - a.z) - (long)(p.x - a.x) * (long)(b.z - a.z) <= 0;
	}

	public static bool IsClockwiseMarginXZ(Vector3 a, Vector3 b, Vector3 c)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		return (b.x - a.x) * (c.z - a.z) - (c.x - a.x) * (b.z - a.z) <= float.Epsilon;
	}

	public static bool IsClockwiseXZ(Vector3 a, Vector3 b, Vector3 c)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		return (b.x - a.x) * (c.z - a.z) - (c.x - a.x) * (b.z - a.z) < 0f;
	}

	public static bool IsClockwiseXZ(Int3 a, Int3 b, Int3 c)
	{
		return RightXZ(a, b, c);
	}

	public static bool IsClockwiseOrColinearXZ(Int3 a, Int3 b, Int3 c)
	{
		return RightOrColinearXZ(a, b, c);
	}

	public static bool IsClockwiseOrColinear(Int2 a, Int2 b, Int2 c)
	{
		return RightOrColinear(a, b, c);
	}

	public static bool IsColinear(Vector2 a, Vector2 b, Vector2 c)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		float num = (b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y);
		if (num <= 1E-07f)
		{
			return num >= -1E-07f;
		}
		return false;
	}

	public static bool IsColinear(Int2 a, Int2 b, Int2 c)
	{
		long num = (b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y);
		if (num <= 1)
		{
			return num >= -1;
		}
		return false;
	}

	public static bool IsColinearXZ(Int3 a, Int3 b, Int3 c)
	{
		return (long)(b.x - a.x) * (long)(c.z - a.z) - (long)(c.x - a.x) * (long)(b.z - a.z) == 0;
	}

	public static bool IsColinearXZ(Vector3 a, Vector3 b, Vector3 c)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		float num = (b.x - a.x) * (c.z - a.z) - (c.x - a.x) * (b.z - a.z);
		if (num <= 1E-07f)
		{
			return num >= -1E-07f;
		}
		return false;
	}

	public static bool IsColinearAlmostXZ(Int3 a, Int3 b, Int3 c)
	{
		long num = (long)(b.x - a.x) * (long)(c.z - a.z) - (long)(c.x - a.x) * (long)(b.z - a.z);
		if (num >= -1000)
		{
			return num <= 1000;
		}
		return false;
	}

	public static bool SegmentsIntersect(Int2 start1, Int2 end1, Int2 start2, Int2 end2)
	{
		if (RightOrColinear(start1, end1, start2) != RightOrColinear(start1, end1, end2))
		{
			return RightOrColinear(start2, end2, start1) != RightOrColinear(start2, end2, end1);
		}
		return false;
	}

	public static bool SegmentsIntersectXZ(Int3 start1, Int3 end1, Int3 start2, Int3 end2)
	{
		if (RightOrColinearXZ(start1, end1, start2) != RightOrColinearXZ(start1, end1, end2))
		{
			return RightOrColinearXZ(start2, end2, start1) != RightOrColinearXZ(start2, end2, end1);
		}
		return false;
	}

	public static bool SegmentsIntersectXZ(Vector3 start1, Vector3 end1, Vector3 start2, Vector3 end2)
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
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0056: Unknown result type (might be due to invalid IL or missing references)
		//IL_0060: Unknown result type (might be due to invalid IL or missing references)
		//IL_0066: Unknown result type (might be due to invalid IL or missing references)
		//IL_006c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0074: Unknown result type (might be due to invalid IL or missing references)
		//IL_007a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0080: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = end1 - start1;
		Vector3 val2 = end2 - start2;
		float num = val2.z * val.x - val2.x * val.z;
		if (num == 0f)
		{
			return false;
		}
		float num2 = val2.x * (start1.z - start2.z) - val2.z * (start1.x - start2.x);
		float num3 = val.x * (start1.z - start2.z) - val.z * (start1.x - start2.x);
		float num4 = num2 / num;
		float num5 = num3 / num;
		if (num4 < 0f || num4 > 1f || num5 < 0f || num5 > 1f)
		{
			return false;
		}
		return true;
	}

	public static Vector3 LineDirIntersectionPointXZ(Vector3 start1, Vector3 dir1, Vector3 start2, Vector3 dir2)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		//IL_0057: Unknown result type (might be due to invalid IL or missing references)
		//IL_005c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		float num = dir2.z * dir1.x - dir2.x * dir1.z;
		if (num == 0f)
		{
			return start1;
		}
		float num2 = dir2.x * (start1.z - start2.z) - dir2.z * (start1.x - start2.x);
		float num3 = num2 / num;
		return start1 + dir1 * num3;
	}

	public static Vector3 LineDirIntersectionPointXZ(Vector3 start1, Vector3 dir1, Vector3 start2, Vector3 dir2, out bool intersects)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0044: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_005c: Unknown result type (might be due to invalid IL or missing references)
		//IL_005d: Unknown result type (might be due to invalid IL or missing references)
		//IL_005f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0064: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		float num = dir2.z * dir1.x - dir2.x * dir1.z;
		if (num == 0f)
		{
			intersects = false;
			return start1;
		}
		float num2 = dir2.x * (start1.z - start2.z) - dir2.z * (start1.x - start2.x);
		float num3 = num2 / num;
		intersects = true;
		return start1 + dir1 * num3;
	}

	public static bool RaySegmentIntersectXZ(Int3 start1, Int3 end1, Int3 start2, Int3 end2)
	{
		Int3 @int = end1 - start1;
		Int3 int2 = end2 - start2;
		long num = int2.z * @int.x - int2.x * @int.z;
		if (num == 0L)
		{
			return false;
		}
		long num2 = int2.x * (start1.z - start2.z) - int2.z * (start1.x - start2.x);
		long num3 = @int.x * (start1.z - start2.z) - @int.z * (start1.x - start2.x);
		if (!((num2 < 0) ^ (num < 0)))
		{
			return false;
		}
		if (!((num3 < 0) ^ (num < 0)))
		{
			return false;
		}
		if ((num >= 0 && num3 > num) || (num < 0 && num3 <= num))
		{
			return false;
		}
		return true;
	}

	public static bool LineIntersectionFactorXZ(Int3 start1, Int3 end1, Int3 start2, Int3 end2, out VFactor factor1, out VFactor factor2)
	{
		Int3 @int = end1 - start1;
		Int3 int2 = end2 - start2;
		long num = (long)int2.z * (long)@int.x - (long)int2.x * (long)@int.z;
		if (num == 0L)
		{
			factor1 = VFactor.zero;
			factor2 = VFactor.zero;
			return false;
		}
		Int3 int3 = start1 - start2;
		long n = (long)int2.x * (long)int3.z - (long)int2.z * (long)int3.x;
		long n2 = (long)@int.x * (long)int3.z - (long)@int.z * (long)int3.x;
		factor1 = new VFactor(n, num);
		factor2 = new VFactor(n2, num);
		return true;
	}

	public static bool LineIntersectionFactorXZ(Vector3 start1, Vector3 end1, Vector3 start2, Vector3 end2, out float factor1, out float factor2)
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
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		//IL_005a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0062: Unknown result type (might be due to invalid IL or missing references)
		//IL_0068: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0078: Unknown result type (might be due to invalid IL or missing references)
		//IL_007e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0084: Unknown result type (might be due to invalid IL or missing references)
		//IL_008c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0092: Unknown result type (might be due to invalid IL or missing references)
		//IL_0098: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = end1 - start1;
		Vector3 val2 = end2 - start2;
		float num = val2.z * val.x - val2.x * val.z;
		if (num <= 1E-05f && num >= -1E-05f)
		{
			factor1 = 0f;
			factor2 = 0f;
			return false;
		}
		float num2 = val2.x * (start1.z - start2.z) - val2.z * (start1.x - start2.x);
		float num3 = val.x * (start1.z - start2.z) - val.z * (start1.x - start2.x);
		float num4 = num2 / num;
		float num5 = num3 / num;
		factor1 = num4;
		factor2 = num5;
		return true;
	}

	public static float LineRayIntersectionFactorXZ(Int3 start1, Int3 end1, Int3 start2, Int3 end2)
	{
		Int3 @int = end1 - start1;
		Int3 int2 = end2 - start2;
		int num = int2.z * @int.x - int2.x * @int.z;
		if (num == 0)
		{
			return float.NaN;
		}
		int num2 = int2.x * (start1.z - start2.z) - int2.z * (start1.x - start2.x);
		int num3 = @int.x * (start1.z - start2.z) - @int.z * (start1.x - start2.x);
		if ((float)num3 / (float)num < 0f)
		{
			return float.NaN;
		}
		return (float)num2 / (float)num;
	}

	public static float LineIntersectionFactorXZ(Vector3 start1, Vector3 end1, Vector3 start2, Vector3 end2)
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
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		//IL_005a: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = end1 - start1;
		Vector3 val2 = end2 - start2;
		float num = val2.z * val.x - val2.x * val.z;
		if (num == 0f)
		{
			return -1f;
		}
		float num2 = val2.x * (start1.z - start2.z) - val2.z * (start1.x - start2.x);
		return num2 / num;
	}

	public static VFactor LineIntersectionFactorXZ(Int3 start1, Int3 end1, Int3 start2, Int3 end2)
	{
		Int3 @int = end1 - start1;
		Int3 int2 = end2 - start2;
		long num = IntMath.Divide(int2.z * @int.x - int2.x * @int.z, 1000);
		if (num == 0L)
		{
			return -VFactor.one;
		}
		long n = IntMath.Divide(int2.x * (start1.z - start2.z) - int2.z * (start1.x - start2.x), 1000);
		return new VFactor(n, num);
	}

	public static Vector3 LineIntersectionPointXZ(Vector3 start1, Vector3 end1, Vector3 start2, Vector3 end2)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		bool intersects;
		return LineIntersectionPointXZ(start1, end1, start2, end2, out intersects);
	}

	public static Int3 LineIntersectionPointXZ(Int3 start1, Int3 end1, Int3 start2, Int3 end2)
	{
		bool intersects;
		return LineIntersectionPointXZ(start1, end1, start2, end2, out intersects);
	}

	public static Vector3 LineIntersectionPointXZ(Vector3 start1, Vector3 end1, Vector3 start2, Vector3 end2, out bool intersects)
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
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		//IL_005a: Unknown result type (might be due to invalid IL or missing references)
		//IL_006d: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0071: Unknown result type (might be due to invalid IL or missing references)
		//IL_0076: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = end1 - start1;
		Vector3 val2 = end2 - start2;
		float num = val2.z * val.x - val2.x * val.z;
		if (num == 0f)
		{
			intersects = false;
			return start1;
		}
		float num2 = val2.x * (start1.z - start2.z) - val2.z * (start1.x - start2.x);
		float num3 = num2 / num;
		intersects = true;
		return start1 + val * num3;
	}

	public static Int3 LineIntersectionPointXZ(Int3 start1, Int3 end1, Int3 start2, Int3 end2, out bool intersects)
	{
		Int3 @int = end1 - start1;
		Int3 int2 = end2 - start2;
		long num = int2.z * @int.x - int2.x * @int.z;
		if (num == 0L)
		{
			intersects = false;
			return start1;
		}
		long n = int2.x * (start1.z - start2.z) - int2.z * (start1.x - start2.x);
		VFactor vFactor = new VFactor(n, num);
		intersects = true;
		return start1 + @int * vFactor;
	}

	public static Vector2 LineIntersectionPoint(Vector2 start1, Vector2 end1, Vector2 start2, Vector2 end2)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		bool intersects;
		return LineIntersectionPoint(start1, end1, start2, end2, out intersects);
	}

	public static Vector2 LineIntersectionPoint(Vector2 start1, Vector2 end1, Vector2 start2, Vector2 end2, out bool intersects)
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
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		//IL_005a: Unknown result type (might be due to invalid IL or missing references)
		//IL_006d: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0071: Unknown result type (might be due to invalid IL or missing references)
		//IL_0076: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		Vector2 val = end1 - start1;
		Vector2 val2 = end2 - start2;
		float num = val2.y * val.x - val2.x * val.y;
		if (num == 0f)
		{
			intersects = false;
			return start1;
		}
		float num2 = val2.x * (start1.y - start2.y) - val2.y * (start1.x - start2.x);
		float num3 = num2 / num;
		intersects = true;
		return start1 + val * num3;
	}

	public static Vector3 SegmentIntersectionPointXZ(Vector3 start1, Vector3 end1, Vector3 start2, Vector3 end2, out bool intersects)
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
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		//IL_005a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0064: Unknown result type (might be due to invalid IL or missing references)
		//IL_006a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0070: Unknown result type (might be due to invalid IL or missing references)
		//IL_0078: Unknown result type (might be due to invalid IL or missing references)
		//IL_007e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0084: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d1: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = end1 - start1;
		Vector3 val2 = end2 - start2;
		float num = val2.z * val.x - val2.x * val.z;
		if (num == 0f)
		{
			intersects = false;
			return start1;
		}
		float num2 = val2.x * (start1.z - start2.z) - val2.z * (start1.x - start2.x);
		float num3 = val.x * (start1.z - start2.z) - val.z * (start1.x - start2.x);
		float num4 = num2 / num;
		float num5 = num3 / num;
		if (num4 < 0f || num4 > 1f || num5 < 0f || num5 > 1f)
		{
			intersects = false;
			return start1;
		}
		intersects = true;
		return start1 + val * num4;
	}

	public static Int3 SegmentIntersectionPointXZ(Int3 start1, Int3 end1, Int3 start2, Int3 end2, out bool intersects)
	{
		Int3 @int = end1 - start1;
		Int3 int2 = end2 - start2;
		long num = int2.z * @int.x - int2.x * @int.z;
		if (num == 0L)
		{
			intersects = false;
			return start1;
		}
		long num2 = int2.x * (start1.z - start2.z) - int2.z * (start1.x - start2.x);
		long num3 = @int.x * (start1.z - start2.z) - @int.z * (start1.x - start2.x);
		VFactor vFactor = new VFactor(num2 * 1000, num);
		VFactor vFactor2 = new VFactor(num3 * 1000, num);
		if (vFactor < VFactor.zero || vFactor > VFactor.one || vFactor2 < VFactor.zero || vFactor2 > VFactor.one)
		{
			intersects = false;
			return start1;
		}
		intersects = true;
		return start1 + @int * vFactor;
	}

	public static bool SegmentIntersectsBounds(Bounds bounds, Vector3 a, Vector3 b)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		//IL_002f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0062: Unknown result type (might be due to invalid IL or missing references)
		//IL_0067: Unknown result type (might be due to invalid IL or missing references)
		//IL_0068: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		//IL_0079: Unknown result type (might be due to invalid IL or missing references)
		//IL_0084: Unknown result type (might be due to invalid IL or missing references)
		//IL_008f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0095: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ab: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cf: Unknown result type (might be due to invalid IL or missing references)
		//IL_00dc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ef: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fb: Unknown result type (might be due to invalid IL or missing references)
		//IL_0101: Unknown result type (might be due to invalid IL or missing references)
		//IL_0108: Unknown result type (might be due to invalid IL or missing references)
		//IL_010e: Unknown result type (might be due to invalid IL or missing references)
		//IL_011b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0121: Unknown result type (might be due to invalid IL or missing references)
		//IL_0128: Unknown result type (might be due to invalid IL or missing references)
		//IL_012e: Unknown result type (might be due to invalid IL or missing references)
		//IL_013a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0140: Unknown result type (might be due to invalid IL or missing references)
		//IL_0147: Unknown result type (might be due to invalid IL or missing references)
		//IL_014d: Unknown result type (might be due to invalid IL or missing references)
		//IL_015a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0160: Unknown result type (might be due to invalid IL or missing references)
		//IL_0167: Unknown result type (might be due to invalid IL or missing references)
		//IL_016d: Unknown result type (might be due to invalid IL or missing references)
		a -= ((Bounds)(ref bounds)).center;
		b -= ((Bounds)(ref bounds)).center;
		Vector3 val = (a + b) * 0.5f;
		Vector3 val2 = a - val;
		Vector3 val3 = default(Vector3);
		((Vector3)(ref val3))._002Ector(Math.Abs(val2.x), Math.Abs(val2.y), Math.Abs(val2.z));
		Vector3 extents = ((Bounds)(ref bounds)).extents;
		if (Math.Abs(val.x) > extents.x + val3.x)
		{
			return false;
		}
		if (Math.Abs(val.y) > extents.y + val3.y)
		{
			return false;
		}
		if (Math.Abs(val.z) > extents.z + val3.z)
		{
			return false;
		}
		if (Math.Abs(val.y * val2.z - val.z * val2.y) > extents.y * val3.z + extents.z * val3.y)
		{
			return false;
		}
		if (Math.Abs(val.x * val2.z - val.z * val2.x) > extents.x * val3.z + extents.z * val3.x)
		{
			return false;
		}
		if (Math.Abs(val.x * val2.y - val.y * val2.x) > extents.x * val3.y + extents.y * val3.x)
		{
			return false;
		}
		return true;
	}

	public static float LineCircleIntersectionFactor(Vector3 circleCenter, Vector3 linePoint1, Vector3 linePoint2, float radius)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = Normalize(linePoint2 - linePoint1, out var magnitude);
		Vector3 val2 = linePoint1 - circleCenter;
		float num = Vector3.Dot(val2, val);
		float num2 = num * num - (((Vector3)(ref val2)).sqrMagnitude - radius * radius);
		if (num2 < 0f)
		{
			num2 = 0f;
		}
		float num3 = 0f - num + Mathf.Sqrt(num2);
		if (!(magnitude > 1E-05f))
		{
			return 1f;
		}
		return num3 / magnitude;
	}

	public static VFactor LineCircleIntersectionFactor(Int3 circleCenter, Int3 linePoint1, Int3 linePoint2, Int radius)
	{
		Int3 rhs = Normalize(linePoint2 - linePoint1, out var magnitude);
		Int3 lhs = linePoint1 - circleCenter;
		Int obj = (Int)new VFactor(Int3.Dot(lhs, rhs), 1000000L);
		long num = obj.i * obj.i - (lhs.sqrMagnitudeLong - radius.i * radius.i);
		if (num < 0)
		{
			num = 0L;
		}
		long n = -obj.i + IntMath.Sqrt(num);
		if (magnitude <= 0)
		{
			return VFactor.one;
		}
		return new VFactor(n, magnitude);
	}

	public static bool ReversesFaceOrientations(Matrix4x4 matrix)
	{
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		//IL_0056: Unknown result type (might be due to invalid IL or missing references)
		//IL_005b: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = ((Matrix4x4)(ref matrix)).MultiplyVector(new Vector3(1f, 0f, 0f));
		Vector3 val2 = ((Matrix4x4)(ref matrix)).MultiplyVector(new Vector3(0f, 1f, 0f));
		Vector3 val3 = ((Matrix4x4)(ref matrix)).MultiplyVector(new Vector3(0f, 0f, 1f));
		float num = Vector3.Dot(Vector3.Cross(val, val2), val3);
		return num < 0f;
	}

	public static bool ReversesFaceOrientationsXZ(Matrix4x4 matrix)
	{
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		//IL_004b: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = ((Matrix4x4)(ref matrix)).MultiplyVector(new Vector3(1f, 0f, 0f));
		Vector3 val2 = ((Matrix4x4)(ref matrix)).MultiplyVector(new Vector3(0f, 0f, 1f));
		float num = val.x * val2.z - val2.x * val.z;
		return num < 0f;
	}

	public static Vector3 Normalize(Vector3 v, out float magnitude)
	{
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		magnitude = ((Vector3)(ref v)).magnitude;
		if (magnitude > 1E-05f)
		{
			return v / magnitude;
		}
		return Vector3.zero;
	}

	public static Int3 Normalize(Int3 v, out long magnitude)
	{
		magnitude = v.Normalize();
		return v;
	}

	public static Vector2 Normalize(Vector2 v, out float magnitude)
	{
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		magnitude = ((Vector2)(ref v)).magnitude;
		if (magnitude > 1E-05f)
		{
			return v / magnitude;
		}
		return Vector2.zero;
	}

	public static Vector3 ClampMagnitudeXZ(Vector3 v, float maxMagnitude)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_004b: Unknown result type (might be due to invalid IL or missing references)
		float num = v.x * v.x + v.z * v.z;
		if (num > maxMagnitude * maxMagnitude && maxMagnitude > 0f)
		{
			float num2 = maxMagnitude / Mathf.Sqrt(num);
			v.x *= num2;
			v.z *= num2;
		}
		return v;
	}

	public static float MagnitudeXZ(Vector3 v)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		return Mathf.Sqrt(v.x * v.x + v.z * v.z);
	}
}
