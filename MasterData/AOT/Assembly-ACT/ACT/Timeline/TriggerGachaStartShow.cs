using ACT.Event;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class TriggerGachaStartShow : ISignalAction
{
	public UniTask Invoke(INotificationReceiver receiver)
	{
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_GachaStartShow, null);
		return UniTask.CompletedTask;
	}
}
