using System.Collections.Generic;
using UnityEngine;

namespace SkuldPuzzleGame;

public class SkuldPuzzleChipBlockManager : MonoBehaviour
{
	public GameObject chipBlockPrefab;

	public Transform chipContent;

	private List<SkuldPuzzleChipBlockEntity> chipBlockList;

	public void CreateStageChipBlockData(List<SkuldPuzzleChipBlockData> chipStageList)
	{
		DisposeChipBlock();
		chipBlockList = new List<SkuldPuzzleChipBlockEntity>();
		chipBlockList.Clear();
		foreach (SkuldPuzzleChipBlockData chipStage in chipStageList)
		{
			GenerateChipBlock(chipStage);
		}
	}

	public void GenerateChipBlock(SkuldPuzzleChipBlockData blockData = null)
	{
		SkuldPuzzleChipBlockEntity component = Object.Instantiate(chipBlockPrefab, chipContent).GetComponent<SkuldPuzzleChipBlockEntity>();
		if (blockData != null)
		{
			component.InitChipBlockData(blockData);
		}
		if (chipBlockList != null)
		{
			chipBlockList.Add(component);
		}
	}

	public List<SkuldPuzzleChipBlockEntity> GetChipBlockList()
	{
		return chipBlockList;
	}

	public SkuldPuzzleChipBlockEntity GetChipBlockByID(int chipID)
	{
		foreach (SkuldPuzzleChipBlockEntity chipBlock in chipBlockList)
		{
			if (chipBlock.GetChipBlockData().chipID == chipID)
			{
				return chipBlock;
			}
		}
		return null;
	}

	public void OpenStoryMode(bool open)
	{
		if (chipBlockList == null)
		{
			return;
		}
		if (open)
		{
			SkuldPuzzleGameManager.Instance.mapBlockManager.HideErrorTip();
			foreach (SkuldPuzzleChipBlockEntity chipBlock in chipBlockList)
			{
				chipBlock.ExitMapBlaock();
			}
			SkuldPuzzleGameManager.Instance.mapBlockManager.ResetTileDefaultState();
		}
		foreach (SkuldPuzzleChipBlockEntity chipBlock2 in chipBlockList)
		{
			chipBlock2.OpenStoryMode(open);
		}
		SkuldPuzzleGameManager.Instance.conditionManager.UpdateConditionStatus();
	}

	public void ResetGame()
	{
		if (chipBlockList == null)
		{
			return;
		}
		foreach (SkuldPuzzleChipBlockEntity chipBlock in chipBlockList)
		{
			if (!chipBlock.isStoryMode)
			{
				chipBlock.ExitMapBlaock(isStoryMode: false);
			}
		}
		SkuldPuzzleGameManager.Instance.mapBlockManager.ResetTileDefaultState();
		SkuldPuzzleGameManager.Instance.mapBlockManager.HideExpectNode(isShow: false);
	}

	public void Dispose()
	{
		DisposeChipBlock();
	}

	public void DisposeChipBlock()
	{
		if (chipBlockList == null)
		{
			return;
		}
		foreach (SkuldPuzzleChipBlockEntity chipBlock in chipBlockList)
		{
			if (chipBlock != null)
			{
				chipBlock.Dispose();
			}
		}
		chipBlockList.Clear();
		chipBlockList = null;
	}
}
