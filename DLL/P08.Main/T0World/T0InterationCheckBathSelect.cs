using System;

namespace T0World;

[Serializable]
public class T0InterationCheckBathSelect : T0InterationBaseData
{
	public HorusBathCharacterEnum checkSelectBathType = HorusBathCharacterEnum.RANDOM;

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
		if ((T0WorldScene.Scene.dataContext as T0WorldDataContext_Horus).bathSelect == checkSelectBathType)
		{
			return true;
		}
		return false;
	}
}
