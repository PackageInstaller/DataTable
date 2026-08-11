using System;
using System.Collections.Generic;
using GameFramework;
using PrimitiveDetection;
using UnityEngine;

namespace Ase;

public static class IntersectionDetection
{
	private static float SqrDistance(Vector3 a, Vector3 b)
	{
		float num = a.x - b.x;
		float num2 = a.y - b.y;
		float num3 = a.z - b.z;
		return num * num + num2 * num2 + num3 * num3;
	}

	private static float SqrNumber(float n)
	{
		return n * n;
	}

	public static bool BoxAndBox(BoxPrimitive one, BoxPrimitive two)
	{
		if (!BoxAndSphere(one, two.boxCenter, two.HalfSize.sqrMagnitude, isSqrSphRad: true) && !BoxAndSphere(two, one.boxCenter, one.HalfSize.sqrMagnitude, isSqrSphRad: true))
		{
			return false;
		}
		Vector3 toCentre = two.GetAxis(3) - one.GetAxis(3);
		Vector3 axis = one.GetAxis(0);
		Vector3 axis2 = one.GetAxis(1);
		Vector3 axis3 = one.GetAxis(2);
		Vector3 axis4 = two.GetAxis(0);
		Vector3 axis5 = two.GetAxis(1);
		Vector3 axis6 = two.GetAxis(2);
		if (!TryAxis(one, two, axis, toCentre))
		{
			return false;
		}
		if (!TryAxis(one, two, axis2, toCentre))
		{
			return false;
		}
		if (!TryAxis(one, two, axis3, toCentre))
		{
			return false;
		}
		if (!TryAxis(one, two, axis4, toCentre))
		{
			return false;
		}
		if (!TryAxis(one, two, axis5, toCentre))
		{
			return false;
		}
		if (!TryAxis(one, two, axis6, toCentre))
		{
			return false;
		}
		if (!TryAxis(one, two, Vector3.Cross(axis, axis4), toCentre))
		{
			return false;
		}
		if (!TryAxis(one, two, Vector3.Cross(axis, axis5), toCentre))
		{
			return false;
		}
		if (!TryAxis(one, two, Vector3.Cross(axis, axis6), toCentre))
		{
			return false;
		}
		if (!TryAxis(one, two, Vector3.Cross(axis2, axis4), toCentre))
		{
			return false;
		}
		if (!TryAxis(one, two, Vector3.Cross(axis2, axis5), toCentre))
		{
			return false;
		}
		if (!TryAxis(one, two, Vector3.Cross(axis2, axis6), toCentre))
		{
			return false;
		}
		if (!TryAxis(one, two, Vector3.Cross(axis3, axis4), toCentre))
		{
			return false;
		}
		if (!TryAxis(one, two, Vector3.Cross(axis3, axis5), toCentre))
		{
			return false;
		}
		if (!TryAxis(one, two, Vector3.Cross(axis3, axis6), toCentre))
		{
			return false;
		}
		return true;
	}

	private static bool TryAxis(BoxPrimitive one, BoxPrimitive two, Vector3 axis, Vector3 toCentre)
	{
		if (Vector3.SqrMagnitude(axis) < 1E-06f)
		{
			return true;
		}
		axis.Normalize();
		if (PenetrationOnAxis(one, two, axis, toCentre) < 0f)
		{
			return false;
		}
		return true;
	}

	private static float PenetrationOnAxis(BoxPrimitive one, BoxPrimitive two, Vector3 axis, Vector3 toCentre)
	{
		return TransformToAxis(one, axis) + TransformToAxis(two, axis) - ABS(Vector3.Dot(toCentre, axis));
	}

	private static float TransformToAxis(BoxPrimitive box, Vector3 axis)
	{
		return box.HalfSize.x * ABS(Vector3.Dot(axis, box.GetAxis(0))) + box.HalfSize.y * ABS(Vector3.Dot(axis, box.GetAxis(1))) + box.HalfSize.z * ABS(Vector3.Dot(axis, box.GetAxis(2)));
	}

	public static bool BoxAndSphere(BoxPrimitive boxPrimitive, SpherePrimitive spherePrimitive)
	{
		return BoxAndSphere(boxPrimitive, spherePrimitive.SphereCenter, spherePrimitive.Radius);
	}

	public static bool BoxAndSphere(Vector3 sphereCenter, float sphereRadius, Vector3 boxCenter, Vector3 boxHalfSize)
	{
		return Vector3.SqrMagnitude(Vector3.Max(Vector3.Max(sphereCenter - boxCenter, boxCenter - sphereCenter) - boxHalfSize, Vector3.zero)) <= sphereRadius * sphereRadius;
	}

	public static bool BoxAndSphere(BoxPrimitive boxPrimitive, Vector3 sphereCenter, float sphereRadius, bool isSqrSphRad = false)
	{
		Vector3 vector = boxPrimitive.Transform.TransformInverse(sphereCenter);
		Vector3 vector2 = new Vector3(Mathf.Clamp(vector.x, 0f - boxPrimitive.HalfSize.x, boxPrimitive.HalfSize.x), Mathf.Clamp(vector.y, 0f - boxPrimitive.HalfSize.y, boxPrimitive.HalfSize.y), Mathf.Clamp(vector.z, 0f - boxPrimitive.HalfSize.z, boxPrimitive.HalfSize.z));
		Vector3 b = boxPrimitive.Transform.Transform(vector2);
		return SqrDistance(sphereCenter, b) <= (isSqrSphRad ? sphereRadius : SqrNumber(sphereRadius));
	}

	public static Vector3 ClosestPointOnBox(SpherePrimitive p, BoxPrimitive b)
	{
		ClosestPointBoxSphere(p, b, out var vBox, out var _);
		return vBox;
	}

	public static bool BoxAndLine(Vector3 point, Vector3 direct, BoxPrimitive boxPrimitive)
	{
		Vector3 v = new Vector3(1f / direct.x, 1f / direct.y, 1f / direct.z);
		Vector3 vector = boxPrimitive.Vertices[0];
		Vector3 vector2 = boxPrimitive.Vertices[0];
		for (int i = 0; i < boxPrimitive.Vertices.Length; i++)
		{
			if (ComparePosition(boxPrimitive.Vertices[i], vector))
			{
				vector = boxPrimitive.Vertices[i];
			}
			if (ComparePosition(vector2, boxPrimitive.Vertices[i]))
			{
				vector2 = boxPrimitive.Vertices[i];
			}
		}
		Vector3 lhs = PrimitiveExtension.VMul(vector - point, v);
		Vector3 rhs = PrimitiveExtension.VMul(vector2 - point, v);
		Vector3 vector3 = Vector3.Min(lhs, rhs);
		Vector3 vector4 = Vector3.Max(lhs, rhs);
		float num = Mathf.Max(Mathf.Max(vector3.x, vector3.y), vector3.z);
		float num2 = Mathf.Min(Mathf.Min(vector4.x, vector4.y), vector4.z);
		return num <= num2;
	}

	public static bool BoxAndRay(Vector3 point, Vector3 direct, BoxPrimitive boxPrimitive)
	{
		Vector3 normalized = direct.normalized;
		Vector3 vector = new Vector3(Mathf.Abs(normalized.x), Mathf.Abs(normalized.y), Mathf.Abs(normalized.z));
		Vector3 axis = boxPrimitive.GetAxis(3);
		Vector3 halfSize = boxPrimitive.HalfSize;
		float num = point.x - axis.x;
		float num2 = Mathf.Abs(num);
		float num3 = num * normalized.x;
		if (num2 > halfSize.x && num3 >= 0f)
		{
			return false;
		}
		float num4 = point.y - axis.y;
		float num5 = Mathf.Abs(num4);
		num3 = num4 * normalized.y;
		if (num5 > halfSize.y && num3 >= 0f)
		{
			return false;
		}
		float num6 = point.z - axis.z;
		float num7 = Mathf.Abs(num6);
		num3 = num6 * normalized.z;
		if (num7 > halfSize.z && num3 >= 0f)
		{
			return false;
		}
		float num8 = Mathf.Abs(normalized.y * num6 - normalized.z * num4);
		float num9 = halfSize.y * vector.z;
		float num10 = halfSize.z * vector.y;
		if (num8 > num9 + num10)
		{
			return false;
		}
		float num11 = Mathf.Abs(normalized.z * num - normalized.x * num6);
		num9 = halfSize.x * vector.z;
		num10 = halfSize.z * vector.x;
		if (num11 > num9 + num10)
		{
			return false;
		}
		float num12 = Mathf.Abs(normalized.x * num4 - normalized.y * num);
		num9 = halfSize.x * vector.y;
		num10 = halfSize.y * vector.x;
		if (num12 > num9 + num10)
		{
			return false;
		}
		return true;
	}

