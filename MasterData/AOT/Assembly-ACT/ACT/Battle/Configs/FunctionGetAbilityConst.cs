namespace ACT.Battle.Configs;

[AbilityTypeMetadata("技能常量常量", "Function", new string[] { "get", "ability", "const" })]
public class FunctionGetAbilityConst : ConfigFunction<float>
{
	public string key;

	protected override float Evaluate(ActionMemory memory)
	{
		if (string.IsNullOrEmpty(key))
		{
			return 0f;
		}
		memory.ability.TryGetAbilityConst(key, out var value);
		return (int)value;
	}
}
