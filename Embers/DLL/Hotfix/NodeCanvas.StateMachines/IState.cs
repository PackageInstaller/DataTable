namespace NodeCanvas.StateMachines;

public interface IState
{
	string name { get; }

	string tag { get; }

	float elapsedTime { get; }

	FSM FSM { get; }

	FSMConnection[] GetTransitions();

	bool CheckTransitions();

	void Finish(bool success);
}
