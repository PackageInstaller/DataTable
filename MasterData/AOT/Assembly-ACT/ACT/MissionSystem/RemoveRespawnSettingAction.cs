using System.Threading;
using ACT.Battle;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class RemoveRespawnSettingAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		if (Flow.Blackboard.Get("RespawnSetting") is RespawnSetting setting)
		{
			Singleton<RespawnManager>.instance.RemoveRespawnSetting(setting);
		}
		return UniTask.CompletedTask;
	}
}
