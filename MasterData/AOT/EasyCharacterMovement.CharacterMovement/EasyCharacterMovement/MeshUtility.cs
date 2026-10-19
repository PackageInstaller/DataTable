using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

namespace EasyCharacterMovement;

public static class MeshUtility
{
	private const int kMaxVertices = 1024;

	private const int kMaxTriangles = 3072;

	private static readonly List<Vector3> _vertices = new List<Vector3>(1024);

	private static readonly List<ushort> _triangles16 = new List<ushort>(3072);

	private static readonly List<int> _triangles32 = new List<int>();

	private static readonly List<ushort> _scratchBuffer16 = new List<ushort>(3072);

	private static readonly List<int> _scratchBuffer32 = new List<int>();

	public static Vector3 FindMeshOpposingNormal(Mesh sharedMesh, ref RaycastHit inHit)
	{
		Vector3 point;
		Vector3 point2;
		Vector3 point3;
		if (sharedMesh.indexFormat == IndexFormat.UInt16)
		{
			_triangles16.Clear();
			int subMeshCount = sharedMesh.subMeshCount;
			if (subMeshCount == 1)
			{
				sharedMesh.GetTriangles(_triangles16, 0);
			}
			else
			{
				for (int i = 0; i < subMeshCount; i++)
				{
					sharedMesh.GetTriangles(_scratchBuffer16, i);
					_triangles16.AddRange(_scratchBuffer16);
				}
			}
			sharedMesh.GetVertices(_vertices);
			point = _vertices[_triangles16[inHit.triangleIndex * 3]];
			point2 = _vertices[_triangles16[inHit.triangleIndex * 3 + 1]];
			point3 = _vertices[_triangles16[inHit.triangleIndex * 3 + 2]];
		}
		else
		{
			_triangles32.Clear();
			int subMeshCount2 = sharedMesh.subMeshCount;
			if (subMeshCount2 == 1)
			{
				sharedMesh.GetTriangles(_triangles32, 0);
			}
			else
			{
				for (int j = 0; j < subMeshCount2; j++)
				{
					sharedMesh.GetTriangles(_scratchBuffer32, j);
					_triangles32.AddRange(_scratchBuffer32);
				}
			}
			sharedMesh.GetVertices(_vertices);
			point = _vertices[_triangles32[inHit.triangleIndex * 3]];
			point2 = _vertices[_triangles32[inHit.triangleIndex * 3 + 1]];
			point3 = _vertices[_triangles32[inHit.triangleIndex * 3 + 2]];
		}
		Matrix4x4 localToWorldMatrix = inHit.transform.localToWorldMatrix;
		Vector3 vector = localToWorldMatrix.MultiplyPoint3x4(point);
		Vector3 vector2 = localToWorldMatrix.MultiplyPoint3x4(point2);
		Vector3 vector3 = localToWorldMatrix.MultiplyPoint3x4(point3);
		Vector3 lhs = vector2 - vector;
		Vector3 rhs = vector3 - vector;
		return Vector3.Cross(lhs, rhs).normalized;
	}

	public static void FlushBuffers()
	{
		_vertices.Clear();
		_scratchBuffer16.Clear();
		_scratchBuffer32.Clear();
		_triangles16.Clear();
		_triangles32.Clear();
	}
}