	public static bool SphereAndSphere(SpherePrimitive one, SpherePrimitive two)
	{
		Vector3 axis = one.GetAxis(3);
		Vector3 axis2 = two.GetAxis(3);
		if (SqrDistance(axis, axis2) > SqrNumber(one.Radius + two.Radius))
		{
			return false;
		}
		return true;
	}

	public static Vector3 ClosestPointOnSphere(SpherePrimitive p, BoxPrimitive b)
	{
		ClosestPointBoxSphere(p, b, out var _, out var vSphere);
		return vSphere;
	}

	public static bool SphereAndRay(Vector3 point, Vector3 direct, SpherePrimitive spherePrimitive)
	{
		return SqrDistance(NearestPointOnRay(point, direct, spherePrimitive.SphereCenter), spherePrimitive.SphereCenter) <= SqrNumber(spherePrimitive.Radius);
	}

	public static bool SectorAndSphere(SectorPrimitive sectorPrimitive, SpherePrimitive spherePrimitive)
	{
		if (!sectorPrimitive.InternalCheckPrimitive() || !spherePrimitive.InternalCheckPrimitive())
		{
			return false;
		}
		Vector3 vector = spherePrimitive.SphereCenter - sectorPrimitive.SectorCenter;
		float num = sectorPrimitive.Radius + spherePrimitive.Radius;
		if (Vector3.SqrMagnitude(vector) > num * num)
		{
			return false;
		}
		PointProjectionOnPlane(sectorPrimitive.LocalUnitY, sectorPrimitive.SectorCenter, spherePrimitive.SphereCenter, out var fpB);
		if (SqrDistance(spherePrimitive.SphereCenter, fpB) > SqrNumber(spherePrimitive.Radius))
		{
			return false;
		}
		Vector3 vector2 = sectorPrimitive.Transform2Local(spherePrimitive.SphereCenter);
		if (vector2.x > Vector3.Magnitude(vector) * Mathf.Cos(sectorPrimitive.Angle / 2f))
		{
			if (vector2.x <= sectorPrimitive.Radius)
			{
				if (vector2.y <= spherePrimitive.Radius)
				{
					return true;
				}
				return false;
			}
			Vector3 vector3 = sectorPrimitive.Radius * new Vector3(vector2.x, 0f, vector2.z).normalized - vector2;
			if (vector2.y <= spherePrimitive.Radius && vector3.sqrMagnitude <= SqrNumber(spherePrimitive.Radius))
			{
				return true;
			}
			return false;
		}
		Vector3 u = sectorPrimitive.Radius * new Vector3(Mathf.Cos(sectorPrimitive.Angle / 2f), 0f, Mathf.Sin(sectorPrimitive.Angle / 2f));
		vector2.y = Mathf.Abs(vector2.y);
		vector2.z = Mathf.Abs(vector2.z);
		return SegmentPointSqrDistance(Vector3.zero, u, vector2) <= spherePrimitive.Radius * spherePrimitive.Radius;
	}

	public static bool SectorAndBox(SectorPrimitive sectorPrimitive, BoxPrimitive boxPrimitive, out PolygonPrimitive polygonPrimitive)
	{
		polygonPrimitive = null;
		if (!sectorPrimitive.InternalCheckPrimitive() || !boxPrimitive.InternalCheckPrimitive())
		{
			return false;
		}
		if (!BoxAndSphere(boxPrimitive, sectorPrimitive.SectorCenter, sectorPrimitive.Radius))
		{
			return false;
		}
		Vector3 footPoint = Vector3.zero;
		List<Vector3> list = new List<Vector3>();
		int index = 0;
		for (int i = 0; i < PrimitiveExtension.Lines.GetLength(0); i++)
		{
			int num = PrimitiveExtension.Lines[i, 0];
			int num2 = PrimitiveExtension.Lines[i, 1];
			if (LineSegmentFootPointOnPlane(boxPrimitive.Vertices[num], boxPrimitive.Vertices[num2], sectorPrimitive.SectorCenter, sectorPrimitive.LocalUnitY, out footPoint))
			{
				list.Add(footPoint);
				if (footPoint.x >= list[index].x)
				{
					index = list.Count - 1;
				}
			}
		}
		if (list.Count <= 0)
		{
			return false;
		}
		polygonPrimitive = PolygonPrimitive.Create(list, sectorPrimitive.SectorCenter, sectorPrimitive.Quaternion);
		if (!GetGravityPoint(polygonPrimitive, out var _))
		{
			polygonPrimitive.XAxisSymmetric();
		}
		index = 1;
		int[] verSort = polygonPrimitive.verSort;
		foreach (int num3 in verSort)
		{
			footPoint = polygonPrimitive.Vertices[num3] - sectorPrimitive.SectorCenter;
			float num4 = Vector3.Dot(footPoint, sectorPrimitive.LocalUnitX);
			if (Mathf.Abs(num4) > 0.0001f && num4 > 0f)
			{
				index = 0;
			}
		}
		if (index != 0 && sectorPrimitive.Angle < MathF.PI)
		{
			return false;
		}
		bool flag = false;
		if (sectorPrimitive.Angle > MathF.PI)
		{
			sectorPrimitive = SectorPrimitive.Create(sectorPrimitive.SectorCenter, sectorPrimitive.Quaternion * Quaternion.Euler(new Vector3(0f, (0f - sectorPrimitive.Angle) * 57.29578f / 4f, 0f)), sectorPrimitive.Angle * 57.29578f / 2f, sectorPrimitive.Radius);
			flag = true;
		}
		if (!sectorPrimitive.InternalCheckPrimitive())
		{
			if (flag)
			{
				sectorPrimitive.OnDispose();
			}
			return false;
		}
		bool flag2 = true;
		Vector3 lineStart;
		Vector3 lineEnd;
		for (int k = 0; k < polygonPrimitive.verSort.Length; k++)
		{
			Vector3 start = polygonPrimitive.Vertices[polygonPrimitive.verSort[k]];
			Vector3 end = polygonPrimitive.Vertices[polygonPrimitive.verSort[(k + 1 < polygonPrimitive.verSort.Length) ? (k + 1) : 0]];
			if (IsSectorIntersectLineSeg(sectorPrimitive, start, end, out lineStart, out lineEnd))
			{
				flag2 = false;
				break;
			}
		}
		if (flag2)
		{
			if (flag)
			{
				sectorPrimitive.OnDispose();
			}
			return false;
		}
		int num5 = 0;
		Vector3[] array = new Vector3[polygonPrimitive.Vertices.Length];
		for (int l = 0; l < polygonPrimitive.Vertices.Length; l++)
		{
			if (SqrDistance(polygonPrimitive.Vertices[l], sectorPrimitive.SectorCenter) <= SqrDistance(polygonPrimitive.Vertices[num5], sectorPrimitive.SectorCenter))
			{
				num5 = l;
			}
		}
		IsSectorIntersectLineSeg(sectorPrimitive, sectorPrimitive.SectorCenter, polygonPrimitive.Vertices[num5], out lineStart, out lineEnd);
		for (int m = 0; m < polygonPrimitive.Vertices.Length; m++)
		{
			array[m] = PointProjectionOnLineSeg(lineStart, lineEnd, polygonPrimitive.Vertices[polygonPrimitive.verSort[m]]);
		}
		int maxindex = 0;
		int maxindex2 = 0;
		FarthestPointsWithoutReturn(array, array.Length, ref maxindex, ref maxindex2);
		Vector3 line2P = (ComparePosition(array[maxindex], array[maxindex2]) ? array[maxindex] : array[maxindex2]);
		Vector3 line2P2 = ((!ComparePosition(array[maxindex], array[maxindex2])) ? array[maxindex] : array[maxindex2]);
		if (!IsLineSegIntersectLineSeg(lineStart, lineEnd, line2P, line2P2, out var intersectPos))
		{
			if (flag)
			{
				sectorPrimitive.OnDispose();
			}
			return false;
		}
		Vector3 point = sectorPrimitive.Radius * new Vector3(Mathf.Cos(sectorPrimitive.Angle / 2f), 0f, Mathf.Sin(sectorPrimitive.Angle / 2f));
		point = sectorPrimitive.Transform2World(point);
		IsSectorIntersectLineSeg(sectorPrimitive, point, sectorPrimitive.SectorCenter, out lineStart, out lineEnd);
		for (int n = 0; n < polygonPrimitive.Vertices.Length; n++)
		{
			array[n] = PointProjectionOnLineSeg(lineStart, lineEnd, polygonPrimitive.Vertices[polygonPrimitive.verSort[n]]);
		}
		FarthestPointsWithoutReturn(array, array.Length, ref maxindex, ref maxindex2);
		line2P = (ComparePosition(array[maxindex], array[maxindex2]) ? array[maxindex] : array[maxindex2]);
		line2P2 = ((!ComparePosition(array[maxindex], array[maxindex2])) ? array[maxindex] : array[maxindex2]);
		flag2 = IsLineSegIntersectLineSeg(lineStart, lineEnd, line2P, line2P2, out intersectPos);
		if (flag)
		{
			sectorPrimitive.OnDispose();
		}
		return flag2;
	}

