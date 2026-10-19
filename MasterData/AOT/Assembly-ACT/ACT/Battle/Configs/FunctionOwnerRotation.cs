using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取拥有者旋转", "Function", new string[] { "owner", "rotation", "vector", "position", "quaternion" })]
public class FunctionOwnerRotation : ConfigFunction<Vector3>
{
	protected override Vector3 Evaluate(ActionMemory memory)
	{
		return ((memory.target.entity.GetModelTrans()?.rotation ?? memory.target.entity.GetRootTransform().rotation) * Quaternion.Euler(0f, -90f, 0f)).eulerAngles;
	}
}
