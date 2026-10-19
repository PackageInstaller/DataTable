using System;
using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.MissionSystem;

public interface IMissionServer
{
	void Init();

	void UnInit();

	void FinishAction(int missionId, int stageIndex, MissionStageType stageType, int conditionGroupIndex, int actionId, int actionType, Action<bool, object> callback = null);

	UniTask FinishServerAction(int missionId, int stageIndex, MissionStageType stageType, int conditionGroupIndex, int actionId, int actionType, CancellationToken token, Action<bool, object> callback = null);
}
