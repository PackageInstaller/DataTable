using SkuldPuzzleGame;
using UnityEngine;

public static class SkuldPuzzleBrige
{
	public static void StartGame(string stageID, GameObject stagePrefab, SkuldPuzzleConditionDataList conditonList)
	{
		SkuldPuzzleGameManager component = stagePrefab.GetComponent<SkuldPuzzleGameManager>();
		component.StartGame(stageID);
		component.conditionManager.InitConditionDataList(conditonList);
	}

	public static void OpenStoryMode(bool isOpen)
	{
		SkuldPuzzleGameManager.Instance.chipBlockManager.OpenStoryMode(isOpen);
	}

	public static void ResetGame()
	{
		SkuldPuzzleGameManager.Instance.chipBlockManager.ResetGame();
	}

	public static void ExitGame()
	{
		SkuldPuzzleGameManager.Instance.ExitGame();
	}

	public static float GetUseTimes()
	{
		return SkuldPuzzleGameManager.Instance.GetTimes();
	}

	public static void PauseGame(bool flag)
	{
		SkuldPuzzleGameManager.Instance.PauseGame(flag);
	}

	public static bool CheckIsHaveDragging()
	{
		if (SkuldPuzzleGameManager.Instance.dragChipEntityID < 0)
		{
			return false;
		}
		return true;
	}
}
