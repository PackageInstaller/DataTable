using System.Collections.Generic;

namespace ACT.MissionSystem;

public interface IReadOnlyStageState
{
	IReadOnlyList<IReadOnlyConditionGroupState> ConditionGroupStates { get; }

	IReadOnlyList<IReadOnlyConditionState> ConditionStates { get; }

	IReadOnlyConditionState GetConditionState(int conditionId);

	bool IsArchive();

	bool IsCompleted();
}
