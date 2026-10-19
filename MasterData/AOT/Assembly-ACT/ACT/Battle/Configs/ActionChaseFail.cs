using ACT.Event;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行追踪Fail", "Action", new string[] { "chase", "fail" })]
public class ActionChaseFail : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		ChaseBattleEvent evt = Singleton<EventManager>.instance.GetEvt<ChaseBattleEvent>();
		evt.ActionMemory = memory;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.ChaseBattleFailed, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
