using System;

namespace UnityEngine.Rendering;

public struct SortingSettings : IEquatable<SortingSettings>
{
	private Matrix4x4 m_WorldToCameraMatrix;

	private Vector3 m_CameraPosition;

	private Vector3 m_CustomAxis;

	private SortingCriteria m_Criteria;

	private DistanceMetric m_DistanceMetric;

	private Matrix4x4 m_PreviousVPMatrix;

	private Matrix4x4 m_NonJitteredVPMatrix;

	public Vector3 customAxis
	{
		set
		{
			m_CustomAxis = value;
		}
	}

	public SortingCriteria criteria
	{
		get
		{
			return m_Criteria;
		}
		set
		{
			m_Criteria = value;
		}
	}

	public DistanceMetric distanceMetric
	{
		set
		{
			m_DistanceMetric = value;
		}
	}

	public SortingSettings(Camera camera)
	{
		ScriptableRenderContext.InitializeSortSettings(camera, out this);
		m_Criteria = criteria;
	}

	public bool Equals(SortingSettings other)
	{
		return m_WorldToCameraMatrix.Equals(other.m_WorldToCameraMatrix) && m_CameraPosition.Equals(other.m_CameraPosition) && m_CustomAxis.Equals(other.m_CustomAxis) && m_Criteria == other.m_Criteria && m_DistanceMetric == other.m_DistanceMetric && m_PreviousVPMatrix.Equals(other.m_PreviousVPMatrix) && m_NonJitteredVPMatrix.Equals(other.m_NonJitteredVPMatrix);
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		return obj is SortingSettings && Equals((SortingSettings)obj);
	}

	public override int GetHashCode()
	{
		int hashCode = m_WorldToCameraMatrix.GetHashCode();
		hashCode = (hashCode * 397) ^ m_CameraPosition.GetHashCode();
		hashCode = (hashCode * 397) ^ m_CustomAxis.GetHashCode();
		hashCode = (hashCode * 397) ^ (int)m_Criteria;
		hashCode = (hashCode * 397) ^ (int)m_DistanceMetric;
		hashCode = (hashCode * 397) ^ m_PreviousVPMatrix.GetHashCode();
		return (hashCode * 397) ^ m_NonJitteredVPMatrix.GetHashCode();
	}
}
