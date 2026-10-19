using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

public static class TheoremSAT
{
	private static List<Vector3> aGeometryVerts;

	private static List<Vector3> bGeometryVerts;

	private static List<Vector3> aGeometryEdges;

	private static List<Vector3> bGeometryEdges;

	private static List<Vector3> separatingAxes;

	public static bool IntersectDetect(List<Vector3> vertices_a, List<int> indices_a, Matrix4x4 trs_a, List<Vector3> vertices_b, List<int> indices_b, Matrix4x4 trs_b, List<Vector3> outputTriangles = null)
	{
		if (separatingAxes == null)
		{
			separatingAxes = new List<Vector3>();
		}
		if (aGeometryEdges == null)
		{
			aGeometryEdges = new List<Vector3>();
		}
		if (bGeometryEdges == null)
		{
			bGeometryEdges = new List<Vector3>();
		}
		if (aGeometryVerts == null)
		{
			aGeometryVerts = new List<Vector3>();
		}
		if (bGeometryVerts == null)
		{
			bGeometryVerts = new List<Vector3>();
		}
		separatingAxes.Clear();
		aGeometryEdges.Clear();
		bGeometryEdges.Clear();
		aGeometryVerts.Clear();
		bGeometryVerts.Clear();
		Vector3[] array = new Vector3[3];
		for (int i = 0; i < indices_a.Count; i += 3)
		{
			array[0] = trs_a.MultiplyPoint(vertices_a[indices_a[i]]);
			array[1] = trs_a.MultiplyPoint(vertices_a[indices_a[i + 1]]);
			array[2] = trs_a.MultiplyPoint(vertices_a[indices_a[i + 2]]);
			aGeometryVerts.AddRange(array);
			aGeometryEdges.Add(array[1] - array[0]);
			aGeometryEdges.Add(array[2] - array[1]);
			separatingAxes.Add(Vector3.Cross(array[1] - array[0], array[2] - array[0]).normalized);
		}
		for (int j = 0; j < indices_b.Count; j += 3)
		{
			array[0] = trs_b.MultiplyPoint(vertices_b[indices_b[j]]);
			array[1] = trs_b.MultiplyPoint(vertices_b[indices_b[j + 1]]);
			array[2] = trs_b.MultiplyPoint(vertices_b[indices_b[j + 2]]);
			bGeometryVerts.AddRange(array);
			bGeometryEdges.Add(array[1] - array[0]);
			bGeometryEdges.Add(array[2] - array[1]);
			separatingAxes.Add(Vector3.Cross(array[1] - array[0], array[2] - array[0]).normalized);
		}
		foreach (Vector3 aGeometryEdge in aGeometryEdges)
		{
			foreach (Vector3 bGeometryEdge in bGeometryEdges)
			{
				Vector3 vector = Vector3.Cross(aGeometryEdge, bGeometryEdge);
				if (vector == Vector3.zero)
				{
					separatingAxes.Add(vector.normalized);
				}
			}
		}
		if (outputTriangles != null)
		{
			outputTriangles.AddRange(aGeometryVerts);
			outputTriangles.AddRange(bGeometryVerts);
		}
		foreach (Vector3 separatingAxis in separatingAxes)
		{
			var (minA, maxA) = Project3D(aGeometryVerts, separatingAxis);
			var (minB, maxB) = Project3D(bGeometryVerts, separatingAxis);
			if (!IsOverlapping(minA, maxA, minB, maxB))
			{
				return false;
			}
		}
		return true;
	}

	private static (float min, float max) Project3D(List<Vector3> vertices, Vector3 axis)
	{
		float num = Vector3.Dot(vertices[0], axis);
		float num2 = num;
		for (int i = 1; i < vertices.Count; i++)
		{
			float b = Vector3.Dot(vertices[i], axis);
			num = Mathf.Min(num, b);
			num2 = Mathf.Max(num2, b);
		}
		return (min: num, max: num2);
	}

	private static bool IsOverlapping(float minA, float maxA, float minB, float maxB)
	{
		if (!(minA > maxB))
		{
			return !(minB > maxA);
		}
		return false;
	}
}
