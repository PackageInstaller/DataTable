using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class ActionSignalReceiver : MonoBehaviour, INotificationReceiver
{
	public void OnNotify(Playable origin, INotification notification, object context)
	{
		if (notification is IActionSignalEmitter actionSignalEmitter)
		{
			actionSignalEmitter.Invoke(this);
		}
	}
}
