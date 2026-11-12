namespace AIScript.Monster._13500010BigHeadGhost;

public class IState
{
	private fsmStatus fsmStatus;

	public AdventureActor _actor;

	public bool IsEnd => fsmStatus == fsmStatus.Exit;

	public void Init(AdventureActor actor)
	{
		_actor = actor;
	}

	public virtual void Enter()
	{
		fsmStatus = fsmStatus.Enter;
	}

	public virtual void Update()
	{
	}

	public virtual void Exit()
	{
		fsmStatus = fsmStatus.Exit;
	}

	public virtual void ForceExit()
	{
	}
}
