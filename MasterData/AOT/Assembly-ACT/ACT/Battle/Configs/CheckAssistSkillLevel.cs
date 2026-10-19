namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断援护技能等级", "Predicate", new string[] { "check", "assist", "skill", "level", "predicate", "condition", "ability", "cd" })]
public class CheckAssistSkillLevel : ConfigPredicate
{
	public int level;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is EvtAssistSKill evtAssistSKill)
		{
			return evtAssistSKill.level == level;
		}
		return false;
	}
}
