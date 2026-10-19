using System;
using System.Collections.Generic;
using Bamboo.Pool;

namespace Bamboo.Chronos;

internal sealed class ActionInfoPools
{
	private readonly Dictionary<Type, RecyclePool> _poolMap = new Dictionary<Type, RecyclePool>();

	public T Get<T>() where T : IRecycle, new()
	{
		Type tYPE = TypeCache<T>.TYPE;
		_poolMap.TryGetValue(tYPE, out var value);
		RecyclePool<T> recyclePool;
		if (value == null)
		{
			recyclePool = new RecyclePool<T>();
			_poolMap[tYPE] = recyclePool;
		}
		else
		{
			recyclePool = (RecyclePool<T>)value;
		}
		return recyclePool.Get();
	}

	public void Recycle(TypeRecycle typeRecycle)
	{
		if (typeRecycle != null)
		{
			Type type = typeRecycle.Type;
			if (_poolMap.TryGetValue(type, out var value))
			{
				value?.RecycleObject(typeRecycle);
			}
		}
	}
}
