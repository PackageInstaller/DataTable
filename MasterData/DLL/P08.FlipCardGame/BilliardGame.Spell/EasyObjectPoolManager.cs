using System;
using System.Collections.Generic;

namespace BilliardGame.Spell;

public class EasyObjectPoolManager
{
	public static EasyObjectPoolManager Instance;

	public Dictionary<Type, IEasyObjectPool> pools;

	public void Init()
	{
		Instance = this;
		pools = new Dictionary<Type, IEasyObjectPool>();
	}

	public ObjectPool<T> TryGetPool<T>() where T : new()
	{
		if (pools.TryGetValue(typeof(T), out var value))
		{
			return value as ObjectPool<T>;
		}
		ObjectPool<T> objectPool = new ObjectPool<T>();
		pools.Add(typeof(T), objectPool);
		return objectPool;
	}

	public void Dispose()
	{
		foreach (KeyValuePair<Type, IEasyObjectPool> pool in pools)
		{
			pool.Value.Dispose();
		}
		pools = null;
	}
}
