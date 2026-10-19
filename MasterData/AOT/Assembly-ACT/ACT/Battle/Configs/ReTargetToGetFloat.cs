namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取重新目标到浮点", "Function", new string[] { "re", "target", "to", "get", "float", "value", "int" })]
public class ReTargetToGetFloat : ConfigFunction<float>
{
	public ReTargetType ReTargetType;

	public ConfigFunction<float> configFunction;

	protected override float Evaluate(ActionMemory memory)
	{
		float result = 0f;
		if (ActionRetarget.GetRetargetMemory(memory, ReTargetType, out var result2))
		{
			result = configFunction.Return(result2);
		}
		else
		{
			_ = LuminApplication.LogEnabled;
		}
		return result;
	}
}