	public static bool SectorAndSector(SectorPrimitive one, SectorPrimitive two)
	{
		Vector3 vector = one.Transform2Local(two.SectorCenter);
		if ((double)Mathf.Abs(Vector3.Dot(two.SectorCenter - one.SectorCenter, one.LocalUnitY)) < 0.0001)
		{
			return false;
		}
		if (vector.sqrMagnitude > SqrNumber(one.Radius + two.Radius))
		{
			return false;
		}
		Vector3 point = two.Radius * new Vector3(Mathf.Cos(two.Angle / 2f), 0f, Mathf.Sin(two.Angle / 2f));
		point = two.Transform2World(point);
		Vector3 point2 = two.Radius * new Vector3(Mathf.Cos(two.Angle / 2f), 0f, 0f - Mathf.Sin(two.Angle / 2f));
		point2 = two.Transform2World(point2);
		if (IsSectorHasPoint(one, two.SectorCenter) || IsSectorHasPoint(one, point) || IsSectorHasPoint(one, point2))
		{
			return true;
		}
		_ = vector.x;
		_ = Vector3.Magnitude(vector) * Mathf.Cos(one.Angle / 2f);
		return false;
	}

	private static bool IsSectorHasPoint(SectorPrimitive sector, Vector3 point)
	{
		Vector3 lhs = point - sector.SectorCenter;
		if (!(Mathf.Abs(Vector3.Dot(lhs, sector.LocalUnitY)) < 0.0001f))
		{
			return false;
		}
		if (lhs.sqrMagnitude > SqrNumber(sector.Radius))
		{
			return false;
		}
		return IsInsideSectorAngle(sector, point);
	}

	private static bool IsInsideSectorAngle(SectorPrimitive sector, Vector3 point)
	{
		Vector3 vector = sector.Transform2Local(point);
		float num = Mathf.Acos(vector.x / vector.magnitude);
		num *= 2f;
		if ((double)Mathf.Abs(num - sector.Angle) <= 0.01)
		{
			return true;
		}
		return num <= sector.Angle;
	}

	private static bool IsCircleIntersectLineSeg(Vector3 circleCenter, float radius, Vector3 seg1, Vector3 seg2)
	{
		Vector3 lhs = seg2 - seg1;
		Vector3 vector = circleCenter - seg1;
		float num = Vector3.Dot(lhs, vector);
		Vector3 a = ((num <= 0f) ? seg1 : ((!(SqrNumber(num) >= lhs.sqrMagnitude)) ? (seg1 + vector * num) : seg2));
		return SqrDistance(a, circleCenter) <= SqrNumber(radius);
	}

	private static bool IsSectorIntersectLineSeg(SectorPrimitive sector, Vector3 start, Vector3 end, out Vector3 lineStart, out Vector3 lineEnd)
	{
		Vector3 vector = start - end;
		Vector3 vector2 = end - start;
		bool flag = false;
		bool flag2 = false;
		Vector3 p = Vector3.zero;
		Vector3 p2 = Vector3.zero;
		Vector3 vector3 = end + Vector3.Cross(vector, sector.LocalUnitY);
		Vector3 vector4 = PointProjectionOnLineSeg(start, end, vector3);
		Vector3 vector5 = vector4 + (vector4 - vector3);
		Vector3 vector6 = (start + end) / 2f;
		Vector3 vector7 = vector3 - vector4;
		Vector3 vector8 = vector5 - vector4;
		Vector3 lineP = vector6 + vector7;
		if (IsInsideSectorAngle(sector, sector.SectorCenter + vector))
		{
			p = sector.SectorCenter + vector.normalized * sector.Radius;
			flag = true;
		}
		if (IsInsideSectorAngle(sector, sector.SectorCenter + vector2))
		{
			p2 = sector.SectorCenter + vector2.normalized * sector.Radius;
			flag2 = true;
		}
		Vector3 vector9 = PointProjectionOnLineSeg(vector6, lineP, sector.SectorCenter);
		Vector3 vector10 = PointProjectionOnLineSeg(vector6, lineP, sector.EdgeVertices[0]);
		Vector3 vector11 = PointProjectionOnLineSeg(vector6, lineP, sector.EdgeVertices[1]);
		lineStart = vector9;
		lineEnd = vector10;
		Vector3 vector12 = vector9;
		Vector3 vector13 = vector9;
		Vector3 normalized = vector7.normalized;
		if (IsInsideSectorAngle(sector, sector.SectorCenter + normalized * sector.Radius))
		{
			vector12 = sector.SectorCenter + normalized * sector.Radius;
			vector12 = PointProjectionOnLineSeg(vector6, lineP, vector12);
		}
		Vector3 normalized2 = vector8.normalized;
		if (IsInsideSectorAngle(sector, sector.SectorCenter + normalized2 * sector.Radius))
		{
			vector13 = sector.SectorCenter + normalized2 * sector.Radius;
			vector13 = PointProjectionOnLineSeg(vector6, lineP, vector13);
		}
		Vector3[] array;
		if (flag & flag2)
		{
			Vector3 p3 = sector.SectorCenter + sector.Radius * lineP.normalized;
			p3 = PointProjectionOnLineSeg(vector6, lineP, p3);
			Vector3 vector14 = PointProjectionOnLineSeg(vector6, lineP, p);
			Vector3 vector15 = PointProjectionOnLineSeg(vector6, lineP, p2);
			array = new Vector3[5] { vector14, vector15, p3, vector12, vector13 };
		}
		else if (!flag && !flag2)
		{
			array = new Vector3[5] { vector9, vector10, vector11, vector12, vector13 };
		}
		else if (flag)
		{
			Vector3 vector16 = PointProjectionOnLineSeg(vector6, lineP, p);
			array = new Vector3[6] { vector9, vector10, vector11, vector16, vector12, vector13 };
		}
		else
		{
			Vector3 vector17 = PointProjectionOnLineSeg(vector6, lineP, p2);
			array = new Vector3[6] { vector9, vector10, vector11, vector17, vector12, vector13 };
		}
		int maxindex = 0;
		int maxindex2 = 0;
		FarthestPointsWithoutReturn(array, array.Length, ref maxindex, ref maxindex2);
		lineStart = (ComparePosition(array[maxindex], array[maxindex2]) ? array[maxindex] : array[maxindex2]);
		lineEnd = ((!ComparePosition(array[maxindex], array[maxindex2])) ? array[maxindex] : array[maxindex2]);
		Vector3 intersectPos;
		return IsLineSegIntersectLineSeg(lineStart, lineEnd, start, end, out intersectPos);
	}

