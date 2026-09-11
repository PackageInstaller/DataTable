using System.Collections.Generic;
using UnityEngine;

namespace TetrisGame;

public class TetrisGameTileManager : MonoBehaviour
{
	[SerializeField]
	private GameObject baseCube;

	[SerializeField]
	private Transform oriPos;

	public RectTransform oriRectPos;

	[SerializeField]
	private TetrisGameManager gameManager;

	public int disposeNum;

	private TetrisGameTileEntity[] tileEntites;

	[SerializeField]
	private TetrisGameEffectPool effctPool;

	public List<Transform> scoreEffectPosList;

	private bool[] xSettleListBook;

	private bool[] ySettleListBook;

	public void InitEditor(int width, int height)
	{
		GenerateNewStageInfo();
	}

	public void GameLoseOver()
	{
		for (int i = 0; i < tileEntites.Length; i++)
		{
			tileEntites[i].SetGameLoseState();
		}
	}

	public TetrisGameTileSaveData[] GetSaveData(out bool isNull)
	{
		TetrisGameTileSaveData[] array = new TetrisGameTileSaveData[gameManager.width * gameManager.height];
		isNull = true;
		if (tileEntites != null)
		{
			for (int i = 0; i < tileEntites.Length; i++)
			{
				array[i] = tileEntites[i].GetSaveData();
			}
			isNull = false;
		}
		return array;
	}

	public void GenerateStage(TetrisGameStageSaveData data)
	{
		GenerateNewStageInfo();
		for (int i = 0; i < tileEntites.Length; i++)
		{
			tileEntites[i].chipIndex = data.tileDataArray[i].chipIndex;
			tileEntites[i].SetTileType(data.tileDataArray[i].tileType, data.tileDataArray[i].colorIndex);
		}
	}

	public void GenerateNewStageInfo()
	{
		tileEntites = new TetrisGameTileEntity[gameManager.width * gameManager.height];
		for (int i = 0; gameManager.height > i; i++)
		{
			for (int j = 0; gameManager.width > j; j++)
			{
				TetrisGameTileEntity component = Object.Instantiate(baseCube, base.transform).GetComponent<TetrisGameTileEntity>();
				TetrisGameTileSaveData tetrisGameTileSaveData = new TetrisGameTileSaveData();
				tetrisGameTileSaveData.width = j;
				tetrisGameTileSaveData.height = i;
				component.SetData(tetrisGameTileSaveData);
				tileEntites[j + i * gameManager.width] = component;
				component.gameObject.transform.localPosition = new Vector3(oriPos.localPosition.x + (float)(gameManager.cubeSize * j), oriPos.localPosition.y + (float)(gameManager.cubeSize * i), 0f);
			}
		}
		InitSettleListBook();
	}

	public void SetFinTileEffectPosList(TetrisGameChipEntity chipEntity)
	{
		int num = 0;
		for (int i = 0; i < chipEntity.tileEntityList.GetLength(0); i++)
		{
			int curY = i / chipEntity.width;
			int curX = i % chipEntity.width;
			Vector2 vector = TetrisGameTools.CalculateTrueTileIndex(chipEntity.originX, chipEntity.originY, curX, curY, chipEntity.transform.eulerAngles.z);
			int num2 = (int)vector.x + (int)vector.y * gameManager.width;
			if (CheckTileInSide((int)vector.x, (int)vector.y) && chipEntity.tileEntityList[i].curType == TileType.Full && tileEntites[num2].curType == TileType.Empty)
			{
				scoreEffectPosList[num].position = tileEntites[num2].rect.position;
				num++;
			}
		}
	}

	public int FillTile(TetrisGameChipEntity chipEntity, bool isExpect = false)
	{
		for (int i = 0; i < chipEntity.tileEntityList.GetLength(0); i++)
		{
			int curY = i / chipEntity.width;
			int curX = i % chipEntity.width;
			Vector2 vector = TetrisGameTools.CalculateTrueTileIndex(chipEntity.originX, chipEntity.originY, curX, curY, chipEntity.transform.eulerAngles.z);
			if (!CheckTileInSide((int)vector.x, (int)vector.y))
			{
				continue;
			}
			if (isExpect)
			{
				if (chipEntity.tileEntityList[i].curType != TileType.Empty)
				{
					tileEntites[(int)vector.x + (int)vector.y * gameManager.width].FillExpect(flag: true, chipEntity.chipColorIndex);
				}
			}
			else
			{
				tileEntites[(int)vector.x + (int)vector.y * gameManager.width].FillTile(chipEntity.tileEntityList[i].curType, chipEntity.chipColorIndex);
			}
		}
		return CheckTileSettle(isExpect);
	}

