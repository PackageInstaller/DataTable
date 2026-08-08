using System;

namespace Capture.Runtime;

public static class CaptureGameLuaBridge
{
	public static void Launcher(CaptureGameDataForExchange captureGameDataForExchange, Action callback)
	{
		callback?.Invoke();
		NScene.Load<CaptureScene>().sceneCtx = captureGameDataForExchange;
	}
}
