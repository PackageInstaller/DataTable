using System;
using System.Collections.Generic;
using UnityEngine;

namespace WaterPipeGame;

public class WaterPipeItemManager : MonoBehaviour
{
	[SerializeField]
	private WaterPipeGameManager gameManager;

	private WaterPipeMapEntity[] waterPipeMapEntites;

	private WaterPipePathEntity[] waterPipePathEntites;

	private WaterPipeEventEntity[] waterPipeEventEntites;

	private int[] eventOrderSort;

	private Dictionary<int, int> eventOrderToIndexDic;

	public GameObject waterPipeMapPrefab;

	public GameObject waterPipePathPrefab;

	[SerializeField]
	private Transform mapContent;

	[SerializeField]
	private Transform pathContent;

	[SerializeField]
	private Transform eventContent;

	private int enterIndex;

	private int endIndex;

	private bool[] pipeLinkArray;

	private bool[] passPipeArray;

	private int[] pipeEventIDArray;

	public WaterPipeMapEntity GetMapEntityByIndex(int index)
	{
		return waterPipeMapEntites[index];
	}

	public WaterPipeEventEntity GetMapEventByIndex(int index)
	{
		return waterPipeEventEntites[index];
	}

	public int GetMapEventEntityPreIndexByIndex(int index)
	{
		if (waterPipeEventEntites[index] == null)
		{
			return -1;
		}
		_ = pipeEventIDArray[index];
		int order = waterPipeEventEntites[index].GetOrder();
		if (eventOrderToIndexDic.ContainsKey(order - 1))
		{
			return eventOrderToIndexDic[order - 1];
		}
		return -1;
	}

	public void ClearMapData()
	{
		if (waterPipeMapEntites != null)
		{
			WaterPipeMapEntity[] array = waterPipeMapEntites;
			foreach (WaterPipeMapEntity waterPipeMapEntity in array)
			{
				if (waterPipeMapEntity != null)
				{
					waterPipeMapEntity.Dispose();
				}
			}
		}
		waterPipeMapEntites = null;
		if (waterPipePathEntites != null)
		{
			WaterPipePathEntity[] array2 = waterPipePathEntites;
			foreach (WaterPipePathEntity waterPipePathEntity in array2)
			{
				if (waterPipePathEntity != null)
				{
					waterPipePathEntity.Dispose();
				}
			}
		}
		waterPipePathEntites = null;
		if (waterPipeEventEntites != null)
		{
			WaterPipeEventEntity[] array3 = waterPipeEventEntites;
			foreach (WaterPipeEventEntity waterPipeEventEntity in array3)
			{
				if (waterPipeEventEntity != null)
				{
					waterPipeEventEntity.Dispose();
				}
			}
		}
		waterPipeEventEntites = null;
	}

	public void LoadStage(WaterPipeItemSaveData[] pipeItemDataArray)
	{
		pipeLinkArray = new bool[gameManager.width * gameManager.height];
		GenerateStage();
		for (int i = 0; i < pipeItemDataArray.Length; i++)
		{
			WaterPipeItemSaveData waterPipeItemSaveData = pipeItemDataArray[i];
			waterPipeMapEntites[i].InitData(waterPipeItemSaveData, i);
			if (waterPipeItemSaveData.pipeType == PipeType.ENTER)
			{
				enterIndex = i;
				pipeLinkArray[i] = true;
			}
			else if (waterPipeItemSaveData.pipeType == PipeType.END)
			{
				endIndex = i;
			}
		}
		if (gameManager.gameState != GameState.EDIT)
		{
			GenerateEventEntity();
		}
		gameManager.pipeHeroManager.InitPos(waterPipeMapEntites[enterIndex].transform.localPosition);
		InitEventPipeLink();
	}

	public void GenerateEventEntity()
	{
		waterPipeEventEntites = new WaterPipeEventEntity[gameManager.width * gameManager.height];
		for (int i = 0; i < waterPipeMapEntites.Length; i++)
		{
			WaterPipeItemSaveData pipeData = waterPipeMapEntites[i].GetPipeData();
			if (pipeData.pipeType >= PipeType.ENTER && pipeData.pipeType <= PipeType.NPC)
			{
				WaterPipeEventEntity component = UnityEngine.Object.Instantiate(gameManager.pipeEventManager.CreateEventEntityByEventType(pipeData.pipeType), eventContent).GetComponent<WaterPipeEventEntity>();
				waterPipeEventEntites[i] = component;
				component.transform.position = waterPipeMapEntites[i].transform.position;
				component.InitData(pipeData);
			}
			else
			{
				waterPipeEventEntites[i] = null;
			}
		}
	}

