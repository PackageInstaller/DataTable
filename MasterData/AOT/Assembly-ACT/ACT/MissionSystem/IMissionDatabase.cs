using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.MissionSystem;

public interface IMissionDatabase
{
	bool LocalMode { get; }

	IReadOnlyList<MissionState> MissionStateList { get; }

	int ExplicitTrackingMission { get; }

	void Init();

	void UnInit();

	IReadOnlyMissionState QueryMissionState(int missionId);

	bool UpdateExplicitTracingMission(int missionId);

	bool SuccessMission(int missionId);

	bool FailureMission(int missionId);

	bool GiveUpMission(int missionId);

	bool WaitingMission(int missionId);

	bool ManualAcceptMission(int missionId);

	bool UpdateCondition(int missionId, MissionStageType stageType, int stageIndex, int conditionId, int progress, bool success);

	UniTask<bool> FinishConditionWithServerVerify(int missionId, MissionStageType stageType, int stageIndex, int conditionId, int progress, CancellationToken token);

	bool FinishAction(int missionId, int stageIndex, MissionStageType targetType, int conditionGroupIndex, int actionId, int actionType);

	UniTask<bool> FinishServerAction(int missionId, MissionStageType targetType, int stageIndex, int conditionGroupIndex, int actionId, int actionType, CancellationToken token);

	bool UpdateStage(int missionId, int newStageIndex);
}
