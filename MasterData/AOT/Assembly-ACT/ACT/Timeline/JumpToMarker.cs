using ACT.Drama;
using Cysharp.Threading.Tasks;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class JumpToMarker : ISignalAction
{
	public string marker;

	public UniTask Invoke(INotificationReceiver receiver)
	{
		ActionSignalReceiver actionSignalReceiver = receiver as ActionSignalReceiver;
		if (actionSignalReceiver != null)
		{
			ConversationController component = actionSignalReceiver.GetComponent<ConversationController>();
			if (component != null)
			{
				component.JumpToMarker(marker);
			}
		}
		return UniTask.CompletedTask;
	}
}
