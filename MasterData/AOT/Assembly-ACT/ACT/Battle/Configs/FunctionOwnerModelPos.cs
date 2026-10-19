using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取拥有者模型位置", "Function", new string[] { "owner", "model", "pos", "vector", "position", "rotation", "quaternion" })]
public class FunctionOwnerModelPos : ConfigFunction<Vector3>
{
	protected override Vector3 Evaluate(ActionMemory memory)
	{
		return memory.owner.GetModelTrans().position;
	}
}
