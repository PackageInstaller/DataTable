using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class GJKDetecotor
{
	public Simplex simplex;

	private Dictionary<Vector3, SupportInfo> supports;

	public GJKDetecotor()
	{
		simplex = new Simplex();
		supports = new Dictionary<Vector3, SupportInfo>();
	}

	public void Clear()
	{
		simplex.Clear();
		supports.Clear();
	}

	public bool GJKTest(Vector3[] vertices1, Vector3[] vertices2)
	{
		simplex.Clear();
		supports.Clear();
		Vector3 vector = FindFirstDirection(vertices1, vertices2);
		simplex.Add(Support(vertices1, vertices2, vector));
		vector = -vector;
		int num = vertices1.Length + vertices2.Length;
		for (int i = 0; i < num; i++)
		{
			Vector3 vector2 = Support(vertices1, vertices2, vector);
			if (Vector3.Dot(vector2, vector) < 0f)
			{
				return false;
			}
			simplex.Add(vector2);
			if (simplex.ContainsPoint(Vector3.zero))
			{
				return true;
			}
			vector = FindNextDirection();
		}
		return false;
	}

	public bool GJK(Vector3[] vertices1, Vector3[] vertices2, ref Vector3 normal, ref Vector3 contactPoint, ref float penetration)
	{
		simplex.Clear();
		supports.Clear();
		Vector3 vector = FindFirstDirection(vertices1, vertices2);
		simplex.Add(Support(vertices1, vertices2, vector));
		vector = -vector;
		int num = vertices1.Length + vertices2.Length;
		for (int i = 0; i < num; i++)
		{
			Vector3 vector2 = Support(vertices1, vertices2, vector);
			if (Vector3.Dot(vector2, vector) < 0f)
			{
				return false;
			}
			simplex.Add(vector2);
			if (simplex.ContainsPoint(Vector3.zero))
			{
				if (EPA(vertices1, vertices2, ref normal, ref contactPoint, ref penetration))
				{
					return true;
				}
				return false;
			}
			vector = FindNextDirection();
		}
		return false;
	}

	public bool GJKDist(Vector3[] vertices1, Vector3[] vertices2, ref Vector3 normal, ref Vector3 contactPoint, ref float penetration)
	{
		simplex.Clear();
		supports.Clear();
		Vector3 vector = FindFirstDirection(vertices1, vertices2);
		simplex.Add(Support(vertices1, vertices2, vector));
		vector = -vector;
		int num = vertices1.Length + vertices2.Length;
		for (int i = 0; i < num; i++)
		{
			Vector3 vector2 = Support(vertices1, vertices2, vector);
			if (Vector3.Dot(vector2, vector) < 0f)
			{
				simplex.GeneratePlanes();
				Simplex.SimplexPlane? simplexPlane = simplex.FindClosestPlane();
				if (!simplexPlane.HasValue)
				{
					return false;
				}
				Simplex.SimplexPlane value = simplexPlane.Value;
				if (!value.originInPlane)
				{
					return false;
				}
				normal = value.normal.normalized;
				penetration = Mathf.Sqrt(value.sqrDistance);
				contactPoint = DistContactPoint(value.A, value.B, value.C, value.normal);
				return true;
			}
			simplex.Add(vector2);
			vector = FindNextDirection();
		}
		return false;
	}

	public bool EPA(Vector3[] vertices1, Vector3[] vertices2, ref Vector3 normal, ref Vector3 contactPoint, ref float penetration)
	{
		int num = vertices1.Length + vertices2.Length;
		simplex.InitPlanes();
		for (int i = 0; i < num; i++)
		{
			Simplex.SimplexPlane? simplexPlane = simplex.FindClosestPlane();
			if (!simplexPlane.HasValue)
			{
				break;
			}
			Simplex.SimplexPlane value = simplexPlane.Value;
			Vector3 vector = Support(vertices1, vertices2, value.normal);
			if ((double)(Vector3.Dot(vector, value.normal) - value.sqrDistance) <= 0.001)
			{
				normal = -value.normal.normalized;
				penetration = Mathf.Sqrt(value.sqrDistance);
				contactPoint = ContactPoint(value.A, value.B, value.C, value.normal);
				return true;
			}
			simplex.InsertPlanePoint(vector, value);
		}
		return false;
	}

	private Vector3 ContactPoint(Vector3 sp1, Vector3 sp2, Vector3 sp3, Vector3 normal)
	{
		SupportInfo supportInfo = supports[sp1];
		SupportInfo supportInfo2 = supports[sp2];
		SupportInfo supportInfo3 = supports[sp3];
		if (supportInfo.vertice1 == supportInfo2.vertice1 && supportInfo2.vertice1 == supportInfo3.vertice1)
		{
			return supportInfo.vertice1;
		}
		if (supportInfo.vertice2 == supportInfo2.vertice2 && supportInfo2.vertice2 == supportInfo3.vertice2)
		{
			return supportInfo.vertice2;
		}
		Vector3 vertice = supportInfo.vertice1;
		Vector3 lineOnePointB = ((supportInfo2.vertice1 == vertice) ? supportInfo3.vertice1 : supportInfo2.vertice1);
		Vector3 vertice2 = supportInfo.vertice2;
		Vector3 lineTwoPointB = ((supportInfo2.vertice2 == vertice2) ? supportInfo3.vertice2 : supportInfo2.vertice2);
		return ClosestPointOnTwoLines(vertice, lineOnePointB, vertice2, lineTwoPointB);
	}

	private Vector3 DistContactPoint(Vector3 sp1, Vector3 sp2, Vector3 sp3, Vector3 normal)
	{
		SupportInfo supportInfo = supports[sp1];
		SupportInfo supportInfo2 = supports[sp2];
		SupportInfo supportInfo3 = supports[sp3];
		if (supportInfo.vertice1 == supportInfo2.vertice1 && supportInfo2.vertice1 == supportInfo3.vertice1)
		{
			return supportInfo.vertice1 + normal;
		}
		if (supportInfo.vertice2 == supportInfo2.vertice2 && supportInfo2.vertice2 == supportInfo3.vertice2)
		{
			return supportInfo.vertice2 + normal;
		}
		Vector3 vertice = supportInfo.vertice1;
		Vector3 lineOnePointB = ((supportInfo2.vertice1 == vertice) ? supportInfo3.vertice1 : supportInfo2.vertice1);
		Vector3 vertice2 = supportInfo.vertice2;
		Vector3 lineTwoPointB = ((supportInfo2.vertice2 == vertice2) ? supportInfo3.vertice2 : supportInfo2.vertice2);
		return ClosestPointOnTwoLines(vertice, lineOnePointB, vertice2, lineTwoPointB);
	}

	private Vector3 FindFirstDirection(Vector3[] vertices1, Vector3[] vertices2, int startIndex = 0)
	{
		if (vertices1.Length <= startIndex || vertices2.Length <= startIndex)
		{
			return Vector3.one;
		}
		Vector3 vector = vertices1[startIndex] - vertices2[startIndex];
		if (vector == Vector3.zero)
		{
			int num = startIndex;
			num++;
			return FindFirstDirection(vertices1, vertices2, num);
		}
		return vector;
	}

	private Vector3 Support(Vector3[] vertices1, Vector3[] vertices2, Vector3 dir)
	{
		Vector3 farthestPointInDirection = GetFarthestPointInDirection(vertices1, dir);
		Vector3 farthestPointInDirection2 = GetFarthestPointInDirection(vertices2, -dir);
		Vector3 vector = farthestPointInDirection - farthestPointInDirection2;
		CacheSupport(vector, farthestPointInDirection, farthestPointInDirection2);
		return vector;
	}

	private void CacheSupport(Vector3 support, Vector3 vertice1, Vector3 vertice2)
	{
		if (!supports.ContainsKey(support))
		{
			SupportInfo value = new SupportInfo(vertice1, vertice2);
			supports.Add(support, value);
		}
	}

	private Vector3 GetFarthestPointInDirection(Vector3[] vertices, Vector3 direction)
	{
		float num = float.MinValue;
		int num2 = 0;
		for (int i = 0; i < vertices.Length; i++)
		{
			float num3 = Vector3.Dot(vertices[i], direction);
			if (num3 > num)
			{
				num = num3;
				num2 = i;
			}
		}
		return vertices[num2];
	}

	private Vector3 FindNextDirection()
	{
		switch (simplex.Count)
		{
		case 2:
		{
			Vector3 vector5 = ClosestPointOnLine(simplex.A, simplex.B, Vector3.zero);
			return Vector3.zero - vector5;
		}
		case 3:
		{
			Vector3 vector4 = FootPointOnPlane(simplex.A, simplex.B, simplex.C, Vector3.zero);
			return Vector3.zero - vector4;
		}
		case 4:
		{
			Vector3 vector = FootPointOnPlane(simplex.D, simplex.A, simplex.B, Vector3.zero);
			Vector3 vector2 = FootPointOnPlane(simplex.D, simplex.A, simplex.C, Vector3.zero);
			Vector3 vector3 = FootPointOnPlane(simplex.D, simplex.B, simplex.C, Vector3.zero);
			float sqrMagnitude = vector.sqrMagnitude;
			float sqrMagnitude2 = vector2.sqrMagnitude;
			float sqrMagnitude3 = vector3.sqrMagnitude;
			switch (MinIndex(sqrMagnitude, sqrMagnitude2, sqrMagnitude3))
			{
			case 1:
				simplex.RemoveAt(2);
				return Vector3.zero - vector;
			case 2:
				simplex.RemoveAt(1);
				return Vector3.zero - vector2;
			default:
				simplex.RemoveAt(0);
				return Vector3.zero - vector3;
			}
		}
		default:
			return Vector3.zero;
		}
	}

	public static Vector3 ClosestPointOnLine(Vector3 linePointA, Vector3 linePointB, Vector3 point)
	{
		Vector3 vector = linePointB - linePointA;
		float num = Vector3.Dot(point - linePointA, vector) / Vector3.Dot(vector, vector);
		return linePointA + num * vector;
	}

	public static Vector3 ClosestPointFromLineTwo(Vector3 lineOnePointA, Vector3 lineOnePointB, Vector3 lineTwoPointA, Vector3 lineTwoPointB)
	{
		Vector3 bestA = Vector3.zero;
		Vector3 bestB = Vector3.zero;
		ClosestPoinsOnTwoLines(lineOnePointA, lineOnePointB, lineTwoPointA, lineTwoPointB, ref bestA, ref bestB);
		return bestB;
	}

	public static void ClosestPoinsOnTwoLines(Vector3 lineOnePointA, Vector3 lineOnePointB, Vector3 lineTwoPointA, Vector3 lineTwoPointB, ref Vector3 bestA, ref Vector3 bestB)
	{
		float num = 0.0001f;
		Vector3 vector = lineOnePointB - lineOnePointA;
		Vector3 vector2 = lineTwoPointB - lineTwoPointA;
		Vector3 rhs = lineOnePointA - lineTwoPointA;
		float num2 = Vector3.Dot(vector, vector);
		float num3 = Vector3.Dot(vector2, vector2);
		float num4 = Vector3.Dot(vector2, rhs);
		float num5 = 0f;
		float num6 = 0f;
		if (num2 <= num && num3 <= num)
		{
			num6 = 0f;
			bestA = lineOnePointA;
			bestB = lineTwoPointA;
			return;
		}
		if (num2 <= num)
		{
			num5 = 0f;
			num6 = num4 / num3;
			num6 = Mathf.Clamp(num6, 0f, 1f);
		}
		else
		{
			float num7 = Vector3.Dot(vector, rhs);
			if (num3 <= num)
			{
				num6 = 0f;
				num5 = Mathf.Clamp((0f - num7) / num2, 0f, 1f);
			}
			else
			{
				float num8 = Vector3.Dot(vector, vector2);
				float num9 = num2 * num3 - num8 * num8;
				num5 = ((num9 == 0f) ? 0f : Mathf.Clamp((num8 * num4 - num7 * num3) / num9, 0f, 1f));
				float num10 = num8 * num5 + num4;
				if (num10 < 0f)
				{
					num6 = 0f;
					num5 = Mathf.Clamp((0f - num7) / num2, 0f, 1f);
				}
				else if (num10 > num3)
				{
					num6 = 1f;
					num5 = Mathf.Clamp((num8 - num7) / num2, 0f, 1f);
				}
				else
				{
					num6 = num10 / num3;
				}
			}
		}
		bestA = lineOnePointA + vector * num5;
		bestB = lineTwoPointA + vector2 * num6;
	}

	public static Vector3 ClosestPointOnTwoLines(Vector3 lineOnePointA, Vector3 lineOnePointB, Vector3 lineTwoPointA, Vector3 lineTwoPointB)
	{
		Vector3 bestA = Vector3.zero;
		Vector3 bestB = Vector3.zero;
		ClosestPoinsOnTwoLines(lineOnePointA, lineOnePointB, lineTwoPointA, lineTwoPointB, ref bestA, ref bestB);
		return bestA + (bestB - bestA) * 0.5f;
	}

	public static Vector3 ClosestPointOnLineSegment(Vector3 linePointA, Vector3 linePointB, Vector3 Point)
	{
		Vector3 vector = linePointB - linePointA;
		float value = Vector3.Dot(Point - linePointA, vector) / Vector3.Dot(vector, vector);
		return linePointA + Mathf.Clamp(value, 0f, 1f) * vector;
	}

	public static Vector3 FootPointOnPlane(Vector3 planePointA, Vector3 planePointB, Vector3 planePointC, Vector3 point)
	{
		Vector3 vector = Vector3.Cross(planePointB - planePointA, planePointC - planePointA);
		if (vector == Vector3.zero)
		{
			return Vector3.zero;
		}
		float num = Vector3.Dot(planePointA - point, vector) / Vector3.Dot(vector, vector);
		return point + num * vector;
	}

	public static float PlaneCenterDistance(Vector3 planePointA, Vector3 planePointB, Vector3 planePointC)
	{
		float num = (planePointA.x + planePointB.x + planePointC.x) * 0.33333f;
		float num2 = (planePointA.y + planePointB.y + planePointC.y) * 0.33333f;
		float num3 = (planePointA.z + planePointB.z + planePointC.z) * 0.33333f;
		return num * num + num2 * num2 + num3 * num3;
	}

	public static int MinIndex(float one, float two, float three)
	{
		int num = ((one < two) ? 1 : 2);
		if (num == 1)
		{
			return (one < three) ? 1 : 3;
		}
		return (two < three) ? 2 : 3;
	}

	public static int MaxIndex(float one, float two, float three)
	{
		int num = ((one > two) ? 1 : 2);
		if (num == 1)
		{
			return (one > three) ? 1 : 3;
		}
		return (two > three) ? 2 : 3;
	}
}
