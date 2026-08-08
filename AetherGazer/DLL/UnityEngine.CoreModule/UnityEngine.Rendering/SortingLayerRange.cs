using System;

namespace UnityEngine.Rendering;

public struct SortingLayerRange : IEquatable<SortingLayerRange>
{
	private short m_LowerBound;

	private short m_UpperBound;

	public static SortingLayerRange all => new SortingLayerRange
	{
		m_LowerBound = short.MinValue,
		m_UpperBound = short.MaxValue
	};

	public bool Equals(SortingLayerRange other)
	{
		return m_LowerBound == other.m_LowerBound && m_UpperBound == other.m_UpperBound;
	}

	public override bool Equals(object obj)
	{
		if (!(obj is SortingLayerRange))
		{
			return false;
		}
		return Equals((SortingLayerRange)obj);
	}

	public override int GetHashCode()
	{
		return (m_UpperBound << 16) | (m_LowerBound & 0xFFFF);
	}
}
