using System.Collections.Generic;
using UnityEngine;

namespace TetrisGame;

public class TetrisGameChipManager : MonoBehaviour
{
	[SerializeField]
	public Transform[] chipGeneratePos;

	public GameObject chipPrefab;

	public TetrisGameManager gameManager;

	private Dictionary<int, TetrisGameChipEntity> chipDic;

	private TetrisGameChipSaveData[] chipData;

	private TetrisGameChipSaveData[] specialChipData;

	public Dictionary<int, TetrisGameChipEntity> chipDicInstance => chipDic;

	public void InitEditorChip(TetrisGameTileSaveData[] dataArray)
	{
		chipDic = new Dictionary<int, TetrisGameChipEntity>();
		Dictionary<int, List<TetrisGameTileSaveData>> dictionary = new Dictionary<int, List<TetrisGameTileSaveData>>();
		for (int i = 0; i < dataArray.Length; i++)
		{
			if (dataArray[i].tileType == TileType.Full && dataArray[i].chipIndex > 0)
			{
				if (!dictionary.ContainsKey(dataArray[i].chipIndex))
				{
					dictionary[dataArray[i].chipIndex] = new List<TetrisGameTileSaveData>();
				}
				dictionary[dataArray[i].chipIndex].Add(dataArray[i]);
			}
		}
		foreach (KeyValuePair<int, List<TetrisGameTileSaveData>> item in dictionary)
		{
			TetrisGameChipEntity value = BuildTetrisChip(item.Value, item.Key);
			chipDic.Add(item.Key, value);
		}
	}

	private TetrisGameChipEntity BuildTetrisChip(List<TetrisGameTileSaveData> dataList, int index)
	{
		int num = index;
		if (num > chipGeneratePos.Length)
		{
			num %= chipGeneratePos.Length;
		}
		Transform transform = chipGeneratePos[num - 1];
		TetrisGameChipEntity component = Object.Instantiate(chipPrefab, transform).GetComponent<TetrisGameChipEntity>();
		component.oriPosition = transform.position;
		component.GenerateChip(dataList, index);
		component.oriAngles = component.gameObject.transform.eulerAngles;
		return component;
	}

	public TetrisGameChipAllSaveData GetSaveData()
	{
		TetrisGameChipAllSaveData tetrisGameChipAllSaveData = new TetrisGameChipAllSaveData();
		TetrisGameChipSaveData[] array = new TetrisGameChipSaveData[0];
		if (chipDic != null)
		{
			array = new TetrisGameChipSaveData[chipDic.Count];
			int num = 0;
			foreach (KeyValuePair<int, TetrisGameChipEntity> item in chipDic)
			{
				array[num] = item.Value.GetSaveData();
				num++;
			}
		}
		tetrisGameChipAllSaveData.chipData = array;
		return tetrisGameChipAllSaveData;
	}

	public void RefreshNewChipList(int[] chipIndexList)
	{
		if (chipDic == null)
		{
			chipDic = new Dictionary<int, TetrisGameChipEntity>();
		}
		if (chipDic != null)
		{
			foreach (KeyValuePair<int, TetrisGameChipEntity> item in chipDic)
			{
				item.Value.Dispose();
			}
			chipDic.Clear();
		}
		if (chipIndexList.Length == gameManager.roundChipNum)
		{
			for (int i = 0; i < gameManager.roundChipNum; i++)
			{
				GenerateSingleChip(chipData[chipIndexList[i]], i + 1, i);
			}
		}
		else
		{
			Debug.LogError("生成碎片数量和配置数量不符");
		}
	}

	public void InitRunTime()
	{
		Dispose();
		TetrisGameChipAllSaveData tetrisGameChipAllSaveData = TetrisGameTools.LoadChipScriptableObject();
		if (tetrisGameChipAllSaveData != null)
		{
			chipData = tetrisGameChipAllSaveData.chipData;
		}
		TetrisGameChipAllSaveData tetrisGameChipAllSaveData2 = TetrisGameTools.LoadChipScriptableObject(isSpecial: true);
		if (tetrisGameChipAllSaveData2 != null)
		{
			specialChipData = tetrisGameChipAllSaveData2.chipData;
		}
	}

	public void DisposeSingleChip(int chipIndex)
	{
		if (chipDic.ContainsKey(chipIndex))
		{
			chipDic[chipIndex].gameObject.SetActive(value: false);
		}
	}

	public int GetCurDicChipNum()
	{
		if (chipDic != null)
		{
			int num = 0;
			{
				foreach (KeyValuePair<int, TetrisGameChipEntity> item in chipDic)
				{
					if (!item.Value.isPutInMap)
					{
						num++;
					}
				}
				return num;
			}
		}
		return 0;
	}

