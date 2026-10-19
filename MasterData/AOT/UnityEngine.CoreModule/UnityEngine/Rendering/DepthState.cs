using System;

namespace UnityEngine.Rendering;

public struct DepthState : IEquatable<DepthState>
{
	private byte m_WriteEnabled;

	private sbyte m_CompareFunction;

	public static DepthState defaultValue => new DepthState(true, CompareFunction.Less);

	public bool writeEnabled
	{
		get
		{
			return Convert.ToBoolean(m_WriteEnabled);
		}
		set
		{
			m_WriteEnabled = Convert.ToByte(value);
		}
	}

	public CompareFunction compareFunction
	{
		get
		{
			return (CompareFunction)m_CompareFunction;
		}
		set
		{
			m_CompareFunction = (sbyte)value;
		}
	}

	public DepthState(bool writeEnabled = true, CompareFunction compareFunction = CompareFunction.Less)
	{
		m_WriteEnabled = Convert.ToByte(writeEnabled);
		m_CompareFunction = (sbyte)compareFunction;
	}

	public bool Equals(DepthState other)
	{
		return m_WriteEnabled == other.m_WriteEnabled && m_CompareFunction == other.m_CompareFunction;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		return obj is DepthState && Equals((DepthState)obj);
	}

	public override int GetHashCode()
	{
		return (m_WriteEnabled.GetHashCode() * 397) ^ m_CompareFunction.GetHashCode();
	}

	public static bool operator ==(DepthState left, DepthState right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(DepthState left, DepthState right)
	{
		return !left.Equals(right);
	}
}
