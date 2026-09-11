using System;

namespace Oath;

[Serializable]
public class OathInteractionClearEvent : OathInteractionNode
{
	public override void StartEvent()
	{
		base.IsFinish = true;
	}

	public override void FinishEvent()
	{
		OathSceneLoader.Scene.context.interationManager.character.eventContext.CleaIndependentrEvent();
		OathSceneLoader.Scene.context.interationManager.character.eventContext.ClearEvent();
	}
}
