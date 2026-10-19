using ACT.Event;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class TriggerGachaAcquireCharacterShow : ISignalAction
{
	public UniTask Invoke(INotificationReceiver receiver)
	{
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_GachaAcquireCharacterShow, null);
		return UniTask.CompletedTask;
	}
}
