using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace Ase.Serializing;

public static class WriterPool
{
	private static readonly Stack<PooledWriter> _pool = new Stack<PooledWriter>();

	private static readonly Dictionary<int, Stack<PooledWriter>> _lengthPool = new Dictionary<int, Stack<PooledWriter>>();

	internal const int LENGTH_BRACKET = 1000;

	public static PooledWriter GetWriter()
	{
		PooledWriter obj = ((_pool.Count > 0) ? _pool.Pop() : new PooledWriter());
		obj.Reset();
		return obj;
	}

	private static int GetDictionaryIndex(int length)
	{
		return length / 1000;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static PooledWriter GetWriter(int length)
	{
		if (length < 1000)
		{
			length = 1000;
		}
		int dictionaryIndex = GetDictionaryIndex(length);
		if (_lengthPool.TryGetValue(dictionaryIndex, out var value) && value.Count > 0)
		{
			PooledWriter pooledWriter = value.Pop();
			pooledWriter.Reset();
			return pooledWriter;
		}
		PooledWriter writer = GetWriter();
		int count = (dictionaryIndex + 1) * 1000;
		writer.EnsureBufferCapacity(count);
		return writer;
	}

	public static void RecycleLength(PooledWriter writer)
	{
		int num = writer.Capacity;
		if (num < 1000)
		{
			num = 1000;
			writer.EnsureBufferCapacity(1000);
		}
		int key = GetDictionaryIndex(num) - 1;
		if (!_lengthPool.TryGetValue(key, out var value))
		{
			value = new Stack<PooledWriter>();
			_lengthPool[key] = value;
		}
		value.Push(writer);
	}

	public static void Recycle(PooledWriter writer)
	{
		_pool.Push(writer);
	}
}
