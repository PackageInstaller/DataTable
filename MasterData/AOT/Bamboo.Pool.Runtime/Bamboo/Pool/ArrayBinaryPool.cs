using System;
using System.Collections.Generic;

namespace Bamboo.Pool;

public class ArrayBinaryPool<T>
{
	private const int DEFAULT_MIN_BIT = 0;

	private const int DEFAULT_MAX_BIT = 10;

	private readonly int _minBit;

	private readonly int _maxBit;

	private readonly Queue<T[]>[] _queues;

	private static ArrayBinaryPool<T> _default;

	public static ArrayBinaryPool<T> Default
	{
		get
		{
			if (_default == null)
			{
				_default = new ArrayBinaryPool<T>(0, 10);
			}
			return _default;
		}
	}

	public ArrayBinaryPool(int minBit, int maxBit)
	{
		_minBit = minBit;
		_maxBit = maxBit;
		int num = _maxBit - _minBit + 1;
		_queues = new Queue<T[]>[num];
		for (int i = 0; i < num; i++)
		{
			_queues[i] = new Queue<T[]>();
		}
	}

	public T[] Get(int length)
	{
		int num = -1;
		for (int i = _minBit; i <= _maxBit; i++)
		{
			if (Power2Helper.Get(i) >= length)
			{
				num = i;
				break;
			}
		}
		if (num == -1)
		{
			return new T[length];
		}
		Queue<T[]> queue = _queues[num - _minBit];
		while (queue.Count > 0)
		{
			T[] array = queue.Dequeue();
			if (array != null)
			{
				return array;
			}
		}
		return new T[length];
	}

	public void Recycle(T[] items)
	{
		if (items == null)
		{
			return;
		}
		Array.Clear(items, 0, items.Length);
		int num = -1;
		for (int i = _minBit; i <= _maxBit; i++)
		{
			if (items.Length == Power2Helper.Get(i))
			{
				num = i;
				break;
			}
		}
		if (num != -1)
		{
			_queues[num - _minBit].Enqueue(items);
		}
	}

	public int GetAlignSize(int length)
	{
		for (int i = _minBit; i <= _maxBit; i++)
		{
			int num = Power2Helper.Get(i);
			if (length <= num)
			{
				return num;
			}
		}
		return length;
	}
}
