namespace Bamboo.Command;

public abstract class BaseAssignment
{
	private AssignmentState _state;

	internal AssignmentState State => _state;

	internal virtual void Execute()
	{
		_state = AssignmentState.Executing;
	}

	public virtual void ForceExecute()
	{
	}

	internal abstract void Update(int delta);

	internal virtual void Stop()
	{
		_state = AssignmentState.Stoped;
	}

	protected void Release()
	{
		_state = AssignmentState.Stopping;
	}

	internal void ResetState()
	{
		_state = AssignmentState.Unexecute;
	}
}
