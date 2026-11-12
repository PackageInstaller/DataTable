public abstract class LogicComponent : ILogicComponent
{
	private bool active;

	public LogicEntity Entity { get; private set; }

	public bool ActiveSelf
	{
		get
		{
			return active;
		}
		set
		{
			if (active == value)
			{
				return;
			}
			active = value;
			if (active)
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
		active = true;
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
