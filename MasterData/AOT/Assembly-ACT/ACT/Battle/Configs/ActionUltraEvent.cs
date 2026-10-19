using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行大招事件", "Action", new string[] { "ultra", "event", "trigger", "signal" })]
public class ActionUltraEvent : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		EvtUltra evt = systemAbility.GetEvt<EvtUltra>(memory.owner, memory.ability);
		evt.mainEntity = memory.owner;
		systemAbility.FireEvt(evt);
		systemAbility.ReleaseEvt(evt);
	}
}
