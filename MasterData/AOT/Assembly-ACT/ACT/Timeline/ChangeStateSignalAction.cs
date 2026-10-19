using ACT.Battle;
using Cysharp.Threading.Tasks;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class ChangeStateSignalAction : ISignalAction
{
	public int swid;

	public int stateId;

	public UniTask Invoke(INotificationReceiver receiver)
	{
		MonoECS.instance.ruleManager.SharedChangeState(swid, stateId);
		return UniTask.CompletedTask;
	}
}
