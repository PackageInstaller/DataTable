namespace RogueCard;

public class StateMachine
{
	private IState currentState;

	private IState lastState;

	public void Initialize(IState startingState = null)
	{
		currentState = startingState;
		currentState?.Enter();
	}

	public void ChangeState(IState newState)
	{
		currentState?.Exit();
		lastState = currentState;
		currentState = newState;
		currentState?.Enter();
	}

	public void BackState()
	{
		ChangeState(lastState);
	}

	public bool CheckBackState()
	{
		return lastState != null;
	}

	public void Update()
	{
		currentState?.Update();
	}

	public void Exit()
	{
		currentState?.Exit();
		currentState = null;
	}

	public IState GetCurrentState()
	{
		return currentState;
	}

	public IState GetLastState()
	{
		return lastState;
	}
}
