using System;

namespace UnityEngine.Rendering;

public struct RenderStateBlock(RenderStateMask mask) : IEquatable<RenderStateBlock>
{
	private BlendState m_BlendState = BlendState.defaultValue;

	private RasterState m_RasterState = RasterState.defaultValue;

	private DepthState m_DepthState = DepthState.defaultValue;

	private StencilState m_StencilState = StencilState.defaultValue;

	private int m_StencilReference = 0;

	private RenderStateMask m_Mask = mask;

	public StencilState stencilState
	{
		set
		{
			m_StencilState = value;
		}
	}

	public int stencilReference
	{
		set
		{
			m_StencilReference = value;
		}
	}

	public bool Equals(RenderStateBlock other)
	{
		return m_BlendState.Equals(other.m_BlendState) && m_RasterState.Equals(other.m_RasterState) && m_DepthState.Equals(other.m_DepthState) && m_StencilState.Equals(other.m_StencilState) && m_StencilReference == other.m_StencilReference && m_Mask == other.m_Mask;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		return obj is RenderStateBlock && Equals((RenderStateBlock)obj);
	}

	public override int GetHashCode()
	{
		int hashCode = m_BlendState.GetHashCode();
		hashCode = (hashCode * 397) ^ m_RasterState.GetHashCode();
		hashCode = (hashCode * 397) ^ m_DepthState.GetHashCode();
		hashCode = (hashCode * 397) ^ m_StencilState.GetHashCode();
		hashCode = (hashCode * 397) ^ m_StencilReference;
		return (hashCode * 397) ^ (int)m_Mask;
	}
}
