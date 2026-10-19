using System.Collections.Generic;

namespace UnityEngine.ResourceManagement.Util;

public class LinkedListNodeCache<T>
{
	private int m_NodesCreated;

	private LinkedList<T> m_NodeCache;

	internal int CreatedNodeCount => m_NodesCreated;

	internal int CachedNodeCount
	{
		get
		{
			if (m_NodeCache != null)
			{
				return m_NodeCache.Count;
			}
			return 0;
		}
		set
		{
			if (m_NodeCache == null)
			{
				m_NodeCache = new LinkedList<T>();
			}
			while (value < m_NodeCache.Count)
			{
				m_NodeCache.RemoveLast();
			}
			while (value > m_NodeCache.Count)
			{
				m_NodeCache.AddLast(new LinkedListNode<T>(default));
			}
		}
	}

	public LinkedListNode<T> Acquire(T val)
	{
		if (m_NodeCache != null)
		{
			LinkedListNode<T> first = m_NodeCache.First;
			if (first != null)
			{
				m_NodeCache.RemoveFirst();
				first.Value = val;
				return first;
			}
		}
		m_NodesCreated++;
		return new LinkedListNode<T>(val);
	}

	public void Release(LinkedListNode<T> node)
	{
		if (m_NodeCache == null)
		{
			m_NodeCache = new LinkedList<T>();
		}
		node.Value = default;
		m_NodeCache.AddLast(node);
	}
}
