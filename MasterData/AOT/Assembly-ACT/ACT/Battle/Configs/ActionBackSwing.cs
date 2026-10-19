using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行返回Swing", "Action", new string[] { "back", "swing" })]
public class ActionBackSwing : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		EvtBackSwing evt = systemAbility.GetEvt<EvtBackSwing>(memory.owner, memory.ability);
		evt.mainEntity = memory.owner;
		systemAbility.FireEvt(evt);
		systemAbility.ReleaseEvt(evt);
	}
}
