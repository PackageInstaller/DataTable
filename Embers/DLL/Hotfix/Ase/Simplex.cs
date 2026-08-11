using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class Simplex
{
	public struct SimplexPlane(Vector3 normal, float distance, Vector3 A, Vector3 B, Vector3 C)
	{
		public Vector3 normal = normal;

		public float sqrDistance = distance;

		public Vector3 A = A;

		public Vector3 B = B;

		public Vector3 C = C;

		public bool originInPlane = OriginInPlane(normal, A, B, C);

		public static bool OriginInPlane(Vector3 normal, Vector3 A, Vector3 B, Vector3 C)
		{
			Vector3 vector = normal - A;
			float num = Mathf.Sign(Vector3.Dot(normal, Vector3.Cross(B - A, vector)));
			float num2 = Mathf.Sign(Vector3.Dot(normal, Vector3.Cross(vector, C - A)));
			if (num * num2 == -1f)
			{
				return false;
			}
			float num3 = Mathf.Sign(Vector3.Dot(normal, Vector3.Cross(C - B, normal - B)));
			if (num3 * num == -1f || num3 * num2 == -1f)
			{
				return false;
			}
			return true;
		}
	}

	public List<Vector3> points;

	public List<SimplexPlane> planes;

	public Vector3 A => points[0];

	public Vector3 B => points[1];

	public Vector3 C => points[2];

	public Vector3 D => points[3];

	public int Count => points.Count;

	public Simplex()
	{
		points = new List<Vector3>();
		planes = new List<SimplexPlane>();
	}

	public void Clear()
	{
		points.Clear();
		planes.Clear();
	}

	public void Add(Vector3 point)
	{
		points.Add(point);
	}

	public void RemoveAt(int index)
	{
		points.RemoveAt(index);
	}

	public bool ContainsPoint(Vector3 point)
	{
		if (Count < 4)
		{
			return false;
		}
		Vector3 lhs = B - A;
		Vector3 rhs = C - B;
		Vector3 lhs2 = C - A;
		Vector3 rhs2 = D - C;
		Vector3 lhs3 = D - A;
		Vector3 rhs3 = B - D;
		Vector3 lhs4 = D - B;
		Vector3 rhs4 = C - D;
		Vector3 lhs5 = Vector3.Cross(lhs, rhs);
		Vector3 lhs6 = Vector3.Cross(lhs2, rhs2);
		Vector3 lhs7 = Vector3.Cross(lhs3, rhs3);
		Vector3 lhs8 = Vector3.Cross(lhs4, rhs4);
		Vector3 rhs5 = point - A;
		Vector3 rhs6 = point - B;
		int num = (int)Mathf.Sign(Vector3.Dot(lhs5, rhs5));
		if (num == 0)
		{
			return false;
		}
		int num2 = (int)Mathf.Sign(Vector3.Dot(lhs6, rhs5));
		if (num2 == 0 || num2 * num == -1)
		{
			return false;
		}
		int num3 = (int)Mathf.Sign(Vector3.Dot(lhs7, rhs5));
		if (num3 == 0 || num3 * num == -1)
		{
			return false;
		}
		int num4 = (int)Mathf.Sign(Vector3.Dot(lhs8, rhs6));
		if (num4 == 0 || num4 * num == -1)
		{
			return false;
		}
		return true;
	}

	public SimplexPlane? FindClosestPlane()
	{
		if (planes.Count == 0)
		{
			return null;
		}
		int num = 0;
		for (int i = 1; i < planes.Count; i++)
		{
			num = ((planes[num].sqrDistance < planes[i].sqrDistance) ? num : i);
		}
		return planes[num];
	}

	public void InitPlanes()
	{
		if (points.Count >= 4)
		{
			planes.Clear();
			Vector3 normal = GJKDetecotor.FootPointOnPlane(A, B, C, Vector3.zero);
			Vector3 normal2 = GJKDetecotor.FootPointOnPlane(A, C, D, Vector3.zero);
			Vector3 normal3 = GJKDetecotor.FootPointOnPlane(A, D, B, Vector3.zero);
			Vector3 normal4 = GJKDetecotor.FootPointOnPlane(B, D, C, Vector3.zero);
			SimplexPlane item = new SimplexPlane(normal, normal.sqrMagnitude, A, B, C);
			SimplexPlane item2 = new SimplexPlane(normal2, normal2.sqrMagnitude, A, C, D);
			SimplexPlane item3 = new SimplexPlane(normal3, normal3.sqrMagnitude, A, D, B);
			SimplexPlane item4 = new SimplexPlane(normal4, normal4.sqrMagnitude, B, D, C);
			planes.Add(item);
			planes.Add(item2);
			planes.Add(item3);
			planes.Add(item4);
		}
	}

	public void GeneratePlanes()
	{
		if (points.Count >= 3)
		{
			planes.Clear();
			if (points.Count == 3)
			{
				Vector3 normal = GJKDetecotor.FootPointOnPlane(A, B, C, Vector3.zero);
				SimplexPlane item = new SimplexPlane(normal, normal.sqrMagnitude, A, B, C);
				planes.Add(item);
				return;
			}
			Vector3 normal2 = GJKDetecotor.FootPointOnPlane(A, B, C, Vector3.zero);
			Vector3 normal3 = GJKDetecotor.FootPointOnPlane(A, C, D, Vector3.zero);
			Vector3 normal4 = GJKDetecotor.FootPointOnPlane(A, D, B, Vector3.zero);
			Vector3 normal5 = GJKDetecotor.FootPointOnPlane(B, D, C, Vector3.zero);
			SimplexPlane item2 = new SimplexPlane(normal2, normal2.sqrMagnitude, A, B, C);
			SimplexPlane item3 = new SimplexPlane(normal3, normal3.sqrMagnitude, A, C, D);
			SimplexPlane item4 = new SimplexPlane(normal4, normal4.sqrMagnitude, A, D, B);
			SimplexPlane item5 = new SimplexPlane(normal5, normal5.sqrMagnitude, B, D, C);
			planes.Add(item2);
			planes.Add(item3);
			planes.Add(item4);
			planes.Add(item5);
		}
	}

	public void InsertPlanePoint(Vector3 point, SimplexPlane plane)
	{
		Vector3 normal = GJKDetecotor.FootPointOnPlane(point, plane.A, plane.B, Vector3.zero);
		Vector3 normal2 = GJKDetecotor.FootPointOnPlane(point, plane.A, plane.C, Vector3.zero);
		Vector3 normal3 = GJKDetecotor.FootPointOnPlane(point, plane.B, plane.C, Vector3.zero);
		SimplexPlane item = new SimplexPlane(normal, normal.sqrMagnitude, point, plane.A, plane.B);
		SimplexPlane item2 = new SimplexPlane(normal2, normal2.sqrMagnitude, point, plane.A, plane.C);
		SimplexPlane item3 = new SimplexPlane(normal3, normal3.sqrMagnitude, point, plane.B, plane.C);
		RemovePlane(plane);
		if (item.originInPlane)
		{
			planes.Add(item);
		}
		if (item2.originInPlane)
		{
			planes.Add(item2);
		}
		if (item3.originInPlane)
		{
			planes.Add(item3);
		}
		Add(point);
	}

	private void RemovePlane(SimplexPlane plane)
	{
		for (int num = planes.Count - 1; num >= 0; num--)
		{
			SimplexPlane simplexPlane = planes[num];
			if (simplexPlane.normal == plane.normal && simplexPlane.sqrDistance == plane.sqrDistance && simplexPlane.A == plane.A && simplexPlane.B == plane.B && simplexPlane.C == plane.C)
			{
				planes.Remove(plane);
			}
		}
	}
}
