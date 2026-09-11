using System;

namespace T0World;

[Serializable]
public class T0InterationBedCheck : T0InterationBaseData
{
	public bool isNeedCheckProp;

	public BedPropEnum propType = BedPropEnum.none;

	public bool isNeedCheckBody;

	public BedPosEnum bodyType = BedPosEnum.none;

	public bool isNeedCheckHandle;

	public BedHandleEnum handleType = BedHandleEnum.none;

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	public bool CheckIsMeet()
	{
		if (isNeedCheckProp && T0BedGame.bedGame.context.currentPropType != propType)
		{
			return false;
		}
		if (isNeedCheckBody && T0BedGame.bedGame.context.currentPosType != bodyType)
		{
			return false;
		}
		if (isNeedCheckHandle && T0BedGame.bedGame.context.currentHandleType != handleType)
		{
			return false;
		}
		return true;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		if (CheckIsMeet())
		{
			base.IsFinish = true;
		}
	}

	public override void FinishEvent(T0WorldInteractionBehavior behaviour)
	{
	}

	public override void UpdateEvent(T0WorldInteractionBehavior behaviour)
	{
	}

	public override void DisposeEvent()
	{
	}
}
