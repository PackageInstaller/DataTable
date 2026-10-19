using System.Collections.Generic;

namespace ACT.MissionSystem;

public interface IReadOnlyConditionGroupState
{
	IReadOnlyList<IReadOnlyConditionState> ConditionStates { get; }

	IReadOnlyList<IReadonlyActionState> ActionStates { get; }

	IReadOnlyConditionState GetConditionState(int conditionId);

	IReadonlyActionState GetActionState(int actionId);

	bool IsAchieve();
}
