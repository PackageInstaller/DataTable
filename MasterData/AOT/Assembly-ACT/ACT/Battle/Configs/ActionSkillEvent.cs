using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行技能事件", "Action", new string[] { "skill", "event", "ability", "cd" })]
public class ActionSkillEvent : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		EvtSkill evt = systemAbility.GetEvt<EvtSkill>(memory.owner, memory.ability);
		evt.mainEntity = memory.owner;
		systemAbility.FireEvt(evt);
		systemAbility.ReleaseEvt(evt);
	}
}
