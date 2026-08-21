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

	public int subMeshIndex
	{
		get
		{
			return m_SubMeshIndex;
		}
		set
		{
			m_SubMeshIndex = value;
		}
	}

	public Matrix4x4 transform
	{
		get
		{
			return m_Transform;
		}
		set
		{
			m_Transform = value;
		}
	}

	public Vector4 lightmapScaleOffset
	{
		get
		{
			return m_LightmapScaleOffset;
		}
		set
		{
			m_LightmapScaleOffset = value;
		}
	}

	public Vector4 realtimeLightmapScaleOffset
	{
		get
		{
			return m_RealtimeLightmapScaleOffset;
		}
		set
		{
			m_RealtimeLightmapScaleOffset = value;
		}
	}
}
