using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace WaterPipeGame;

public class WaterPipeTools
{
	private struct StepData
	{
		public int step;

		public int toLinkPipeIndex;

		public int linkEventCount;
	}

	public static void SavePipeStageDataByJson(WaterPipeStageSaveData saveData)
	{
		string path = string.Format(WaterPipeConst.mapDataPath, saveData.stageID);
		string contents = JsonUtility.ToJson(saveData);
		File.WriteAllText(path, contents);
	}

	public static WaterPipeStageSaveData LoadPipeStageData(int stageID)
	{
		string json = (Application.isPlaying ? AssetEx.LoadText(string.Format(WaterPipeConst.assetMapDataPath, stageID)) : File.ReadAllText(string.Format(WaterPipeConst.mapDataPath, stageID)));
		return JsonUtility.FromJson<WaterPipeStageSaveData>(json);
	}

	public static DIR RotateDir(DIR dir, int rotateNums = 1)
	{
		if (rotateNums == 0)
		{
			return dir;
		}
		dir = (DIR)((int)(dir + rotateNums - 1) % 4 + 1);
		return dir;
	}

	public static int GetLinkDirIndex(DIR dir, int pipeIndex)
	{
		int num = pipeIndex % WaterPipeGameManager.Instance.width;
		_ = pipeIndex / WaterPipeGameManager.Instance.width;
		int num2 = 0;
		switch (dir)
		{
		case DIR.UP:
			num2 = -WaterPipeGameManager.Instance.width;
			break;
		case DIR.DOWN:
			num2 = WaterPipeGameManager.Instance.width;
			break;
		case DIR.RIGHT:
			if (num == WaterPipeGameManager.Instance.width - 1)
			{
				return -1;
			}
			num2 = 1;
			break;
		case DIR.LEFT:
			if (num == 0)
			{
				return -1;
			}
			num2 = -1;
			break;
		}
		return pipeIndex + num2;
	}

	public static bool IsCanLinkPipe(DIR toLinkDir, WaterPipeMapEntity linkEntity)
	{
		DIR dir = linkEntity.dir;
		PipeType pipeType = linkEntity.pipeType;
		toLinkDir = RotateDir(toLinkDir, 2);
		if (WaterPipeConst.pipeTypeDir.ContainsKey(pipeType))
		{
			DIR[] array = WaterPipeConst.pipeTypeDir[pipeType];
			for (int i = 0; i < array.Length; i++)
			{
				if (RotateDir(array[i], (int)(dir - 1)) == toLinkDir)
				{
					return true;
				}
			}
			return false;
		}
		return true;
	}

	private static bool IsMeetMuskLink(Dictionary<int, StepData> stepDic, int beginPipeIndex, int targetPipeIndex)
	{
		bool flag = false;
		int num = beginPipeIndex;
		while (!flag && stepDic != null && stepDic.ContainsKey(num))
		{
			num = stepDic[num].toLinkPipeIndex;
			if (num == targetPipeIndex)
			{
				flag = true;
				break;
			}
		}
		return flag;
	}

