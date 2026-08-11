using System;
using System.Collections.Generic;

namespace MemoryPack;

public sealed class MemoryPackReaderOptionalState : IDisposable
{
	private readonly Dictionary<uint, object> refToObject;

	public MemoryPackSerializerOptions Options { get; private set; }

	internal MemoryPackReaderOptionalState()
	{
		refToObject = new Dictionary<uint, object>();
		Options = null;
	}

	internal void Init(MemoryPackSerializerOptions? options)
	{
		Options = options ?? MemoryPackSerializerOptions.Default;
	}

	public object GetObjectReference(uint id)
	{
		if (refToObject.TryGetValue(id, out object value))
		{
			return value;
		}
		MemoryPackSerializationException.ThrowMessage("Object is not found in this reference id:" + id);
		return null;
	}

	public void AddObjectReference(uint id, object value)
	{
		if (!refToObject.TryAdd(id, value))
		{
			MemoryPackSerializationException.ThrowMessage("Object is already added, id:" + id);
		}
	}

	public void Reset()
	{
		refToObject.Clear();
		Options = null;
	}

	void IDisposable.Dispose()
	{
		MemoryPackReaderOptionalStatePool.Return(this);
	}
}
