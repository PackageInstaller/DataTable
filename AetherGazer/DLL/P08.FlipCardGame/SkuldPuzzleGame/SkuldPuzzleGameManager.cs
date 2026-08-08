using System.Collections.Generic;
using UnityEngine;

namespace SkuldPuzzleGame;

public class SkuldPuzzleGameManager : MonoBehaviour
{
	private float times;

	private bool isPause;

	public string stageID;

	[HideInInspector]
	public int width;

	[HideInInspector]
	public int height;

	public SkuldPuzzleMapBlockManager mapBlockManager;

	public SkuldPuzzleChipBlockManager chipBlockManager;

	public SkuldPuzzleBanLineManager banLineManager;

	public SkuldPuzzleConditionManager conditionManager;

	public bool isFillingInMap;

	public int dragChipEntityID = -1;

	private static SkuldPuzzleGameManager _instance;

	private List<SkuldPuzzleShapeChipData> shapeTemplateList;

	public static SkuldPuzzleGameManager Instance => _instance;

	private void Awake()
	{
		_instance = this;
		InitShapeTemplateList();
	}

	public void Update()
	{
		if (!isPause)
		{
			times += Time.deltaTime;
		}
	}

	public float GetTimes()
	{
		return times;
	}

	public void PauseGame(bool flag)
	{
		isPause = flag;
	}

	public void StartGame(string stageID)
	{
		SkuldPuzzleStageSaveData skuldPuzzleStageSaveData = SkuldPuzzleTools.LoadStageData(stageID);
		times = 0f;
		isPause = false;
		width = skuldPuzzleStageSaveData.width;
		height = skuldPuzzleStageSaveData.height;
		isFillingInMap = false;
		SetDragChipEntityID(-1);
		mapBlockManager.CreateStage(skuldPuzzleStageSaveData);
		chipBlockManager.CreateStageChipBlockData(skuldPuzzleStageSaveData.chipList);
		banLineManager.CreateStageBanLineData(skuldPuzzleStageSaveData);
		bool flag = SkuldPuzzleTools.CheckIsHaveStoryMode(skuldPuzzleStageSaveData);
		LuaHelper.CallFunction("SkuldPuzzleToluaBridge.InitPuzzleStageMapData", width, height, flag);
	}

	public bool IsCanDragChip(int chipEntityID)
	{
		if (chipEntityID == dragChipEntityID)
		{
			return true;
		}
		if (dragChipEntityID == -1)
		{
			return true;
		}
		return false;
	}

	public void SetDragChipEntityID(int chipEntityID)
	{
		dragChipEntityID = chipEntityID;
	}

	private void InitShapeTemplateList()
	{
		if (shapeTemplateList == null)
		{
			SkuldPuzzleShapeChipAllSaveData skuldPuzzleShapeChipAllSaveData = SkuldPuzzleTools.LoadShapeChipData();
			shapeTemplateList = skuldPuzzleShapeChipAllSaveData.shapeList;
		}
	}

	public SkuldPuzzleShapeChipData GetShapeTemplate(int shapeTemplateId)
	{
		foreach (SkuldPuzzleShapeChipData shapeTemplate in shapeTemplateList)
		{
			if (shapeTemplate.shapeTemplateId == shapeTemplateId)
			{
				return shapeTemplate;
			}
		}
		return null;
	}

	public void ExitGame()
	{
		DisposeGame();
	}

	public void DisposeGame()
	{
		mapBlockManager.Dispose();
		chipBlockManager.Dispose();
		banLineManager.Dispose();
		conditionManager.Dispose();
		shapeTemplateList.Clear();
		shapeTemplateList = null;
		_instance = null;
	}
}
