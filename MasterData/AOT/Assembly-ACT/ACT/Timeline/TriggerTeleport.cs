using ACT.Utility;
using Cysharp.Threading.Tasks;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class TriggerTeleport : ISignalAction
{
	public UniTask Invoke(INotificationReceiver receiver)
	{
		GameUtility.TriggerTeleportPoint();
		return UniTask.CompletedTask;
	}
}
