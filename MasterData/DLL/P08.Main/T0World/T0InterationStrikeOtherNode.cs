using System;

namespace T0World;

[Serializable]
public class T0InterationStrikeOtherNode : T0InterationFunctionDataBase
{
	public int targetTreeID;

	public int targetNodeID;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		base.IsFinish = true;
	}

	public override void OnFinish(T0WorldInteractionBehavior behaviour)
	{
		base.IsDispose = true;
		T0WorldScene.Scene.interactionManager.InteractContext.ClearFocusEvent();
		ClearBrotherNode();
		T0WorldScene.Scene.agentManager.GetAgent(entityID).Blackboard.EventContext.DisposeAllEvent();
		T0WorldScene.Scene.interactionManager.TriggerTargetInteraction(targetTreeID, targetNodeID);
	}
}
