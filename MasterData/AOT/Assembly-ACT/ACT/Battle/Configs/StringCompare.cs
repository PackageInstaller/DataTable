namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断字符串比较", "Predicate", new string[] { "string", "compare", "predicate", "check", "condition" })]
public class StringCompare : ConfigPredicate
{
	public ConfigFunction<string> s1;

	public ConfigFunction<string> s2;

	public override bool Check(ActionMemory memory)
	{
		return s1.Return(memory).Equals(s2.Return(memory));
	}
}
