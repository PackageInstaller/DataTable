using System;

namespace UnityEngine.Rendering;

public struct BlendState : IEquatable<BlendState>
{
	private RenderTargetBlendState m_BlendState0;

	private RenderTargetBlendState m_BlendState1;

	private RenderTargetBlendState m_BlendState2;

	private RenderTargetBlendState m_BlendState3;

	private RenderTargetBlendState m_BlendState4;

	private RenderTargetBlendState m_BlendState5;

	private RenderTargetBlendState m_BlendState6;

	private RenderTargetBlendState m_BlendState7;

	private byte m_SeparateMRTBlendStates;

	private byte m_AlphaToMask;

	private short m_Padding;

	public static BlendState defaultValue => new BlendState(false, false);

	public BlendState(bool separateMRTBlend = false, bool alphaToMask = false)
	{
		m_BlendState0 = RenderTargetBlendState.defaultValue;
		m_BlendState1 = RenderTargetBlendState.defaultValue;
		m_BlendState2 = RenderTargetBlendState.defaultValue;
		m_BlendState3 = RenderTargetBlendState.defaultValue;
		m_BlendState4 = RenderTargetBlendState.defaultValue;
		m_BlendState5 = RenderTargetBlendState.defaultValue;
		m_BlendState6 = RenderTargetBlendState.defaultValue;
		m_BlendState7 = RenderTargetBlendState.defaultValue;
		m_SeparateMRTBlendStates = Convert.ToByte(separateMRTBlend);
		m_AlphaToMask = Convert.ToByte(alphaToMask);
		m_Padding = 0;
	}

	public bool Equals(BlendState other)
	{
		return m_BlendState0.Equals(other.m_BlendState0) && m_BlendState1.Equals(other.m_BlendState1) && m_BlendState2.Equals(other.m_BlendState2) && m_BlendState3.Equals(other.m_BlendState3) && m_BlendState4.Equals(other.m_BlendState4) && m_BlendState5.Equals(other.m_BlendState5) && m_BlendState6.Equals(other.m_BlendState6) && m_BlendState7.Equals(other.m_BlendState7) && m_SeparateMRTBlendStates == other.m_SeparateMRTBlendStates && m_AlphaToMask == other.m_AlphaToMask;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		return obj is BlendState && Equals((BlendState)obj);
	}

	public override int GetHashCode()
	{
		int hashCode = m_BlendState0.GetHashCode();
		hashCode = (hashCode * 397) ^ m_BlendState1.GetHashCode();
		hashCode = (hashCode * 397) ^ m_BlendState2.GetHashCode();
		hashCode = (hashCode * 397) ^ m_BlendState3.GetHashCode();
		hashCode = (hashCode * 397) ^ m_BlendState4.GetHashCode();
		hashCode = (hashCode * 397) ^ m_BlendState5.GetHashCode();
		hashCode = (hashCode * 397) ^ m_BlendState6.GetHashCode();
		hashCode = (hashCode * 397) ^ m_BlendState7.GetHashCode();
		hashCode = (hashCode * 397) ^ m_SeparateMRTBlendStates.GetHashCode();
		return (hashCode * 397) ^ m_AlphaToMask.GetHashCode();
	}
}
