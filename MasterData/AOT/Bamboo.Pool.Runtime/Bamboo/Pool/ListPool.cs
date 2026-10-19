using System.Collections.Generic;

namespace Bamboo.Pool;

public sealed class ListPool<T>
{
	private const int DEFAULT_MIN_NUM = 8;

	private const int DEFAULT_MAX_NUM = 65536;

	private static ListPool<T> _default;

	private readonly int _minBit;

	private readonly int _maxBit;

	private readonly int _bitNum;

	private readonly Queue<List<T>>[] _queues;

	public static ListPool<T> Default
	{
		get
		{
			if (_default == null)
			{
				_default = new ListPool<T>(8, 65536);
			}
			return _default;
		}
	}

	public ListPool(int minNum, int maxNum)
	{
		_minBit = BinaryHelper.GetBit(minNum);
		_maxBit = BinaryHelper.GetBit(maxNum);
		_bitNum = _maxBit - _minBit + 1;
		_queues = new Queue<List<T>>[_bitNum];
		for (int i = 0; i < _bitNum; i++)
		{
			_queues[i] = new Queue<List<T>>();
		}
	}

	public List<T> Get(int length = 0)
	{
		int num = BinaryHelper.GetBit(length);
		if (num < 0)
		{
			return new List<T>(length);
		}
		if (num > _maxBit)
		{
			return new List<T>(length);
		}
		if (num < _minBit)
		{
			num = _minBit;
		}
		int num2 = 0;
		for (int i = num - _minBit; i < _bitNum; i++)
		{
			Queue<List<T>> queue = _queues[i];
			if (queue.Count > num2++)
			{
				return queue.Dequeue();
			}
		}
		return new List<T>(BinaryHelper.GetPower2(num));
	}

	public void Recycle(List<T> list)
	{
		if (list != null)
		{
			list.Clear();
			int bitFromAlign = BinaryHelper.GetBitFromAlign(list.Capacity);
			if (bitFromAlign >= _minBit && _bitNum <= _maxBit)
			{
				int num = bitFromAlign - _minBit;
				_queues[num].Enqueue(list);
			}
		}
	}
}
