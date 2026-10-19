using System.Threading;
using ACT.Event;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.Battle;

public class TriggerActionFireEvent : TriggerActionBase
{
	public TriggerType triggerType;

	public override UniTask Invoke(TriggerActionContext context, CancellationToken token)
	{
		TriggerEventEntry evt = Singleton<EventManager>.instance.GetEvt<TriggerEventEntry>();
		evt.triggerType = triggerType;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.TriggerObjectEntry, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		return UniTask.CompletedTask;
	}
}
