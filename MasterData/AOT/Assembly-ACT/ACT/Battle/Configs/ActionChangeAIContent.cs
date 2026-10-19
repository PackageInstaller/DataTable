using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改AI内容", "Action", new string[] { "change", "ai", "content", "bt", "behavior", "behaviour" })]
public class ActionChangeAIContent : ConfigAction
{
	public int contextType;

	public ConfigFunction<Vector3> newPosFunction;

	public override void Do(ActionMemory memory)
	{
		BattleInteractableObject battleInteractableObject = MonoECS.instance.aiContextManager.FindContext(contextType);
		if (battleInteractableObject != null)
		{
			Vector3 position = newPosFunction.Return(memory);
			battleInteractableObject.transform.position = position;
		}
	}
}
