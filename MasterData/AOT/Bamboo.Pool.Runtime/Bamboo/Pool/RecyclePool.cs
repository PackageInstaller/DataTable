using System.Collections.Generic;

namespace Bamboo.Pool;

public abstract class RecyclePool
{
	public abstract IRecycle GetObject();

	public abstract void RecycleObject(IRecycle obj);
}
public class RecyclePool<T> : RecyclePool where T : IRecycle, new()
{
	private const int DEFAULT_INIT_NUM = 8;

	private const int DEFAULT_STEP_NUM = 8;

	private static RecyclePool<T> _default;

	private readonly int _stepNum;

	private readonly Queue<T> _queue;

	public static RecyclePool<T> Default
	{
		get
		{
			if (_default == null)
			{
				_default = new RecyclePool<T>();
			}
			return _default;
		}
	}

	public RecyclePool()
		: this(8, 8)
	{
	}

	public RecyclePool(int initNum, int stepNum)
	{
		_queue = new Queue<T>(initNum);
		for (int i = 0; i < initNum; i++)
		{
			_queue.Enqueue(new T());
		}
		_stepNum = stepNum;
	}

	public T Get()
	{
		if (_queue.Count > 0)
		{
			T result = _queue.Dequeue();
			result.IsRecycled = false;
			return result;
		}
		for (int i = 1; i < _stepNum; i++)
		{
			_queue.Enqueue(new T());
		}
		return new T();
	}

	public void Recycle(T item)
	{
		if (item != null && !item.IsRecycled)
		{
			item.Recycle();
			item.IsRecycled = true;
			_queue.Enqueue(item);
		}
	}

	public override IRecycle GetObject()
	{
		return Get();
	}

	public override void RecycleObject(IRecycle obj)
	{
		if (obj != null && obj is T)
		{
			Recycle((T)obj);
		}
	}
}
