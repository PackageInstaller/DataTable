namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断技能", "Predicate", new string[] { "check", "ability", "add", "predicate", "condition", "skill", "cd" })]
public class CheckAbilityAddPredicate : ConfigPredicate
{
	public string name;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is BaseAddAbilityEvt baseAddAbilityEvt)
		{
			return baseAddAbilityEvt.name == name;
		}
		return false;
	}
}