	public void SetEventOrderSort(int[] eventOrderSort)
	{
		this.eventOrderSort = eventOrderSort;
		eventOrderToIndexDic = new Dictionary<int, int>();
		for (int i = 0; i < waterPipeMapEntites.Length; i++)
		{
			WaterPipeItemSaveData pipeData = waterPipeMapEntites[i].GetPipeData();
			if (waterPipeEventEntites[i] != null && pipeData.pipeType != PipeType.ENTER)
			{
				int value = pipeEventIDArray[i];
				int num = Array.IndexOf(eventOrderSort, value);
				waterPipeEventEntites[i].SetOrder(num);
				eventOrderToIndexDic.Add(num, i);
			}
		}
	}

	public void GeneratePathEntity(List<int> movePathList)
	{
		waterPipePathEntites = new WaterPipePathEntity[gameManager.width * gameManager.height];
		int num = movePathList[0];
		int num2 = movePathList[1];
		for (int i = 2; i < movePathList.Count; i++)
		{
			WaterPipePathEntity component = UnityEngine.Object.Instantiate(waterPipePathPrefab, pathContent).GetComponent<WaterPipePathEntity>();
			waterPipePathEntites[num] = component;
			component.transform.position = waterPipeMapEntites[num2].transform.position;
			int num3 = movePathList[i];
			component.UpdateImg(num, num2, num3);
			num = num2;
			num2 = num3;
		}
	}

	public void GenerateStage()
	{
		GenerateNewStageInfo();
	}

	public void GenerateNewStageInfo()
	{
		float num = (float)gameManager.width * 0.5f;
		_ = gameManager.width;
		float num2 = (float)gameManager.cubeSize * 0.5f;
		waterPipeMapEntites = new WaterPipeMapEntity[gameManager.width * gameManager.height];
		for (int i = 0; gameManager.height > i; i++)
		{
			for (int j = 0; gameManager.width > j; j++)
			{
				WaterPipeMapEntity component = UnityEngine.Object.Instantiate(waterPipeMapPrefab, mapContent).GetComponent<WaterPipeMapEntity>();
				waterPipeMapEntites[j + i * gameManager.width] = component;
				component.transform.localPosition = new Vector2(((float)j - num) * (float)gameManager.cubeSize + num2, -i * gameManager.cubeSize + 2 * gameManager.cubeSize);
			}
		}
	}

	public WaterPipeItemSaveData[] GetSaveData()
	{
		WaterPipeItemSaveData[] array = new WaterPipeItemSaveData[gameManager.width * gameManager.height];
		if (waterPipeMapEntites != null)
		{
			for (int i = 0; i < waterPipeMapEntites.Length; i++)
			{
				array[i] = waterPipeMapEntites[i].GetSaveData();
			}
		}
		return array;
	}

	public void InitEventPipeLink()
	{
		if (pipeEventIDArray == null)
		{
			pipeEventIDArray = new int[gameManager.width * gameManager.height];
			for (int i = 0; i < waterPipeMapEntites.Length; i++)
			{
				pipeEventIDArray[i] = waterPipeMapEntites[i].eventID;
			}
			LuaHelper.CallFunction("InitWaterPipeEventList", pipeEventIDArray);
		}
	}

	public void CheckStageFinish(int pipeIndex = -1)
	{
		if (passPipeArray == null)
		{
			passPipeArray = new bool[gameManager.width * gameManager.height];
		}
		for (int i = 0; i < waterPipeMapEntites.Length; i++)
		{
			passPipeArray[i] = false;
		}
		CheckIsLink(enterIndex);
		for (int j = 0; j < passPipeArray.Length; j++)
		{
			if (!passPipeArray[j])
			{
				pipeLinkArray[j] = false;
				waterPipeMapEntites[j].SetLink(isLink: false);
			}
		}
		SetRightLinkState(pipeIndex);
		LuaHelper.CallFunction("UpdateWaterPipeEventLinkData", pipeLinkArray);
		bool flag = false;
		if (waterPipeEventEntites[endIndex] != null && waterPipeEventEntites[endIndex].GetLink())
		{
			flag = true;
		}
		if (flag && gameManager.gameState == GameState.PLAYING)
		{
			gameManager.gameState = GameState.SHOWING;
			List<int> movePathList = WaterPipeTools.GetMovePathList(waterPipeMapEntites, enterIndex, endIndex);
			gameManager.pipeHeroManager.InitMovePathList(movePathList);
			GeneratePathEntity(movePathList);
		}
	}

