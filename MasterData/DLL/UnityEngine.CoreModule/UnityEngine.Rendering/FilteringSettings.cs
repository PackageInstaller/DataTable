using System;
using UnityEngine.Internal;

namespace UnityEngine.Rendering;

public struct FilteringSettings : IEquatable<FilteringSettings>
{
	private RenderQueueRange m_RenderQueueRange;

	private int m_LayerMask;

	private uint m_RenderingLayerMask;

	private int m_ExcludeMotionVectorObjects;

	private SortingLayerRange m_SortingLayerRange;

	public RenderQueueRange renderQueueRange
	{
		get
		{
			return m_RenderQueueRange;
		}
		set
		{
			m_RenderQueueRange = value;
		}
	}

	public int layerMask
	{
		get
		{
			return m_LayerMask;
		}
		set
		{
			m_LayerMask = value;
		}
	}

	public uint renderingLayerMask
	{
		set
		{
			m_RenderingLayerMask = value;
		}
	}

	public bool excludeMotionVectorObjects
	{
		set
		{
			m_ExcludeMotionVectorObjects = (value ? 1 : 0);
		}
	}

	public SortingLayerRange sortingLayerRange
	{
		set
		{
			m_SortingLayerRange = value;
		}
	}

	public FilteringSettings([DefaultValue("RenderQueueRange.all")] RenderQueueRange? renderQueueRange = null, int layerMask = -1, uint renderingLayerMask = uint.MaxValue, int excludeMotionVectorObjects = 0)
	{
		this = default(FilteringSettings);
		m_RenderQueueRange = renderQueueRange ?? RenderQueueRange.all;
		m_LayerMask = layerMask;
		m_RenderingLayerMask = renderingLayerMask;
		m_ExcludeMotionVectorObjects = excludeMotionVectorObjects;
		m_SortingLayerRange = SortingLayerRange.all;
	}

	public bool Equals(FilteringSettings other)
	{
		return m_RenderQueueRange.Equals(other.m_RenderQueueRange) && m_LayerMask == other.m_LayerMask && m_RenderingLayerMask == other.m_RenderingLayerMask && m_ExcludeMotionVectorObjects == other.m_ExcludeMotionVectorObjects;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		return obj is FilteringSettings && Equals((FilteringSettings)obj);
	}

	public override int GetHashCode()
	{
		int hashCode = m_RenderQueueRange.GetHashCode();
		hashCode = (hashCode * 397) ^ m_LayerMask;
		hashCode = (hashCode * 397) ^ (int)m_RenderingLayerMask;
		return (hashCode * 397) ^ m_ExcludeMotionVectorObjects;
	}

	public static bool operator ==(FilteringSettings left, FilteringSettings right)
	{
		return left.Equals(right);
	}
}
