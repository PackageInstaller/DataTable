namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断施法者", "Predicate", new string[] { "caster", "target", "retarget", "aim", "predicate", "check", "condition" })]
public class CasterPredicate : ConfigPredicate
{
	public ConfigPredicate[] predicates;

	public override bool Check(ActionMemory memory)
	{
		ActionMemory memory2 = new ActionMemory(memory.caster, memory.owner, memory.caster, memory.evt, memory.ability);
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
