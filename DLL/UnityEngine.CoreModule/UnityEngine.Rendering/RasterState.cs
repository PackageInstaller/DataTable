using System;

namespace UnityEngine.Rendering;

public struct RasterState(CullMode cullingMode = CullMode.Back, int offsetUnits = 0, float offsetFactor = 0f, bool depthClip = true) : IEquatable<RasterState>
{
	public static readonly RasterState defaultValue = new RasterState(CullMode.Back, 0, 0f, true);

	private CullMode m_CullingMode = cullingMode;

	private int m_OffsetUnits = offsetUnits;

	private float m_OffsetFactor = offsetFactor;

	private byte m_DepthClip = Convert.ToByte(depthClip);

	private byte m_Conservative = Convert.ToByte(value: false);

	private byte m_Padding1 = 0;

	private byte m_Padding2 = 0;

	public bool Equals(RasterState other)
	{
		return m_CullingMode == other.m_CullingMode && m_OffsetUnits == other.m_OffsetUnits && m_OffsetFactor.Equals(other.m_OffsetFactor) && m_DepthClip == other.m_DepthClip && m_Conservative == other.m_Conservative;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		return obj is RasterState && Equals((RasterState)obj);
	}

	public override int GetHashCode()
	{
		int cullingMode = (int)m_CullingMode;
		cullingMode = (cullingMode * 397) ^ m_OffsetUnits;
		cullingMode = (cullingMode * 397) ^ m_OffsetFactor.GetHashCode();
		cullingMode = (cullingMode * 397) ^ m_DepthClip.GetHashCode();
		return (cullingMode * 397) ^ m_Conservative.GetHashCode();
	}
}
