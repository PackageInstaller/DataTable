using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行之后切换技能连击事件", "Action", new string[] { "after", "switch", "skill", "combo", "event", "ability", "cd" })]
public class ActionAfterSwitchSkillComboEvent : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		EvtAfterSwitchSkill evt = systemAbility.GetEvt<EvtAfterSwitchSkill>(memory.owner, memory.ability);
		evt.mainEntity = memory.owner;
		systemAbility.FireEvt(evt);
		systemAbility.ReleaseEvt(evt);
	}
}
