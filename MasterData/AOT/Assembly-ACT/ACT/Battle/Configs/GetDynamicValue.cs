using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取动态值", "Function", new string[] { "get", "dynamic", "value", "float", "int" })]
public class GetDynamicValue : ConfigFunction<float>
{
	public string dynamicValueName;

	protected override float Evaluate(ActionMemory memory)
	{
		memory.target.entity.GetCompAbility().vars.TryGetValue(dynamicValueName, out var value);
		return value?.value ?? 1f;
	}
}
