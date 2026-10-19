namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断援护技能索引", "Predicate", new string[] { "check", "assist", "skill", "index", "predicate", "condition", "ability", "cd" })]
public class CheckAssistSkillIndex : ConfigPredicate
{
	public int index;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is EvtAssistSKill evtAssistSKill)
		{
			return evtAssistSKill.index == index;
		}
		return false;
	}
}
