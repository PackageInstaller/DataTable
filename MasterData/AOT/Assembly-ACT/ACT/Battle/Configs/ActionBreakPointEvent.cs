using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行Break点事件", "Action", new string[] { "break", "point", "event", "trigger", "signal" })]
public class ActionBreakPointEvent : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		EvtBreakPoint evt = systemAbility.GetEvt<EvtBreakPoint>(memory.owner, memory.ability);
		evt.mainEntity = memory.owner;
		systemAbility.FireEvt(evt);
		systemAbility.ReleaseEvt(evt);
	}
}
