using System;
using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;

namespace TetrisGame;

public class TetrisGameChipEntity : SerializedMonoBehaviour
{
	[SerializeField]
	private GameObject bubbleCxEffectPerfab;

	private List<GameObject> effectList;

	public RectTransform rectTransform;

	public GameObject baseCube;

	public int chipIndex;

	public int chipColorIndex;

	public int chipShapeIndex;

	public TetrisGameManager gameManager;

	public TetrisGameTileEntity oriGrid;

	public TetrisGameChipEvent gameChipEvent;

	[HideInInspector]
	public Transform fatherTransform;

	public bool isDrag;

	[SerializeField]
	private BoxCollider2D boxCollider;

	[HideInInspector]
	public TetrisGameTileEntity[] tileEntityList;

	[HideInInspector]
	public List<Transform> tileEntityImgList;

	[HideInInspector]
	public int width;

	[HideInInspector]
	public int height;

	public ChipType chipType;

	public int originX;

	public int originY;

	private int minX = -1;

	private int minY = -1;

	private int maxX = -1;

	private int maxY = -1;

	public Vector3 oriPosition;

	public Vector3 oriAngles;

	public int putInX;

	public int putInY;

	[HideInInspector]
	public bool isRotating;

	public bool isFilling;

	public bool isPutInMap;

	public bool CheckIsFull(TileType tileType)
	{
		if (tileType == TileType.Full || tileType == TileType.BUBBLE)
		{
			return true;
		}
		return false;
	}

	public void Start()
	{
		rectTransform = base.gameObject.GetComponent<RectTransform>();
		fatherTransform = base.gameObject.transform.parent;
	}

	public void SetPutMapPos(int x, int y)
	{
		putInX = x;
		putInY = y;
	}

	public void GenerateChip(List<TetrisGameTileSaveData> dataList, int index, int shapeIndex = -1, int colorIndex = -1, ChipType chipType = ChipType.Normal)
	{
		putInX = -1;
		putInY = -1;
		isPutInMap = false;
		gameChipEvent.chipEntity = this;
		rectTransform = base.gameObject.GetComponent<RectTransform>();
		base.transform.localPosition = new Vector3(0f, 0f, 0f);
		chipIndex = index;
		chipShapeIndex = shapeIndex;
		this.chipType = chipType;
		if (this.chipType == ChipType.Bubble)
		{
			AudioManager.Instance.Play("effect", "minigame_activity_3_6", "minigame_activity_3_6_block_bubble", useStream: false);
		}
		if (chipType == ChipType.Bubble && TetrisGameManager.Instance.bubbleColorIndex > 0)
		{
			chipColorIndex = TetrisGameManager.Instance.bubbleColorIndex;
		}
		else if (Application.isPlaying)
		{
			if (TetrisGameManager.Instance.lockChipColor > 0)
			{
				chipColorIndex = TetrisGameManager.Instance.lockChipColor;
			}
			else if (colorIndex > 0)
			{
				chipColorIndex = colorIndex;
			}
			else
			{
				chipColorIndex = TetrisGameManager.Instance.colorManager.RandomColorType();
			}
		}
		else
		{
			chipColorIndex = UnityEngine.Random.Range(1, 12);
		}
		minX = -1;
		minY = -1;
		maxX = -1;
		maxY = -1;
		originX = -1;
		originY = -1;
		foreach (TetrisGameTileSaveData data in dataList)
		{
			data.chipIndex = index;
			minX = ((minX == -1) ? data.width : Mathf.Min(minX, data.width));
			minY = ((minY == -1) ? data.height : Mathf.Min(minY, data.height));
			maxX = ((maxX == -1) ? data.width : Mathf.Max(maxX, data.width));
			maxY = ((maxY == -1) ? data.height : Mathf.Max(maxY, data.height));
		}
		width = maxX - minX + 1;
		height = maxY - minY + 1;
		RefreshTileInfo(dataList);
	}

