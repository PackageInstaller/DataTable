namespace ACT.MissionSystem;

public interface IReadonlyActionState
{
	int ActionId { get; }

	int ActionType { get; }

	bool Finished { get; }
}
