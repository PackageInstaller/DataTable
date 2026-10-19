using System.Threading;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.Drama.Conversation;

public class SendKeyPointEvent : BaseEvent
{
	public int keyPoint;

	public bool sendImmediately;

	public override async UniTask DoEvent(CancellationToken cancellationToken = default(CancellationToken))
	{
		Singleton<ConversationManager>.instance.SetKeyPoint(keyPoint);
		if (sendImmediately)
		{
			Singleton<ConversationManager>.instance.SendKeyPoints();
		}
	}
}
