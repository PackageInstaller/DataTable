using System.Collections.Generic;

namespace Bamboo.Collections;

public class BMapPool<TKey, TValue>
{
	private readonly BArrayPool<bool> _existsPool = new BArrayPool<bool>();

	private readonly BArrayPool<TKey> _keysPool = new BArrayPool<TKey>();

	private readonly BArrayPool<TValue> _valuesPool = new BArrayPool<TValue>();

	private readonly BArrayPool<BMap<TKey, TValue>.OperateItem> _operateItemsPool = new BArrayPool<BMap<TKey, TValue>.OperateItem>();

	private readonly Queue<BMap<TKey, TValue>> _queues = new Queue<BMap<TKey, TValue>>();

	private static BMapPool<TKey, TValue> _default;

	public static BMapPool<TKey, TValue> Default
	{
		get
		{
			if (_default == null)
			{
				_default = new BMapPool<TKey, TValue>();
			}
			return _default;
		}
	}

	public BMap<TKey, TValue> Get()
	{
		while (_queues.Count > 0)
		{
			BMap<TKey, TValue> bMap = _queues.Dequeue();
			if (bMap != null)
			{
				bMap.Renew();
				return bMap;
			}
		}
		return new BMap<TKey, TValue>(_existsPool, _keysPool, _valuesPool, _operateItemsPool);
	}

	public BMap<TKey, TValue> Get(int initNum)
	{
		while (_queues.Count > 0)
		{
			BMap<TKey, TValue> bMap = _queues.Dequeue();
			if (bMap != null)
			{
				bMap.Renew(initNum);
				return bMap;
			}
		}
		return new BMap<TKey, TValue>(initNum, _existsPool, _keysPool, _valuesPool, _operateItemsPool);
	}

	public void Recycle(BMap<TKey, TValue> map)
	{
		if (map != null && !map.IsRecycled)
		{
			map.Recycle();
			_queues.Enqueue(map);
		}
	}
}