	public static bool SectorAndCapsule(SectorPrimitive sectorPrimitive, CapsulePrimitive capsulePrimitive, out Vector3 bestA)
	{
		bestA = Vector3.zero;
		Vector3 bestB = Vector3.zero;
		GJKDetecotor.ClosestPoinsOnTwoLines(capsulePrimitive.CenterOne, capsulePrimitive.CenterTwo, sectorPrimitive.SectorCenter, sectorPrimitive.LocalUnitX * sectorPrimitive.Radius + sectorPrimitive.SectorCenter, ref bestA, ref bestB);
		SpherePrimitive spherePrimitive = SpherePrimitive.Create(bestA, capsulePrimitive.Radius, capsulePrimitive.CapsuleQuaternion);
		bool result = SectorAndSphere(sectorPrimitive, spherePrimitive);
		ReferencePool.Release(spherePrimitive);
		return result;
	}

	public static bool CapsuleAndCapsule(CapsulePrimitive capsule1, CapsulePrimitive capsule2)
	{
		Vector3 bestA = Vector3.zero;
		Vector3 bestB = Vector3.zero;
		GJKDetecotor.ClosestPoinsOnTwoLines(capsule1.CenterOne, capsule1.CenterTwo, capsule2.CenterOne, capsule2.CenterTwo, ref bestA, ref bestB);
		float num = SqrDistance(bestA, bestB);
		if (num <= 0f || num >= SqrNumber(capsule1.Radius + capsule2.Radius))
		{
			return false;
		}
		return true;
	}

	public static bool CapsuleAndSphere(CapsulePrimitive capsule, SpherePrimitive sphere)
	{
		Vector3 axis = sphere.GetAxis(3);
		return SqrDistance(GJKDetecotor.ClosestPointOnLineSegment(capsule.CenterOne, capsule.CenterTwo, axis), axis) <= SqrNumber(capsule.Radius + sphere.Radius);
	}

	public static bool CapsuleAndBox(CapsulePrimitive capsule, BoxPrimitive box)
	{
		float sphereRadius = capsule.Radius + capsule.HalfHeight.y;
		if (!BoxAndSphere(box, capsule.CapsuleCenter, sphereRadius))
		{
			return false;
		}
		Vector3 vector = box.GetAxis(3) - capsule.GetAxis(3);
		float smallestPenetration = float.MaxValue;
		int smallestCase = 16777215;
		Vector3 normalized = (box.GetAxis(0) + box.GetAxis(1)).normalized;
		Vector3 normalized2 = (box.GetAxis(0) + box.GetAxis(2)).normalized;
		Vector3 normalized3 = (box.GetAxis(1) + box.GetAxis(2)).normalized;
		if (!TryAxis(capsule, box, normalized, vector, 3, ref smallestPenetration, ref smallestCase))
		{
			return false;
		}
		if (!TryAxis(capsule, box, normalized2, vector, 4, ref smallestPenetration, ref smallestCase))
		{
			return false;
		}
		if (!TryAxis(capsule, box, normalized3, vector, 5, ref smallestPenetration, ref smallestCase))
		{
			return false;
		}
		int num = smallestCase;
		if (!TryAxis(capsule, box, box.GetAxis(0), vector, 0, ref smallestPenetration, ref smallestCase))
		{
			return false;
		}
		if (!TryAxis(capsule, box, box.GetAxis(1), vector, 1, ref smallestPenetration, ref smallestCase))
		{
			return false;
		}
		if (!TryAxis(capsule, box, box.GetAxis(2), vector, 2, ref smallestPenetration, ref smallestCase))
		{
			return false;
		}
		if (smallestCase < 3)
		{
			Vector3 axis = box.GetAxis(smallestCase);
			Vector3 vector2 = (int)Mathf.Sign(Vector3.Dot(axis, -vector)) * axis;
			Vector3 zero = Vector3.zero;
			float num2 = Vector3.Dot(capsule.CenterOneToTwo, vector2);
			zero = ((!(Mathf.Abs(num2) > 0.0001f) || !(num2 > 0f)) ? capsule.CenterTwo : capsule.CenterOne);
			Vector3 vector3 = box.Transform.TransformInverse(zero);
			if (smallestCase == 0 && (Mathf.Abs(vector3.y) > box.HalfSize.y || Mathf.Abs(vector3.z) > box.HalfSize.z))
			{
				smallestCase = num;
			}
			if (smallestCase == 1 && (Mathf.Abs(vector3.x) > box.HalfSize.x || Mathf.Abs(vector3.z) > box.HalfSize.z))
			{
				smallestCase = num;
			}
			if (smallestCase == 2 && (Mathf.Abs(vector3.x) > box.HalfSize.x || Mathf.Abs(vector3.y) > box.HalfSize.y))
			{
				smallestCase = num;
			}
			if (smallestCase < 3)
			{
				float num3 = Vector3.Dot(box.GetAxis(3), vector2) + box.HalfSize[smallestCase];
				float num4 = Vector3.Dot(vector2, zero) - capsule.Radius - num3;
				if (Mathf.Abs(num4) >= 0.0001f && num4 >= 0f)
				{
					return false;
				}
				return true;
			}
		}
		if (smallestCase >= 3)
		{
			Vector3 zero2 = Vector3.zero;
			Vector3 vector4 = Vector3.zero;
			Vector3 vector5 = Vector3.zero;
			if (smallestCase == 3)
			{
				vector4 = (int)Mathf.Sign(Vector3.Dot(normalized, -vector)) * box.HalfSize;
				vector5 = vector4;
				vector5.z *= -1f;
			}
			if (smallestCase == 4)
			{
				vector4 = (int)Mathf.Sign(Vector3.Dot(normalized2, -vector)) * box.HalfSize;
				vector5 = vector4;
				vector5.y *= -1f;
			}
			if (smallestCase == 5)
			{
				vector4 = (int)Mathf.Sign(Vector3.Dot(normalized3, -vector)) * box.HalfSize;
				vector5 = vector4;
				vector5.x *= -1f;
			}
			vector4 = box.Transform.Transform(vector4);
			vector5 = box.Transform.Transform(vector5);
			zero2 = GJKDetecotor.ClosestPointFromLineTwo(vector4, vector5, capsule.CenterOne, capsule.CenterTwo);
			return BoxAndSphere(box, zero2, capsule.Radius);
		}
		return false;
	}

	private static bool TryAxis(CapsulePrimitive one, BoxPrimitive two, Vector3 axis, Vector3 toCentre, int index, ref float smallestPenetration, ref int smallestCase)
	{
		if ((double)axis.sqrMagnitude < 0.0001)
		{
			return true;
		}
		axis.Normalize();
		float num = PenetrationOnAxis(one, two, axis, toCentre);
		if (num < 0f)
		{
			return false;
		}
		if (num < smallestPenetration)
		{
			smallestPenetration = num;
			smallestCase = index;
		}
		return true;
	}

	private static float PenetrationOnAxis(CapsulePrimitive one, BoxPrimitive two, Vector3 axis, Vector3 toCentre)
	{
		float num = TransformToAxis(one, axis);
		float num2 = TransformToAxis(two, axis);
		float num3 = Mathf.Abs(Vector3.Dot(toCentre, axis));
		return num + num2 - num3;
	}

