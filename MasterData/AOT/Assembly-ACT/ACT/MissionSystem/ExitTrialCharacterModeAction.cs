using System.Threading;
using ACT.Model;
using Cysharp.Threading.Tasks;

namespace ACT.MissionSystem;

public class ExitTrialCharacterModeAction : MissionAction
{
	public override bool OnlyInMissionWorld => false;

	protected override async UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		await Model<TrialCharacterModel>.Interface.ExitTrialCharacterMode();
	}
}
