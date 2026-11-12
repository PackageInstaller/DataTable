using UnityEngine;

public abstract class LogicMonoComponent : MonoBehaviour, ILogicComponent
{
	public LogicEntity Entity { get; private set; }

	public bool ActiveSelf
	{
		get
		{
			return enabled;
		}
		set
		{
			if (enabled == value)
			{
				return;
			}
			enabled = value;
			if (enabled)
			{
				if (Entity != null && Entity.ActiveSelf)
				{
					OnActive();
				}
			}
			else if (Entity != null && Entity.ActiveSelf)
			{
				OnDeactive();
			}
		}
	}

	public virtual void OnActive()
	{
	}

	public virtual void OnDeactive()
	{
	}

	public void Init()
	{
		OnInit();
	}

	protected virtual void OnInit()
	{
	}

	public void Shutdown()
	{
		OnShutdown();
		Entity = null;
	}

	protected virtual void OnShutdown()
	{
	}

	public void SetEntity(ILogicEntity entity)
	{
		Entity = (LogicEntity)entity;
	}
}