	private static float TransformToAxis(CapsulePrimitive capsule, Vector3 axis)
	{
		return capsule.Radius * Mathf.Abs(Vector3.Dot(axis, capsule.GetAxis(0))) + (capsule.HalfHeight.y + capsule.Radius) * Mathf.Abs(Vector3.Dot(axis, capsule.GetAxis(1))) + capsule.Radius * Mathf.Abs(Vector3.Dot(axis, capsule.GetAxis(2)));
	}

	public static bool CapsuleAndRay(Vector3 point, Vector3 direct, CapsulePrimitive capsulePrimitive)
	{
		direct = direct.normalized;
		Vector3 centerOneToTwo = capsulePrimitive.CenterOneToTwo;
		Vector3 lhs = point - capsulePrimitive.CenterOne;
		float num = Vector3.Dot(centerOneToTwo, centerOneToTwo);
		float num2 = Vector3.Dot(lhs, centerOneToTwo) / num;
		Vector3 vector = capsulePrimitive.CenterOne + centerOneToTwo * num2;
		Vector3 b = point + direct * Vector3.Dot(vector - point, direct);
		return SqrDistance(vector, b) <= SqrNumber(capsulePrimitive.Radius);
	}

	public static bool AnnulusAndBox(AnnulusPrimitive annulusPrimitive, BoxPrimitive boxPrimitive)
	{
		SectorPrimitive sectorPrimitive = SectorPrimitive.Create(annulusPrimitive.AnnulusCenter, annulusPrimitive.Quaternion, annulusPrimitive.Angle * 57.29578f, annulusPrimitive.OuterDiameter);
		if (!sectorPrimitive.InternalCheckPrimitive() || !boxPrimitive.InternalCheckPrimitive())
		{
			sectorPrimitive.OnDispose();
			return false;
		}
		if (!SectorAndBox(sectorPrimitive, boxPrimitive, out var polygonPrimitive))
		{
			sectorPrimitive.OnDispose();
			polygonPrimitive?.OnDispose();
			return false;
		}
		bool flag = true;
		float num = SqrNumber(annulusPrimitive.InternalDiameter);
		for (int i = 0; i < boxPrimitive.Vertices.Length; i++)
		{
			if (SqrDistance(boxPrimitive.Vertices[i], annulusPrimitive.AnnulusCenter) > num)
			{
				flag = false;
				break;
			}
		}
		if (flag)
		{
			sectorPrimitive.OnDispose();
			polygonPrimitive.OnDispose();
			return false;
		}
		SectorPrimitive sectorPrimitive2 = SectorPrimitive.Create(annulusPrimitive.AnnulusCenter, annulusPrimitive.Quaternion, annulusPrimitive.Angle * 57.29578f, annulusPrimitive.InternalDiameter);
		List<int> list = new List<int>(polygonPrimitive.verSort);
		list.Add(list[0]);
		bool flag2 = false;
		if (annulusPrimitive.Angle * 57.29578f >= 180f)
		{
			flag2 = true;
			annulusPrimitive = AnnulusPrimitive.Create(annulusPrimitive.AnnulusCenter, annulusPrimitive.Quaternion * Quaternion.Euler(new Vector3(0f, (0f - annulusPrimitive.Angle) * 57.29578f / 4f, 0f)), annulusPrimitive.Angle * 57.29578f / 2f, annulusPrimitive.OuterDiameter, annulusPrimitive.InternalDiameter);
			sectorPrimitive = SectorPrimitive.Create(annulusPrimitive.AnnulusCenter, annulusPrimitive.Quaternion * Quaternion.Euler(new Vector3(0f, (0f - annulusPrimitive.Angle) * 57.29578f / 4f, 0f)), annulusPrimitive.Angle * 57.29578f / 2f, annulusPrimitive.OuterDiameter);
			sectorPrimitive2 = SectorPrimitive.Create(annulusPrimitive.AnnulusCenter, annulusPrimitive.Quaternion * Quaternion.Euler(new Vector3(0f, (0f - annulusPrimitive.Angle) * 57.29578f / 4f, 0f)), annulusPrimitive.Angle * 57.29578f / 2f, annulusPrimitive.InternalDiameter);
		}
		if (!sectorPrimitive.InternalCheckPrimitive() || !sectorPrimitive2.InternalCheckPrimitive())
		{
			if (flag2)
			{
				annulusPrimitive.OnDispose();
				sectorPrimitive.OnDispose();
				sectorPrimitive2.OnDispose();
			}
			polygonPrimitive.OnDispose();
			return false;
		}
		for (int j = 0; j < list.Count - 1; j++)
		{
			Vector3 line1P = polygonPrimitive.Vertices[list[j]];
			Vector3 line1P2 = polygonPrimitive.Vertices[list[j + 1]];
			if (IsLineSegIntersectLineSeg(line1P, line1P2, annulusPrimitive.AnnulusCenter, sectorPrimitive.EdgeVertices[0], out var intersectPos) && !IsSectorHasPoint(sectorPrimitive2, intersectPos))
			{
				if (flag2)
				{
					annulusPrimitive.OnDispose();
					sectorPrimitive.OnDispose();
					sectorPrimitive2.OnDispose();
				}
				polygonPrimitive.OnDispose();
				return true;
			}
			if (IsLineSegIntersectLineSeg(line1P, line1P2, annulusPrimitive.AnnulusCenter, sectorPrimitive.EdgeVertices[1], out var intersectPos2) && !IsSectorHasPoint(sectorPrimitive2, intersectPos2))
			{
				if (flag2)
				{
					annulusPrimitive.OnDispose();
					sectorPrimitive.OnDispose();
					sectorPrimitive2.OnDispose();
				}
				polygonPrimitive.OnDispose();
				return true;
			}
			if (IsLineIntersectLine(line1P, line1P2, annulusPrimitive.AnnulusCenter, sectorPrimitive.EdgeVertices[0], out var intersectPos3) && Vector3.Dot(intersectPos3 - annulusPrimitive.AnnulusCenter, sectorPrimitive2.EdgeVertices[0] - sectorPrimitive2.SectorCenter) >= 0f && !IsSectorHasPoint(sectorPrimitive2, intersectPos3))
			{
				if (flag2)
				{
					annulusPrimitive.OnDispose();
					sectorPrimitive.OnDispose();
					sectorPrimitive2.OnDispose();
				}
				polygonPrimitive.OnDispose();
				return true;
			}
			if (IsLineIntersectLine(line1P, line1P2, annulusPrimitive.AnnulusCenter, sectorPrimitive.EdgeVertices[1], out var intersectPos4) && Vector3.Dot(intersectPos4 - annulusPrimitive.AnnulusCenter, sectorPrimitive2.EdgeVertices[1] - sectorPrimitive2.SectorCenter) >= 0f && !IsSectorHasPoint(sectorPrimitive2, intersectPos4))
			{
				if (flag2)
				{
					annulusPrimitive.OnDispose();
					sectorPrimitive.OnDispose();
					sectorPrimitive2.OnDispose();
				}
				polygonPrimitive.OnDispose();
				return true;
			}
		}
		if (flag2)
		{
			annulusPrimitive.OnDispose();
			sectorPrimitive.OnDispose();
			sectorPrimitive2.OnDispose();
		}
		polygonPrimitive.OnDispose();
		return false;
	}

