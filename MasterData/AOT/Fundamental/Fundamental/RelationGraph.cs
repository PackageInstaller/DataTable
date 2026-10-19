using System.Collections.Generic;

namespace Fundamental;

public class RelationGraph<TForwardKey, TBackwardKey>
{
	private Dictionary<TForwardKey, HashSet<TBackwardKey>> m_ForwardValues = new Dictionary<TForwardKey, HashSet<TBackwardKey>>();

	private Dictionary<TBackwardKey, HashSet<TForwardKey>> m_BackwardValues = new Dictionary<TBackwardKey, HashSet<TForwardKey>>();

	public HashSet<TBackwardKey> getForwardValue(TForwardKey forwardKey)
	{
		if (!m_ForwardValues.ContainsKey(forwardKey))
		{
			return null;
		}
		return m_ForwardValues[forwardKey];
	}

	public HashSet<TForwardKey> getBackwardValues(TBackwardKey backwardKey)
	{
		if (!m_BackwardValues.ContainsKey(backwardKey))
		{
			return null;
		}
		return m_BackwardValues[backwardKey];
	}

	public void Add(TForwardKey forwardKey, TBackwardKey backwardKey)
	{
		if (!m_ForwardValues.ContainsKey(forwardKey))
		{
			m_ForwardValues.Add(forwardKey, new HashSet<TBackwardKey> { backwardKey });
		}
		else
		{
			m_ForwardValues[forwardKey].Add(backwardKey);
		}
		if (!m_BackwardValues.ContainsKey(backwardKey))
		{
			m_BackwardValues.Add(backwardKey, new HashSet<TForwardKey> { forwardKey });
		}
		else
		{
			m_BackwardValues[backwardKey].Add(forwardKey);
		}
	}

	public void RemoveForwardKey(TForwardKey forwardKey)
	{
		if (!m_ForwardValues.ContainsKey(forwardKey))
		{
			return;
		}
		HashSet<TBackwardKey> hashSet = m_ForwardValues[forwardKey];
		m_ForwardValues.Remove(forwardKey);
		foreach (TBackwardKey item in hashSet)
		{
			m_BackwardValues[item].Remove(forwardKey);
			if (m_BackwardValues[item].Count == 0)
			{
				m_BackwardValues.Remove(item);
			}
		}
	}

	public void RemoveBackwardKey(TBackwardKey backwardKey)
	{
		if (!m_BackwardValues.ContainsKey(backwardKey))
		{
			return;
		}
		HashSet<TForwardKey> hashSet = m_BackwardValues[backwardKey];
		m_BackwardValues.Remove(backwardKey);
		foreach (TForwardKey item in hashSet)
		{
			m_ForwardValues[item].Remove(backwardKey);
			if (m_ForwardValues[item].Count == 0)
			{
				m_ForwardValues.Remove(item);
			}
		}
	}

	public void Remove(TForwardKey forwardKey, TBackwardKey backwardKey)
	{
		if (!m_ForwardValues.ContainsKey(forwardKey))
		{
			m_ForwardValues[forwardKey].Remove(backwardKey);
		}
		if (!m_BackwardValues.ContainsKey(backwardKey))
		{
			m_BackwardValues[backwardKey].Remove(forwardKey);
		}
	}
}
