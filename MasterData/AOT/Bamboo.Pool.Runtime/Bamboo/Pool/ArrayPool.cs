using System.Collections.Generic;

namespace Bamboo.Pool;

public sealed class ArrayPool<T>
{
	private static ArrayPool<T> _default;

	private readonly Dictionary<int, Queue<T[]>> _map = new Dictionary<int, Queue<T[]>>();

	public static ArrayPool<T> Default
	{
		get
		{
			if (_default == null)
			{
				_default = new ArrayPool<T>();
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
		if (bytes != null)
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
}
