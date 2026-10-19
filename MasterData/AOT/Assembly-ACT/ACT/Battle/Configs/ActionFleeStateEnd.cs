using ACT.Event;
using Fundamental;

namespace ACT.Battle.Configs;

public class ActionFleeStateEnd : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		FleeStateEndEvt evt = Singleton<EventManager>.instance.GetEvt<FleeStateEndEvt>();
		evt.fleeMonster = memory.target.entity;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.FleeStateEnd, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
