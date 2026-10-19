using System.Threading;
using ACT.Drama;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class SendKeyPointAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		SendKeyPointActionParam sendKeyPointActionParam = Param as SendKeyPointActionParam;
		Singleton<ConversationManager>.instance.SetKeyPoint(sendKeyPointActionParam.keyPoint);
		Singleton<ConversationManager>.instance.SendKeyPoints();
		return UniTask.CompletedTask;
	}
}
