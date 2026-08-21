#define ENABLE_DEBUG_AND_ABOVE_LOG
using System.Collections.Generic;

namespace GameFramework.Runtime;

public class KeyValueRegistry<K, V> : IKeyValueRegistry<K, V>
{
	private readonly Dictionary<K, V> lookups = new Dictionary<K, V>();

	public virtual V Find(K key)
	{
		lookups.TryGetValue(key, out var value);
		return value;
	}

	public virtual V Find(K key, V defaultValue)
	{
		if (lookups.TryGetValue(key, out var value))
		{
			return value;
		}
		return defaultValue;
	}

	public virtual void Register(K key, V value)
	{
		if (lookups.ContainsKey(key))
		{
			Log.Warning("The Key({0}) already exists", key);
		}
		lookups[key] = value;
	}

	public virtual void UnRegister(K key)
	{
		if (!lookups.ContainsKey(key))
		{
			Log.Warning("The Key({0}) no exists", key);
		}
		else
		{
			lookups.Remove(key);
		}
	}
}
