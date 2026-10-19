using System.Collections.Generic;

namespace Bamboo.Pool;

public sealed class FastFreeArrayPool<T>
{
	private static FastFreeArrayPool<T> _default;

	private readonly Dictionary<int, Queue<T[]>> _map = new Dictionary<int, Queue<T[]>>();

	public static FastFreeArrayPool<T> Default
	{
		get
		{
			if (_default == null)
			{
				_default = new FastFreeArrayPool<T>();
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

	public void Recycle(T[] bytes)
	{
		if (_map.TryGetValue(bytes.Length, out var value))
		{
			value.Enqueue(bytes);
			return;
		}
		_map[bytes.Length] = new Queue<T[]>();
		_map[bytes.Length].Enqueue(bytes);
	}
}
