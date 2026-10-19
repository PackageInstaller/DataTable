using System.Threading;
using ACT.Battle;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class SetRespawnToRespawnPosSettingAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		RespawnSetting_ToRespawnPos respawnSetting_ToRespawnPos = new RespawnSetting_ToRespawnPos();
		Flow.Blackboard.Add("RespawnSetting", respawnSetting_ToRespawnPos);
		Singleton<RespawnManager>.instance.AddRespawnSetting(respawnSetting_ToRespawnPos);
		return UniTask.CompletedTask;
	}
}
