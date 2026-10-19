using System;
using System.Collections.Generic;

namespace Bamboo.Pool;

public sealed class FreeArrayPool<T>
{
	private static FreeArrayPool<T> _default;

	private readonly Dictionary<int, Queue<T[]>> _map = new Dictionary<int, Queue<T[]>>();

	public static FreeArrayPool<T> Default
	{
		get
		{
			if (_default == null)
			{
				_default = new FreeArrayPool<T>();
			}
			return _default;
		}
	}

	public T[] Get(int length)
	{
		if (_map.TryGetValue(length, out var value) && value.Count > 0)
		{
			return value.Dequeue();
		}
		return new T[length];
	}

	public void Recycle(T[] bytes, bool isClear = false)
	{
		if (bytes != null)
		{
			int num = bytes.Length;
			if (isClear)
			{
				Array.Clear(bytes, 0, num);
			}
			if (_map.TryGetValue(num, out var value))
			{
				value.Enqueue(bytes);
				return;
			}
			_map[bytes.Length] = new Queue<T[]>();
			_map[bytes.Length].Enqueue(bytes);
		}
	}
}
