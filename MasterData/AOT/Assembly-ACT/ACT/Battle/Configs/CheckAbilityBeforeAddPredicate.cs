namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断技能Before", "Predicate", new string[] { "check", "ability", "before", "add", "predicate", "condition", "skill", "cd" })]
public class CheckAbilityBeforeAddPredicate : ConfigPredicate
{
	public string name;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is EvtAddAbilityBeforeAdd evtAddAbilityBeforeAdd)
		{
			return evtAddAbilityBeforeAdd.name == name;
		}
		return false;
	}
}
