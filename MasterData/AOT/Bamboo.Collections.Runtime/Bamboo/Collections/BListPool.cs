using System.Collections.Generic;

namespace Bamboo.Collections;

public class BListPool<T>
{
	private readonly BArrayPool<T> _itemsPool = new BArrayPool<T>();

	private readonly BArrayPool<BList<T>.OperateItem> _operateItemsPool = new BArrayPool<BList<T>.OperateItem>();

	private readonly Queue<BList<T>> _queues = new Queue<BList<T>>();

	private static BListPool<T> _default;

	public static BListPool<T> Default
	{
		get
		{
			if (_default == null)
			{
				_default = new BListPool<T>();
			}
			return _default;
		}
	}

	public BList<T> Get()
	{
		while (_queues.Count > 0)
		{
			BList<T> bList = _queues.Dequeue();
			if (bList != null)
			{
				bList.Renew();
				return bList;
			}
		}
		return new BList<T>(_itemsPool, _operateItemsPool);
	}

	public BList<T> Get(int initNum)
	{
		while (_queues.Count > 0)
		{
			BList<T> bList = _queues.Dequeue();
			if (bList != null)
			{
				bList.Renew(initNum);
				return bList;
			}
		}
		return new BList<T>(initNum, _itemsPool, _operateItemsPool);
	}

	public void Recycle(BList<T> list)
	{
		if (list != null && !list.IsRecycled)
		{
			list.Recycle();
			_queues.Enqueue(list);
		}
	}
}
