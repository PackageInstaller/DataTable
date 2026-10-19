using System.Threading;
using ACT.Battle;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class ExitProtagonistModeAction : MissionAction
{
	public override bool OnlyInMissionWorld => false;

	protected override async UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		await Singleton<ProtagonistManager>.instance.ExitProtagonistMode();
	}
}
