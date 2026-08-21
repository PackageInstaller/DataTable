using Cysharp.Threading.Tasks;

namespace Ase.ECS;

public abstract class BaseSystem : ISystem, ILifeCycle, IInit, IAwake, IStart, IUpdate, IFixedUpdate, IPause, IDispose, IReset
{
	protected int index;

	protected WorldBase world;

	protected bool SystemIsNeedExecute;

	protected abstract bool IsLogicSystem { get; }

	public bool LogicSystem => IsLogicSystem;

	public bool IsRunning
	{
		get
		{
			if (NeedPauseSystem)
			{
				WorldBase worldBase = world;
				if (worldBase == null)
				{
					return false;
				}
				return !worldBase.IsSoftPaused;
			}
			return true;
		}
	}

	public virtual bool NeedPauseSystem => true;

	public int Index => index;

	public void Init(bool systemIsNeedExecute, int sysIndex, WorldBase worldBase, object data = null)
	{
		index = sysIndex;
		world = worldBase;
		SystemIsNeedExecute = systemIsNeedExecute;
		OnInit(data);
	}

	public virtual UniTask<bool> OnEnter(object data = null)
	{
		return new UniTask<bool>(result: true);
	}

	public virtual UniTask<bool> OnGamePreparationEnd(object data = null)
	{
		return new UniTask<bool>(result: true);
	}

	public virtual void OnInit(object data = null)
	{
	}

	public virtual void OnAwake(object data = null)
	{
	}

	public virtual async UniTask OnStartBefore(object data = null)
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

	public virtual void OnLateUpdate(float deltaTime)
	{
	}

	public virtual void OnGameSpeedChanged(float beforeTheChangeSpeed, float gameSpeed)
	{
	}

	public virtual void OnReset()
	{
	}

	public virtual void OnDispose()
	{
		world = null;
	}

	public virtual void OnResumeBefore()
	{
	}

	public virtual void OnPauseBefore()
	{
	}

	public virtual void OnPause()
	{
	}

	public virtual void OnResume()
	{
	}

	public virtual void OnDrawGizmos()
	{
	}

	public T GetSystem<T>() where T : BaseSystem
	{
		WorldBase worldBase = world;
		if (worldBase == null)
		{
			return null;
		}
		return worldBase.GetSystem<T>();
	}
}
