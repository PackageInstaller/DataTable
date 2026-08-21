using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace Ase.Serializing;

public static class ReaderPool
{
	private static readonly Stack<PooledReader> _pool = new Stack<PooledReader>();

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static PooledReader GetReader(byte[] bytes)
	{
		return GetReader(new ArraySegment<byte>(bytes));
	}

	public static PooledReader GetReader(ArraySegment<byte> segment)
	{
		PooledReader pooledReader;
		if (_pool.Count > 0)
		{
			pooledReader = _pool.Pop();
			pooledReader.Initialize(segment);
		}
		else
		{
			pooledReader = new PooledReader(segment);
		}
		return pooledReader;
	}

	public static void Recycle(PooledReader reader)
	{
		_pool.Push(reader);
	}
}
