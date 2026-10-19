using ACT.Game;
using Cysharp.Threading.Tasks;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class TriggerInteractEventSignalAction : ISignalAction
{
	public int wid;

	public string eventName;

	public UniTask Invoke(INotificationReceiver receiver)
	{
		G.service.TriggerCustomInteractEvent(wid, eventName, null);
		return UniTask.CompletedTask;
	}
}
