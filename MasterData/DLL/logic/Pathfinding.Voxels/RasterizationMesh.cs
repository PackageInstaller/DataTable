using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding.Voxels;

public class RasterizationMesh
{
	public MeshFilter original;

	public int area;

	public Vector3[] vertices;

	public int[] triangles;

	public int numVertices;

	public int numTriangles;

	public Bounds bounds;

	public Matrix4x4 matrix;

	public bool pool;

	public RasterizationMesh()
	{
	}

	public RasterizationMesh(Vector3[] vertices, int[] triangles, Bounds bounds)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0033: Unknown result type (might be due to invalid IL or missing references)
		base._002Ector();
		matrix = Matrix4x4.identity;
		this.vertices = vertices;
		numVertices = vertices.Length;
		this.triangles = triangles;
		numTriangles = triangles.Length;
		this.bounds = bounds;
		original = null;
		area = 0;
	}

	public RasterizationMesh(Vector3[] vertices, int[] triangles, Bounds bounds, Matrix4x4 matrix)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_002f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		base._002Ector();
		this.matrix = matrix;
		this.vertices = vertices;
		numVertices = vertices.Length;
		this.triangles = triangles;
		numTriangles = triangles.Length;
		this.bounds = bounds;
		original = null;
		area = 0;
	}

	public void RecalculateBounds()
	{
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		Bounds val = default(Bounds);
		((Bounds)(ref val))._002Ector(((Matrix4x4)(ref matrix)).MultiplyPoint3x4(vertices[0]), Vector3.zero);
		for (int i = 1; i < numVertices; i++)
		{
			((Bounds)(ref val)).Encapsulate(((Matrix4x4)(ref matrix)).MultiplyPoint3x4(vertices[i]));
		}
		bounds = val;
	}

	public void Pool()
	{
		if (pool)
		{
			ArrayPool<int>.Release(ref triangles);
			ArrayPool<Vector3>.Release(ref vertices);
		}
	}
}
