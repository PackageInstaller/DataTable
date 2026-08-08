using T0World;

namespace Oath;

public class OathCaptureCameraController : T0CaptureCameraController
{
	public override void Init(T0CaptureCameraLogic cameraLogic)
	{
		logic = cameraLogic;
		curLogicHandler = new OathStandaloneCameraHandler();
		curLogicHandler.InitHandler(this);
	}
}
