using T0World;

namespace Oath;

public class OathMobileCameraHandler : T0MobileCameraHandler
{
	public override void BackToNormalState()
	{
		OathSceneLoader.Scene.context.captureViewUI?.ChangeViewMode(OathCaptureModeStateEnum.photo);
	}
}
