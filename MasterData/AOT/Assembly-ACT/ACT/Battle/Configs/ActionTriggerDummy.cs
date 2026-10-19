using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("触发假人", "Action", new string[] { "trigger", "dummy", "event", "signal" })]
public class ActionTriggerDummy : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		EvtTriggerDummy evt = systemAbility.GetEvt<EvtTriggerDummy>(memory.owner, memory.ability);
		evt.mainEntity = memory.owner;
		systemAbility.FireEvt(evt);
		systemAbility.ReleaseEvt(evt);
	}
}
