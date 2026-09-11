using System;

namespace T0World;

[Serializable]
public class T0InterationBedInvokeHandle : T0InterationBedSelectBase
{
	public override T0BedClickType GetSelectType()
	{
		return T0BedClickType.INVOKE_HANDLE;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		base.StartEvent(behaviour);
		(T0WorldScene.Scene.mWorldUI as T0WorldUI).ChangeGrahiceRaycastTarget(isTarget: false);
	}
}
