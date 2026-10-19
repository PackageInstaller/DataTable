using UnityEngine.Playables;

namespace ACT.Timeline;

public interface IActionSignalEmitter
{
	void Invoke(INotificationReceiver receiver);
}
