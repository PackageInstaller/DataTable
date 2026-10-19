using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("计算浮点减法", "Function", new string[] { "float", "subtraction", "value", "int" })]
public class FloatSubtraction : ConfigFunction<float>
{
	public ConfigFunction<float> v1;

	public ConfigFunction<float> v2;

	protected override float Evaluate(ActionMemory memory)
	{
		return Mathf.Clamp(v1.Return(memory) - v2.Return(memory), float.MinValue, float.MaxValue);
	}
}
