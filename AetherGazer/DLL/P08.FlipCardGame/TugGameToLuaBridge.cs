using TetrisGame;

public static class TugGameToLuaBridge
{
	public static TugGameData LoadConfig(string stagePrefabPath)
	{
		return TugGameControl.Instance.LoadAsset(stagePrefabPath);
	}

	public static void StartGame(string stageID, string stagePrefabPath, int roundChipNum = 3)
	{
		TugGameControl.Instance.StartGame();
	}

	public static void EndGame()
	{
	}

	public static void PauseGame(bool flag)
	{
		TetrisGameManager.Instance.PauseGame(flag);
	}

	public static void SetTugGameObjectPosition()
	{
	}
}
