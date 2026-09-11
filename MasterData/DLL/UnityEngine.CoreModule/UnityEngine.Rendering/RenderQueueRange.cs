using System;

namespace UnityEngine.Rendering;

public struct RenderQueueRange : IEquatable<RenderQueueRange>
{
	private int m_LowerBound;

	private int m_UpperBound;

	private const int k_MinimumBound = 0;

	public static readonly int minimumBound = 0;

	private const int k_MaximumBound = 5000;

	public static readonly int maximumBound = 5000;

	public static RenderQueueRange all => new RenderQueueRange
	{
		m_LowerBound = 0,
		m_UpperBound = 5000
	};

	public static RenderQueueRange opaque => new RenderQueueRange
	{
		m_LowerBound = 0,
		m_UpperBound = 2500
	};

	public static RenderQueueRange transparent => new RenderQueueRange
	{
		m_LowerBound = 2501,
		m_UpperBound = 5000
	};

	public bool Equals(RenderQueueRange other)
	{
		return m_LowerBound == other.m_LowerBound && m_UpperBound == other.m_UpperBound;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		return obj is RenderQueueRange && Equals((RenderQueueRange)obj);
	}

	public override int GetHashCode()
	{
		return (m_LowerBound * 397) ^ m_UpperBound;
	}
}
