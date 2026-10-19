using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("取两个浮点最小值", "Function", new string[] { "two", "float", "get", "min", "value", "int" })]
public class TwoFloatGetMinValue : ConfigFunction<float>
{
	public ConfigFunction<float> v1;

	public ConfigFunction<float> v2;

	protected override float Evaluate(ActionMemory memory)
	{
		return Mathf.Min(v1.Return(memory), v2.Return(memory));
	}
}