	public static List<int> GetMovePathList(WaterPipeMapEntity[] mapEntites, int beginIndex, int endIndex)
	{
		List<int> list = new List<int>();
		Queue<int> queue = new Queue<int>();
		Dictionary<int, StepData> dictionary = new Dictionary<int, StepData>();
		int num = 0;
		queue.Enqueue(beginIndex);
		StepData value = default(StepData);
		value.step = 1;
		value.toLinkPipeIndex = -1;
		value.linkEventCount = num;
		dictionary.Add(beginIndex, value);
		StepData value3 = default(StepData);
		while (queue.Count > 0)
		{
			int num2 = queue.Peek();
			if (dictionary.ContainsKey(num2) && dictionary[num2].linkEventCount < num)
			{
				queue.Dequeue();
				continue;
			}
			WaterPipeMapEntity obj = mapEntites[num2];
			PipeType pipeType = obj.pipeType;
			DIR dir = obj.dir;
			DIR[] array = ((!WaterPipeConst.pipeTypeDir.ContainsKey(pipeType)) ? WaterPipeConst.pipeTypeDir[PipeType.DEFAULT] : WaterPipeConst.pipeTypeDir[pipeType]);
			for (int i = 0; i < array.Length; i++)
			{
				DIR dIR = RotateDir(array[i], (int)(dir - 1));
				int linkDirIndex = GetLinkDirIndex(dIR, num2);
				if (linkDirIndex < 0 || linkDirIndex >= mapEntites.Length || !mapEntites[linkDirIndex].IsLink())
				{
					continue;
				}
				bool num3 = IsCanLinkPipe(dIR, mapEntites[linkDirIndex]);
				int mapEventEntityPreIndexByIndex = WaterPipeGameManager.Instance.pipeItemManager.GetMapEventEntityPreIndexByIndex(linkDirIndex);
				bool flag = true;
				if (mapEventEntityPreIndexByIndex > 0)
				{
					flag = IsMeetMuskLink(dictionary, num2, mapEventEntityPreIndexByIndex);
				}
				bool flag2 = false;
				if (dictionary.ContainsKey(linkDirIndex) && dictionary.ContainsKey(num2) && dictionary[num2].toLinkPipeIndex == linkDirIndex)
				{
					flag2 = true;
				}
				if (!(num3 & flag) || flag2)
				{
					continue;
				}
				if (dictionary.ContainsKey(linkDirIndex) && dictionary.ContainsKey(num2) && dictionary[num2].linkEventCount + 1 < dictionary[linkDirIndex].linkEventCount)
				{
					StepData value2 = dictionary[linkDirIndex];
					value2.step = dictionary[num2].step + 1;
					value2.toLinkPipeIndex = num2;
					value2.linkEventCount = dictionary[num2].linkEventCount;
					dictionary[linkDirIndex] = value2;
				}
				else if (!dictionary.ContainsKey(linkDirIndex))
				{
					value3.step = dictionary[num2].step + 1;
					value3.toLinkPipeIndex = num2;
					value3.linkEventCount = dictionary[num2].linkEventCount;
					if (WaterPipeGameManager.Instance.pipeItemManager.GetMapEventByIndex(linkDirIndex) != null)
					{
						num = (value3.linkEventCount = dictionary[num2].linkEventCount + 1);
					}
					dictionary.Add(linkDirIndex, value3);
					queue.Enqueue(linkDirIndex);
				}
			}
			queue.Dequeue();
		}
		int num4 = endIndex;
		while (num4 != -1 && dictionary.ContainsKey(num4))
		{
			list.Add(num4);
			num4 = dictionary[num4].toLinkPipeIndex;
		}
		return list;
	}

	public static string GetBeginAndEndSprite(PipeType pipeType, PipeState pipeState)
	{
		if (pipeType == PipeType.ENTER)
		{
			return string.Format(WaterPipeConst.pipeImgName, "BaichaoUI_3_9_00939");
		}
		if (pipeState == PipeState.NORMAL)
		{
			return string.Format(WaterPipeConst.pipeImgName, "BaichaoUI_3_9_00940");
		}
		return string.Format(WaterPipeConst.pipeImgName, "BaichaoUI_3_9_00941");
	}

	public static string GetSpritePath(string spriteName, PipeType pipeType, PipeState pipeState = PipeState.NORMAL)
	{
		if (pipeType == PipeType.ENTER || pipeType == PipeType.END)
		{
			return GetBeginAndEndSprite(pipeType, pipeState);
		}
		string result = string.Empty;
		if (!Application.isPlaying)
		{
			result = string.Format(WaterPipeConst.pipeImgName, spriteName);
		}
		else if (WaterPipeConst.pipeTypeName.ContainsKey(pipeType) && pipeState != PipeState.FINISH)
		{
			if (WaterPipeConst.pipeTypeName.ContainsKey(pipeType))
			{
				result = string.Format(WaterPipeConst.pipeImgName, WaterPipeConst.pipeTypeName[pipeType]);
			}
		}
		else
		{
			result = string.Format(WaterPipeConst.pipeImgName, spriteName);
		}
		return result;
	}

	public static string GetRouteSpritePath(PipeType pipeType, PipeState pipeState = PipeState.NORMAL)
	{
		string empty = string.Empty;
		empty = ((!WaterPipeConst.pipeMapName.ContainsKey(pipeType)) ? WaterPipeConst.pipeMapName[PipeType.DEFAULT] : WaterPipeConst.pipeMapName[pipeType]);
		switch (pipeState)
		{
		case PipeState.NORMAL:
			empty = string.Format(WaterPipeConst.pipeImgNormal, empty);
			break;
		case PipeState.RIGHTLINK:
			empty = string.Format(WaterPipeConst.pipeImgLink, empty);
			break;
		case PipeState.FINISH:
			empty = string.Format(WaterPipeConst.pipeImgFinish, empty);
			break;
		}
		return empty;
	}

	public static string GetOrderSpritePath(int order)
	{
		return WaterPipeConst.pipeImgBasePath + "BaichaoUI_3_9_order_" + order;
	}
}
