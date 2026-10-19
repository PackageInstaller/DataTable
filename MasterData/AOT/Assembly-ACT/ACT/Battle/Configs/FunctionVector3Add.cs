using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("计算向量3", "Function", new string[] { "vector3", "add", "value", "float", "int" })]
public class FunctionVector3Add : ConfigFunction<Vector3>
{
	public ConfigFunction<Vector3> v1;

	public ConfigFunction<Vector3> v2;

	protected override Vector3 Evaluate(ActionMemory memory)
	{
		return v1.Return(memory) + v2.Return(memory);
	}
}