	public Vector2 GetTileIndexByPosition(Vector2 position)
	{
		oriRectPos.SetParent(base.transform.parent);
		Vector2 vector = position - (oriRectPos.anchoredPosition - new Vector2(gameManager.cubeSize / 2, gameManager.cubeSize / 2));
		int num = Mathf.FloorToInt(vector.x / (float)gameManager.cubeSize);
		int num2 = Mathf.FloorToInt(vector.y / (float)gameManager.cubeSize);
		oriRectPos.SetParent(base.transform);
		return new Vector2(num, num2);
	}

	public bool CheckCanPlaceWaitChip()
	{
		Dictionary<int, TetrisGameChipEntity> chipDicInstance = gameManager.chipManager.chipDicInstance;
		bool result = false;
		foreach (KeyValuePair<int, TetrisGameChipEntity> item in chipDicInstance)
		{
			if (!item.Value.isPutInMap && CheckCanFillTileByChip(item.Value))
			{
				result = true;
				break;
			}
		}
		return result;
	}

	public bool CheckCanFillTileByChip(TetrisGameChipEntity chip)
	{
		for (int i = 0; i < tileEntites.Length; i++)
		{
			int num = i / gameManager.width;
			int num2 = i % gameManager.width;
			if (CheckTileCanPlace(chip, new Vector2(num2, num), chip.transform.eulerAngles.z))
			{
				return true;
			}
			if (!TetrisGameManager.Instance.canRotate)
			{
				continue;
			}
			for (int j = 1; j <= 3; j++)
			{
				if (CheckTileCanPlace(chip, new Vector2(num2, num), chip.transform.eulerAngles.z + (float)(j * 90)))
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool GetTilePositionByIndex(int x, int y, out Vector3 position)
	{
		if (x >= 0 && x < gameManager.width && y >= 0 && y < gameManager.height)
		{
			position = tileEntites[x + y * gameManager.width].transform.position;
			return true;
		}
		position = default(Vector3);
		return false;
	}

	public bool CheckTileCanPlace(TetrisGameChipEntity chipEntity)
	{
		for (int i = 0; i < chipEntity.tileEntityList.GetLength(0); i++)
		{
			int curY = i / chipEntity.width;
			int curX = i % chipEntity.width;
			Vector2 vector = TetrisGameTools.CalculateTrueTileIndex(chipEntity.originX, chipEntity.originY, curX, curY, chipEntity.transform.eulerAngles.z);
			if (!CheckTileInSide((int)vector.x, (int)vector.y) || !tileEntites[(int)vector.x + (int)vector.y * gameManager.width].CheckTileCanPlace(chipEntity.tileEntityList[i].curType))
			{
				return false;
			}
		}
		return true;
	}

	public bool CheckTileCanPlace(TetrisGameChipEntity chipEntity, Vector2 originIndex, float z)
	{
		for (int i = 0; i < chipEntity.tileEntityList.GetLength(0); i++)
		{
			int curY = i / chipEntity.width;
			int curX = i % chipEntity.width;
			if (chipEntity.tileEntityList[i].curType != TileType.Empty)
			{
				Vector2 vector = TetrisGameTools.CalculateTrueTileIndex((int)originIndex.x, (int)originIndex.y, curX, curY, z);
				int num = (int)vector.x + (int)vector.y * gameManager.width;
				TileType curType = chipEntity.tileEntityList[i].curType;
				if (!CheckTileInSide((int)vector.x, (int)vector.y) || !tileEntites[num].CheckTileCanPlace(curType))
				{
					return false;
				}
			}
		}
		return true;
	}

	public void UpdataTileCanPlaceExpectState(TetrisGameChipEntity chipEntity)
	{
		ResetTileCanPlaceExpectState();
		FillTile(chipEntity, isExpect: true);
	}

	public void ResetTileCanPlaceExpectState()
	{
		for (int i = 0; i < tileEntites.GetLength(0); i++)
		{
			tileEntites[i].FillExpect(flag: false);
		}
		for (int j = 0; j < tileEntites.Length; j++)
		{
			tileEntites[j].needEmpty = false;
		}
	}

	public void UpdataTileCanDisposeExpectState()
	{
		CheckTileSettle(isExpect: true);
		for (int i = 0; i < tileEntites.Length; i++)
		{
			tileEntites[i].UpdataExpectDispose();
		}
	}

	private bool CheckTileInSide(int x, int y)
	{
		if (x < 0 || x >= gameManager.width || y < 0 || y >= gameManager.height)
		{
			return false;
		}
		return true;
	}

	private void InitSettleListBook()
	{
		if (xSettleListBook == null || xSettleListBook.Length != gameManager.width)
		{
			xSettleListBook = new bool[gameManager.width];
		}
		if (ySettleListBook == null || ySettleListBook.Length != gameManager.height)
		{
			ySettleListBook = new bool[gameManager.height];
		}
		for (int i = 0; i < gameManager.width; i++)
		{
			xSettleListBook[i] = false;
		}
		for (int j = 0; j < gameManager.height; j++)
		{
			ySettleListBook[j] = false;
		}
	}

	private int CalculateSettleCount()
	{
		int num = 0;
		bool[] array = xSettleListBook;
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i])
			{
				num++;
			}
		}
		array = ySettleListBook;
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i])
			{
				num++;
			}
		}
		return num;
	}

	public int CheckTileSettle(bool isExpect = false)
	{
		disposeNum = 0;
		List<int> list = new List<int>();
		bool flag = false;
		for (int i = 0; i < tileEntites.Length; i++)
		{
			tileEntites[i].needEmpty = false;
		}
		for (int j = 0; j < gameManager.height; j++)
		{
			bool flag2 = true;
			for (int k = gameManager.width * j; k < gameManager.width * (j + 1); k++)
			{
				if (tileEntites[k].curType == TileType.Empty && !tileEntites[k].isExpect)
				{
					flag2 = false;
					break;
				}
			}
			if (!flag2)
			{
				continue;
			}
			bool flag3 = TetrisGameManager.Instance.colorRemove;
			TetrisGameTileEntity tetrisGameTileEntity = tileEntites[gameManager.width * j];
			if (flag3)
			{
				for (int l = gameManager.width * j; l < gameManager.width * (j + 1); l++)
				{
					if (tileEntites[l].GetCurShowColor() != 17)
					{
						tetrisGameTileEntity = tileEntites[l];
					}
				}
			}
			for (int m = gameManager.width * j; m < gameManager.width * (j + 1); m++)
			{
				tileEntites[m].needEmpty = true;
				if (flag3 && !tileEntites[m].IsSameColor(tetrisGameTileEntity.GetCurShowColor()))
				{
					flag3 = false;
				}
			}
			ySettleListBook[j] = true;
			if (flag3)
			{
				list.Add(tetrisGameTileEntity.GetCurShowColor());
			}
		}
		for (int n = 0; n < gameManager.width; n++)
		{
			bool flag4 = true;
			for (int num = 0; num < gameManager.height; num++)
			{
				if (tileEntites[num * gameManager.width + n].curType == TileType.Empty && !tileEntites[num * gameManager.width + n].isExpect)
				{
					flag4 = false;
					break;
				}
			}
			if (!flag4)
			{
				continue;
			}
			bool flag5 = TetrisGameManager.Instance.colorRemove;
			TetrisGameTileEntity tetrisGameTileEntity2 = tileEntites[n];
			if (flag5)
			{
				for (int num2 = 0; num2 < gameManager.height; num2++)
				{
					if (tileEntites[num2 * gameManager.width + n].GetCurShowColor() != 17)
					{
						tetrisGameTileEntity2 = tileEntites[num2 * gameManager.width + n];
					}
				}
			}
			for (int num3 = 0; num3 < gameManager.height; num3++)
			{
				tileEntites[num3 * gameManager.width + n].needEmpty = true;
				if (flag5 && !tileEntites[num3 * gameManager.width + n].IsSameColor(tetrisGameTileEntity2.GetCurShowColor()))
				{
					flag5 = false;
				}
			}
			xSettleListBook[n] = true;
			if (flag5)
			{
				flag = true;
				list.Add(tetrisGameTileEntity2.GetCurShowColor());
			}
		}
		if (TetrisGameManager.Instance.colorRemove)
		{
			bool flag6 = false;
			for (int num4 = 0; num4 < tileEntites.Length; num4++)
			{
				foreach (int item in list)
				{
					if (tileEntites[num4].IsSameColor(item))
					{
						flag6 = true;
						if (flag)
						{
							xSettleListBook[num4 % gameManager.width] = true;
						}
						else
						{
							ySettleListBook[num4 / gameManager.width] = true;
						}
					}
				}
			}
			if (flag6)
			{
				if (flag)
				{
					for (int num5 = 0; num5 < gameManager.width; num5++)
					{
						if (xSettleListBook[num5])
						{
							for (int num6 = 0; num6 < gameManager.height; num6++)
							{
								tileEntites[num5 + num6 * gameManager.width].needEmpty = true;
							}
						}
					}
				}
				else
				{
					for (int num7 = 0; num7 < gameManager.height; num7++)
					{
						if (ySettleListBook[num7])
						{
							for (int num8 = 0; num8 < gameManager.width; num8++)
							{
								tileEntites[num8 + num7 * gameManager.width].needEmpty = true;
							}
						}
					}
				}
				if (!isExpect)
				{
					LuaHelper.CallFunction("TetrisGameSkillRecords", 1011);
				}
			}
		}
		if (!isExpect)
		{
			for (int num9 = 0; num9 < tileEntites.Length; num9++)
			{
				if (tileEntites[num9].needEmpty)
				{
					if (tileEntites[num9].curType != TileType.Empty)
					{
						disposeNum++;
					}
					tileEntites[num9].needEmpty = false;
					tileEntites[num9].SetTileType(TileType.Empty);
				}
			}
			ShowDisposeEffect();
		}
		int result = CalculateSettleCount();
		InitSettleListBook();
		return result;
	}

	private void ShowDisposeEffect()
	{
		EffectType type = EffectType.One;
		int num = CalculateSettleCount();
		if (num <= 2)
		{
			AudioManager.Instance.Play("effect", "minigame_activity_3_6", "minigame_activity_3_6_block_finish01", useStream: false);
		}
		else if (num <= 4)
		{
			AudioManager.Instance.Play("effect", "minigame_activity_3_6", "minigame_activity_3_6_block_finish02", useStream: false);
		}
		else if (num <= 6)
		{
			AudioManager.Instance.Play("effect", "minigame_activity_3_6", "minigame_activity_3_6_block_finish03", useStream: false);
		}
		else
		{
			AudioManager.Instance.Play("effect", "minigame_activity_3_6", "minigame_activity_3_6_block_finish04", useStream: false);
		}
		if (TetrisGameManager.Instance.machineStage)
		{
			type = ((!TetrisGameManager.Instance.canCombom) ? EffectType.Skill2 : EffectType.Skill1);
		}
		else if (num == 1)
		{
			type = EffectType.One;
		}
		else if (num == 2)
		{
			type = EffectType.Two;
		}
		else if (num >= 3)
		{
			type = EffectType.Three;
		}
		int num2 = 0;
		for (int i = 0; i < gameManager.width; i++)
		{
			if (xSettleListBook[i])
			{
				Vector2 pos = oriRectPos.anchoredPosition + new Vector2(i * gameManager.cubeSize, (float)gameManager.cubeSize * ((float)(gameManager.height / 2) - 0.5f));
				RectTransform rectTransform = effctPool.PlayEffect(type, i, -1, pos);
				scoreEffectPosList[num2].position = rectTransform.position;
				num2++;
			}
		}
		for (int j = 0; j < gameManager.height; j++)
		{
			if (ySettleListBook[j])
			{
				Vector2 pos2 = oriRectPos.anchoredPosition + new Vector2((float)((double)gameManager.cubeSize * ((double)(gameManager.width / 2) - 0.5)), j * gameManager.cubeSize);
				RectTransform rectTransform2 = effctPool.PlayEffect(type, -1, j, pos2);
				scoreEffectPosList[num2].position = rectTransform2.position;
				num2++;
			}
		}
	}

	public void Dispose()
	{
		if (tileEntites != null)
		{
			for (int i = 0; i < tileEntites.GetLength(0); i++)
			{
				tileEntites[i].Dispose();
			}
			tileEntites = null;
		}
		effctPool.Dispose();
	}
}
