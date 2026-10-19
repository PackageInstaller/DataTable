namespace ACT.MissionSystem;

public abstract class MissionFSMState
{
	public void Enter()
	{
		OnEnter();
	}

	public void Exit()
	{
		OnExit();
	}

	protected virtual void OnEnter()
	{
	}

	protected virtual void OnExit()
	{
	}
}
