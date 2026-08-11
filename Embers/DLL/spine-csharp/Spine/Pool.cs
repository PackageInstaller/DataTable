using System;
using System.Collections.Generic;

namespace Spine;

internal class Pool<T> where T : class, new()
{
	public interface IPoolable
	{
		void Reset();
	}

	public readonly int max;

	private readonly Stack<T> freeObjects;

	public int Count => freeObjects.Count;

	public int Peak { get; private set; }

	public Pool(int initialCapacity = 16, int max = int.MaxValue)
	{
		freeObjects = new Stack<T>(initialCapacity);
		this.max = max;
	}

	public T Obtain()
	{
		if (freeObjects.Count != 0)
		{
			return freeObjects.Pop();
		}
		return new T();
	}

	public void Free(T obj)
	{
		if (obj == null)
		{
			throw new ArgumentNullException("obj", "obj cannot be null");
		}
		if (freeObjects.Count < max)
		{
			freeObjects.Push(obj);
			Peak = Math.Max(Peak, freeObjects.Count);
		}
		Reset(obj);
	}

	public void Clear()
	{
		freeObjects.Clear();
	}

	protected void Reset(T obj)
	{
		if (obj is IPoolable poolable)
		{
			poolable.Reset();
		}
	}
}
