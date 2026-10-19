using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取欧拉角到四元数", "Function", new string[] { "euler", "to", "quaternion", "vector", "position", "rotation" })]
public class FunctionEulerToQuaternion : ConfigFunction<Quaternion>
{
	public ConfigFunction<Vector3> euler;

	protected override Quaternion Evaluate(ActionMemory memory)
	{
		return Quaternion.Euler(euler.Return(memory));
	}
}
