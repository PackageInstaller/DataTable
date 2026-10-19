using System.Collections.Generic;
using ACT.Game.Data;

namespace ACT.MissionSystem;

public interface IReadOnlyMissionState
{
	int MissionId { get; }

	int Version { get; }

	bool IsFinished { get; }

	bool IsInBlockedMapArea { get; }

	int FinishCount { get; }

	int CurrentStage { get; }

	int ValidCurrentStage { get; }

	bool IsClientWaiting { get; }

	bool IsClientAccepting { get; }

	bool IsServerAccepting { get; }

	ACT.Game.Data.MissionStateEnum StateEnum { get; }

	IReadOnlyStageState FailureState { get; }

	IReadOnlyStageState ExtraState { get; }

	IReadOnlyList<IReadOnlyStageState> StageStates { get; }

	IReadOnlyConditionState GetConditionState(int conditionId);
}
