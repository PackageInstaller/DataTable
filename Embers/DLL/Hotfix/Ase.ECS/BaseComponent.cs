using Ase.Serializing;

namespace Ase.ECS;

public class BaseComponent : IComponent, ILifeCycle, IInit, IAwake, IStart, IUpdate, IFixedUpdate, IPause, IDispose, IRollbackAble
{
	protected int componentIndex;

	protected BaseEntity mBaseEntity;

	public int Index => componentIndex;

	public BaseEntity Entity => mBaseEntity;

	public ILTransform transform => mBaseEntity.transform;

	public virtual void OnInit(object data)
	{
	}

	public virtual void OnAwake(object data = null)
	{
	}

	public virtual void OnStart(object data = null)
	{
	}

	public virtual void OnUpdate(float deltaTime)
	{
	}

	public virtual void OnFixedUpdateBefore(WorldUpdateType updateType)
	{
	}

	public virtual void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
	}

	public virtual void OnFixedUpdateAfter(WorldUpdateType updateType)
	{
	}

	public virtual void OnDispose()
	{
	}

	public virtual void OnPause()
	{
	}

	public virtual void OnGameSpeedChanged(float gameSpeed)
	{
	}

	public virtual void OnResume()
	{
	}

	public virtual void TakeSnapShot(PooledWriter writer)
	{
	}

	public virtual void RollBackTo(ref RollBackData rollBackData, PooledReader localReader, PooledReader reader)
	{
	}

	public virtual void Init(int index, BaseEntity entity, object data = null)
	{
		componentIndex = index;
		mBaseEntity = entity;
		OnInit(data);
	}

	public virtual void OnEntityFrozen(bool isFrozen, bool isFrozenLogic = true)
	{
	}

	public virtual void OnEntityDead()
	{
	}

	public virtual void OnEntityRelease()
	{
	}

	public virtual void OnEntityReborn()
	{
	}

	public virtual void OnLevelFail()
	{
	}

	protected T GetData<T>(string key)
	{
		return mBaseEntity.GetData<T>(key);
	}

	protected T GetData<T>(string key, T defaultValue)
	{
		return mBaseEntity.GetData(key, defaultValue);
	}
}
