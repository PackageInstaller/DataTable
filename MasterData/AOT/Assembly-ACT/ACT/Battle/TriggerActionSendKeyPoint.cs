using System.Threading;
using ACT.Drama;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.Battle;

public class TriggerActionSendKeyPoint : TriggerActionBase
{
	public int keyPoint;

	public override UniTask Invoke(TriggerActionContext context, CancellationToken token)
	{
		Singleton<ConversationManager>.instance.SetKeyPoint(keyPoint);
		Singleton<ConversationManager>.instance.SendKeyPoints();
		return UniTask.CompletedTask;
	}
}
