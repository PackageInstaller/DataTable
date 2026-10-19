using System.Threading;
using ACT.Battle;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class SetNoMoveRespawnSettingAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		RespawnSetting_NoMove respawnSetting_NoMove = new RespawnSetting_NoMove();
		Flow.Blackboard.Add("RespawnSetting", respawnSetting_NoMove);
		Singleton<RespawnManager>.instance.AddRespawnSetting(respawnSetting_NoMove);
		return UniTask.CompletedTask;
	}
}
