namespace ACT.Battle.Configs;

[AbilityTypeMetadata("常量浮点常量", "Function", new string[] { "const", "float" })]
public class ConstFloat : ConfigFunction<float>
{
	public DynamicFloat value;

	protected override float Evaluate(ActionMemory memory)
	{
		return value.GetFloat(memory.ability);
	}
}
