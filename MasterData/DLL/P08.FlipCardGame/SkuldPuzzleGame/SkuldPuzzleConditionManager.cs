using System.Collections.Generic;
using UnityEngine;

namespace SkuldPuzzleGame;

public class SkuldPuzzleConditionManager : MonoBehaviour
{
	private SkuldPuzzleConditionData[] conditonDataList;

	private bool[] conditonBoolList;

	private int[] conditonNumList;

	private bool[] moveChipIDBook;

	private bool[] aimvalueBook;

	public void InitConditionDataList(SkuldPuzzleConditionDataList skuldPuzzleConditionDataList)
	{
		conditonDataList = skuldPuzzleConditionDataList.conditonList;
		conditonBoolList = new bool[conditonDataList.Length];
		for (int i = 0; i < conditonDataList.Length; i++)
		{
			conditonBoolList[i] = false;
		}
		conditonNumList = new int[conditonDataList.Length];
		List<SkuldPuzzleChipBlockEntity> chipBlockList = SkuldPuzzleGameManager.Instance.chipBlockManager.GetChipBlockList();
		moveChipIDBook = new bool[chipBlockList.Count + 1];
		aimvalueBook = new bool[chipBlockList.Count + 1];
		SetDefaultBookData();
		UpdateConditionStatus();
	}

	public void SetDefaultBookData()
	{
		for (int i = 0; i < moveChipIDBook.Length; i++)
		{
			moveChipIDBook[i] = false;
		}
		for (int j = 0; j < aimvalueBook.Length; j++)
		{
			aimvalueBook[j] = false;
		}
	}

	public void UpdateConditionStatus()
	{
		for (int i = 0; i < conditonDataList.Length; i++)
		{
			SkuldPuzzleConditionData skuldPuzzleConditionData = conditonDataList[i];
			bool flag = false;
			int conditonNum = 0;
			switch ((ConditionType)skuldPuzzleConditionData.conditionType)
			{
			case ConditionType.FinishChip:
				flag = UpdateFinishChipCondition(skuldPuzzleConditionData);
				break;
			case ConditionType.Color:
				flag = UpdateColorCondition(skuldPuzzleConditionData, out conditonNum);
				break;
			case ConditionType.ChipBlock:
				flag = UpdateChipBlockCondition(skuldPuzzleConditionData, out conditonNum);
				break;
			}
			conditonBoolList[i] = flag;
			conditonNumList[i] = conditonNum;
		}
		LuaHelper.CallFunction("SkuldPuzzleToluaBridge.UpdatePuzzleConditionData", conditonBoolList, conditonNumList);
	}

	public bool UpdateFinishChipCondition(SkuldPuzzleConditionData conditonData)
	{
		List<SkuldPuzzleChipBlockEntity> chipBlockList = SkuldPuzzleGameManager.Instance.chipBlockManager.GetChipBlockList();
		bool flag = true;
		foreach (SkuldPuzzleChipBlockEntity item in chipBlockList)
		{
			flag = item.isFillInMap;
			if (!flag)
			{
				break;
			}
		}
		return flag;
	}

	public bool UpdateColorCondition(SkuldPuzzleConditionData conditonData, out int conditonNum)
	{
		SkuldPuzzleChipBlockEntity chipBlockByID = SkuldPuzzleGameManager.Instance.chipBlockManager.GetChipBlockByID(conditonData.chipID);
		conditonNum = 0;
		if (!chipBlockByID.isFillInMap)
		{
			return false;
		}
		SetDefaultBookData();
		int aimCount = conditonData.aimCount;
		int num = 0;
		bool flag = false;
		int[] aimList = conditonData.aimList;
		foreach (int num2 in aimList)
		{
			aimvalueBook[num2] = true;
		}
		moveChipIDBook[chipBlockByID.GetChipBlockByID()] = true;
		foreach (SkuldPuzzleTileData tileData in chipBlockByID.tileDataList)
		{
			SkuldPuzzleTools.CalculateTrueTileIndex(chipBlockByID.originX, chipBlockByID.originY, tileData.x, tileData.y, chipBlockByID.GetRotateAngle(), out var x, out var y);
			foreach (Vector2Int roundNext in SkuldPuzzleConst.RoundNextList)
			{
				int chipX = x + roundNext.x;
				int chipY = y + roundNext.y;
				SkuldPuzzleMapBlockEntity tileEntityByXY = SkuldPuzzleGameManager.Instance.mapBlockManager.GetTileEntityByXY(chipX, chipY);
				if (!(tileEntityByXY != null))
				{
					continue;
				}
				int fillChipID = tileEntityByXY.GetFillChipID();
				if (fillChipID <= 0 || moveChipIDBook[fillChipID])
				{
					continue;
				}
				SkuldPuzzleChipBlockEntity chipBlockByID2 = SkuldPuzzleGameManager.Instance.chipBlockManager.GetChipBlockByID(fillChipID);
				if (chipBlockByID2 != null && aimvalueBook[(int)chipBlockByID2.GetColorType()])
				{
					moveChipIDBook[fillChipID] = true;
					num++;
					if (num >= aimCount)
					{
						flag = true;
						break;
					}
				}
			}
			if (flag)
			{
				break;
			}
		}
		conditonNum = num;
		return flag;
	}

	public bool UpdateChipBlockCondition(SkuldPuzzleConditionData conditonData, out int conditonNum)
	{
		SkuldPuzzleChipBlockEntity chipBlockByID = SkuldPuzzleGameManager.Instance.chipBlockManager.GetChipBlockByID(conditonData.chipID);
		conditonNum = 0;
		if (!chipBlockByID.isFillInMap)
		{
			return false;
		}
		SetDefaultBookData();
		int aimCount = conditonData.aimCount;
		int num = 0;
		bool flag = false;
		int[] aimList = conditonData.aimList;
		foreach (int num2 in aimList)
		{
			aimvalueBook[num2] = true;
		}
		moveChipIDBook[chipBlockByID.GetChipBlockByID()] = true;
		foreach (SkuldPuzzleTileData tileData in chipBlockByID.tileDataList)
		{
			SkuldPuzzleTools.CalculateTrueTileIndex(chipBlockByID.originX, chipBlockByID.originY, tileData.x, tileData.y, chipBlockByID.GetRotateAngle(), out var x, out var y);
			foreach (Vector2Int roundNext in SkuldPuzzleConst.RoundNextList)
			{
				int chipX = x + roundNext.x;
				int chipY = y + roundNext.y;
				SkuldPuzzleMapBlockEntity tileEntityByXY = SkuldPuzzleGameManager.Instance.mapBlockManager.GetTileEntityByXY(chipX, chipY);
				if (!(tileEntityByXY != null))
				{
					continue;
				}
				int fillChipID = tileEntityByXY.GetFillChipID();
				if (fillChipID > 0 && !moveChipIDBook[fillChipID] && aimvalueBook[fillChipID])
				{
					moveChipIDBook[fillChipID] = true;
					num++;
					if (num >= aimCount)
					{
						flag = true;
						break;
					}
				}
			}
			if (flag)
			{
				break;
			}
		}
		conditonNum = num;
		return flag;
	}

	public void Dispose()
	{
		conditonBoolList = null;
		conditonDataList = null;
		moveChipIDBook = null;
		aimvalueBook = null;
		conditonNumList = null;
	}
}
