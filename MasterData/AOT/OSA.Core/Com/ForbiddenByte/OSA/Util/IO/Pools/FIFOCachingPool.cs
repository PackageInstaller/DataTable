using System.Collections.Generic;

namespace Com.ForbiddenByte.OSA.Util.IO.Pools;

public class FIFOCachingPool : IPool
{
	public delegate void ObjectDestroyer(object key, object value);

	private readonly Queue<object> _Keys;

	private readonly Dictionary<object, object> _Cache;

	private readonly ObjectDestroyer _ObjectDestroyer;

	public int Capacity { get; private set; }

	public int CurrentCount => _Keys.Count;

	public FIFOCachingPool(int capacity, ObjectDestroyer objectDestroyer = null)
	{
		Capacity = capacity;
		_Keys = new Queue<object>(capacity);
		_Cache = new Dictionary<object, object>(capacity);
		_ObjectDestroyer = objectDestroyer;
	}

	public object Get(object key)
	{
		if (_Cache.TryGetValue(key, out var value))
		{
			return value;
		}
		return null;
	}

	public void Put(object key, object value)
	{
		if (CurrentCount == Capacity)
		{
			object key2 = _Keys.Dequeue();
			object value2 = _Cache[key2];
			_Cache.Remove(key2);
			if (_ObjectDestroyer != null)
			{
				_ObjectDestroyer(key2, value2);
			}
		}
		_Keys.Enqueue(key);
		_Cache[key] = value;
	}

	public void Clear()
	{
		if (_ObjectDestroyer != null)
		{
			foreach (KeyValuePair<object, object> item in _Cache)
			{
				if (item.Value != null)
				{
					_ObjectDestroyer(item.Key, item.Value);
				}
			}
		}
		_Cache.Clear();
	}
}
