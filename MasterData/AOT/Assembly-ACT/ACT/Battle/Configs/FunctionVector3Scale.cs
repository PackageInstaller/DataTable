using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取向量3", "Function", new string[] { "vector3", "scale", "vector", "position", "rotation", "quaternion" })]
public class FunctionVector3Scale : ConfigFunction<Vector3>
{
	public ConfigFunction<Vector3> v1;

	public ConfigFunction<float> v2;

	protected override Vector3 Evaluate(ActionMemory memory)
	{
		return v1.Return(memory) * v2.Return(memory);
	}
}