	public void SetRightLinkState(int pipeIndex)
	{
		for (int i = 0; i < waterPipeMapEntites.Length; i++)
		{
			waterPipeMapEntites[i].ChangeState(isRightLink: false);
		}
		for (int j = 0; j < eventOrderToIndexDic.Count; j++)
		{
			int num = eventOrderToIndexDic[j];
			if (waterPipeEventEntites[num] != null)
			{
				waterPipeEventEntites[num].SetLink(isLink: false);
				pipeLinkArray[num] = false;
			}
		}
		for (int k = 0; k < eventOrderToIndexDic.Count; k++)
		{
			int num2 = eventOrderToIndexDic[k];
			if (waterPipeMapEntites[num2].GetPipeData().pipeType == PipeType.ENTER || !waterPipeMapEntites[num2].IsLink())
			{
				continue;
			}
			List<int> movePathList = WaterPipeTools.GetMovePathList(waterPipeMapEntites, enterIndex, num2);
			bool flag = true;
			if (eventOrderToIndexDic.ContainsKey(k - 1))
			{
				int item = eventOrderToIndexDic[k - 1];
				flag = movePathList.Contains(item);
			}
			if (flag)
			{
				for (int l = k + 1; l < eventOrderToIndexDic.Count; l++)
				{
					int item2 = eventOrderToIndexDic[l];
					flag = !movePathList.Contains(item2);
					if (!flag)
					{
						break;
					}
				}
			}
			if (!flag)
			{
				break;
			}
			pipeLinkArray[num2] = true;
			waterPipeEventEntites[num2].SetLink(isLink: true);
			for (int m = 0; m < movePathList.Count; m++)
			{
				waterPipeMapEntites[movePathList[m]].ChangeState(isRightLink: true);
				if (movePathList[m] == pipeIndex)
				{
					AudioManager.Instance.Play("effect", "minigame_activity_3_9", "minigame_activity_3_9_pipe_success", useStream: false);
				}
			}
		}
	}

	public void CheckIsLink(int pipeIndex)
	{
		passPipeArray[pipeIndex] = true;
		WaterPipeMapEntity waterPipeMapEntity = waterPipeMapEntites[pipeIndex];
		PipeType pipeType = waterPipeMapEntity.pipeType;
		if (pipeType == PipeType.NONE)
		{
			return;
		}
		DIR dir = waterPipeMapEntity.dir;
		DIR[] array = ((!WaterPipeConst.pipeTypeDir.ContainsKey(pipeType)) ? WaterPipeConst.pipeTypeDir[PipeType.DEFAULT] : WaterPipeConst.pipeTypeDir[pipeType]);
		for (int i = 0; i < array.Length; i++)
		{
			DIR dIR = WaterPipeTools.RotateDir(array[i], (int)(dir - 1));
			int linkDirIndex = WaterPipeTools.GetLinkDirIndex(dIR, pipeIndex);
			if (linkDirIndex >= 0 && linkDirIndex < waterPipeMapEntites.Length && waterPipeMapEntites[linkDirIndex].pipeType != PipeType.NONE && !passPipeArray[linkDirIndex])
			{
				bool flag = false;
				if (pipeLinkArray[pipeIndex])
				{
					flag = WaterPipeTools.IsCanLinkPipe(dIR, waterPipeMapEntites[linkDirIndex]);
				}
				if (flag)
				{
					pipeLinkArray[linkDirIndex] = flag;
					waterPipeMapEntites[linkDirIndex].SetLink(flag);
					CheckIsLink(linkDirIndex);
				}
			}
		}
	}

	public void ExitGame()
	{
		ClearMapData();
		pipeLinkArray = null;
		passPipeArray = null;
		pipeEventIDArray = null;
		eventOrderSort = null;
		if (eventOrderToIndexDic != null)
		{
			eventOrderToIndexDic.Clear();
		}
	}
}
