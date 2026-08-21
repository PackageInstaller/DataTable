using System;

namespace UnityEngine.Pool;

public struct PooledObject<T>(T value, IObjectPool<T> pool) : IDisposable where T : class
{
	private readonly T m_ToReturn = value;

	private readonly IObjectPool<T> m_Pool = pool;

	void IDisposable.Dispose()
	{
		m_Pool.Release(m_ToReturn);
	}
}
