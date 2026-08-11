using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase;

public abstract class UnityGameObjectFactoryBase : IObjectFactory<GameObject>
{
	private class PooledUnityObject : MonoBehaviour, IPooledObject
	{
		internal IObjectPool<GameObject> pool;

		public void Free()
		{
			pool?.Free(base.gameObject);
		}

		public void Release()
		{
			pool?.Release(base.gameObject);
		}
	}

	public virtual GameObject Create(IObjectPool<GameObject> pool)
	{
		GameObject gameObject = Create();
		if (gameObject == null)
		{
			return null;
		}
		gameObject.AddComponent<PooledUnityObject>().pool = pool;
		return gameObject;
	}

	protected abstract GameObject Create();

	public abstract void Reset(GameObject obj);

	public virtual void Destroy(GameObject obj)
	{
		Object.Destroy(obj);
	}

	public virtual void Dispose()
	{
	}

	public virtual bool Validate(GameObject obj)
	{
		return true;
	}

	public virtual UniTask<bool> PreLoadData()
	{
		return new UniTask<bool>(result: true);
	}
}
