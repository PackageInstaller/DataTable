using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase;

public class GroundMeshCollider : MonoBehaviour
{
	[SerializeField]
	private Vector3[] vertices;

	[SerializeField]
	private int[] triangles;

	public void Calulate(Mesh sourceMesh)
	{
		if (sourceMesh == null)
		{
			Debug.LogError("GroundMeshCollider: 初始化的Mesh为空");
			return;
		}
		vertices = sourceMesh.vertices;
		triangles = sourceMesh.triangles;
	}

	public UniTask Init()
	{
		Mesh mesh = new Mesh();
		mesh.name = "GeneratedMesh";
		mesh.vertices = vertices;
		mesh.triangles = triangles;
		base.gameObject.GetOrAddComponent<MeshCollider>().sharedMesh = mesh;
		base.gameObject.layer = LayerMask.NameToLayer("Ground");
		return UniTask.CompletedTask;
	}
}
