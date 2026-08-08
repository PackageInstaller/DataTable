using System;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[UsedByNativeCode]
public struct ScriptableCullingParameters : IEquatable<ScriptableCullingParameters>
{
	private int m_IsOrthographic;

	private LODParameters m_LODParameters;

	public static readonly int maximumCullingPlaneCount = 10;

	internal unsafe fixed byte m_CullingPlanes[160];

	private int m_CullingPlaneCount;

	private uint m_CullingMask;

	private ulong m_SceneMask;

	private ulong m_ViewID;

	public static readonly int layerCount = 32;

	internal unsafe fixed float m_LayerFarCullDistances[32];

	private int m_LayerCull;

	private Matrix4x4 m_CullingMatrix;

	private Vector3 m_Origin;

	private float m_ShadowDistance;

	private float m_ShadowNearPlaneOffset;

	private CullingOptions m_CullingOptions;

	private ReflectionProbeSortingCriteria m_ReflectionProbeSortingCriteria;

	private CameraProperties m_CameraProperties;

	private float m_AccurateOcclusionThreshold;

	private int m_MaximumPortalCullingJobs;

	private Matrix4x4 m_StereoViewMatrix;

	private Matrix4x4 m_StereoProjectionMatrix;

	private float m_StereoSeparationDistance;

	private int m_maximumVisibleLights;

	private bool m_ConservativeEnclosingSphere;

	private int m_NumIterationsEnclosingSphere;

	public int maximumVisibleLights
	{
		set
		{
			m_maximumVisibleLights = value;
		}
	}

	public int cullingPlaneCount => m_CullingPlaneCount;

	public uint cullingMask
	{
		set
		{
			m_CullingMask = value;
		}
	}

	public float shadowDistance
	{
		set
		{
			m_ShadowDistance = value;
		}
	}

	public unsafe float GetLayerCullingDistance(int layerIndex)
	{
		if (layerIndex < 0 || layerIndex >= 32)
		{
			throw new ArgumentOutOfRangeException(string.Format("{0} was {1}, but must be at least 0 and less than {2}", "layerIndex", layerIndex, 32));
		}
		fixed (float* layerFarCullDistances = m_LayerFarCullDistances)
		{
			return layerFarCullDistances[layerIndex];
		}
	}

	public unsafe Plane GetCullingPlane(int index)
	{
		if (index < 0 || index >= cullingPlaneCount)
		{
			throw new ArgumentOutOfRangeException(string.Format("{0} was {1}, but must be at least 0 and less than {2}", "index", index, cullingPlaneCount));
		}
		fixed (byte* cullingPlanes = m_CullingPlanes)
		{
			Plane* ptr = (Plane*)cullingPlanes;
			return ptr[index];
		}
	}

	public unsafe void SetCullingPlane(int index, Plane plane)
	{
		if (index < 0 || index >= cullingPlaneCount)
		{
			throw new ArgumentOutOfRangeException(string.Format("{0} was {1}, but must be at least 0 and less than {2}", "index", index, cullingPlaneCount));
		}
		fixed (byte* cullingPlanes = m_CullingPlanes)
		{
			Plane* ptr = (Plane*)cullingPlanes;
			ptr[index] = plane;
		}
	}

	public bool Equals(ScriptableCullingParameters other)
	{
		for (int i = 0; i < 32; i++)
		{
			if (!GetLayerCullingDistance(i).Equals(other.GetLayerCullingDistance(i)))
			{
				return false;
			}
		}
		for (int j = 0; j < cullingPlaneCount; j++)
		{
			if (!GetCullingPlane(j).Equals(other.GetCullingPlane(j)))
			{
				return false;
			}
		}
		return m_IsOrthographic == other.m_IsOrthographic && m_LODParameters.Equals(other.m_LODParameters) && m_CullingPlaneCount == other.m_CullingPlaneCount && m_CullingMask == other.m_CullingMask && m_SceneMask == other.m_SceneMask && m_ViewID == other.m_ViewID && m_LayerCull == other.m_LayerCull && m_CullingMatrix.Equals(other.m_CullingMatrix) && m_Origin.Equals(other.m_Origin) && m_ShadowDistance.Equals(other.m_ShadowDistance) && m_ShadowNearPlaneOffset.Equals(other.m_ShadowNearPlaneOffset) && m_CullingOptions == other.m_CullingOptions && m_ReflectionProbeSortingCriteria == other.m_ReflectionProbeSortingCriteria && m_CameraProperties.Equals(other.m_CameraProperties) && m_AccurateOcclusionThreshold.Equals(other.m_AccurateOcclusionThreshold) && m_StereoViewMatrix.Equals(other.m_StereoViewMatrix) && m_StereoProjectionMatrix.Equals(other.m_StereoProjectionMatrix) && m_StereoSeparationDistance.Equals(other.m_StereoSeparationDistance) && m_maximumVisibleLights == other.m_maximumVisibleLights && m_ConservativeEnclosingSphere == other.m_ConservativeEnclosingSphere && m_NumIterationsEnclosingSphere == other.m_NumIterationsEnclosingSphere;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		return obj is ScriptableCullingParameters && Equals((ScriptableCullingParameters)obj);
	}

	public override int GetHashCode()
	{
		int isOrthographic = m_IsOrthographic;
		isOrthographic = (isOrthographic * 397) ^ m_LODParameters.GetHashCode();
		isOrthographic = (isOrthographic * 397) ^ m_CullingPlaneCount;
		isOrthographic = (isOrthographic * 397) ^ (int)m_CullingMask;
		isOrthographic = (isOrthographic * 397) ^ m_SceneMask.GetHashCode();
		isOrthographic = (isOrthographic * 397) ^ m_ViewID.GetHashCode();
		isOrthographic = (isOrthographic * 397) ^ m_LayerCull;
		isOrthographic = (isOrthographic * 397) ^ m_CullingMatrix.GetHashCode();
		isOrthographic = (isOrthographic * 397) ^ m_Origin.GetHashCode();
		isOrthographic = (isOrthographic * 397) ^ m_ShadowDistance.GetHashCode();
		isOrthographic = (isOrthographic * 397) ^ m_ShadowNearPlaneOffset.GetHashCode();
		isOrthographic = (isOrthographic * 397) ^ (int)m_CullingOptions;
		isOrthographic = (isOrthographic * 397) ^ (int)m_ReflectionProbeSortingCriteria;
		isOrthographic = (isOrthographic * 397) ^ m_CameraProperties.GetHashCode();
		isOrthographic = (isOrthographic * 397) ^ m_AccurateOcclusionThreshold.GetHashCode();
		isOrthographic = (isOrthographic * 397) ^ m_MaximumPortalCullingJobs.GetHashCode();
		isOrthographic = (isOrthographic * 397) ^ m_StereoViewMatrix.GetHashCode();
		isOrthographic = (isOrthographic * 397) ^ m_StereoProjectionMatrix.GetHashCode();
		isOrthographic = (isOrthographic * 397) ^ m_StereoSeparationDistance.GetHashCode();
		isOrthographic = (isOrthographic * 397) ^ m_maximumVisibleLights;
		isOrthographic = (isOrthographic * 397) ^ m_ConservativeEnclosingSphere.GetHashCode();
		return (isOrthographic * 397) ^ m_NumIterationsEnclosingSphere.GetHashCode();
	}
}