	public static bool AnnulusAndSphere(AnnulusPrimitive annulusPrimitive, SpherePrimitive spherePrimitive)
	{
		SectorPrimitive sectorPrimitive = SectorPrimitive.Create(annulusPrimitive.AnnulusCenter, annulusPrimitive.Quaternion, annulusPrimitive.Angle * 57.29578f, annulusPrimitive.OuterDiameter);
		if (!SectorAndSphere(sectorPrimitive, spherePrimitive) || !sectorPrimitive.InternalCheckPrimitive())
		{
			return false;
		}
		if ((annulusPrimitive.AnnulusCenter - spherePrimitive.SphereCenter).magnitude + spherePrimitive.Radius <= annulusPrimitive.InternalDiameter)
		{
			return false;
		}
		SectorPrimitive sectorPrimitive2 = SectorPrimitive.Create(annulusPrimitive.AnnulusCenter, annulusPrimitive.Quaternion, annulusPrimitive.Angle * 57.29578f, annulusPrimitive.InternalDiameter);
		if (sectorPrimitive2.Angle > MathF.PI)
		{
			sectorPrimitive2 = SectorPrimitive.Create(sectorPrimitive2.SectorCenter, sectorPrimitive2.Quaternion * Quaternion.Euler(new Vector3(0f, (0f - sectorPrimitive2.Angle) * 57.29578f / 4f, 0f)), sectorPrimitive2.Angle * 57.29578f / 2f, sectorPrimitive2.Radius);
		}
		if (!sectorPrimitive2.InternalCheckPrimitive())
		{
			return false;
		}
		Vector3 point = annulusPrimitive.Transform2Local(spherePrimitive.SphereCenter);
		point.z = Mathf.Abs(point.z);
		Vector3 vector = annulusPrimitive.Transform2World(point);
		Vector3 lhs = vector - sectorPrimitive2.SectorCenter;
		Vector3 rhs = sectorPrimitive2.LocalUnitX - sectorPrimitive2.SectorCenter;
		float num = Mathf.Acos(Vector3.Dot(lhs, rhs) / (lhs.magnitude * rhs.magnitude));
		num *= 2f;
		float num2 = SqrDistance(vector, sectorPrimitive2.SectorCenter);
		if (num <= annulusPrimitive.Angle && num2 >= SqrNumber(annulusPrimitive.OuterDiameter))
		{
			return true;
		}
		if (num <= annulusPrimitive.Angle && num2 >= SqrNumber(annulusPrimitive.InternalDiameter) && num2 <= SqrNumber(annulusPrimitive.OuterDiameter))
		{
			return true;
		}
		if (SqrDistance(vector, sectorPrimitive2.EdgeVertices[0]) <= SqrNumber(spherePrimitive.Radius))
		{
			return true;
		}
		if (num <= annulusPrimitive.Angle && SqrDistance(vector, sectorPrimitive2.SectorCenter) <= SqrNumber(sectorPrimitive2.Radius))
		{
			return false;
		}
		Vector3 vector2 = PointProjectionOnLineSeg(sectorPrimitive2.SectorCenter, sectorPrimitive2.EdgeVertices[0], vector);
		bool result = Vector3.Dot(sectorPrimitive2.EdgeVertices[0] - sectorPrimitive2.SectorCenter, vector2 - sectorPrimitive2.SectorCenter) >= 0f && Vector3.Dot(vector2 - sectorPrimitive2.EdgeVertices[0], vector2 - sectorPrimitive2.SectorCenter) >= 0f;
		sectorPrimitive.OnDispose();
		sectorPrimitive2.OnDispose();
		return result;
	}

	public static bool AnnulusAndCapusle(AnnulusPrimitive annulusPrimitive, CapsulePrimitive capsulePrimitive)
	{
		return CheckAnnulusAndCapusleCollision(annulusPrimitive, capsulePrimitive);
	}

	public static bool CheckAnnulusAndCapusleCollision(AnnulusPrimitive annulus, CapsulePrimitive capsule)
	{
		Vector3 point = (capsule.CenterOne + capsule.CenterTwo) * 0.5f;
		float num = DistanceFromPointToAnnulus(capsule.CenterOne, annulus);
		float num2 = DistanceFromPointToAnnulus(capsule.CenterTwo, annulus);
		float num3 = DistanceFromPointToAnnulus(point, annulus);
		if (!(num <= capsule.Radius) && !(num2 <= capsule.Radius))
		{
			return num3 <= capsule.Radius;
		}
		return true;
	}

	private static bool IsPointInAnnulus(Vector3 point, AnnulusPrimitive annulus)
	{
		Vector3 vector = Quaternion.Inverse(annulus.Quaternion) * (point - annulus.AnnulusCenter);
		Vector2 vector2 = new Vector2(vector.x, vector.z);
		float magnitude = vector2.magnitude;
		if (magnitude < annulus.InternalDiameter || magnitude > annulus.OuterDiameter)
		{
			return false;
		}
		float angleRad = Mathf.Atan2(vector2.y, vector2.x);
		angleRad = NormalizeAngle(angleRad);
		float num = annulus.Angle * 0.5f;
		if (!(angleRad <= num))
		{
			return angleRad >= MathF.PI * 2f - num;
		}
		return true;
	}

	private static float DistanceFromPointToAnnulus(Vector3 point, AnnulusPrimitive annulus)
	{
		Vector3 vector = Quaternion.Inverse(annulus.Quaternion) * (point - annulus.AnnulusCenter);
		Vector2 vector2 = new Vector2(vector.x, vector.z);
		float magnitude = vector2.magnitude;
		float angleRad = Mathf.Atan2(vector2.y, vector2.x);
		angleRad = NormalizeAngle(angleRad);
		float num = annulus.Angle * 0.5f;
		if (angleRad <= num || angleRad >= MathF.PI * 2f - num)
		{
			if (magnitude < annulus.InternalDiameter)
			{
				return annulus.InternalDiameter - magnitude;
			}
			if (magnitude > annulus.OuterDiameter)
			{
				return magnitude - annulus.OuterDiameter;
			}
			return 0f;
		}
		Vector3 a = new Vector3(Mathf.Cos(num), 0f, Mathf.Sin(num)) * annulus.InternalDiameter;
		Vector3 b = new Vector3(Mathf.Cos(num), 0f, Mathf.Sin(num)) * annulus.OuterDiameter;
		Vector3 a2 = new Vector3(Mathf.Cos(0f - num), 0f, Mathf.Sin(0f - num)) * annulus.InternalDiameter;
		Vector3 b2 = new Vector3(Mathf.Cos(0f - num), 0f, Mathf.Sin(0f - num)) * annulus.OuterDiameter;
		float a3 = DistancePointToSegment(new Vector3(vector.x, 0f, vector.z), a, b);
		float b3 = DistancePointToSegment(new Vector3(vector.x, 0f, vector.z), a2, b2);
		return Mathf.Min(a3, b3);
	}

	private static float DistancePointToSegment(Vector3 point, Vector3 a, Vector3 b)
	{
		Vector3 vector = b - a;
		float value = Vector3.Dot(point - a, vector) / vector.sqrMagnitude;
		value = Mathf.Clamp01(value);
		Vector3 vector2 = a + value * vector;
		return (point - vector2).magnitude;
	}

	private static float NormalizeAngle(float angleRad)
	{
		if (angleRad < 0f)
		{
			angleRad += MathF.PI * 2f;
		}
		return angleRad;
	}

	private static float DistancePointToRay(Vector3 point, Vector3 dir)
	{
		dir.Normalize();
		float num = Vector3.Dot(point, dir);
		Vector3 vector = dir * num;
		return (point - vector).magnitude;
	}

	private static float DistanceFromPointToLineSegment(Vector3 point, Vector3 lineStart, Vector3 lineEnd)
	{
		Vector3 vector = lineEnd - lineStart;
		float magnitude = vector.magnitude;
		vector.Normalize();
		float value = Vector3.Dot(point - lineStart, vector);
		value = Mathf.Clamp(value, 0f, magnitude);
		Vector3 b = lineStart + value * vector;
		return Vector3.Distance(point, b);
	}

	private static float SegmentPointSqrDistance(Vector3 x0, Vector3 u, Vector3 x)
	{
		float value = Vector3.Dot(x - x0, u) / Vector3.SqrMagnitude(u);
		return Vector3.SqrMagnitude(x - (x0 + Mathf.Clamp(value, 0f, 1f) * u));
	}

	private static bool IsCapsuleDiskIntersect(Vector3 x0, Vector3 u, float cr, Vector3 c, float r)
	{
		return SegmentPointSqrDistance(x0, u, c) <= (cr + r) * (cr + r);
	}

