using System.Threading;
using ACT.Sound;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class PlaySpecialBGMAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		Singleton<GameManager>.instance.audioManager.SetGlobalParameter("Special_Music_Change", 0);
		Singleton<BGMManager>.instance.SetBGM(BGMType.Special, (Param as PlaySpecialBGMActionParam).bgmName);
		return UniTask.CompletedTask;
	}
}
