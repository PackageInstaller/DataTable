using System;

public class UIListCommand
{
	public Action action;

	public UIListCommand(Action action)
	{
		this.action = action;
	}

	public virtual void Execute()
	{
		if (action != null)
		{
			action();
		}
	}
}
