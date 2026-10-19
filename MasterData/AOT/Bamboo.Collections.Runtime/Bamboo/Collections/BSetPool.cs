using System.Collections.Generic;

namespace Bamboo.Collections;

public class BSetPool<T>
{
	private readonly BArrayPool<bool> _existsPool = new BArrayPool<bool>();

	private readonly BArrayPool<T> _itemsPool = new BArrayPool<T>();

	private readonly BArrayPool<BSet<T>.OperateItem> _operateItemsPool = new BArrayPool<BSet<T>.OperateItem>();

	private readonly Queue<BSet<T>> _queues = new Queue<BSet<T>>();

	private static BSetPool<T> _default;

	public static BSetPool<T> Default
	{
		get
		{
			if (_default == null)
			{
				_default = new BSetPool<T>();
			}
			return _default;
		}
	}

	public BSet<T> Get()
	{
		while (_queues.Count > 0)
		{
			BSet<T> bSet = _queues.Dequeue();
			if (bSet != null)
			{
				bSet.Renew();
				return bSet;
			}
		}
		return new BSet<T>(_existsPool, _itemsPool, _operateItemsPool);
	}

	public BSet<T> Get(int initNum)
	{
		while (_queues.Count > 0)
		{
			BSet<T> bSet = _queues.Dequeue();
			if (bSet != null)
			{
				bSet.Renew(initNum);
				return bSet;
			}
		}
		return new BSet<T>(initNum, _existsPool, _itemsPool, _operateItemsPool);
	}

	public void Recycle(BSet<T> set)
	{
		if (set != null && !set.IsRecycled)
		{
			set.Recycle();
			_queues.Enqueue(set);
		}
	}
}
