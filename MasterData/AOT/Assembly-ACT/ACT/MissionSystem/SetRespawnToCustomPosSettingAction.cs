using System.Threading;
using ACT.Battle;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.MissionSystem;

public class SetRespawnToCustomPosSettingAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		SetRespawnToCustomPosSettingActionParam setRespawnToCustomPosSettingActionParam = Param as SetRespawnToCustomPosSettingActionParam;
		RespawnSetting_ToCustomPos respawnSetting_ToCustomPos = new RespawnSetting_ToCustomPos
		{
			chunkId = setRespawnToCustomPosSettingActionParam.chunkId,
			position = new Vector3(setRespawnToCustomPosSettingActionParam.positionX, setRespawnToCustomPosSettingActionParam.positionY, setRespawnToCustomPosSettingActionParam.positionZ)
		};
		Flow.Blackboard.Add("RespawnSetting", respawnSetting_ToCustomPos);
		Singleton<RespawnManager>.instance.AddRespawnSetting(respawnSetting_ToCustomPos);
		return UniTask.CompletedTask;
	}
}
