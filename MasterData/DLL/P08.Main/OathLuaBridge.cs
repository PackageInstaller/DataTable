using Oath;

public static class OathLuaBridge
{
	public static void Launcher(string sceneName, int oathCharacterID, int sceneMode)
	{
		OathSceneLoader oathSceneLoader = NScene.Load<OathSceneLoader>();
		oathSceneLoader.context.sceneName = sceneName;
		oathSceneLoader.context.characterID = oathCharacterID;
		oathSceneLoader.context.sceneMode = (OathConst.OathSceneMode)sceneMode;
	}

	public static void ChangeCapturePose(int filterType, string poseName)
	{
		if (OathSceneLoader.Scene.context.captureManager != null)
		{
			OathSceneLoader.Scene.context.captureManager.ChangeCapturePose(filterType, poseName);
		}
	}

	public static void InvokeSkip()
	{
		OathSceneLoader.Scene.context.interationManager.InvokeSkip();
	}
}
