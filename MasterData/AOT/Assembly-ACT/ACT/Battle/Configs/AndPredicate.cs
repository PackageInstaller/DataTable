namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断并", "Predicate", new string[] { "and", "predicate", "check", "condition" })]
public class AndPredicate : ConfigPredicate
{
	public ConfigPredicate[] predicates;

	public override bool Check(ActionMemory memory)
	{
		ConfigPredicate[] array = predicates;
		foreach (ConfigPredicate configPredicate in array)
		{
			if (configPredicate.Inverse ? configPredicate.Check(memory) : (!configPredicate.Check(memory)))
			{
				return false;
			}
		}
		return true;
	}
}
