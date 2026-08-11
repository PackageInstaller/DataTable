namespace NodeCanvas.StateMachines;

public interface IStateCallbackReceiver
{
	void OnStateEnter(IState state);

	void OnStateUpdate(IState state);

	void OnStateExit(IState state);
}
