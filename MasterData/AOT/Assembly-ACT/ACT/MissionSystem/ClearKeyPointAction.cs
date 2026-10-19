using System.Threading;
using ACT.Drama;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class ClearKeyPointAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		ClearKeyPointActionParam clearKeyPointActionParam = Param as ClearKeyPointActionParam;
		Singleton<ConversationManager>.instance.ClearKeyPoints(clearKeyPointActionParam.keyPoints);
		return UniTask.CompletedTask;
	}
}
