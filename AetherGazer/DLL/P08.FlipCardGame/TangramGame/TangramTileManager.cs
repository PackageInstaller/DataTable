using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;

namespace TangramGame;

public class TangramTileManager : SerializedMonoBehaviour
{
	public Transform oriPos;

	public RectTransform oriRectPos;

	public Transform baseCubeNode;

	public Transform shadowCubeNode;

	public Transform shadowTriggerNode;

	public CanvasGroup shadowCubeCanvas;

	public CanvasGroup shadowTriggerCanvas;

	public CanvasGroup showNodeCanvas;

	public GameObject shadowCubeBg;

	public GameObject shadowTriggerBg;

	public GameObject bigShadowCubeBg;

	public GameObject bigShadowTriggerBg;

	public int width;

	public int height;

	[HideInInspector]
	public TangramTileController[,] tileEntites;

	[HideInInspector]
	public List<GameObject> shadowEntites;

	public GameObject baseCube;

	[SerializeField]
	public Texture2D baseImage;

	private bool needDrwaLine;

	public TangramGameStageManager stageManager;

	private int offsetValue = 4;

	private int[] nextX = new int[4] { 0, 1, 0, -1 };

	private int[] nextY = new int[4] { 1, 0, -1, 0 };

	public void StartGame()
	{
		shadowCubeCanvas.alpha = 0f;
		shadowTriggerCanvas.alpha = 0f;
		showNodeCanvas.alpha = 0f;
		if (tileEntites == null)
		{
			return;
		}
		for (int i = 0; i < tileEntites.GetLength(0); i++)
		{
			for (int j = 0; j < tileEntites.GetLength(1); j++)
			{
				tileEntites[i, j].StartGame(i, j);
			}
		}
	}

