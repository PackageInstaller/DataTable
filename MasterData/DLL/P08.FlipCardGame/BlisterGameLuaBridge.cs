using ZumaGame;

public class BlisterGameLuaBridge
{
	public static void Launcher(string mapName)
	{
		NScene.Load<BlisterGameSceneLoader>().SetGameConfig(mapName);
	}

	public static void StartGame()
	{
		(NScene.GetCurrentScene() as BlisterGameSceneLoader)?.StartGame();
	}

	public static float GetCurTime()
	{
		BlisterGameSceneLoader blisterGameSceneLoader = NScene.GetCurrentScene() as BlisterGameSceneLoader;
		if (!(blisterGameSceneLoader != null))
		{
			return 0f;
		}
		return blisterGameSceneLoader.GetCurTime();
	}

	public static void PauseGame()
	{
		(NScene.GetCurrentScene() as BlisterGameSceneLoader)?.PauseGame();
	}

	public static void ReStartGame()
	{
		(NScene.GetCurrentScene() as BlisterGameSceneLoader).ReStartGame();
	}

	public static bool IsInAnim()
	{
		return BlisterController.Instance.IsInAnim();
	}
}
