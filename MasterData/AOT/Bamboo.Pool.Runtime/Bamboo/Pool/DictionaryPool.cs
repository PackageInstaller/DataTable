using System.Collections.Generic;

namespace Bamboo.Pool;

public sealed class DictionaryPool<TKey, TValue>
{
	private const int DEFAULT_MIN_NUM = 7;

	private const int DEFAULT_MAX_NUM = 62851;

	private static DictionaryPool<TKey, TValue> _default;

	private readonly int _minBit;

	private readonly int _maxBit;

	private readonly int _bitNum;

	private readonly Queue<Dictionary<TKey, TValue>>[] _queues;

	public static DictionaryPool<TKey, TValue> Default
	{
		get
		{
			if (_default == null)
			{
				_default = new DictionaryPool<TKey, TValue>(7, 62851);
			}
			return _default;
		}
	}

	public DictionaryPool(int minNum, int maxNum)
	{
		_minBit = HashHelper.GetBit(minNum);
		_maxBit = HashHelper.GetBit(maxNum);
		_bitNum = _maxBit - _minBit + 1;
		_queues = new Queue<Dictionary<TKey, TValue>>[_bitNum];
		for (int i = 0; i < _bitNum; i++)
		{
			_queues[i] = new Queue<Dictionary<TKey, TValue>>();
		}
	}

	public Dictionary<TKey, TValue> Get(int length = 0)
	{
		int num = HashHelper.GetBit(length);
		if (num < 0)
		{
			return new Dictionary<TKey, TValue>(length);
		}
		if (num > _maxBit)
		{
			return new Dictionary<TKey, TValue>(length);
		}
		if (num < _minBit)
		{
			num = _minBit;
		}
		int num2 = 0;
		for (int i = num - _minBit; i < _bitNum; i++)
		{
			Queue<Dictionary<TKey, TValue>> queue = _queues[i];
			if (queue.Count > num2++)
			{
				return queue.Dequeue();
			}
		}
		return new Dictionary<TKey, TValue>(HashHelper.GetPrime(num));
	}

	public void Recycle(Dictionary<TKey, TValue> dictionary)
	{
		if (dictionary != null)
		{
			dictionary.Clear();
			int bitFromAlign = HashHelper.GetBitFromAlign(dictionary.EnsureCapacity(0));
			if (bitFromAlign >= _minBit && _bitNum <= _maxBit)
			{
				int num = bitFromAlign - _minBit;
				_queues[num].Enqueue(dictionary);
			}
		}
	}
}
