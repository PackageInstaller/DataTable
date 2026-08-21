using System;

namespace T0World;

[Serializable]
public class T0InterationCookCheckHandle : T0InterationBaseData
{
	public T0CookViewHandleType handleType = T0CookViewHandleType.CLICK_SURE;

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		T0CookSelectView.cookGame.RegisterInteration(this);
	}

	public void CheckCookHandleFinish(T0CookViewHandleType type)
	{
		if (type == handleType)
		{
			base.IsFinish = true;
		}
	}
}
