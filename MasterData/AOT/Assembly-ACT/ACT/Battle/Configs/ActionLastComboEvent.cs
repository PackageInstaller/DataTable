using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行最后连击事件", "Action", new string[] { "last", "combo", "event", "trigger", "signal" })]
public class ActionLastComboEvent : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		EvtLastCombo evt = systemAbility.GetEvt<EvtLastCombo>(memory.owner, memory.ability);
		evt.mainEntity = memory.owner;
		systemAbility.FireEvt(evt);
		systemAbility.ReleaseEvt(evt);
	}
}
