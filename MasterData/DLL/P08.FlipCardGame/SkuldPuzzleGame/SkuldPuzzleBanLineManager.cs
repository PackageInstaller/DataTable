using System.Collections.Generic;
using UnityEngine;

namespace SkuldPuzzleGame;

public class SkuldPuzzleBanLineManager : MonoBehaviour
{
	public GameObject banLinePrefab;

	private List<SkuldPuzzleBanLineEntity> banLineList;

	private bool[,] banBookArray;

	private int mapWidth;

	private int mapHeight;

	private int listLen;

	public void CreateStageBanLineData(int width, int height)
	{
		mapWidth = width;
		mapHeight = height;
	}

	public void CreateStageBanLineData(SkuldPuzzleStageSaveData stageData)
	{
		CreateStageBanLineData(stageData.width, stageData.height);
		DisposeBanLineList();
		DisposeBanDataBook();
		banLineList = new List<SkuldPuzzleBanLineEntity>();
		banLineList.Clear();
		listLen = mapWidth * mapHeight + 1;
		banBookArray = new bool[listLen, listLen];
		foreach (SkuldPuzzleBanLineData ban in stageData.banList)
		{
			GenerateBanLine(ban);
			banBookArray[ban.tileIndexA, ban.tileIndexB] = true;
			banBookArray[ban.tileIndexB, ban.tileIndexA] = true;
		}
	}

	public void GenerateBanLine(SkuldPuzzleBanLineData banLineData)
	{
		SkuldPuzzleBanLineEntity component = Object.Instantiate(banLinePrefab, base.transform).GetComponent<SkuldPuzzleBanLineEntity>();
		component.InitBanLineData(banLineData, mapWidth, mapHeight);
		if (banLineList != null)
		{
			banLineList.Add(component);
		}
	}

	public bool IsMeetBan(int indexA, int indexB)
	{
		if (indexA < 0 || indexA >= listLen)
		{
			return false;
		}
		if (indexB < 0 || indexB >= listLen)
		{
			return false;
		}
		if (banBookArray[indexA, indexB])
		{
			return true;
		}
		return false;
	}

	public void Dispose()
	{
		DisposeBanLineList();
		DisposeBanDataBook();
	}

	public void DisposeBanLineList()
	{
		if (banLineList == null)
		{
			return;
		}
		foreach (SkuldPuzzleBanLineEntity banLine in banLineList)
		{
			if (banLine != null)
			{
				banLine.Dispose();
			}
		}
		banLineList.Clear();
		banLineList = null;
	}

	public void DisposeBanDataBook()
	{
		if (banBookArray != null)
		{
			banBookArray = null;
		}
	}
}
