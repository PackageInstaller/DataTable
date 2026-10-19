using ACT.Drama;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class SetKeyPointSignalAction : ISignalAction
{
	public int keyPoint;

	public bool sendImmediately;

	public UniTask Invoke(INotificationReceiver receiver)
	{
		Singleton<ConversationManager>.instance.SetKeyPoint(keyPoint);
		if (sendImmediately)
		{
			Singleton<ConversationManager>.instance.SendKeyPoints();
		}
		return UniTask.CompletedTask;
	}
}