	public void GenerateRandomChip()
	{
		if (chipDic == null)
		{
			chipDic = new Dictionary<int, TetrisGameChipEntity>();
		}
		if (chipDic != null)
		{
			foreach (KeyValuePair<int, TetrisGameChipEntity> item in chipDic)
			{
				item.Value.Dispose();
			}
			chipDic.Clear();
		}
		for (int i = 0; i < gameManager.roundChipNum; i++)
		{
			if (TetrisGameManager.Instance.bubbleChipPosIndex == i + 1)
			{
				int skillSpecialChipID = TetrisGameManager.Instance.skillSpecialChipID;
				GenerateSingleChip(specialChipData[skillSpecialChipID - 1], i + 1, skillSpecialChipID, -1, ChipType.Bubble);
				continue;
			}
			int lockChipShape;
			if (TetrisGameManager.Instance.lockChipShape >= 0)
			{
				lockChipShape = TetrisGameManager.Instance.lockChipShape;
				if (TetrisGameManager.Instance.lockChipType != ChipType.Normal)
				{
					GenerateSingleChip(specialChipData[lockChipShape - 1], i + 1, lockChipShape, -1, TetrisGameManager.Instance.lockChipType);
				}
				else
				{
					GenerateSingleChip(chipData[lockChipShape], i + 1, lockChipShape);
				}
				continue;
			}
			TetrisGameChipCustomData customData = TetrisGameManager.Instance.customManager.GetCustomData();
			int colorIndex = -1;
			RotateDir rotateDir = RotateDir.None;
			if (customData != null)
			{
				lockChipShape = customData.shapeIndex - 1;
				colorIndex = customData.colorIndex;
				rotateDir = customData.dir;
			}
			else
			{
				lockChipShape = TetrisGameTools.RandomChipIndex();
			}
			GenerateSingleChip(chipData[lockChipShape], i + 1, lockChipShape, colorIndex);
			if (rotateDir != RotateDir.None && chipDic.ContainsKey(i + 1))
			{
				chipDic[i + 1].RotateToTargetDir((int)rotateDir);
			}
		}
		AudioManager.Instance.Play("effect", "minigame_activity_3_6", "minigame_activity_3_6_block_refresh01", useStream: false);
	}

	public void GenerateSpecificChip(int[] chipIndexList)
	{
		if (chipDic == null)
		{
			chipDic = new Dictionary<int, TetrisGameChipEntity>();
		}
		if (chipDic != null)
		{
			foreach (KeyValuePair<int, TetrisGameChipEntity> item in chipDic)
			{
				item.Value.Dispose();
			}
			chipDic.Clear();
		}
		for (int i = 0; i < chipIndexList.Length; i++)
		{
			if (TetrisGameManager.Instance.bubbleChipPosIndex == i + 1)
			{
				int skillSpecialChipID = TetrisGameManager.Instance.skillSpecialChipID;
				GenerateSingleChip(specialChipData[skillSpecialChipID - 1], i + 1, skillSpecialChipID, -1, ChipType.Bubble);
			}
			else
			{
				int num = chipIndexList[i];
				GenerateSingleChip(specialChipData[num - 1], i + 1, num, -1, ChipType.Special);
			}
		}
		AudioManager.Instance.Play("effect", "minigame_activity_3_6", "minigame_activity_3_6_block_refresh02", useStream: false);
	}

	public void GenerateChip(TetrisGameChipAllSaveData chipData)
	{
		chipDic = new Dictionary<int, TetrisGameChipEntity>();
		TetrisGameChipSaveData[] array = chipData.chipData;
		for (int i = 0; i < array.Length; i++)
		{
			Transform parent = chipGeneratePos[array[i].chipIndex - 1];
			TetrisGameChipEntity component = Object.Instantiate(chipPrefab, parent).GetComponent<TetrisGameChipEntity>();
			List<TetrisGameTileSaveData> list = new List<TetrisGameTileSaveData>();
			for (int j = 0; j < array[i].relevanceList.Length; j++)
			{
				list.Add(array[i].relevanceList[j]);
			}
			component.GenerateChip(list, array[i].chipIndex);
			chipDic.Add(array[i].chipIndex, component);
		}
	}

	public void GenerateSingleChip(TetrisGameChipSaveData chipData, int posIndex, int shapeIndex, int colorIndex = -1, ChipType chipType = ChipType.Normal)
	{
		Transform parent = chipGeneratePos[posIndex];
		TetrisGameChipEntity component = Object.Instantiate(chipPrefab, parent).GetComponent<TetrisGameChipEntity>();
		List<TetrisGameTileSaveData> list = new List<TetrisGameTileSaveData>();
		for (int i = 0; i < chipData.relevanceList.Length; i++)
		{
			list.Add(chipData.relevanceList[i]);
		}
		component.GenerateChip(list, posIndex, shapeIndex, colorIndex, chipType);
		chipDic.Add(posIndex, component);
		if (chipType == ChipType.Normal)
		{
			int index = Random.Range(0, 3);
			component.RotateChip(index, isCreate: true);
		}
		component.oriAngles = component.gameObject.transform.eulerAngles;
		component.ResetChip();
	}

	public void UpdataIsCanPlaceState(TetrisGameChipEntity chipEntity)
	{
		if (gameManager.tileManager.CheckTileCanPlace(chipEntity))
		{
			gameManager.tileManager.UpdataTileCanPlaceExpectState(chipEntity);
			gameManager.tileManager.UpdataTileCanDisposeExpectState();
		}
	}

	public void RotateChip(int chipPosIndex)
	{
		if (chipDic != null && chipDic.ContainsKey(chipPosIndex) && TetrisGameManager.Instance.canRotate)
		{
			TetrisGameChipEntity tetrisGameChipEntity = chipDic[chipPosIndex];
			if (tetrisGameChipEntity != null)
			{
				tetrisGameChipEntity.RotateChip();
			}
		}
	}

	public bool CheckIsHaveDragging()
	{
		if (chipDic != null)
		{
			foreach (KeyValuePair<int, TetrisGameChipEntity> item in chipDic)
			{
				if (item.Value.isDrag)
				{
					return true;
				}
			}
		}
		return false;
	}

	public void Dispose()
	{
		if (chipDic == null)
		{
			return;
		}
		foreach (KeyValuePair<int, TetrisGameChipEntity> item in chipDic)
		{
			item.Value.Dispose();
		}
		chipDic.Clear();
		chipDic = null;
	}
}
