using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("计算浮点", "Function", new string[] { "float", "add", "value", "int" })]
public class FloatAdd : ConfigFunction<float>
{
	public ConfigFunction<float> v1;

	public ConfigFunction<float> v2;

	protected override float Evaluate(ActionMemory memory)
	{
		return Mathf.Clamp(v1.Return(memory) + v2.Return(memory), float.MinValue, float.MaxValue);
	}
}
