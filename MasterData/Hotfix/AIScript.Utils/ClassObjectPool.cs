using System;
using System.Collections.Generic;

namespace AIScript.Utils;

public class ClassObjectPool<T> where T : class
{
	private readonly Func<T> _factory;

	private readonly Action<T> _onRent;

	private readonly Action<T> _onReturn;

	private readonly Stack<T> _unused;

	private readonly HashSet<T> _used;

	public int UsedCount => _used.Count;

	public int UnusedCount => _unused.Count;

	public ClassObjectPool(Func<T> factory, int initialCapacity = 0, Action<T> onRent = null, Action<T> onReturn = null)
	{
		if (factory == null)
		{
			throw new ArgumentNullException("factory");
		}
		_factory = factory;
		_onRent = onRent;
		_onReturn = onReturn;
		_unused = ((initialCapacity > 0) ? new Stack<T>(initialCapacity) : new Stack<T>());
		_used = new HashSet<T>();
		for (int i = 0; i < initialCapacity; i++)
		{
			_unused.Push(_factory());
		}
	}

	public T Rent()
	{
		T val = ((_unused.Count > 0) ? _unused.Pop() : _factory());
		_used.Add(val);
		_onRent?.Invoke(val);
		return val;
	}

	public bool Return(T instance)
	{
		if (instance == null)
		{
			return false;
		}
		if (!_used.Remove(instance))
		{
			return false;
		}
		_onReturn?.Invoke(instance);
		_unused.Push(instance);
		return true;
	}

	public void ReturnAllUsed()
	{
		if (_used.Count != 0)
		{
			List<T> list = new List<T>(_used);
			_used.Clear();
			for (int i = 0; i < list.Count; i++)
			{
				T val = list.get_Item(i);
				_onReturn?.Invoke(val);
				_unused.Push(val);
			}
		}
	}

	public void Clear(bool clearUsed = false)
	{
		_unused.Clear();
		if (clearUsed)
		{
			_used.Clear();
		}
	}

	public IReadOnlyCollection<T> GetUsedSnapshot()
	{
		return new List<T>(_used);
	}

	public IReadOnlyCollection<T> GetUnusedSnapshot()
	{
		return new List<T>((IEnumerable<T>)_unused);
	}
}
