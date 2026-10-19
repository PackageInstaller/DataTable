using System.Diagnostics;
using UnityEngine;

namespace ACT.World.StaticNodes;

[DisallowMultipleComponent]
[ExecuteAlways]
public sealed class ActMeshFilterProvider : MonoBehaviour
{
	[SerializeField]
	private MeshCollider _meshCollider;

	[SerializeField]
	private Vector3[] _meshVertices;

	[SerializeField]
	private Vector3[] _meshNormals;

	[SerializeField]
	private int[] _meshTriangles;

	[SerializeField]
	private string _meshName;

	private void Awake()
	{
		if ((object)_meshCollider == null)
		{
			_meshCollider = GetComponent<MeshCollider>();
		}
		ApplyMesh();
	}

	[Conditional("UNITY_EDITOR")]
	public void CopyMesh(Mesh mesh)
	{
		_meshName = mesh.name;
		_meshVertices = mesh.vertices;
		_meshNormals = mesh.normals;
		_meshTriangles = mesh.triangles;
	}

	[Conditional("UNITY_EDITOR")]
	public void RecordComponent(MeshCollider meshCollider)
	{
		_meshCollider = meshCollider;
	}

	public void ApplyMesh()
	{
		Mesh mesh = new Mesh
		{
			name = _meshName,
			vertices = _meshVertices,
			normals = _meshNormals,
			triangles = _meshTriangles
		};
		_meshCollider.sharedMesh = mesh;
		mesh.UploadMeshData(markNoLongerReadable: true);
	}
}
