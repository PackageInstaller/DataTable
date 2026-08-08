using System;

namespace T0World;

[Serializable]
public class T0InterationExitCurrent : T0InterationFunctionDataBase
{
	public bool isRegisterExitEvent = true;

	public bool isLinkMainLine;

	public override bool isNeedSDK => true;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		if (isRegisterExitEvent)
		{
			T0WorldScene.Scene.dataContext.ExitRegisteEvent = this;
		}
		else
		{
			T0WorldScene.Scene.dataContext.ExitRegisteEvent = null;
		}
		if (isLinkMainLine)
		{
			base.IsFinish = true;
		}
	}

	public override void FinishEvent(T0WorldInteractionBehavior behaviour)
	{
		T0WorldScene.Scene.dataContext.ExitRegisteEvent = null;
	}

	public override void SendSDK(T0WorldInteractionBehavior behaviour)
	{
		if (isRegisterExitEvent)
		{
			T0SDKData baseSDKData = GetBaseSDKData();
			baseSDKData.sdkType = 10;
			T0SDKSystem.SendSDKData(behaviour, baseSDKData);
		}
	}
}
