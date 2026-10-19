namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断日志", "Predicate", new string[] { "log", "predicate", "check", "condition" })]
public class PredicateLog : ConfigPredicate
{
	public string log;

	public override bool Check(ActionMemory memory)
	{
		_ = LuminApplication.LogEnabled;
		return !Inverse;
	}
}
