using System.Collections.Generic;

namespace YS;

public class ObjectPool<T> where T : class, IResetable, new()
{
	private static int _initSize;

	private static int _maxSize;

	private static readonly object syncObj;

	private static Stack<T> _objectStack;

	public static int CacheSize => _objectStack.Count;

	private ObjectPool()
	{
	}

	static ObjectPool()
	{
		_initSize = 3;
		_maxSize = 60;
		syncObj = new object();
		_objectStack = new Stack<T>(_maxSize);
		for (int i = 0; i < _initSize; i++)
		{
			Store(new T());
		}
	}

	public static T New()
	{
		lock (syncObj)
		{
			if (_objectStack.Count > 0)
			{
				return _objectStack.Pop();
			}
			T val = new T();
			val.Reset();
			return val;
		}
	}

	public static void Store(T obj)
	{
		lock (syncObj)
		{
			obj.Reset();
			if (_objectStack.Count < _maxSize)
			{
				_objectStack.Push(obj);
			}
		}
	}
}
