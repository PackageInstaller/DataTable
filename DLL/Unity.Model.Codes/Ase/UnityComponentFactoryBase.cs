using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase;

public abstract class UnityComponentFactoryBase<T> : IObjectFactory<T> where T : Component
{
	private class PooledUnityObject : MonoBehaviour, IPooledObject
	{
		internal IObjectPool<T> pool;

		internal T target;

		public void Free()
		{
			pool?.Free(target);
		}

		public void Release()
		{
			pool?.Release(target);
		}
	}

	public T Create(IObjectPool<T> pool)
	{
		T val = Create();
		PooledUnityObject pooledUnityObject = val.gameObject.AddComponent<PooledUnityObject>();
		pooledUnityObject.pool = pool;
		pooledUnityObject.target = val;
		return val;
	}

	protected abstract T Create();

	public abstract void Reset(T obj);

	public virtual void Destroy(T obj)
	{
		Object.Destroy(obj.gameObject);
	}

	public virtual void Dispose()
	{
	}

	public virtual bool Validate(T obj)
	{
		return true;
	}

	public virtual async UniTask<bool> PreLoadData()
	{
		return true;
	}
}
