namespace ACT.MissionSystem;

public class ConditionState : IReadOnlyConditionState
{
	public readonly int ConditionId;

	public readonly int ConditionType;

	public int Version;

	public bool Finished;

	public int Progress;

	public int StartTs;

	int IReadOnlyConditionState.ConditionId => ConditionId;

	int IReadOnlyConditionState.ConditionType => ConditionType;

	int IReadOnlyConditionState.Version => Version;

	bool IReadOnlyConditionState.Finished => Finished;

	int IReadOnlyConditionState.Progress => Progress;

	int IReadOnlyConditionState.StartTs => StartTs;

	public ConditionState(int conditionId, int conditionType)
	{
		ConditionId = conditionId;
		ConditionType = conditionType;
	}

	public void Reset()
	{
		Version = 0;
		Finished = false;
		Progress = 0;
		StartTs = 0;
	}
}
