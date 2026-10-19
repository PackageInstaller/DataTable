using UnityEngine.Scripting;

namespace UnityEngine.Playables;

[RequiredByNativeCode]
public interface INotificationReceiver
{
	[RequiredByNativeCode]
	void OnNotify(Playable origin, INotification notification, object context);
}
