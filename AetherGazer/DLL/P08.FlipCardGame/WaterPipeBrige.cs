using UnityEngine;
using WaterPipeGame;

public static class WaterPipeBrige
{
	public static void StartGame(int stageID, int[] eventOrderSort, GameObject stagePrefab)
	{
		WaterPipeGameManager component = stagePrefab.GetComponent<WaterPipeGameManager>();
		component.StartGame(stageID);
		component.SetEventOrderSort(eventOrderSort);
		component.CheckStageFinish();
	}

	public static void PauseGame(bool flag)
	{
		WaterPipeGameManager.Instance.PauseGame(flag);
	}

	public static void ExitGame()
	{
		WaterPipeGameManager.Instance.ExitGame();
	}

	public static void DisposeGame()
	{
		WaterPipeGameManager.Instance.DisposeGame();
	}

	public static void PlayHeroBeginMove()
	{
		WaterPipeGameManager.Instance.pipeHeroManager.BeginMove();
	}

	public static float GetUseTimes()
	{
		return WaterPipeGameManager.Instance.GetTimes();
	}
}
