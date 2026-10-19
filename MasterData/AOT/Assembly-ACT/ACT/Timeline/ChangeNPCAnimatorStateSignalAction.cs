using Cysharp.Threading.Tasks;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class ChangeNPCAnimatorStateSignalAction : ISignalAction
{
	public int swid;

	public int stateId;

	public UniTask Invoke(INotificationReceiver receiver)
	{
		return UniTask.CompletedTask;
	}
}
