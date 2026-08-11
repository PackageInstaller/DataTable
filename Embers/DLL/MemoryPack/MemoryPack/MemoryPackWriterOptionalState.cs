using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace MemoryPack;

public sealed class MemoryPackWriterOptionalState : IDisposable
{
	private sealed class ReferenceEqualityComparer : IEqualityComparer<object>
	{
		public static ReferenceEqualityComparer Instance { get; } = new ReferenceEqualityComparer();

		private ReferenceEqualityComparer()
		{
		}

		public new bool Equals(object? x, object? y)
		{
			return x == y;
		}

		public int GetHashCode(object obj)
		{
			return RuntimeHelpers.GetHashCode(obj);
		}
	}

	internal static readonly MemoryPackWriterOptionalState NullState = new MemoryPackWriterOptionalState(_: true);

	private uint nextId;

	private readonly Dictionary<object, uint> objectToRef;

	public MemoryPackSerializerOptions Options { get; private set; }

	internal MemoryPackWriterOptionalState()
	{
		objectToRef = new Dictionary<object, uint>(ReferenceEqualityComparer.Instance);
		Options = null;
		nextId = 0u;
	}

	private MemoryPackWriterOptionalState(bool _)
	{
		objectToRef = null;
		Options = MemoryPackSerializerOptions.Default;
		nextId = 0u;
	}

	internal void Init(MemoryPackSerializerOptions? options)
	{
		Options = options ?? MemoryPackSerializerOptions.Default;
	}

	public void Reset()
	{
		objectToRef.Clear();
		Options = null;
		nextId = 0u;
	}

	public (bool existsReference, uint id) GetOrAddReference(object value)
	{
		if (objectToRef.TryGetValue(value, out var value2))
		{
			return (existsReference: true, id: value2);
		}
		value2 = nextId++;
		objectToRef.Add(value, value2);
		return (existsReference: false, id: value2);
	}

	void IDisposable.Dispose()
	{
		MemoryPackWriterOptionalStatePool.Return(this);
	}
}
