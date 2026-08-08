using System;

namespace T0World;

[Serializable]
public class T0InterationCookCheckSelect : T0InterationBaseData
{
	public HorusCookSelectEnum checkSelectType = HorusCookSelectEnum.NONE;

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		if (CheckIsMeet())
		{
			base.IsFinish = true;
		}
	}

	private bool CheckIsMeet()
	{
		if ((T0WorldScene.Scene.dataContext as T0WorldDataContext_Horus).cookSelectType == checkSelectType)
		{
			return true;
		}
		return false;
	}
}
