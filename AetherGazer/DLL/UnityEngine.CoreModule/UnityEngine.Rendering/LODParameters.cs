using System;

namespace UnityEngine.Rendering;

public struct LODParameters : IEquatable<LODParameters>
{
	private int m_IsOrthographic;

	private Vector3 m_CameraPosition;

	private float m_FieldOfView;

	private float m_OrthoSize;

	private int m_CameraPixelHeight;

	public bool Equals(LODParameters other)
	{
		return m_IsOrthographic == other.m_IsOrthographic && m_CameraPosition.Equals(other.m_CameraPosition) && m_FieldOfView.Equals(other.m_FieldOfView) && m_OrthoSize.Equals(other.m_OrthoSize) && m_CameraPixelHeight == other.m_CameraPixelHeight;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		return obj is LODParameters && Equals((LODParameters)obj);
	}

	public override int GetHashCode()
	{
		int isOrthographic = m_IsOrthographic;
		isOrthographic = (isOrthographic * 397) ^ m_CameraPosition.GetHashCode();
		isOrthographic = (isOrthographic * 397) ^ m_FieldOfView.GetHashCode();
		isOrthographic = (isOrthographic * 397) ^ m_OrthoSize.GetHashCode();
		return (isOrthographic * 397) ^ m_CameraPixelHeight;
	}
}
