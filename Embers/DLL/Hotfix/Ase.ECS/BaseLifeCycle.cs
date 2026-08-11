namespace Ase.ECS;

public class BaseLifeCycle : ILifeCycle, IInit, IAwake, IStart, IUpdate, IFixedUpdate, IPause, IDispose
{
	public virtual void OnInit(object data = null)
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

	public virtual void OnGameSpeedChanged(float gameSpeed)
	{
	}

	public virtual void OnDispose()
	{
	}
}
