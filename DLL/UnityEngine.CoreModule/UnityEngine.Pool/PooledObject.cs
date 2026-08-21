using System;

namespace UnityEngine.Pool;

public struct PooledObject<T> : IDisposable where T : class
{
	private readonly T m_ToReturn;

	private readonly IObjectPool<T> m_Pool;

	internal PooledObject(T value, IObjectPool<T> pool)
	{
		m_ToReturn = value;
		m_Pool = pool;
	}

	void IDisposable.Dispose()
	{
		m_Pool.Release(m_ToReturn);
	}
}
