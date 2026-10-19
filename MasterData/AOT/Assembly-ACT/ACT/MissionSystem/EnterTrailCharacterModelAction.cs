using System.Threading;
using ACT.Model;
using Cysharp.Threading.Tasks;

namespace ACT.MissionSystem;

public class EnterTrailCharacterModelAction : MissionAction
{
	protected override async UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		if (!token.IsCancellationRequested)
		{
			EnterTrailCharacterModelActionParam enterTrailCharacterModelActionParam = Param as EnterTrailCharacterModelActionParam;
			int[] probationIds = new int[3] { enterTrailCharacterModelActionParam.probationId1, enterTrailCharacterModelActionParam.probationId2, enterTrailCharacterModelActionParam.probationId3 };
			await Model<TrialCharacterModel>.Interface.EnterTrialCharacterMode(probationIds, enterTrailCharacterModelActionParam.battleIndex, enterTrailCharacterModelActionParam.trialPotionId);
		}
	}
}
