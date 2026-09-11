using System;

namespace T0World;

[Serializable]
public class T0InterationCrocodileWaitSelect : T0InterationBaseData
{
	public override bool isNeedSDK => true;

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		T0CrocodileGame.crocodileGame.SetWaitSelectEventData(this);
	}

	public override void SendSDK(T0WorldInteractionBehavior behaviour)
	{
		if (!(T0CrocodileGame.crocodileGame == null))
		{
			string waitSelectSDKStr = T0CrocodileGame.crocodileGame.GetWaitSelectSDKStr();
			int currentPressIndex = T0CrocodileGame.crocodileGame.GetCurrentPressIndex();
			T0SDKData baseSDKData = GetBaseSDKData();
			baseSDKData.select_param = currentPressIndex.ToString();
			baseSDKData.select_list = waitSelectSDKStr;
			T0SDKSystem.SendSDKData(behaviour, baseSDKData);
		}
	}
}
