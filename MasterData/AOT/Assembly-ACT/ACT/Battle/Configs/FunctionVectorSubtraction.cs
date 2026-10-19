using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("计算向量减法", "Function", new string[] { "vector", "subtraction", "value", "float", "int" })]
public class FunctionVectorSubtraction : ConfigFunction<Vector3>
{
	public ConfigFunction<Vector3> v1;

	public ConfigFunction<Vector3> v2;

	protected override Vector3 Evaluate(ActionMemory memory)
	{
		return v1.Return(memory) - v2.Return(memory);
	}
}
