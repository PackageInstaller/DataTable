using TangramGame;
using UnityEngine;

public static class TangramGameBridge
{
	public static void InitGame(GameObject stagePrefab)
	{
		TangramManager.Instance.Init();
		TangramManager.Instance.InitPrefab(stagePrefab);
	}

	public static void StartStage(TangramDataExchange data, string stageID)
	{
		TangramManager.Instance.StartStage(data.finfishList, stageID);
	}

	public static void DisposeStage()
	{
		TangramManager.Instance.Dispose(retainTile: true);
	}

	public static void FinishStage(string stageID)
	{
		LuaHelper.CallFunction("FinishTangramGame");
	}

	public static void FinishStageChip(int chipIndex)
	{
		LuaHelper.CallFunction("FinishTangramGameChip", chipIndex);
	}

	public static void ResetAllStageChip()
	{
		TangramManager.Instance.curStageManager.chipManager.ResetAllStageChip();
	}

	public static void RotateChip()
	{
	}
}
