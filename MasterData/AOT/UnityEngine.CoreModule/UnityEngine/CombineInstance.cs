namespace UnityEngine;

public struct CombineInstance
{
	private int m_MeshInstanceID;

	private int m_SubMeshIndex;

	private Matrix4x4 m_Transform;

	private Vector4 m_LightmapScaleOffset;

	private Vector4 m_RealtimeLightmapScaleOffset;

	public Mesh mesh
	{
		get
		{
			return Mesh.FromInstanceID(m_MeshInstanceID);
		}
		set
		{
			m_MeshInstanceID = ((value != null) ? value.GetInstanceID() : 0);
		}
	}

	public Matrix4x4 transform
	{
		set
		{
			m_Transform = value;
		}
	}
}
