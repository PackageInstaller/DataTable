using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.MissionSystem;

public interface IMissionManagerInternal
{
	MissionFlow GetMission(int missionId);

	UniTask<bool> UpdateConditionState(int missionId, int conditionId, bool serverVerify, int progress, bool success, CancellationToken token);

	bool FinishAction(int missionId, int stageIndex, MissionStageType stageType, int conditionGroupIndex, int actionId, int actionType);

	UniTask<bool> FinishServerAction(int missionId, int stageIndex, MissionStageType stageType, int conditionGroupIndex, int actionId, int actionType, CancellationToken token);
}
