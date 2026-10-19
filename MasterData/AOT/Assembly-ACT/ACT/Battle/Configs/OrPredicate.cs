namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断Or", "Predicate", new string[] { "or", "predicate", "check", "condition" })]
public class OrPredicate : ConfigPredicate
{
	public ConfigPredicate[] predicates;

	public override bool Check(ActionMemory memory)
	{
		ConfigPredicate[] array = predicates;
		foreach (ConfigPredicate configPredicate in array)
		{
			if (configPredicate.Inverse ? (!configPredicate.Check(memory)) : configPredicate.Check(memory))
			{
				return true;
			}
		}
		return false;
	}
}
