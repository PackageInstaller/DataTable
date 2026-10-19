using System.Collections.Generic;

namespace Bamboo.Collections;

public class BSortedSetPool<T>
{
	private readonly BArrayPool<bool> _existsPool = new BArrayPool<bool>();

	private readonly BArrayPool<T> _itemsPool = new BArrayPool<T>();

	private readonly BArrayPool<BSortedSet<T>.OperateItem> _operateItemsPool = new BArrayPool<BSortedSet<T>.OperateItem>();

	private readonly Queue<BSortedSet<T>> _queues = new Queue<BSortedSet<T>>();

	private static BSortedSetPool<T> _default;

	public static BSortedSetPool<T> Default
	{
		get
		{
			if (_default == null)
			{
				_default = new BSortedSetPool<T>();
			}
			return _default;
		}
	}

	public BSortedSet<T> Get()
	{
		while (_queues.Count > 0)
		{
			BSortedSet<T> bSortedSet = _queues.Dequeue();
			if (bSortedSet != null)
			{
				bSortedSet.Renew();
				return bSortedSet;
			}
		}
		return new BSortedSet<T>(_existsPool, _itemsPool, _operateItemsPool);
	}

	public BSortedSet<T> Get(int initNum)
	{
		while (_queues.Count > 0)
		{
			BSortedSet<T> bSortedSet = _queues.Dequeue();
			if (bSortedSet != null)
			{
				bSortedSet.Renew(initNum);
				return bSortedSet;
			}
		}
		return new BSortedSet<T>(initNum, _existsPool, _itemsPool, _operateItemsPool);
	}

	public void Recycle(BSortedSet<T> set)
	{
		if (set != null && !set.IsRecycled)
		{
			set.Recycle();
			_queues.Enqueue(set);
		}
	}
}
