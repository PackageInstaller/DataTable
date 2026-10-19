using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("计算浮点", "Function", new string[] { "abs", "float", "value", "int" })]
public class AbsFloat : ConfigFunction<float>
{
	public ConfigFunction<float> value;

	protected override float Evaluate(ActionMemory memory)
	{
		return Mathf.Abs(value.Return(memory));
	}
}
