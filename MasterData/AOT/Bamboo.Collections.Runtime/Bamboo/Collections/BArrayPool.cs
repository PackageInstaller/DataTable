using System.Collections.Generic;
using Bamboo.Pool;

namespace Bamboo.Collections;

public class BArrayPool<T>
{
	private readonly ArrayBinaryPool<T> _itemsPool = new ArrayBinaryPool<T>(3, 10);

	private readonly Queue<BArray<T>> _queues = new Queue<BArray<T>>();

	private static BArrayPool<T> _default;

	public static BArrayPool<T> Default
	{
		get
		{
			if (_default == null)
			{
				_default = new BArrayPool<T>();
			}
			return _default;
		}
	}

	public BArray<T> Get()
	{
		while (_queues.Count > 0)
		{
			BArray<T> bArray = _queues.Dequeue();
			if (bArray != null)
			{
				bArray.Renew(0);
				return bArray;
			}
		}
		return new BArray<T>(0, _itemsPool);
	}

	public BArray<T> Get(int length)
	{
		while (_queues.Count > 0)
		{
			BArray<T> bArray = _queues.Dequeue();
			if (bArray != null)
			{
				bArray.Renew(length);
				return bArray;
			}
		}
		return new BArray<T>(length, _itemsPool);
	}

	public void Recycle(BArray<T> array)
	{
		if (array != null && !array.IsRecycled)
		{
			array.Recycle();
			_queues.Enqueue(array);
		}
	}
}
