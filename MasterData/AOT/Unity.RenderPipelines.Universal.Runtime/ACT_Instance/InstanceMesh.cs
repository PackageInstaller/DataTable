using UnityEngine;

namespace ACT_Instance;

[ExecuteAlways]
public class InstanceMesh : MonoBehaviour
{
	public Mesh mesh;

	public Material mat;

	public bool renderShadow;

	public bool distanceRandomCulling;

	public DrawInstanceObject.RenderType renderType;

	public DrawInstanceObject.InstanceObject m_InstanceObject;

	private void AddToList()
	{
		CreateMesh();
		Object.FindObjectsOfType<DrawInstance>()[0].AddToList(this);
	}

	public void CreateMesh()
	{
		MeshRenderer[] componentsInChildren = gameObject.GetComponentsInChildren<MeshRenderer>();
		if (componentsInChildren.Length != 0)
		{
			m_InstanceObject = new DrawInstanceObject.InstanceObject();
			m_InstanceObject.renderType = renderType;
			m_InstanceObject.renderShadow = renderShadow;
			m_InstanceObject.mesh = mesh;
			m_InstanceObject.mat = mat;
			m_InstanceObject.TransformMatrix = Matrix4x4.identity;
			Vector3[] boundCorner = getBoundCorner(m_InstanceObject.mesh.bounds);
			Bounds bounds = new Bounds(transform.position, Vector3.zero);
			MeshRenderer[] array = componentsInChildren;
			for (int i = 0; i < array.Length; i++)
			{
				Matrix4x4 localToWorldMatrix = array[i].transform.localToWorldMatrix;
				Bounds bounds2 = GeometryUtility.CalculateBounds(boundCorner, localToWorldMatrix);
				bounds.Encapsulate(bounds2);
				m_InstanceObject.instanceData.Add(DrawInstanceObject.GetInstanceData(localToWorldMatrix, Vector4.one, new Vector4(distanceRandomCulling ? 1 : 0, Random.value, 0f, 0f), Vector4.zero, bounds2));
			}
			m_InstanceObject.LocalBounds = bounds;
			m_InstanceObject.bounds = bounds;
		}
	}

	private Vector3[] getBoundCorner(Bounds bounds)
	{
		Vector3[] array = new Vector3[8];
		array[0] = bounds.center + bounds.extents;
		array[1] = bounds.center + new Vector3(0f - bounds.extents.x, bounds.extents.y, bounds.extents.z);
		array[2] = bounds.center + new Vector3(0f - bounds.extents.x, 0f - bounds.extents.y, bounds.extents.z);
		array[3] = bounds.center + new Vector3(0f - bounds.extents.x, bounds.extents.y, 0f - bounds.extents.z);
		array[4] = bounds.center + new Vector3(bounds.extents.x, 0f - bounds.extents.y, bounds.extents.z);
		array[5] = bounds.center + new Vector3(bounds.extents.x, 0f - bounds.extents.y, 0f - bounds.extents.z);
		array[5] = bounds.center + new Vector3(bounds.extents.x, bounds.extents.y, 0f - bounds.extents.z);
		array[7] = bounds.center - bounds.extents;
		return array;
	}
}
