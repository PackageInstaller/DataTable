using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;

namespace TangramGame;

public class TangramGameChipManager : SerializedMonoBehaviour
{
	[HideInInspector]
	public Dictionary<int, TangramGameChip> chipDic;

	public GameObject baseCube;

	[SerializeField]
	public Transform[] chipGeneratePos;

	public GameObject chipPrefab;

	public TangramGameStageManager stageManager;

	public void StartGame(int[] finfishList)
	{
		if (chipDic == null || finfishList.Length == 0)
		{
			return;
		}
		for (int i = 0; i < finfishList.Length; i++)
		{
			if (chipDic.ContainsKey(finfishList[i]))
			{
				chipDic[finfishList[i]].GoToFinialPos();
			}
		}
	}

	public void ResetAllStageChip()
	{
		if (chipDic == null)
		{
			return;
		}
		foreach (KeyValuePair<int, TangramGameChip> item in chipDic)
		{
			if (!item.Value.isDestination)
			{
				TangramManager.Instance.curStageManager.tileManager.RemoveTile(item.Value);
				item.Value.ResetChip();
			}
		}
	}

	public bool CheckAllChipIsCorrcet()
	{
		foreach (KeyValuePair<int, TangramGameChip> item in chipDic)
		{
			if (!item.Value.isDestination)
			{
				return false;
			}
		}
		return true;
	}

	public void RefreshIsCanPlace(TangramGameChip chipEntity, bool isDrag = false)
	{
		TangramManager.Instance.curStageManager.tileManager.CheckTileCanPlace(chipEntity, isDrag);
		chipEntity.SetDragState();
	}

	public bool CheckChipIsCorrectPosition(int index)
	{
		bool flag = false;
		if (chipDic.ContainsKey(index))
		{
			flag = chipDic[index].CheckTileIsDestination();
		}
		chipDic[index].isDestination = flag;
		if (CheckAllChipIsCorrcet())
		{
			TangramGameBridge.FinishStage(stageManager.stageID);
		}
		Debug.Log(flag + "是否抵达终点");
		return flag;
	}

	public void GenerateNewChipBySaveData(List<TangramChipData> chipDataList)
	{
		foreach (TangramChipData chipData in chipDataList)
		{
			TangramGameChip value = BuildTangramChip(chipData.relevanceList, chipData.chipIndex, chipData);
			chipDic.Add(chipData.chipIndex, value);
		}
	}

	public void GenerateNewChipList(List<TangramTileData> tileDataList)
	{
		Dictionary<int, List<TangramChipTileData>> dictionary = new Dictionary<int, List<TangramChipTileData>>();
		foreach (TangramTileData tileData in tileDataList)
		{
			foreach (TangramChipTileData data in tileData.dataList)
			{
				if (data.chipIndex > 0)
				{
					TangramChipTileData tangramChipTileData = new TangramChipTileData(tileData.x, tileData.y);
					tangramChipTileData.chipIndex = data.chipIndex;
					tangramChipTileData.x = data.x;
					tangramChipTileData.y = data.y;
					tangramChipTileData.tileType = data.tileType;
					if (!dictionary.ContainsKey(data.chipIndex))
					{
						dictionary[data.chipIndex] = new List<TangramChipTileData>();
					}
					dictionary[data.chipIndex].Add(tangramChipTileData);
				}
			}
		}
		foreach (KeyValuePair<int, List<TangramChipTileData>> item in dictionary)
		{
			TangramGameChip value = BuildTangramChip(item.Value, item.Key, null);
			chipDic.Add(item.Key, value);
		}
	}

	private TangramGameChip BuildTangramChip(List<TangramChipTileData> dataList, int index, TangramChipData chipData)
	{
		Transform parent = chipGeneratePos[index - 1];
		TangramGameChip component = Object.Instantiate(chipPrefab, parent).GetComponent<TangramGameChip>();
		if (chipData != null)
		{
			component.InitNewChip(chipData);
		}
		else
		{
			component.InitNewChip(dataList, index);
		}
		return component;
	}

	public void RefreshOtherChipState(TangramGameChip chipEntity)
	{
		TangramGameChip[] componentsInChildren = stageManager.gameObject.GetComponentsInChildren<TangramGameChip>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			if (chipEntity.chipIndex != componentsInChildren[i].chipIndex && componentsInChildren[i].isLocate)
			{
				if (TangramManager.Instance.curStageManager.tileManager.CheckTileCanPlace(componentsInChildren[i]))
				{
					TangramManager.Instance.curStageManager.tileManager.FillTile(componentsInChildren[i]);
				}
				componentsInChildren[i].SetDragState();
			}
		}
	}

	public void Init()
	{
		chipDic = new Dictionary<int, TangramGameChip>();
	}

	public void Dispose()
	{
		if (chipDic == null)
		{
			return;
		}
		foreach (KeyValuePair<int, TangramGameChip> item in chipDic)
		{
			item.Value.Dispose();
		}
		chipDic.Clear();
		chipDic = null;
	}
}
