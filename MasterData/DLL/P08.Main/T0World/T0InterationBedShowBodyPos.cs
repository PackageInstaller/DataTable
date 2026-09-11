using System;

namespace T0World;

[Serializable]
public class T0InterationBedShowBodyPos : T0InterationBedSelectBase
{
	public override T0BedClickType GetSelectType()
	{
		return T0BedClickType.SELECT_BODY_POS;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		base.StartEvent(behaviour);
		T0BedGame.bedGame.SetModeUIType(BedSelectEnum.prop);
	}

	public override void FinishEvent(T0WorldInteractionBehavior behaviour)
	{
		base.StartEvent(behaviour);
	}
}
