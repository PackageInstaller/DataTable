namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断RetargetPredicate", "Predicate", new string[] { "retarget", "predicate", "check", "condition" })]
public class RetargetPredicate : ConfigPredicate
{
	public ReTargetType reTargetType;

	public ConfigPredicate[] predicates;

	public override bool Check(ActionMemory memory)
	{
		if (ActionRetarget.GetRetargetMemory(memory, reTargetType, out var result))
		{
			ConfigPredicate[] array = predicates;
			foreach (ConfigPredicate configPredicate in array)
			{
				if (configPredicate.Inverse ? configPredicate.Check(result) : (!configPredicate.Check(result)))
				{
					return Inverse;
				}
			}
			return !Inverse;
		}
		_ = LuminApplication.LogEnabled;
		return false;
	}
}
