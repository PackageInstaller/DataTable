namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取字符串", "Function", new string[] { "string" })]
public class FunctionString : ConfigFunction<string>
{
	public string text;

	protected override string Evaluate(ActionMemory memory)
	{
		return text;
	}
}
