using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("计算值", "Function", new string[] { "max", "value", "float", "int" })]
public class MaxValue : ConfigFunction<float>
{
	public ConfigFunction<float> v1;

	public ConfigFunction<float> v2;

	protected override float Evaluate(ActionMemory memory)
	{
		return Mathf.Max(v1.Return(memory), v2.Return(memory));
	}
}
