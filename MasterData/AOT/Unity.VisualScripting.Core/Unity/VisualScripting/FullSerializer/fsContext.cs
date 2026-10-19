using System;
using System.Collections.Generic;

namespace Unity.VisualScripting.FullSerializer;

public sealed class fsContext
{
	private readonly Dictionary<Type, object> _contextObjects = new Dictionary<Type, object>();

	public void Reset()
	{
		_contextObjects.Clear();
	}

	public void Set<T>(T obj)
	{
		_contextObjects[typeof(T)] = obj;
	}

	public bool Has<T>()
	{
		return _contextObjects.ContainsKey(typeof(T));
	}

	public T Get<T>()
	{
		if (_contextObjects.TryGetValue(typeof(T), out var value))
		{
			return (T)value;
		}
		throw new InvalidOperationException("There is no context object of type " + typeof(T));
	}
}
