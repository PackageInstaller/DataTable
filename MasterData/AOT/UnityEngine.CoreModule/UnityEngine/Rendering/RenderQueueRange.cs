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

	public int lowerBound
	{
		get
		{
			return m_LowerBound;
		}
		set
		{
			if (value < 0 || value > 5000)
			{
				throw new ArgumentOutOfRangeException($"The lower bound must be at least {0} and at most {5000}.");
			}
			m_LowerBound = value;
		}
	}

	public int upperBound
	{
		get
		{
			return m_UpperBound;
		}
		set
		{
			if (value < 0 || value > 5000)
			{
				throw new ArgumentOutOfRangeException($"The upper bound must be at least {0} and at most {5000}.");
			}
			m_UpperBound = value;
		}
	}

	public RenderQueueRange(int lowerBound, int upperBound)
	{
		if (lowerBound < 0 || lowerBound > 5000)
		{
			throw new ArgumentOutOfRangeException("lowerBound", lowerBound, $"The lower bound must be at least {0} and at most {5000}.");
		}
		if (upperBound < 0 || upperBound > 5000)
		{
			throw new ArgumentOutOfRangeException("upperBound", upperBound, $"The upper bound must be at least {0} and at most {5000}.");
		}
		m_LowerBound = lowerBound;
		m_UpperBound = upperBound;
	}

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

	public static bool operator ==(RenderQueueRange left, RenderQueueRange right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(RenderQueueRange left, RenderQueueRange right)
	{
		return !left.Equals(right);
	}
}
