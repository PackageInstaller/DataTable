using System;
using System.Collections.Generic;
using GameFramework;

namespace Ase.ECS;

public sealed class ComponentData : IComponentData, IReference
{
	private IDictionary<string, object> data = new Dictionary<string, object>();

	public IDictionary<string, object> Data => data;

	public ComponentData()
	{
	}

	public ComponentData(IComponentData componentData)
	{
		PutAll(componentData);
	}

	public void Clear()
	{
		data.Clear();
	}

	public bool ContainsKey(string key)
	{
		return data.ContainsKey(key);
	}

	public bool Remove(string key)
	{
		return data.Remove(key);
	}

	public T Get<T>(string key)
	{
		return Get(key, default(T));
	}

	public Type GetKeyType(string key)
	{
		if (data.TryGetValue(key, out var value))
		{
			return value.GetType();
		}
		return null;
	}

	public T Get<T>(string key, T defaultValue)
	{
		if (data.TryGetValue(key, out var value))
		{
			return (T)value;
		}
		return defaultValue;
	}

	public void Put<T>(string key, T value)
	{
		if (!IsValidType(value))
		{
			throw new ArgumentException("Value must be serializable!");
		}
		data[key] = value;
	}

	public void PutAll(IComponentData bundle)
	{
		foreach (KeyValuePair<string, object> datum in bundle.Data)
		{
			if (!IsValidType(datum.Value))
			{
				throw new ArgumentException("Value must be serializable!");
			}
			data[datum.Key] = datum.Value;
		}
	}

	private bool IsValidType(object value)
	{
		return true;
	}
}
