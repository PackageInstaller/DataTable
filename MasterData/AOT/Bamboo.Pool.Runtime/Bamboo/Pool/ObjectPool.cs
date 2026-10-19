using System.Collections.Generic;

namespace Bamboo.Pool;

public abstract class ObjectPool<TPool, TObject> where TPool : new()
{
	private const int DEFAULT_INIT_NUM = 8;

	private const int DEFAULT_STEP_NUM = 8;

	private static TPool _default;

	private readonly Queue<TObject> _queue;

	protected virtual int InitNum => 8;

	protected virtual int StepNum => 8;

	public static TPool Default
	{
		get
		{
			if (_default == null)
			{
				_default = new TPool();
			}
			return _default;
		}
	}

	public ObjectPool()
	{
		_queue = new Queue<TObject>(InitNum);
		for (int i = 0; i < InitNum; i++)
		{
			_queue.Enqueue(GenerateObject());
		}
	}

	public TObject Get()
	{
		if (_queue.Count > 0)
		{
			return _queue.Dequeue();
		}
		for (int i = 1; i < StepNum; i++)
		{
			_queue.Enqueue(GenerateObject());
		}
		return GenerateObject();
	}

	public void Recycle(TObject obj)
	{
		if (obj != null)
		{
			RecycleObject(obj);
			_queue.Enqueue(obj);
		}
	}

	protected abstract TObject GenerateObject();

	protected abstract void RecycleObject(TObject obj);
}
