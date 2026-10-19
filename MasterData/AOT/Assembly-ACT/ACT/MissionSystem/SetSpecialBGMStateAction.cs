using System.Threading;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class SetSpecialBGMStateAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		Singleton<GameManager>.instance.audioManager.SetGlobalParameter("Special_Music_Change", (Param as SetSpecialBGMStateActionParam).bgmState);
		return UniTask.CompletedTask;
	}
}
