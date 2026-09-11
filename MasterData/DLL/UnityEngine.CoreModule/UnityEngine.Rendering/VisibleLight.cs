using System;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[UsedByNativeCode]
public struct VisibleLight : IEquatable<VisibleLight>
{
	private LightType m_LightType;

	private Color m_FinalColor;

	private Rect m_ScreenRect;

	private Matrix4x4 m_LocalToWorldMatrix;

	private float m_Range;

	private float m_SpotAngle;

	private int m_InstanceId;

	private VisibleLightFlags m_Flags;

	public Light light => (Light)Object.FindObjectFromInstanceID(m_InstanceId);

	public LightType lightType => m_LightType;

	public Color finalColor => m_FinalColor;

	public Matrix4x4 localToWorldMatrix => m_LocalToWorldMatrix;

	public float range => m_Range;

	public float spotAngle => m_SpotAngle;

	public bool Equals(VisibleLight other)
	{
		return m_LightType == other.m_LightType && m_FinalColor.Equals(other.m_FinalColor) && m_ScreenRect.Equals(other.m_ScreenRect) && m_LocalToWorldMatrix.Equals(other.m_LocalToWorldMatrix) && m_Range.Equals(other.m_Range) && m_SpotAngle.Equals(other.m_SpotAngle) && m_InstanceId == other.m_InstanceId && m_Flags == other.m_Flags;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		return obj is VisibleLight && Equals((VisibleLight)obj);
	}

	public override int GetHashCode()
	{
		int num = (int)m_LightType;
		num = (num * 397) ^ m_FinalColor.GetHashCode();
		num = (num * 397) ^ m_ScreenRect.GetHashCode();
		num = (num * 397) ^ m_LocalToWorldMatrix.GetHashCode();
		num = (num * 397) ^ m_Range.GetHashCode();
		num = (num * 397) ^ m_SpotAngle.GetHashCode();
		num = (num * 397) ^ m_InstanceId;
		return (num * 397) ^ (int)m_Flags;
	}
}
