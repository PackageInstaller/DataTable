using System;

namespace T0World;

[Serializable]
public class T0InterationBedHideHandleArea : T0InterationBaseData
{
	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		base.StartEvent(behaviour);
		T0BedGame.bedGame.HideHandleArea();
		base.IsFinish = true;
	}
}
