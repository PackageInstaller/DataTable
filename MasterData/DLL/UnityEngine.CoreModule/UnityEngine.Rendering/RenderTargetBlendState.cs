using System;

namespace UnityEngine.Rendering;

public struct RenderTargetBlendState : IEquatable<RenderTargetBlendState>
{
	private byte m_WriteMask;

	private byte m_SourceColorBlendMode;

	private byte m_DestinationColorBlendMode;

	private byte m_SourceAlphaBlendMode;

	private byte m_DestinationAlphaBlendMode;

	private byte m_ColorBlendOperation;

	private byte m_AlphaBlendOperation;

	private byte m_Padding;

	public static RenderTargetBlendState defaultValue => new RenderTargetBlendState(ColorWriteMask.All, BlendMode.One, BlendMode.Zero, BlendMode.One, BlendMode.Zero, BlendOp.Add, BlendOp.Add);

	public RenderTargetBlendState(ColorWriteMask writeMask = ColorWriteMask.All, BlendMode sourceColorBlendMode = BlendMode.One, BlendMode destinationColorBlendMode = BlendMode.Zero, BlendMode sourceAlphaBlendMode = BlendMode.One, BlendMode destinationAlphaBlendMode = BlendMode.Zero, BlendOp colorBlendOperation = BlendOp.Add, BlendOp alphaBlendOperation = BlendOp.Add)
	{
		m_WriteMask = (byte)writeMask;
		m_SourceColorBlendMode = (byte)sourceColorBlendMode;
		m_DestinationColorBlendMode = (byte)destinationColorBlendMode;
		m_SourceAlphaBlendMode = (byte)sourceAlphaBlendMode;
		m_DestinationAlphaBlendMode = (byte)destinationAlphaBlendMode;
		m_ColorBlendOperation = (byte)colorBlendOperation;
		m_AlphaBlendOperation = (byte)alphaBlendOperation;
		m_Padding = 0;
	}

	public bool Equals(RenderTargetBlendState other)
	{
		return m_WriteMask == other.m_WriteMask && m_SourceColorBlendMode == other.m_SourceColorBlendMode && m_DestinationColorBlendMode == other.m_DestinationColorBlendMode && m_SourceAlphaBlendMode == other.m_SourceAlphaBlendMode && m_DestinationAlphaBlendMode == other.m_DestinationAlphaBlendMode && m_ColorBlendOperation == other.m_ColorBlendOperation && m_AlphaBlendOperation == other.m_AlphaBlendOperation;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		return obj is RenderTargetBlendState && Equals((RenderTargetBlendState)obj);
	}

	public override int GetHashCode()
	{
		int hashCode = m_WriteMask.GetHashCode();
		hashCode = (hashCode * 397) ^ m_SourceColorBlendMode.GetHashCode();
		hashCode = (hashCode * 397) ^ m_DestinationColorBlendMode.GetHashCode();
		hashCode = (hashCode * 397) ^ m_SourceAlphaBlendMode.GetHashCode();
		hashCode = (hashCode * 397) ^ m_DestinationAlphaBlendMode.GetHashCode();
		hashCode = (hashCode * 397) ^ m_ColorBlendOperation.GetHashCode();
		return (hashCode * 397) ^ m_AlphaBlendOperation.GetHashCode();
	}
}
