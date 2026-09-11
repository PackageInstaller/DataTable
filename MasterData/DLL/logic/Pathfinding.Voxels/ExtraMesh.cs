using System;
using UnityEngine;

namespace Pathfinding.Voxels;

[Obsolete("Use RasterizationMesh instead")]
public class ExtraMesh : RasterizationMesh
{
	public ExtraMesh(Vector3[] vertices, int[] triangles, Bounds bounds)
	{
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		base._002Ector(vertices, triangles, bounds);
	}

	public ExtraMesh(Vector3[] vertices, int[] triangles, Bounds bounds, Matrix4x4 matrix)
	{
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		//IL_0004: Unknown result type (might be due to invalid IL or missing references)
		base._002Ector(vertices, triangles, bounds, matrix);
	}
}
