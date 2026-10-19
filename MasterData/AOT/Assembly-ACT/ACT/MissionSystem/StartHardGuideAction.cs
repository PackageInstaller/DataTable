using System.Threading;
using ACT.Model;
using Cysharp.Threading.Tasks;

namespace ACT.MissionSystem;

public class StartHardGuideAction : MissionAction
{
	protected override async UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		StartHardGuideActionParam param = Param as StartHardGuideActionParam;
		Model<GuideModel>.Interface.StartGuide(param.guideId);
		await UniTask.WaitUntil(() => Model<GuideModel>.Interface.GuideHasTriggeredAndFinsh(param.guideId), PlayerLoopTiming.Update, token).SuppressCancellationThrow();
	}
}
