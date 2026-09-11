namespace RogueCard;

public abstract class StateWithSubstates : IState
{
	protected StateMachine subStateMachine;

	public StateWithSubstates()
	{
		subStateMachine = new StateMachine();
	}

	public virtual void Enter()
	{
		subStateMachine.Initialize();
	}

	public virtual void Update()
	{
		subStateMachine.Update();
	}

	public virtual void Exit()
	{
		subStateMachine.Exit();
	}

	public void ChangeSubState(IState newSubState)
	{
		subStateMachine.ChangeState(newSubState);
	}

	public IState GetCurrentSubState()
	{
		return subStateMachine?.GetCurrentState();
	}

	public virtual int GetIndex()
	{
		return GetCurrentSubState().GetIndex();
	}

	public virtual bool GetIsEnterAni()
	{
		return GetCurrentSubState().GetIsEnterAni();
	}
}
