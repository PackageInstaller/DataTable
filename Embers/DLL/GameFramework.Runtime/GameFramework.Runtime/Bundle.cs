using System;
using System.Collections.Generic;

namespace GameFramework.Runtime;

public class Bundle : IBundle
{
	protected IDictionary<string, object> data = new Dictionary<string, object>();

	public virtual int Count => data.Count;

	public virtual IDictionary<string, object> Data => data;

	public virtual ICollection<string> Keys => data.Keys;

	public virtual ICollection<object> Values => data.Values;

	public Bundle()
	{
	}

	public Bundle(IBundle bundle)
	{
		PutAll(bundle);
	}

	public virtual void Clear()
	{
		data.Clear();
	}

	public virtual bool ContainsKey(string key)
	{
		return data.ContainsKey(key);
	}

	public virtual bool Remove(string key)
	{
		return data.Remove(key);
	}

	public virtual object Get(string key)
	{
		data.TryGetValue(key, out var value);
		return value;
	}

	public virtual T Get<T>(string key)
	{
		return Get(key, default(T));
	}

	public virtual T Get<T>(string key, T defaultValue)
	{
		if (data.TryGetValue(key, out var value))
		{
			return (T)value;
		}
		return defaultValue;
	}

	public virtual void Put<T>(string key, T value)
	{
		if (!IsValidType(value))
		{
			throw new ArgumentException("Value must be serializable!");
		}
		data[key] = value;
	}

	public virtual void PutAll(IBundle bundle)
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

	protected virtual bool IsValidType(object value)
	{
		return true;
	}
}
