namespace Bamboo.Command;

public abstract class DurativeAssignment : BaseAssignment
{
	protected bool IsExecuting => State == AssignmentState.Executing;

	internal override void Execute()
	{
		base.Execute();
		OnEnter();
	}

	internal override void Update(int delta)
	{
		OnUpdate(delta);
	}

	internal override void Stop()
	{
		OnExit();
		base.Stop();
	}

	protected abstract void OnEnter();

	protected abstract void OnUpdate(int delta);

	protected abstract void OnExit();
}
