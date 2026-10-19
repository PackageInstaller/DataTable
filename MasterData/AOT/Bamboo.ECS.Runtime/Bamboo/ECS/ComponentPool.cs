using System.Collections.Generic;

namespace Bamboo.ECS;

public static class ComponentPool<T> where T : class, IComponent, new()
{
	private static readonly Stack<T> _pool = new Stack<T>(32);

	private static int _maxCapacity = 1024;

	private static int _totalCreated = 0;

	private static int _totalAcquired = 0;

	private static int _totalReleased = 0;

	public static int Count => _pool.Count;

	public static int MaxCapacity
	{
		get
		{
			return _maxCapacity;
		}
		set
		{
			_maxCapacity = ((value > 0) ? value : 1024);
		}
	}

	public static int TotalCreated => _totalCreated;

	public static int TotalAcquired => _totalAcquired;

	public static int TotalReleased => _totalReleased;

	public static T Get()
	{
		T val;
		if (_pool.Count > 0)
		{
			val = _pool.Pop();
		}
		else
		{
			val = new T();
			_totalCreated++;
		}
		_totalAcquired++;
		val.OnGet();
		return val;
	}

	public static void Release(T component)
	{
		if (component != null)
		{
			component.OnRelease();
			_totalReleased++;
			if (_pool.Count < _maxCapacity)
			{
				_pool.Push(component);
			}
		}
	}

	public static void Clear()
	{
		_pool.Clear();
	}

	public static void ResetStats()
	{
		_totalCreated = 0;
		_totalAcquired = 0;
		_totalReleased = 0;
	}
}
