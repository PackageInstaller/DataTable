using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取拥有者坐标向量3", "Function", new string[] { "owner", "coordinate", "vector3", "vector", "position", "rotation", "quaternion" })]
public class FunctionOwnerCoordinateVector3 : ConfigFunction<Vector3>
{
	public Vector3 value;

	protected override Vector3 Evaluate(ActionMemory memory)
	{
		return memory.owner.GetCompPhysics().PathLocalToWorld(value);
	}
}
