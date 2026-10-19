using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取向量3到路径", "Function", new string[] { "v3", "to", "path", "vector", "position", "rotation", "quaternion" })]
public class FunctionV3ToPath : ConfigFunction<Vector3>
{
	[SerializeField]
	private ConfigFunction<Vector3> _config;

	protected override Vector3 Evaluate(ActionMemory memory)
	{
		Vector3 result = _config.Return(memory);
		CompPhysics compPhysics = memory.owner.GetCompPhysics() ?? memory.caster.GetCompPhysics();
		if (compPhysics != null)
		{
			result.z = compPhysics.GetConstZ;
		}
		return result;
	}
}
