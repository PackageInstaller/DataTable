using System.Collections.Generic;

namespace BilliardGame.Spell;

public class ObjectPool<T> : IEasyObjectPool where T : new()
{
	private readonly Queue<T> m_Stack = new Queue<T>();

	private readonly Queue<T> m_cache = new Queue<T>();

	public int countAll { get; private set; }

	public static T Get()
	{
		ObjectPool<T> objectPool = EasyObjectPoolManager.Instance.TryGetPool<T>();
		T result;
		if (objectPool.m_Stack.Count == 0)
		{
			result = new T();
			objectPool.countAll++;
		}
		else
		{
			result = objectPool.m_Stack.Dequeue();
		}
		return result;
	}

	public static void Release(T element)
	{
		EasyObjectPoolManager.Instance.TryGetPool<T>().m_cache.Enqueue(element);
	}

	public static void ReleaseCache()
	{
		ObjectPool<T> objectPool = EasyObjectPoolManager.Instance.TryGetPool<T>();
		for (int num = objectPool.m_cache.Count - 1; num >= 0; num--)
		{
			objectPool.m_Stack.Enqueue(objectPool.m_cache.Dequeue());
		}
	}

	public void Dispose()
	{
		m_Stack.Clear();
		m_cache.Clear();
	}
}
