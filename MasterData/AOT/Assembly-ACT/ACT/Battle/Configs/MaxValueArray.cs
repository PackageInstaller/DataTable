using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("计算值数组", "Function", new string[] { "max", "value", "array", "float", "int" })]
public class MaxValueArray : ConfigFunction<float>
{
	public ConfigFunction<float>[] values;

	protected override float Evaluate(ActionMemory memory)
	{
		float num = float.MinValue;
		ConfigFunction<float>[] array = values;
		foreach (ConfigFunction<float> configFunction in array)
		{
			num = Mathf.Max(num, configFunction.Return(memory));
		}
		return num;
	}
}
