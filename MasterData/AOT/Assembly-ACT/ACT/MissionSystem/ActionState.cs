namespace ACT.MissionSystem;

public class ActionState : IReadonlyActionState
{
	public readonly int ActionId;

	public readonly int ActionType;

	public bool Finished;

	int IReadonlyActionState.ActionId => ActionId;

	int IReadonlyActionState.ActionType => ActionType;

	bool IReadonlyActionState.Finished => Finished;

	public ActionState(int actionId, int actionType)
	{
		ActionId = actionId;
		ActionType = actionType;
	}

	public void Reset()
	{
		Finished = false;
	}
}
