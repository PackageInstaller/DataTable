using System;
using System.Collections.Generic;

namespace Ase;

public class DoubleMap<K, V>
{
	private readonly Dictionary<K, V> kv = new Dictionary<K, V>();

	private readonly Dictionary<V, K> vk = new Dictionary<V, K>();

	public List<K> Keys => new List<K>(kv.Keys);

	public List<V> Values => new List<V>(vk.Keys);

	public DoubleMap()
	{
	}

	public DoubleMap(int capacity)
	{
		kv = new Dictionary<K, V>(capacity);
		vk = new Dictionary<V, K>(capacity);
	}

	public void ForEach(Action<K, V> action)
	{
		if (action == null)
		{
			return;
		}
		foreach (K key in kv.Keys)
		{
			action(key, kv[key]);
		}
	}

	public void Add(K key, V value)
	{
		if (key != null && value != null && !kv.ContainsKey(key) && !vk.ContainsKey(value))
		{
			kv.Add(key, value);
			vk.Add(value, key);
		}
	}

	public V GetValueByKey(K key)
	{
		if (key != null && kv.ContainsKey(key))
		{
			return kv[key];
		}
		return default(V);
	}

	public K GetKeyByValue(V value)
	{
		if (value != null && vk.ContainsKey(value))
		{
			return vk[value];
		}
		return default(K);
	}

	public void RemoveByKey(K key)
	{
		if (key != null && kv.TryGetValue(key, out var value))
		{
			kv.Remove(key);
			vk.Remove(value);
		}
	}

	public void RemoveByValue(V value)
	{
		if (value != null && vk.TryGetValue(value, out var value2))
		{
			kv.Remove(value2);
			vk.Remove(value);
		}
	}

	public void Clear()
	{
		kv.Clear();
		vk.Clear();
	}

	public bool ContainsKey(K key)
	{
		if (key == null)
		{
			return false;
		}
		return kv.ContainsKey(key);
	}

	public bool ContainsValue(V value)
	{
		if (value == null)
		{
			return false;
		}
		return vk.ContainsKey(value);
	}

	public bool Contains(K key, V value)
	{
		if (key == null || value == null)
		{
			return false;
		}
		if (kv.ContainsKey(key))
		{
			return vk.ContainsKey(value);
		}
		return false;
	}
}
