using ACT.Drama;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class SetActiveConversationContent : ISignalAction
{
	public bool active;

	public UniTask Invoke(INotificationReceiver receiver)
	{
		Singleton<TimelineConversationManager>.instance.SetActiveContent(active);
		return UniTask.CompletedTask;
	}
}
