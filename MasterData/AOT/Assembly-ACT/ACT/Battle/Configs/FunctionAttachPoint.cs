using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取挂点点", "Function", new string[] { "attach", "point", "vector", "position", "rotation", "quaternion" })]
public class FunctionAttachPoint : ConfigFunction<Vector3>
{
	[Tooltip("通过Wrap上的AttachPoint 瞄准")]
	public string attachPoint;

	protected override Vector3 Evaluate(ActionMemory memory)
	{
		return memory.target.entity.GetMono().GetAttachPointPosition(attachPoint);
	}
}
