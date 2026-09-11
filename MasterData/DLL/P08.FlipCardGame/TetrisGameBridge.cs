using LuaInterface;
using TetrisGame;
using UnityEngine;

public static class TetrisGameBridge
{
	public static void StartGame(string stageID, GameObject stagePrefab, int roundChipNum = 3)
	{
		TetrisGameManager component = stagePrefab.GetComponent<TetrisGameManager>();
		component.InitRunTime(stageID, roundChipNum);
		component.StartGame();
	}

	public static void SetSkillInfo(TetrisGameExchange data)
	{
		TetrisGameManager.Instance.InitSkillInfo(data);
	}

	public static void SetGuideInfo(TetrisGameGuideInfo info)
	{
		TetrisGameManager.Instance.InitGuideInfo(info);
	}

	public static bool RefreshAllWaitChip(bool force = false)
	{
		if (force)
		{
			TetrisGameManager.Instance.chipManager.GenerateRandomChip();
			return true;
		}
		if (TetrisGameManager.Instance.chipManager.GetCurDicChipNum() <= 0)
		{
			TetrisGameManager.Instance.chipManager.GenerateRandomChip();
			return true;
		}
		return false;
	}

	public static bool CheckNeedRefreshAllWaitChip()
	{
		if (TetrisGameManager.Instance.chipManager.GetCurDicChipNum() <= 0)
		{
			return true;
		}
		return false;
	}

	public static bool CheckCanPlaceWaitChip()
	{
		return TetrisGameManager.Instance.tileManager.CheckCanPlaceWaitChip();
	}

	public static void PauseGame(bool flag)
	{
		TetrisGameManager.Instance.PauseGame(flag);
	}

	public static void ExitGame()
	{
		TetrisGameManager.Instance.DisposeStage();
	}

	public static void OverGameEnd()
	{
		TetrisGameManager.Instance.tileManager.GameLoseOver();
	}

	public static bool CheckIsHaveDragging()
	{
		return TetrisGameManager.Instance.chipManager.CheckIsHaveDragging();
	}

	[NoToLua]
	public static void PlaceChip(int funNum, int cellNum, int disposeNum)
	{
		LuaHelper.CallFunction("TetrisGmaePlaceChip", funNum, cellNum, disposeNum);
	}

	public static void RefreshSpecificChip(int[] chipIndexList)
	{
		TetrisGameManager.Instance.chipManager.GenerateSpecificChip(chipIndexList);
	}

	public static void RotateChip(int chipPosIndex)
	{
		TetrisGameManager.Instance.chipManager.RotateChip(chipPosIndex);
	}

	public static void SetMachineInfoState(bool state)
	{
		TetrisGameManager.Instance.SetMachineStage(state);
	}

	public static void SetLockChip(int chipPosIndex)
	{
		TetrisGameManager.Instance.SetLockChip(chipPosIndex);
	}
}
