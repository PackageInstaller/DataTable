namespace ACT.MissionSystem;

public interface IReadOnlyConditionState
{
	int ConditionId { get; }

	int ConditionType { get; }

	int Version { get; }

	bool Finished { get; }

	int Progress { get; }

	int StartTs { get; }
}