	private static void ClosestPointBoxSphere(SpherePrimitive p, BoxPrimitive b, out Vector3 vBox, out Vector3 vSphere)
	{
		Vector3 rhs = b.Transform.TransformInverse(p.SphereCenter);
		vBox = Vector3.zero;
		vBox += Vector3.Max(-b.HalfSize, Vector3.Min(b.HalfSize, rhs));
		vBox = b.Transform * vBox;
		Vector3 rhs2 = p.Transform.TransformInverse(b.boxCenter);
		vSphere = Vector3.zero;
		vSphere += Vector3.Max((0f - p.Radius) * p.Scale, Vector3.Min(p.Radius * p.Scale, rhs2));
		vSphere = p.Transform * vSphere;
	}

	public static bool LineSegmentFootPointOnPlane(Vector3 pointA, Vector3 pointB, Vector3 planePoint, Vector3 planeNormal, out Vector3 footPoint)
	{
		Vector3 vector = pointB - pointA;
		PointProjectionOnPlane(planeNormal, planePoint, pointA, out var fpB);
		PointProjectionOnPlane(planeNormal, planePoint, pointB, out var fpB2);
		Vector3 lhs = pointA - fpB;
		Vector3 rhs = pointB - fpB2;
		float num = Vector3.Dot(lhs, rhs);
		if (Mathf.Abs(num) > 0.0001f && num > 0f)
		{
			footPoint = Vector3.negativeInfinity;
			return false;
		}
		float magnitude = lhs.magnitude;
		float num2 = rhs.magnitude + magnitude;
		footPoint = pointA + magnitude * vector / num2;
		return true;
	}

	private static bool IsPointProjectionInsideSegment(Vector3 point, Vector3 p1, Vector3 p2, out bool isP1, out bool isP2)
	{
		isP1 = true;
		isP2 = true;
		Vector3 lhs = point - p1;
		Vector3 rhs = p2 - p1;
		if (Vector3.Dot(lhs, rhs) < 0f)
		{
			isP1 = false;
		}
		Vector3 lhs2 = point - p2;
		Vector3 rhs2 = p1 - p2;
		if (Vector3.Dot(lhs2, rhs2) >= 0f)
		{
			isP2 = false;
		}
		return isP1 & isP2;
	}

	private static void CircleIntersectLine(Vector3 circleCenter, float radius, Vector3 lineP1, Vector3 lineP2, out Vector3 point1, out Vector3 point2)
	{
		point1 = Vector3.negativeInfinity;
		point2 = Vector3.negativeInfinity;
		Vector3 vector = lineP2 - lineP1;
		Vector3 vector2 = Vector3.Cross(vector, circleCenter - lineP1);
		float magnitude = vector.magnitude;
		if (!(Mathf.Abs((vector2.x + vector2.y + vector2.z) / magnitude) > radius))
		{
			Vector3 vector3 = PointProjectionOnLineSeg(lineP1, lineP2, circleCenter);
			Vector3 vector4 = vector / magnitude;
			float num = Mathf.Sqrt(radius * radius - (vector3 - circleCenter).magnitude);
			point1 = vector3 + vector4 * num;
			point2 = vector3 - vector4 * num;
		}
	}

	public static Vector3 PointProjectionOnLineSeg(Vector3 lineP1, Vector3 lineP2, Vector3 p)
	{
		Vector3 vector = lineP2 - lineP1;
		float num = Vector3.Dot(p - lineP1, vector) / vector.sqrMagnitude;
		return lineP1 + vector * num;
	}

	private static bool IsLineSegIntersectLineSeg(Vector3 line1P1, Vector3 line1P2, Vector3 line2P1, Vector3 line2P2, out Vector3 intersectPos)
	{
		intersectPos = Vector3.zero;
		double num = 1E-06;
		Vector3 vector = (ComparePosition(line1P1, line1P2) ? line1P1 : line1P2);
		Vector3 vector2 = ((!ComparePosition(line1P1, line1P2)) ? line1P1 : line1P2);
		Vector3 vector3 = (ComparePosition(line2P1, line2P2) ? line2P1 : line2P2);
		Vector3 obj = ((!ComparePosition(line2P1, line2P2)) ? line2P1 : line2P2);
		line1P1 = vector;
		line1P2 = vector2;
		line2P1 = vector3;
		line2P2 = obj;
		Vector3 vector4 = line1P2 - line1P1;
		Vector3 vector5 = line1P1 - line2P1;
		Vector3 vector6 = line2P2 - line2P1;
		Vector3 rhs = line2P2 - line1P1;
		Vector3 rhs2 = line1P2 - line2P1;
		Vector3 lhs = Vector3.Cross(vector5, vector6);
		if (Mathf.Abs(Vector3.Dot(lhs, vector4)) > 0.001f)
		{
			return false;
		}
		if (Vector3.Cross(vector4, vector6).sqrMagnitude <= 0.001f)
		{
			if ((double)Vector3.Cross(vector5, rhs2).sqrMagnitude <= num)
			{
				bool num2 = ComparePosition(line1P1, line2P1);
				bool flag = !ComparePosition(line1P2, line2P1);
				if (num2 & flag)
				{
					return true;
				}
				bool num3 = ComparePosition(line2P1, line1P1);
				flag = !ComparePosition(line2P2, line1P1);
				if (num3 & flag)
				{
					return true;
				}
			}
			return false;
		}
		if (Mathf.Min(line1P1.x, line1P2.x) > Mathf.Max(line2P1.x, line2P2.x) || Mathf.Max(line1P1.x, line1P2.x) < Mathf.Min(line2P1.x, line2P2.x) || Mathf.Min(line1P1.y, line1P2.y) > Mathf.Max(line2P1.y, line2P2.y) || Mathf.Max(line1P1.y, line1P2.y) < Mathf.Min(line2P1.y, line2P2.y) || Mathf.Min(line1P1.z, line1P2.z) > Mathf.Max(line2P1.z, line2P2.z) || Mathf.Max(line1P1.z, line1P2.z) < Mathf.Min(line2P1.z, line2P2.z))
		{
			return false;
		}
		float num4 = Vector3.Dot(Vector3.Cross(-vector5, vector4), Vector3.Cross(vector4, rhs));
		float num5 = Vector3.Dot(Vector3.Cross(vector5, vector6), Vector3.Cross(vector6, rhs2));
		if ((double)Math.Abs(num4) > num && num4 > 0f && (double)Math.Abs(num5) > num && num5 > 0f)
		{
			Vector3 rhs3 = Vector3.Cross(vector6, vector4);
			float num6 = Vector3.Dot(lhs, rhs3) / rhs3.sqrMagnitude;
			intersectPos = line1P1 + vector4 * num6;
			return true;
		}
		return false;
	}

	private static bool GetGravityPoint(PolygonPrimitive polygon, out Vector3 graPoint)
	{
		double num = 0.0;
		double num2 = 0.0;
		double num3 = 0.0;
		double num4 = polygon.Transform.TransformInverse(polygon.Vertices[polygon.verSort[0]]).x;
		double num5 = polygon.Transform.TransformInverse(polygon.Vertices[polygon.verSort[0]]).z;
		double num6 = polygon.Transform.TransformInverse(polygon.Vertices[polygon.verSort[1]]).x;
		double num7 = polygon.Transform.TransformInverse(polygon.Vertices[polygon.verSort[1]]).z;
		double num8 = polygon.Vertices.Length;
		int num9 = 2;
		for (double num10 = 1.0; num10 <= num8 - 2.0; num10++)
		{
			double num11 = polygon.Transform.TransformInverse(polygon.Vertices[polygon.verSort[num9]]).x;
			double num12 = polygon.Transform.TransformInverse(polygon.Vertices[polygon.verSort[num9]]).z;
			double num13 = ((num6 - num4) * (num12 - num5) - (num11 - num4) * (num7 - num5)) / 2.0;
			num += (num4 + num6 + num11) * num13;
			num2 += (num5 + num7 + num12) * num13;
			num3 += num13;
			num6 = num11;
			num7 = num12;
			num9++;
		}
		graPoint = new Vector3((float)(num / num3 / 3.0), 0f, (float)(num2 / num3 / 3.0));
		return graPoint.z > 0f;
	}

