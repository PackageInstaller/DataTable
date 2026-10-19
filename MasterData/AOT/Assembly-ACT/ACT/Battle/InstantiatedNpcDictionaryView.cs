using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle;

public readonly struct InstantiatedNpcDictionaryView
{
	private readonly Dictionary<int, Entity> m_Dictionary;

	public int Count => m_Dictionary.Count;

	public Entity this[int key] => m_Dictionary[key];

	internal InstantiatedNpcDictionaryView(Dictionary<int, Entity> dictionary)
	{
		m_Dictionary = dictionary;
	}

	public bool TryGetValue(int key, out Entity value)
	{
		return m_Dictionary.TryGetValue(key, out value);
	}

	public bool ContainsKey(int key)
	{
		return m_Dictionary.ContainsKey(key);
	}

	public Dictionary<int, Entity>.Enumerator GetEnumerator()
	{
		return m_Dictionary.GetEnumerator();
	}
}
