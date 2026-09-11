using System;

namespace T0World;

[Serializable]
public class T0InterationBedSelectBase : T0InterationBaseData
{
	public virtual T0BedClickType GetSelectType()
	{
		return T0BedClickType.NONE;
	}

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		T0BedGame.bedGame.RegisterInteration(this);
	}

	public override void FinishEvent(T0WorldInteractionBehavior behaviour)
	{
		T0BedGame.bedGame.ClearRunEvent();
	}

	public override void UpdateEvent(T0WorldInteractionBehavior behaviour)
	{
	}

	public override void DisposeEvent()
	{
	}

	public virtual void CheckBedFinishEvent(T0BedClickType clickType)
	{
		if (clickType == GetSelectType())
		{
			base.IsFinish = true;
		}
	}
}