	private static bool ComparePosition(Vector3 p1, Vector3 p2)
	{
		if (Mathf.Abs(p1.x - p2.x) > 0.001f)
		{
			return p1.x <= p2.x;
		}
		if (Mathf.Abs(p1.y - p2.y) > 0.001f)
		{
			return p1.y <= p2.y;
		}
		if (Mathf.Abs(p1.z - p2.z) > 0.001f)
		{
			return p1.z <= p2.z;
		}
		return false;
	}

	private static double RotatingCalipers(Vector3[] points, int m, ref int maxindex1, ref int maxindex2)
	{
		float num = 0f;
		List<Vector3> list = new List<Vector3>(points);
		list.Add(points[0]);
		int num2 = 1;
		for (int i = 0; i < m; i++)
		{
			while (Mathf.Abs(PrimitiveExtension.Determinant(list[i] - list[i + 1], list[num2 + 1] - list[i + 1])) > Mathf.Abs(PrimitiveExtension.Determinant(list[i] - list[i + 1], list[num2] - list[i + 1])))
			{
				num2 = (num2 + 1) % m;
			}
			float num3 = SqrDistance(list[i], list[num2]);
			if (num3 > num)
			{
				num = num3;
				maxindex1 = i;
				maxindex2 = num2;
			}
			float num4 = SqrDistance(list[i + 1], list[num2]);
			if (num4 > num)
			{
				num = num4;
				maxindex1 = i + 1;
				maxindex2 = num2;
			}
		}
		maxindex1 = ((maxindex1 != list.Count - 1) ? maxindex1 : 0);
		maxindex2 = ((maxindex2 != list.Count - 1) ? maxindex2 : 0);
		return Math.Sqrt(num);
	}

	private static double FarthestPoints(Vector3[] points, int m, ref int maxindex1, ref int maxindex2)
	{
		float num = 0f;
		for (int i = 0; i < m; i++)
		{
			for (int j = i + 1; j < m; j++)
			{
				float num2 = SqrDistance(points[i], points[j]);
				if (num2 > num)
				{
					num = num2;
					maxindex1 = i;
					maxindex2 = j;
				}
			}
		}
		return Math.Sqrt(num);
	}

	private static void FarthestPointsWithoutReturn(Vector3[] points, int m, ref int maxindex1, ref int maxindex2)
	{
		float num = 0f;
		for (int i = 0; i < m; i++)
		{
			for (int j = i + 1; j < m; j++)
			{
				float num2 = SqrDistance(points[i], points[j]);
				if (num2 > num)
				{
					num = num2;
					maxindex1 = i;
					maxindex2 = j;
				}
			}
		}
	}

	private static void PointProjectionOnPlane(Vector3 planeNormal, Vector3 planePoint, Vector3 oriPoint, out Vector3 fpB)
	{
		fpB = Vector3.zero;
		fpB.x = (planeNormal.x * planeNormal.y * planePoint.y + planeNormal.y * planeNormal.y * oriPoint.x - planeNormal.x * planeNormal.y * oriPoint.y + planeNormal.x * planeNormal.z * planePoint.z + planeNormal.z * planeNormal.z * oriPoint.x - planeNormal.x * planeNormal.z * oriPoint.z + planeNormal.x * planeNormal.x * planePoint.x) / (planeNormal.x * planeNormal.x + planeNormal.y * planeNormal.y + planeNormal.z * planeNormal.z);
		fpB.y = (planeNormal.y * planeNormal.z * planePoint.z + planeNormal.z * planeNormal.z * oriPoint.y - planeNormal.y * planeNormal.z * oriPoint.z + planeNormal.y * planeNormal.x * planePoint.x + planeNormal.x * planeNormal.x * oriPoint.y - planeNormal.x * planeNormal.y * oriPoint.x + planeNormal.y * planeNormal.y * planePoint.y) / (planeNormal.x * planeNormal.x + planeNormal.y * planeNormal.y + planeNormal.z * planeNormal.z);
		fpB.z = (planeNormal.x * planeNormal.z * planePoint.x + planeNormal.x * planeNormal.x * oriPoint.z - planeNormal.x * planeNormal.z * oriPoint.x + planeNormal.y * planeNormal.z * planePoint.y + planeNormal.y * planeNormal.y * oriPoint.z - planeNormal.y * planeNormal.z * oriPoint.y + planeNormal.z * planeNormal.z * planePoint.z) / (planeNormal.x * planeNormal.x + planeNormal.y * planeNormal.y + planeNormal.z * planeNormal.z);
	}

	private static bool IsLineSegIntersectLine(Vector3 segPt1, Vector3 segPt2, Vector3 linePt1, Vector3 linePt2)
	{
		bool result = false;
		double num = Vector3.Dot(linePt2 - linePt1, segPt1 - linePt1) - Vector3.Dot(linePt2 - linePt1, segPt1 - linePt1);
		double num2 = Vector3.Dot(linePt2 - linePt1, segPt2 - linePt1) - Vector3.Dot(linePt2 - linePt1, segPt2 - linePt1);
		if (((num >= 0.0) & (num2 <= 0.0)) | ((num <= 0.0) & (num2 >= 0.0)))
		{
			result = true;
		}
		return result;
	}

	private static bool IsLineIntersectLine(Vector3 line1P1, Vector3 line1P2, Vector3 line2P1, Vector3 line2P2, out Vector3 intersectPos)
	{
		double num = 0.0001;
		intersectPos = Vector3.zero;
		Vector3 vector = line1P2 - line1P1;
		Vector3 lhs = line1P1 - line2P1;
		Vector3 rhs = line2P2 - line2P1;
		_ = line2P2 - line1P1;
		Vector3 rhs2 = line1P2 - line2P1;
		Vector3 lhs2 = line2P1 - line1P1;
		Vector3 vector2 = Vector3.Cross(lhs, rhs);
		if ((double)Mathf.Abs(Vector3.Dot(vector2, vector)) > num)
		{
			return false;
		}
		if ((double)Vector3.Cross(vector, rhs).sqrMagnitude <= num)
		{
			if ((double)Vector3.Cross(lhs, rhs2).sqrMagnitude <= num)
			{
				if (ComparePosition(line1P1, line2P1) && !ComparePosition(line1P2, line2P1))
				{
					return true;
				}
				if (ComparePosition(line2P1, line1P1) && !ComparePosition(line2P2, line1P1))
				{
					return true;
				}
			}
			return false;
		}
		Vector3 rhs3 = Vector3.Cross(vector, rhs);
		Vector3 lhs3 = Vector3.Cross(lhs2, rhs);
		if ((double)Mathf.Abs(rhs3.sqrMagnitude) <= 1E-06)
		{
			return false;
		}
		float num2 = Vector3.Dot(lhs2, rhs3);
		float num3 = Vector3.Dot(lhs3, rhs3) / rhs3.sqrMagnitude;
		if ((Mathf.Abs(num3 - 1f) > 0.0001f && num3 > 1f) || (Mathf.Abs(num2) > 0.0001f && num2 < 0f))
		{
			return false;
		}
		intersectPos = line1P1 + vector2 * num3;
		return true;
	}

	public static Vector3 NearestPointOnRay(Vector3 point, Vector3 direct, Vector3 targetPoint)
	{
		Vector3 lhs = targetPoint - point;
		direct = direct.normalized;
		float num = Vector3.Dot(lhs, direct);
		if (Mathf.Abs(num) > 0.0001f && num <= 0f)
		{
			return point;
		}
		return point + num * direct;
	}

	private static float ABS(float f)
	{
		if (!(f < 0f))
		{
			return f;
		}
		return 0f - f;
	}
}
