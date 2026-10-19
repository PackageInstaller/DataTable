using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取仇恨位置", "Function", new string[] { "hatred", "position", "vector", "rotation", "quaternion" })]
public class FunctionHatredPosition : ConfigFunction<Vector3>
{
	public Vector3 offset;

	[Tooltip("如果没找到目标就使用这个结果")]
	public ConfigFunction<Vector3> fallback;

	protected override Vector3 Evaluate(ActionMemory memory)
	{
		Entity hatred = memory.owner.GetCompHatred().GetHatred();
		if (hatred.IsValid)
		{
			Vector3 vector = offset;
			vector.x = offset.z;
			vector.z = offset.x;
			return hatred.GetCompTransform().FaceDirOffest(vector);
		}
		return fallback.Return(memory);
	}
}
