using System.Threading;
using ACT.Model;
using Cysharp.Threading.Tasks;

namespace ACT.MissionSystem;

public class StartSoftGuideAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		StartSoftGuideActionParam startSoftGuideActionParam = Param as StartSoftGuideActionParam;
		Model<GuideModel>.Interface.StartGuide(startSoftGuideActionParam.guideId);
		return UniTask.CompletedTask;
	}
}