	public void GenerateStage(List<TangramTileData> tileDataList, int width, int height, bool isEdit = false)
	{
		this.width = width;
		this.height = height;
		tileEntites = new TangramTileController[width, height];
		if (isEdit)
		{
			foreach (TangramTileData tileData in tileDataList)
			{
				TangramTileController component = Object.Instantiate(baseCube, baseCubeNode).GetComponent<TangramTileController>();
				component.SetData(tileData);
				component.go.transform.localPosition = new Vector3(oriPos.localPosition.x + stageManager.CUBE_SIZE * (float)tileData.x, oriPos.localPosition.y + stageManager.CUBE_SIZE * (float)tileData.y, 0f);
				tileEntites[tileData.x, tileData.y] = component;
			}
			return;
		}
		TangramTileController[] componentsInChildren = baseCubeNode.GetComponentsInChildren<TangramTileController>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].SetData(tileDataList[i]);
			tileEntites[componentsInChildren[i].x, componentsInChildren[i].y] = componentsInChildren[i];
		}
		for (int j = 0; j < componentsInChildren.Length; j++)
		{
			for (int k = 0; k < tileDataList[j].dataList.Count; k++)
			{
				if (tileDataList[j].dataList[k].tileType != TangramGameConst.TILE_TYPE.EMPTY && CheckIsNeedInstantiateShadow(componentsInChildren[j].x, componentsInChildren[j].y))
				{
					GameObject gameObject;
					if (tileDataList[j].dataList[k].tileType != TangramGameConst.TILE_TYPE.FULL)
					{
						gameObject = Object.Instantiate(bigShadowTriggerBg, shadowTriggerNode);
						RotateTriggerGo(tileDataList[j].dataList[k].tileType, gameObject.transform);
					}
					else
					{
						gameObject = Object.Instantiate(bigShadowCubeBg, shadowCubeNode);
					}
					gameObject.transform.localPosition = componentsInChildren[j].go.transform.localPosition;
					shadowEntites.Add(gameObject);
				}
			}
		}
	}

	private Vector3 GetOffsetPos(int x, int y, bool isTrigger, GameObject trueBG)
	{
		Vector3 zero = Vector3.zero;
		float num = 1.1f;
		for (int i = 0; i <= 3; i++)
		{
			int num2 = nextX[i];
			int num3 = nextY[i];
			if (!tileEntites[x + num2, y + num3])
			{
				continue;
			}
			bool flag = false;
			for (int j = 0; j < tileEntites[x + num2, y + num3].dataList.Count; j++)
			{
				if (tileEntites[x + num2, y + num3].dataList[j].tileType == TangramGameConst.TILE_TYPE.EMPTY)
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				continue;
			}
			if (isTrigger)
			{
				zero.x += num2 * (offsetValue + 1);
				zero.y += num3 * (offsetValue + 1);
				continue;
			}
			zero.x += num2 * offsetValue;
			zero.y += num3 * offsetValue;
			if (i < 2 || num != 1.1f)
			{
				continue;
			}
			int num4 = nextX[i - 2];
			int num5 = nextY[i - 2];
			if (!tileEntites[x + num4, y + num5])
			{
				continue;
			}
			for (int k = 0; k < tileEntites[x + num4, y + num5].dataList.Count; k++)
			{
				if (tileEntites[x + num4, y + num5].dataList[k].tileType == TangramGameConst.TILE_TYPE.EMPTY)
				{
					num = 1.25f;
				}
			}
		}
		trueBG.transform.localScale = Vector3.one * num;
		return zero;
	}

	private bool CheckIsNeedInstantiateShadow(int x, int y)
	{
		for (int i = 0; i <= 3; i++)
		{
			int num = nextX[i];
			int num2 = nextY[i];
			if (!tileEntites[x + num, y + num2])
			{
				continue;
			}
			for (int j = 0; j < tileEntites[x + num, y + num2].dataList.Count; j++)
			{
				if (tileEntites[x + num, y + num2].dataList[j].tileType == TangramGameConst.TILE_TYPE.EMPTY)
				{
					return true;
				}
			}
		}
		return false;
	}

	private void RotateTriggerGo(TangramGameConst.TILE_TYPE type, Transform trs)
	{
		switch (type)
		{
		case TangramGameConst.TILE_TYPE.LEFT_LOW:
			trs.eulerAngles = new Vector3(0f, 0f, 0f) + trs.parent.eulerAngles;
			break;
		case TangramGameConst.TILE_TYPE.LEFT_HIGH:
			trs.eulerAngles = new Vector3(0f, 0f, 270f) + trs.parent.eulerAngles;
			break;
		case TangramGameConst.TILE_TYPE.RIGHT_HIGH:
			trs.eulerAngles = new Vector3(0f, 0f, 180f) + trs.parent.eulerAngles;
			break;
		case TangramGameConst.TILE_TYPE.RIGHT_LOW:
			trs.eulerAngles = new Vector3(0f, 0f, 90f) + trs.parent.eulerAngles;
			break;
		}
	}

	public bool CheckTileCanPlace(TangramGameChip chipEntity, bool isDrag = false)
	{
		for (int i = 0; i < chipEntity.tileInfo.GetLength(0); i++)
		{
			int curY = i / chipEntity.width;
			int curX = i % chipEntity.width;
			Vector2 vector = TangramGameTools.CalculateTrueTileIndex(chipEntity.originX, chipEntity.originY, curX, curY, chipEntity.transform.eulerAngles.z);
			if (!CheckTileInSide((int)vector.x, (int)vector.y) || !tileEntites[(int)vector.x, (int)vector.y].CheckTileCanPlace(chipEntity.tileInfo[i]))
			{
				return false;
			}
		}
		return true;
	}

	private bool CheckTileInSide(int x, int y)
	{
		if (x < 0 || x >= width || y < 0 || y >= height)
		{
			return false;
		}
		return true;
	}

	public void FillTile(TangramGameChip chipEntity)
	{
		if (chipEntity.isFill)
		{
			return;
		}
		for (int i = 0; i < chipEntity.tileInfo.GetLength(0); i++)
		{
			int curY = i / chipEntity.width;
			int curX = i % chipEntity.width;
			Vector2 vector = TangramGameTools.CalculateTrueTileIndex(chipEntity.originX, chipEntity.originY, curX, curY, chipEntity.transform.eulerAngles.z);
			if (CheckTileInSide((int)vector.x, (int)vector.y))
			{
				tileEntites[(int)vector.x, (int)vector.y].FillTile(chipEntity.tileInfo[i]);
			}
		}
		chipEntity.isFill = true;
	}

	public void RemoveTile(TangramGameChip chipEntity)
	{
		if (!chipEntity.isFill)
		{
			return;
		}
		for (int i = 0; i < chipEntity.tileInfo.GetLength(0); i++)
		{
			int curY = i / chipEntity.width;
			int curX = i % chipEntity.width;
			Vector2 vector = TangramGameTools.CalculateTrueTileIndex(chipEntity.originX, chipEntity.originY, curX, curY, chipEntity.transform.eulerAngles.z);
			if (CheckTileInSide((int)vector.x, (int)vector.y))
			{
				tileEntites[(int)vector.x, (int)vector.y].RemoveTile(chipEntity.tileInfo[i]);
			}
			chipEntity.isFill = false;
		}
	}

	public void CheckStageFin()
	{
		for (int i = 0; i < tileEntites.GetLength(0); i++)
		{
			for (int j = 0; j < tileEntites.GetLength(1); j++)
			{
				if (tileEntites[i, j].oriTileType != TangramGameConst.TILE_TYPE.EMPTY && tileEntites[i, j].curType != tileEntites[i, j].oriTileType)
				{
					return;
				}
			}
		}
		TangramGameBridge.FinishStage(stageManager.stageID);
	}

	public Vector2 GetTileIndexByPosition(Vector2 position)
	{
		oriRectPos.SetParent(base.transform.parent);
		Vector2 vector = position - (oriRectPos.anchoredPosition - new Vector2(stageManager.CUBE_SIZE / 2f, stageManager.CUBE_SIZE / 2f));
		int num = Mathf.FloorToInt(Mathf.Round(vector.x) / stageManager.CUBE_SIZE);
		int num2 = Mathf.FloorToInt(Mathf.Round(vector.y) / stageManager.CUBE_SIZE);
		oriRectPos.SetParent(base.transform);
		return new Vector2(num, num2);
	}

	public bool GetTilePositionByIndex(int x, int y, out Vector3 position)
	{
		if (x >= 0 && x < width && y >= 0 && y < height)
		{
			position = tileEntites[x, y].transform.position;
			return true;
		}
		position = default(Vector3);
		return false;
	}

	public void Init(int width, int height)
	{
		this.width = width;
		this.height = height;
		GenerateNewStageInfo();
	}

	public List<TangramTileData> GetSaveData()
	{
		List<TangramTileData> list = new List<TangramTileData>();
		for (int i = 0; width > i; i++)
		{
			for (int j = 0; height > j; j++)
			{
				TangramTileData tangramTileData = new TangramTileData();
				tangramTileData.x = i;
				tangramTileData.y = j;
				tangramTileData.tileType = tileEntites[i, j].tileTpye;
				tangramTileData.dataList = tileEntites[i, j].dataList;
				list.Add(tangramTileData);
			}
		}
		return list;
	}

	private void GenerateNewStageInfo()
	{
		tileEntites = new TangramTileController[width, height];
		for (int i = 0; width > i; i++)
		{
			for (int j = 0; height > j; j++)
			{
				TangramTileController component = Object.Instantiate(baseCube, base.transform).GetComponent<TangramTileController>();
				component.SetData(i, j);
				tileEntites[i, j] = component;
				component.go.transform.localPosition = new Vector3(oriPos.localPosition.x + stageManager.CUBE_SIZE * (float)i, oriPos.localPosition.y + stageManager.CUBE_SIZE * (float)j, 0f);
			}
		}
	}

	public void Dispose(bool retainTile = false)
	{
		width = 0;
		height = 0;
		if (tileEntites != null)
		{
			for (int i = 0; i < tileEntites.GetLength(0); i++)
			{
				for (int j = 0; j < tileEntites.GetLength(1); j++)
				{
					if (tileEntites[i, j] != null)
					{
						tileEntites[i, j].Dispose(retainTile);
						tileEntites[i, j] = null;
					}
				}
			}
			tileEntites = null;
		}
		if (shadowEntites == null)
		{
			return;
		}
		foreach (GameObject shadowEntite in shadowEntites)
		{
			Object.DestroyImmediate(shadowEntite);
		}
	}
}
