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

	public ColorWriteMask writeMask
	{
		get
		{
			return (ColorWriteMask)m_WriteMask;
		}
		set
		{
			m_WriteMask = (byte)value;
		}
	}

	public BlendMode sourceColorBlendMode
	{
		get
		{
			return (BlendMode)m_SourceColorBlendMode;
		}
		set
		{
			m_SourceColorBlendMode = (byte)value;
		}
	}

	public BlendMode destinationColorBlendMode
	{
		get
		{
			return (BlendMode)m_DestinationColorBlendMode;
		}
		set
		{
			m_DestinationColorBlendMode = (byte)value;
		}
	}

	public BlendMode sourceAlphaBlendMode
	{
		get
		{
			return (BlendMode)m_SourceAlphaBlendMode;
		}
		set
		{
			m_SourceAlphaBlendMode = (byte)value;
		}
	}

	public BlendMode destinationAlphaBlendMode
	{
		get
		{
			return (BlendMode)m_DestinationAlphaBlendMode;
		}
		set
		{
			m_DestinationAlphaBlendMode = (byte)value;
		}
	}

	public BlendOp colorBlendOperation
	{
		get
		{
			return (BlendOp)m_ColorBlendOperation;
		}
		set
		{
			m_ColorBlendOperation = (byte)value;
		}
	}

	public BlendOp alphaBlendOperation
	{
		get
		{
			return (BlendOp)m_AlphaBlendOperation;
		}
		set
		{
			m_AlphaBlendOperation = (byte)value;
		}
	}

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

	public static bool operator ==(RenderTargetBlendState left, RenderTargetBlendState right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(RenderTargetBlendState left, RenderTargetBlendState right)
	{
		return !left.Equals(right);
	}
}