	private void RefreshTileInfo(List<TetrisGameTileSaveData> dataList)
	{
		int num = maxY - minY + 1;
		int num2 = maxX - minX + 1;
		tileEntityList = new TetrisGameTileEntity[num * num2];
		tileEntityImgList = new List<Transform>();
		effectList = new List<GameObject>();
		foreach (TetrisGameTileSaveData data in dataList)
		{
			if (CheckIsFull(data.tileType))
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(baseCube, base.transform);
				tileEntityList[data.width - minX + (data.height - minY) * num2] = gameObject.GetComponent<TetrisGameTileEntity>();
				tileEntityList[data.width - minX + (data.height - minY) * num2].isChipTile = true;
				tileEntityList[data.width - minX + (data.height - minY) * num2].chipIndex = chipIndex;
				tileEntityList[data.width - minX + (data.height - minY) * num2].colorIndex = chipColorIndex;
				TetrisGameTileSaveData tetrisGameTileSaveData = new TetrisGameTileSaveData();
				tetrisGameTileSaveData.width = data.width - minX;
				tetrisGameTileSaveData.height = data.height - minY;
				tetrisGameTileSaveData.chipIndex = data.chipIndex;
				tetrisGameTileSaveData.tileType = data.tileType;
				tileEntityList[data.width - minX + (data.height - minY) * num2].SetData(tetrisGameTileSaveData);
				gameObject.transform.localPosition = new Vector3((data.width - minX) * gameManager.cubeSize, (data.height - minY) * gameManager.cubeSize, 0f);
				tileEntityList[data.width - minX + (data.height - minY) * num2].SetTileType(data.tileType);
				gameObject.transform.SetParent(base.transform.parent);
				tileEntityImgList.Add(gameObject.transform.GetChild(0));
			}
		}
		for (int i = 0; i < tileEntityList.GetLength(0); i++)
		{
			if (tileEntityList[i] == null)
			{
				int num3 = i % num2;
				int num4 = i / num2;
				GameObject gameObject2 = UnityEngine.Object.Instantiate(baseCube, base.transform);
				tileEntityList[i] = gameObject2.GetComponent<TetrisGameTileEntity>();
				tileEntityList[i].isChipTile = true;
				tileEntityList[i].SetNullTile();
				gameObject2.transform.localPosition = new Vector3(num3 * gameManager.cubeSize, num4 * gameManager.cubeSize, 0f);
				gameObject2.transform.SetParent(base.transform.parent);
			}
		}
		rectTransform.sizeDelta = new Vector2((maxX - minX + 1) * gameManager.cubeSize, (maxY - minY + 1) * gameManager.cubeSize);
		rectTransform.localPosition = new Vector3((maxX - minX + 1) * gameManager.cubeSize / 2 - gameManager.cubeSize / 2, (maxY - minY + 1) * gameManager.cubeSize / 2 - gameManager.cubeSize / 2, 0f);
		boxCollider.size = new Vector3((maxX - minX + 1) * gameManager.cubeSize, (maxY - minY + 1) * gameManager.cubeSize, 0f);
		oriGrid = tileEntityList[0];
		for (int j = 0; j < tileEntityList.GetLength(0); j++)
		{
			tileEntityList[j].transform.SetParent(base.transform);
			if (chipType == ChipType.Bubble)
			{
				GameObject gameObject3 = UnityEngine.Object.Instantiate(bubbleCxEffectPerfab, base.transform);
				effectList.Add(gameObject3);
				gameObject3.SetActive(value: true);
				gameObject3.transform.localPosition = tileEntityList[j].transform.localPosition;
			}
		}
	}

	public TetrisGameChipSaveData GetSaveData()
	{
		TetrisGameChipSaveData tetrisGameChipSaveData = new TetrisGameChipSaveData();
		tetrisGameChipSaveData.chipIndex = chipIndex;
		tetrisGameChipSaveData.relevanceList = new TetrisGameTileSaveData[tileEntityList.Length];
		for (int i = 0; i < tileEntityList.Length; i++)
		{
			tetrisGameChipSaveData.relevanceList[i] = tileEntityList[i].GetSaveData();
		}
		return tetrisGameChipSaveData;
	}

	public void RotateChip(int index = 1, bool isCreate = false)
	{
		if (isCreate)
		{
			Vector3 vector = new Vector3(0f, 0f, index * -90);
			base.transform.Rotate(vector);
			for (int i = 0; i < tileEntityImgList.Count; i++)
			{
				tileEntityImgList[i].transform.Rotate(-vector);
			}
		}
		else
		{
			if (isRotating)
			{
				return;
			}
			Vector3 vector2 = new Vector3(0f, 0f, index * -90);
			Vector3 beginAngle = base.transform.eulerAngles;
			Vector3 targetAngle = beginAngle + vector2;
			isRotating = true;
			Vector3 localEulerAngles = tileEntityImgList[0].transform.localEulerAngles;
			Vector3 tileAngle = localEulerAngles - vector2;
			LeanTween.value(0f, 1f, 0.1f).setOnUpdate(delegate(float value)
			{
				base.transform.eulerAngles = Vector3.Lerp(beginAngle, targetAngle, value);
				for (int j = 0; j < tileEntityImgList.Count; j++)
				{
					tileEntityImgList[j].transform.localEulerAngles = tileAngle;
				}
			}).setOnComplete((Action)delegate
			{
				base.transform.eulerAngles = targetAngle;
				for (int j = 0; j < tileEntityImgList.Count; j++)
				{
					tileEntityImgList[j].transform.localEulerAngles = tileAngle;
				}
				isRotating = false;
			})
				.setEase(LeanTweenType.easeOutQuad);
		}
	}

	public void RotateToTargetDir(int index)
	{
		index--;
		Vector3 vector = new Vector3(0f, 0f, index * -90);
		base.transform.localEulerAngles = vector;
		for (int i = 0; i < tileEntityImgList.Count; i++)
		{
			tileEntityImgList[i].transform.localEulerAngles = -vector;
		}
	}

	public void RefreshOriginPos()
	{
		oriGrid.transform.SetParent(base.transform.parent);
		Vector2 tileIndexByPosition = gameManager.tileManager.GetTileIndexByPosition(oriGrid.rect.anchoredPosition);
		oriGrid.transform.SetParent(base.transform);
		if (gameManager.tileManager.GetTilePositionByIndex((int)tileIndexByPosition.x, (int)tileIndexByPosition.y, out var _))
		{
			originX = (int)tileIndexByPosition.x;
			originY = (int)tileIndexByPosition.y;
		}
		else
		{
			originX = -1;
			originY = -1;
		}
	}

	public int CalculateCellNum()
	{
		return tileEntityImgList.Count;
	}

	public void ResetChip()
	{
		base.transform.localPosition = Vector3.zero;
		if (TetrisGameManager.Instance.isRunTime)
		{
			base.transform.localScale = new Vector3(TetrisGameManager.Instance.chipScale, TetrisGameManager.Instance.chipScale, 1f);
		}
	}

	public void Dispose()
	{
		if ((bool)base.gameObject)
		{
			UnityEngine.Object.DestroyImmediate(base.gameObject);
		}
	}
}
