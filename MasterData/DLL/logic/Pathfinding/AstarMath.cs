using System;
using UnityEngine;

namespace Pathfinding;

public static class AstarMath
{
	[Obsolete("Use VectorMath.ClosestPointOnLine instead")]
	public static Vector3 NearestPoint(Vector3 lineStart, Vector3 lineEnd, Vector3 point)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.ClosestPointOnLine(lineStart, lineEnd, point);
	}

	[Obsolete("Use VectorMath.ClosestPointOnLineFactor instead")]
	public static float NearestPointFactor(Vector3 lineStart, Vector3 lineEnd, Vector3 point)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.ClosestPointOnLineFactor(lineStart, lineEnd, point);
	}

	[Obsolete("Use VectorMath.ClosestPointOnLineFactor instead")]
	public static VFactor NearestPointFactor(Int3 lineStart, Int3 lineEnd, Int3 point)
	{
		return VectorMath.ClosestPointOnLineFactor(lineStart, lineEnd, point);
	}

	[Obsolete("Use VectorMath.ClosestPointOnLineFactor instead")]
	public static float NearestPointFactor(Int2 lineStart, Int2 lineEnd, Int2 point)
	{
		return VectorMath.ClosestPointOnLineFactor(lineStart, lineEnd, point);
	}

	[Obsolete("Use VectorMath.ClosestPointOnSegment instead")]
	public static Vector3 NearestPointStrict(Vector3 lineStart, Vector3 lineEnd, Vector3 point)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.ClosestPointOnSegment(lineStart, lineEnd, point);
	}

	[Obsolete("Use VectorMath.ClosestPointOnSegmentXZ instead")]
	public static Vector3 NearestPointStrictXZ(Vector3 lineStart, Vector3 lineEnd, Vector3 point)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.ClosestPointOnSegmentXZ(lineStart, lineEnd, point);
	}

	[Obsolete("Use VectorMath.SqrDistancePointSegmentApproximate instead")]
	public static float DistancePointSegment(int x, int z, int px, int pz, int qx, int qz)
	{
		return VectorMath.SqrDistancePointSegmentApproximate(x, z, px, pz, qx, qz);
	}

	[Obsolete("Use VectorMath.SqrDistancePointSegmentApproximate instead")]
	public static float DistancePointSegment(Int3 a, Int3 b, Int3 p)
	{
		return VectorMath.SqrDistancePointSegmentApproximate(a, b, p);
	}

	[Obsolete("Use VectorMath.SqrDistancePointSegment instead")]
	public static float DistancePointSegmentStrict(Vector3 a, Vector3 b, Vector3 p)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.SqrDistancePointSegment(a, b, p);
	}

	[Obsolete("Use AstarSplines.CubicBezier instead")]
	public static Vector3 CubicBezier(Vector3 p0, Vector3 p1, Vector3 p2, Vector3 p3, float t)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		return AstarSplines.CubicBezier(p0, p1, p2, p3, t);
	}

	[Obsolete("Use Mathf.InverseLerp instead")]
	public static float MapTo(float startMin, float startMax, float value)
	{
		return Mathf.InverseLerp(startMin, startMax, value);
	}

	public static float MapTo(float startMin, float startMax, float targetMin, float targetMax, float value)
	{
		return Mathf.Lerp(targetMin, targetMax, Mathf.InverseLerp(startMin, startMax, value));
	}

	public static string FormatBytesBinary(int bytes)
	{
		double num = ((bytes >= 0) ? 1.0 : (-1.0));
		bytes = Mathf.Abs(bytes);
		if (bytes < 1024)
		{
			return (double)bytes * num + " bytes";
		}
		if (bytes < 1048576)
		{
			return ((double)bytes / 1024.0 * num).ToString("0.0") + " KiB";
		}
		if (bytes < 1073741824)
		{
			return ((double)bytes / 1048576.0 * num).ToString("0.0") + " MiB";
		}
		return ((double)bytes / 1073741824.0 * num).ToString("0.0") + " GiB";
	}

	private static int Bit(int a, int b)
	{
		return (a >> b) & 1;
	}

	public static Color IntToColor(int i, float a)
	{
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		int num = Bit(i, 2) + Bit(i, 3) * 2 + 1;
		int num2 = Bit(i, 1) + Bit(i, 4) * 2 + 1;
		int num3 = Bit(i, 0) + Bit(i, 5) * 2 + 1;
		return new Color((float)num * 0.25f, (float)num2 * 0.25f, (float)num3 * 0.25f, a);
	}

	public static Color HSVToRGB(float h, float s, float v)
	{
		//IL_00b1: Unknown result type (might be due to invalid IL or missing references)
		float num = 0f;
		float num2 = 0f;
		float num3 = 0f;
		float num4 = s * v;
		float num5 = h / 60f;
		float num6 = num4 * (1f - Math.Abs(num5 % 2f - 1f));
		if (num5 < 1f)
		{
			num = num4;
			num2 = num6;
		}
		else if (num5 < 2f)
		{
			num = num6;
			num2 = num4;
		}
		else if (num5 < 3f)
		{
			num2 = num4;
			num3 = num6;
		}
		else if (num5 < 4f)
		{
			num2 = num6;
			num3 = num4;
		}
		else if (num5 < 5f)
		{
			num = num6;
			num3 = num4;
		}
		else if (num5 < 6f)
		{
			num = num4;
			num3 = num6;
		}
		float num7 = v - num4;
		num += num7;
		num2 += num7;
		num3 += num7;
		return new Color(num, num2, num3);
	}

	[Obsolete("Use VectorMath.SqrDistanceXZ instead")]
	public static float SqrMagnitudeXZ(Vector3 a, Vector3 b)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		return VectorMath.SqrDistanceXZ(a, b);
	}

	[Obsolete("Obsolete", true)]
	public static float DistancePointSegment2(int x, int z, int px, int pz, int qx, int qz)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Obsolete", true)]
	public static float DistancePointSegment2(Vector3 a, Vector3 b, Vector3 p)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Use Int3.GetHashCode instead", true)]
	public static int ComputeVertexHash(int x, int y, int z)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Obsolete", true)]
	public static float Hermite(float start, float end, float value)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Obsolete", true)]
	public static float MapToRange(float targetMin, float targetMax, float value)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Obsolete", true)]
	public static string FormatBytes(int bytes)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Obsolete", true)]
	public static float MagnitudeXZ(Vector3 a, Vector3 b)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Obsolete", true)]
	public static int Repeat(int i, int n)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Use Mathf.Abs instead", true)]
	public static float Abs(float a)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Use Mathf.Abs instead", true)]
	public static int Abs(int a)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Use Mathf.Min instead", true)]
	public static float Min(float a, float b)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Use Mathf.Min instead", true)]
	public static int Min(int a, int b)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Use Mathf.Min instead", true)]
	public static uint Min(uint a, uint b)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Use Mathf.Max instead", true)]
	public static float Max(float a, float b)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Use Mathf.Max instead", true)]
	public static int Max(int a, int b)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Use Mathf.Max instead", true)]
	public static uint Max(uint a, uint b)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Use Mathf.Max instead", true)]
	public static ushort Max(ushort a, ushort b)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Use Mathf.Sign instead", true)]
	public static float Sign(float a)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Use Mathf.Sign instead", true)]
	public static int Sign(int a)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Use Mathf.Clamp instead", true)]
	public static float Clamp(float a, float b, float c)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Use Mathf.Clamp instead", true)]
	public static int Clamp(int a, int b, int c)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Use Mathf.Clamp01 instead", true)]
	public static float Clamp01(float a)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Use Mathf.Clamp01 instead", true)]
	public static int Clamp01(int a)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Use Mathf.Lerp instead", true)]
	public static float Lerp(float a, float b, float t)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Use Mathf.RoundToInt instead", true)]
	public static int RoundToInt(float v)
	{
		throw new NotImplementedException("Obsolete");
	}

	[Obsolete("Use Mathf.RoundToInt instead", true)]
	public static int RoundToInt(double v)
	{
		throw new NotImplementedException("Obsolete");
	}
}
