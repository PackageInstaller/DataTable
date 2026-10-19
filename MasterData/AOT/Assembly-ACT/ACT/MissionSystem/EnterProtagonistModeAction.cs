using System.Threading;
using ACT.Battle;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class EnterProtagonistModeAction : MissionAction
{
	protected override async UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		await UniTask.WaitUntil(() => Singleton<ProtagonistManager>.instance.CanEnterProtagonistMode, PlayerLoopTiming.Update, token);
		if (!token.IsCancellationRequested)
		{
			await Singleton<ProtagonistManager>.instance.EnterProtagonistMode();
		}
	}
}
