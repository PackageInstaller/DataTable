namespace Ase;

public abstract class PooledObjectBase<T> : IPooledObject where T : PooledObjectBase<T>
{
	private IObjectPool<T> pool;

	public PooledObjectBase(IObjectPool<T> pool)
	{
		this.pool = pool;
	}

	public virtual void Free()
	{
		pool?.Free((T)this);
	}

	public void Release()
	{
		pool?.Release((T)this);
	}
}
