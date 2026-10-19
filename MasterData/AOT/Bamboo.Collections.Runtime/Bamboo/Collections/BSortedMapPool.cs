using System.Collections.Generic;

namespace Bamboo.Collections;

public class BSortedMapPool<TKey, TValue>
{
	private readonly BArrayPool<bool> _existsPool = new BArrayPool<bool>();

	private readonly BArrayPool<TKey> _keysPool = new BArrayPool<TKey>();

	private readonly BArrayPool<TValue> _valuesPool = new BArrayPool<TValue>();

	private readonly BArrayPool<BSortedMap<TKey, TValue>.OperateItem> _operateItemsPool = new BArrayPool<BSortedMap<TKey, TValue>.OperateItem>();

	private readonly Queue<BSortedMap<TKey, TValue>> _queues = new Queue<BSortedMap<TKey, TValue>>();

	private static BSortedMapPool<TKey, TValue> _default;

	public static BSortedMapPool<TKey, TValue> Default
	{
		get
		{
			if (_default == null)
			{
				_default = new BSortedMapPool<TKey, TValue>();
			}
			return _default;
		}
	}

	public BSortedMap<TKey, TValue> Get()
	{
		while (_queues.Count > 0)
		{
			BSortedMap<TKey, TValue> bSortedMap = _queues.Dequeue();
			if (bSortedMap != null)
			{
				bSortedMap.Renew();
				return bSortedMap;
			}
		}
		return new BSortedMap<TKey, TValue>(_existsPool, _keysPool, _valuesPool, _operateItemsPool);
	}

	public BSortedMap<TKey, TValue> Get(int initNum)
	{
		while (_queues.Count > 0)
		{
			BSortedMap<TKey, TValue> bSortedMap = _queues.Dequeue();
			if (bSortedMap != null)
			{
				bSortedMap.Renew(initNum);
				return bSortedMap;
			}
		}
		return new BSortedMap<TKey, TValue>(initNum, _existsPool, _keysPool, _valuesPool, _operateItemsPool);
	}

	public void Recycle(BSortedMap<TKey, TValue> map)
	{
		if (map != null && !map.IsRecycled)
		{
			map.Recycle();
			_queues.Enqueue(map);
		}
	}
}
