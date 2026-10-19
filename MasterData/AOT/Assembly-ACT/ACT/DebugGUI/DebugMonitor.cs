namespace ACT.DebugGUI;

public abstract class DebugMonitor
{
	protected virtual bool OnInit()
	{
		return true;
	}

	public virtual void OnDraw()
	{
	}

	public virtual void OnUpdate()
	{
	}

	public void Remove()
	{
		OnRemove();
	}

	protected virtual void OnRemove()
	{
	}
}
