using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取上下文位置", "Function", new string[] { "context", "position", "vector", "rotation", "quaternion" })]
public class FunctionContextPosition : ConfigFunction<Vector3>
{
	public int contextType;

	[Tooltip("如果没找到目标就使用这个结果")]
	public ConfigFunction<Vector3> fallback;

	protected override Vector3 Evaluate(ActionMemory memory)
	{
		BattleInteractableObject battleInteractableObject = MonoECS.instance.aiContextManager.FindContext(contextType);
		if (!(battleInteractableObject != null))
		{
			return fallback.Return(memory);
		}
		return battleInteractableObject.transform.position;
	}
}
