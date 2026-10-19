using System;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[UsedByNativeCode]
public struct VisibleReflectionProbe : IEquatable<VisibleReflectionProbe>
{
	private Bounds m_Bounds;

	private Matrix4x4 m_LocalToWorldMatrix;

	private Vector4 m_HdrData;

	private Vector3 m_Center;

	private float m_BlendDistance;

	private int m_Importance;

	private int m_BoxProjection;

	private int m_InstanceId;

	private int m_TextureId;

	public Texture texture => (Texture)Object.FindObjectFromInstanceID(m_TextureId);

	public ReflectionProbe reflectionProbe => (ReflectionProbe)Object.FindObjectFromInstanceID(m_InstanceId);

	public Bounds bounds => m_Bounds;

	public Matrix4x4 localToWorldMatrix => m_LocalToWorldMatrix;

	public Vector4 hdrData => m_HdrData;

	public Vector3 center => m_Center;

	public float blendDistance => m_BlendDistance;

	public bool isBoxProjection => Convert.ToBoolean(m_BoxProjection);

	public bool Equals(VisibleReflectionProbe other)
	{
		return m_Bounds.Equals(other.m_Bounds) && m_LocalToWorldMatrix.Equals(other.m_LocalToWorldMatrix) && m_HdrData.Equals(other.m_HdrData) && m_Center.Equals(other.m_Center) && m_BlendDistance.Equals(other.m_BlendDistance) && m_Importance == other.m_Importance && m_BoxProjection == other.m_BoxProjection && m_InstanceId == other.m_InstanceId && m_TextureId == other.m_TextureId;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		return obj is VisibleReflectionProbe && Equals((VisibleReflectionProbe)obj);
	}

	public override int GetHashCode()
	{
		int hashCode = m_Bounds.GetHashCode();
		hashCode = (hashCode * 397) ^ m_LocalToWorldMatrix.GetHashCode();
		hashCode = (hashCode * 397) ^ m_HdrData.GetHashCode();
		hashCode = (hashCode * 397) ^ m_Center.GetHashCode();
		hashCode = (hashCode * 397) ^ m_BlendDistance.GetHashCode();
		hashCode = (hashCode * 397) ^ m_Importance;
		hashCode = (hashCode * 397) ^ m_BoxProjection;
		hashCode = (hashCode * 397) ^ m_InstanceId;
		return (hashCode * 397) ^ m_TextureId;
	}
}
