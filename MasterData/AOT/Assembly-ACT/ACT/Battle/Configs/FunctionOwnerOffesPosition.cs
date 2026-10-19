using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取拥有者偏移位置", "Function", new string[] { "owner", "offes", "position", "vector", "rotation", "quaternion" })]
public class FunctionOwnerOffesPosition : ConfigFunction<Vector3>
{
	[Tooltip("Entity面向的偏移量")]
	public Vector3 value;

	protected override Vector3 Evaluate(ActionMemory memory)
	{
		return memory.owner.GetCompTransform().FaceDirOffest(value);
	}
}
