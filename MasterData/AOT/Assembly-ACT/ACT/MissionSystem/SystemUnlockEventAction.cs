using System.Threading;
using ACT.Event;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class SystemUnlockEventAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.TaskStepCompleteNtfSystemUnLockHUD, null);
		return UniTask.CompletedTask;
	}
}
