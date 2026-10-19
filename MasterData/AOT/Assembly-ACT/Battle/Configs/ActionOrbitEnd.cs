using ACT.Battle.Configs;
using ACT.Event;
using Fundamental;

namespace Battle.Configs;

[AbilityTypeMetadata("执行轨道", "Action", new string[] { "orbit", "end", "move", "movement", "position", "velocity" })]
public class ActionOrbitEnd : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		OrbitEndEvent evt = Singleton<EventManager>.instance.GetEvt<OrbitEndEvent>();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.OrbitEnd, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
