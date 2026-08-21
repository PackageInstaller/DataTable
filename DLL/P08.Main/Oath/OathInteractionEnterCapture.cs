using System;

namespace Oath;

[Serializable]
public class OathInteractionEnterCapture : OathInteractionNode
{
	public override void StartEvent()
	{
		base.IsFinish = true;
	}

	public override void AddChildEvent()
	{
		OathSceneLoader.Scene.ChangeToCaptureMode();
	}
}
