using ACT.Event;
using Fundamental;

namespace ACT.Battle.Configs;

public class ActionSendPojiaToFushiEvent : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		PojiaToFushiEvt evt = Singleton<EventManager>.instance.GetEvt<PojiaToFushiEvt>();
		evt.entity = memory.target.entity;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.PojiaToFushi, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
