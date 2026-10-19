namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断拥有者", "Predicate", new string[] { "owner", "target", "retarget", "aim", "predicate", "check", "condition" })]
public class OwnerPredicate : ConfigPredicate
{
	public ConfigPredicate[] predicates;

	public override bool Check(ActionMemory memory)
	{
		ActionMemory memory2 = new ActionMemory(memory.caster, memory.owner, memory.owner, memory.evt, memory.ability);
		ConfigPredicate[] array = predicates;
		foreach (ConfigPredicate configPredicate in array)
		{
			if (configPredicate.Inverse ? configPredicate.Check(memory2) : (!configPredicate.Check(memory2)))
			{
				return Inverse;
			}
		}
		return !Inverse;
	}
}
