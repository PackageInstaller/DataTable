using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle;

public class EntityTags
{
	private readonly List<Action<EntityTag, int>> m_TagChangeCallbacks = new List<Action<EntityTag, int>>();

	private Dictionary<EntityTag, int> m_TagValues;

	public event Action<EntityTag, int> onEntityTagCountChange
	{
		add
		{
			m_TagChangeCallbacks.Add(value);
		}
		remove
		{
			m_TagChangeCallbacks.Remove(value);
		}
	}

	public EntityTags()
	{
		m_TagValues = new Dictionary<EntityTag, int>();
	}

	public void Reset()
	{
		m_TagChangeCallbacks.Clear();
		m_TagValues.Clear();
	}

	public bool InTag(EntityTag tag)
	{
		if (m_TagValues.TryGetValue(tag, out var value))
		{
			return value > 0;
		}
		return false;
	}

	private void InvokeTagChange(EntityTag tag, int value)
	{
		foreach (Action<EntityTag, int> tagChangeCallback in m_TagChangeCallbacks)
		{
			tagChangeCallback?.Invoke(tag, value);
		}
	}

	public void AddTag(EntityTag tag)
	{
		if (m_TagValues.TryGetValue(tag, out var value))
		{
			m_TagValues[tag] = value + 1;
		}
		else
		{
			m_TagValues[tag] = 1;
		}
		InvokeTagChange(tag, m_TagValues[tag]);
	}

	public void RemoveTag(EntityTag tag)
	{
		if (m_TagValues.TryGetValue(tag, out var value))
		{
			m_TagValues[tag] = Mathf.Max(0, value - 1);
			InvokeTagChange(tag, m_TagValues[tag]);
		}
	}

	public void ClearTag(EntityTag tag)
	{
		if (m_TagValues.TryGetValue(tag, out var _))
		{
			m_TagValues[tag] = 0;
		}
	}
}
