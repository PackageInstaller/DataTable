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

	public LightType lightType
	{
		get
		{
			return m_LightType;
		}
		set
		{
			m_LightType = value;
		}
	}

	public Color finalColor
	{
		get
		{
			return m_FinalColor;
		}
		set
		{
			m_FinalColor = value;
		}
	}

	public Rect screenRect
	{
		get
		{
			return m_ScreenRect;
		}
		set
		{
			m_ScreenRect = value;
		}
	}

	public Matrix4x4 localToWorldMatrix
	{
		get
		{
			return m_LocalToWorldMatrix;
		}
		set
		{
			m_LocalToWorldMatrix = value;
		}
	}

	public float range
	{
		get
		{
			return m_Range;
		}
		set
		{
			m_Range = value;
		}
	}

	public float spotAngle
	{
		get
		{
			return m_SpotAngle;
		}
		set
		{
			m_SpotAngle = value;
		}
	}

	public bool intersectsNearPlane
	{
		get
		{
			return (m_Flags & VisibleLightFlags.IntersectsNearPlane) > (VisibleLightFlags)0;
		}
		set
		{
			if (value)
			{
				m_Flags |= VisibleLightFlags.IntersectsNearPlane;
			}
			else
			{
				m_Flags &= ~VisibleLightFlags.IntersectsNearPlane;
			}
		}
	}

	public bool intersectsFarPlane
	{
		get
		{
			return (m_Flags & VisibleLightFlags.IntersectsFarPlane) > (VisibleLightFlags)0;
		}
		set
		{
			if (value)
			{
				m_Flags |= VisibleLightFlags.IntersectsFarPlane;
			}
			else
			{
				m_Flags &= ~VisibleLightFlags.IntersectsFarPlane;
			}
		}
	}

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

	public static bool operator ==(VisibleLight left, VisibleLight right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(VisibleLight left, VisibleLight right)
	{
		return !left.Equals(right);
	}
}
