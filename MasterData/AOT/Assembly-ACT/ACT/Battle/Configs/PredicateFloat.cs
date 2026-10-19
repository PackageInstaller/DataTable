namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取浮点", "Function", new string[] { "float", "value", "int" })]
public class PredicateFloat : ConfigFunction<float>
{
	public ConfigPredicate[] predicates;

	public ConfigFunction<float> onTrue;

	public ConfigFunction<float> onFalse;

	protected override float Evaluate(ActionMemory memory)
	{
		ConfigPredicate[] array = predicates;
		foreach (ConfigPredicate configPredicate in array)
		{
			if (configPredicate.Inverse ? configPredicate.Check(memory) : (!configPredicate.Check(memory)))
			{
				return onFalse.Return(memory);
			}
		}
		return onTrue.Return(memory);
	}
}
