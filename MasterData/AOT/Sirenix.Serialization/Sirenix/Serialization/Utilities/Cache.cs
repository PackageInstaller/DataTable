using System;
using System.Threading;

namespace Sirenix.Serialization.Utilities;

public sealed class Cache<T> : ICache, IDisposable where T : class, new()
{
	private static readonly bool IsNotificationReceiver = typeof(ICacheNotificationReceiver).IsAssignableFrom(typeof(T));

	private static object[] FreeValues = new object[4];

	private bool isFree;

	private static volatile int THREAD_LOCK_TOKEN = 0;

	private static int maxCacheSize = 5;

	public T Value;

	public static int MaxCacheSize
	{
		get
		{
			return maxCacheSize;
		}
		set
		{
			maxCacheSize = Math.Max(1, value);
		}
	}

	public bool IsFree => isFree;

	object ICache.Value => Value;

	private Cache()
	{
		Value = new T();
		isFree = false;
	}

	public static Cache<T> Claim()
	{
		Cache<T> cache = null;
		while (Interlocked.CompareExchange(ref THREAD_LOCK_TOKEN, 1, 0) != 0)
		{
		}
		object[] freeValues = FreeValues;
		int num = freeValues.Length;
		for (int i = 0; i < num; i++)
		{
			cache = (Cache<T>)freeValues[i];
			if (cache != null)
			{
				freeValues[i] = null;
				cache.isFree = false;
				break;
			}
		}
		THREAD_LOCK_TOKEN = 0;
		if (cache == null)
		{
			cache = new Cache<T>();
		}
		if (IsNotificationReceiver)
		{
			(cache.Value as ICacheNotificationReceiver).OnClaimed();
		}
		return cache;
	}

	public static void Release(Cache<T> cache)
	{
		if (cache == null)
		{
			throw new ArgumentNullException("cache");
		}
		if (cache.isFree)
		{
			return;
		}
		if (IsNotificationReceiver)
		{
			(cache.Value as ICacheNotificationReceiver).OnFreed();
		}
		while (Interlocked.CompareExchange(ref THREAD_LOCK_TOKEN, 1, 0) != 0)
		{
		}
		if (cache.isFree)
		{
			THREAD_LOCK_TOKEN = 0;
			return;
		}
		cache.isFree = true;
		object[] freeValues = FreeValues;
		int num = freeValues.Length;
		bool flag = false;
		for (int i = 0; i < num; i++)
		{
			if (freeValues[i] == null)
			{
				freeValues[i] = cache;
				flag = true;
				break;
			}
		}
		if (!flag && num < MaxCacheSize)
		{
			object[] array = new object[num * 2];
			for (int j = 0; j < num; j++)
			{
				array[j] = freeValues[j];
			}
			array[num] = cache;
			FreeValues = array;
		}
		THREAD_LOCK_TOKEN = 0;
	}

	public static implicit operator T(Cache<T> cache)
	{
		if (cache == null)
		{
			return null;
		}
		return cache.Value;
	}

	public void Release()
	{
		Release(this);
	}

	void IDisposable.Dispose()
	{
		Release(this);
	}
}
