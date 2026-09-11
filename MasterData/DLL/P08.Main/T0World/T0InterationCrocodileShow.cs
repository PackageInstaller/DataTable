using System;

namespace T0World;

[Serializable]
public class T0InterationCrocodileShow : T0InterationBaseData
{
	public bool isShow = true;

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		if (isShow)
		{
			T0CrocodileGame.crocodileGame.OpenSelectView();
		}
		else
		{
			T0CrocodileGame.crocodileGame.CloseSelectView();
		}
		base.IsFinish = true;
	}
}
