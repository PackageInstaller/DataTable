using System.Collections.Generic;

namespace Com.ForbiddenByte.OSA.Util.IO.Pools;

public class LRUCachingPool : IPool
{
	public delegate void ObjectDestroyer(object key, object value);

	private class CacheItem
	{
		public object Key { get; set; }

		public object Value { get; set; }
	}

	private readonly Dictionary<object, LinkedListNode<CacheItem>> _Cache;

	private readonly LinkedList<CacheItem> _LruOrderList;

	private readonly ObjectDestroyer _ObjectDestroyer;

	public int Capacity { get; private set; }

	public int CurrentCount => _Cache.Count;

	public LRUCachingPool(int capacity, ObjectDestroyer objectDestroyer = null)
	{
		Capacity = capacity;
		_Cache = new Dictionary<object, LinkedListNode<CacheItem>>(capacity);
		_LruOrderList = new LinkedList<CacheItem>();
		_ObjectDestroyer = objectDestroyer;
	}

	public object Get(object key)
	{
		if (_Cache.TryGetValue(key, out var value))
		{
			_LruOrderList.Remove(value);
			_LruOrderList.AddLast(value);
			return value.Value.Value;
		}
		return null;
	}

	public void Put(object key, object value)
	{
		if (_Cache.TryGetValue(key, out var value2))
		{
			_LruOrderList.Remove(value2);
			_Cache.Remove(key);
		}
		if (_Cache.Count == Capacity)
		{
			LinkedListNode<CacheItem> first = _LruOrderList.First;
			_LruOrderList.RemoveFirst();
			_Cache.Remove(first.Value.Key);
			if (_ObjectDestroyer != null)
			{
				_ObjectDestroyer(first.Value.Key, first.Value.Value);
			}
		}
		LinkedListNode<CacheItem> linkedListNode = new LinkedListNode<CacheItem>(new CacheItem
		{
			Key = key,
			Value = value
		});
		_LruOrderList.AddLast(linkedListNode);
		_Cache[key] = linkedListNode;
	}

	public void Clear()
	{
		if (_ObjectDestroyer != null)
		{
			foreach (CacheItem lruOrder in _LruOrderList)
			{
				if (lruOrder.Value != null)
				{
					_ObjectDestroyer(lruOrder.Key, lruOrder.Value);
				}
			}
		}
		_Cache.Clear();
		_LruOrderList.Clear();
	}
}
