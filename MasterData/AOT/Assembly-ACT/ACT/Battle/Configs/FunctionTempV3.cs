using ACT.World.StateObject;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取临时向量3", "Function", new string[] { "temp", "v3", "vector", "position", "rotation", "quaternion" })]
public class FunctionTempV3 : ConfigFunction<Vector3>
{
	protected override Vector3 Evaluate(ActionMemory memory)
	{
		InteractLaser component = memory.owner.GetRoot().GetComponent<InteractLaser>();
		if (component == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError(memory.ability?.ToString() + "调用错误FunctionVector");
			}
			return Vector3.zero;
		}
		return component.targetPos;
	}
}
