using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace TangramGame;

public class TangramGameChip : MonoBehaviour
{
	public GameObject baseCube;

	[HideInInspector]
	public RectTransform rectTransform;

	public TangramGameStageManager stageManager;

	[HideInInspector]
	public TangramTileController oriGrid;

	public Transform trueBgTrs;

	public Transform falseBgTrs;

	public GameObject trueCubeBg;

	public GameObject falseCubeBg;

	public Transform shadowTrs;

	public RectTransform shadowRect;

	public GameObject shadowCubeBg;

	public GameObject shadowTriggerBg;

	public GameObject trueTriggerBg;

	public GameObject falseTriggerBg;

	public BoxCollider2D boxCollider;

	public GameObject tileGameList;

	public GameObject rotateBtnGo;

	public Button rotateBtn;

	public Image chipTopImage;

	private IUIController controller;

	[HideInInspector]
	public Transform fatherTransform;

	[HideInInspector]
	public int answerX;

	[HideInInspector]
	public int answerY;

	[HideInInspector]
	public int startRotate;

	[HideInInspector]
	public TangramGameConst.TILE_TYPE[] tileInfo;

	[HideInInspector]
	public TangramTileController[] tileEntityList;

	[HideInInspector]
	public bool isDrag;

	[HideInInspector]
	public short chipIndex;

	[HideInInspector]
	public bool isLocate;

	[HideInInspector]
	public bool isFill;

	[HideInInspector]
	public int originX;

	[HideInInspector]
	public int originY;

	[HideInInspector]
	public int width;

	[HideInInspector]
	public int height;

	[HideInInspector]
	public bool isDestination;

	[HideInInspector]
	public int offsetDeltaX = 20;

	[HideInInspector]
	public int offsetDeltaY = 20;

	[HideInInspector]
	public Vector3 oriPosition;

	[HideInInspector]
	public Vector3 oriAngles;

	private Vector2 oriShadowCenter;

	[HideInInspector]
	[SerializeField]
	public List<TangramChipTileData> relevanceList;

	[HideInInspector]
	[SerializeField]
	private int minX = -1;

	[HideInInspector]
	[SerializeField]
	private int minY = -1;

	[HideInInspector]
	[SerializeField]
	private int maxX = -1;

	[HideInInspector]
	[SerializeField]
	private int maxY = -1;

	[Header("策划配置部分")]
	public bool canRotate;

	public bool needCutout;

	[SerializeField]
	public Sprite chipImage;

	private const string abHead = "Assets/ABResources/";

	private const string atlasHead = "Assets/UIResources/UI_AB/";

	private const int shadowOffset = 8;

	private List<TangramChipTileData> tmpTileData;

	private int tmpTileIndex;

	private int tmpEmptyTitleIndex;

	private int tmpIndex;

	private int tmptileLength;

	[HideInInspector]
	public bool isLoadComplete;

	private int[] nextX = new int[4] { 0, 1, 0, -1 };

	private int[] nextY = new int[4] { 1, 0, -1, 0 };

	public void Start()
	{
		rectTransform = base.gameObject.GetComponent<RectTransform>();
		fatherTransform = base.gameObject.transform.parent;
		rotateBtn.onClick.AddListener(delegate
		{
			if (canRotate && !isDrag && !isDestination)
			{
				RotateChip();
				SetDragState();
				TangramManager.Instance.curStageManager.tileManager.CheckStageFin();
			}
		});
	}

	public void RefreshOriginPos()
	{
		oriGrid.transform.SetParent(base.transform.parent, worldPositionStays: true);
		Vector2 tileIndexByPosition = stageManager.tileManager.GetTileIndexByPosition(oriGrid.rect.anchoredPosition);
		oriGrid.transform.SetParent(tileGameList.transform, worldPositionStays: true);
		if (TangramManager.Instance.curStageManager.tileManager.GetTilePositionByIndex((int)tileIndexByPosition.x, (int)tileIndexByPosition.y, out var _))
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

	public void Dispose()
	{
		if (tileEntityList != null)
		{
			TangramTileController[] array = tileEntityList;
			foreach (TangramTileController tangramTileController in array)
			{
				if ((bool)tangramTileController)
				{
					tangramTileController.Dispose();
				}
			}
		}
		if (relevanceList != null)
		{
			relevanceList.Clear();
			relevanceList = null;
		}
		if (tmpTileData != null)
		{
			tmpTileData.Clear();
			tmpTileData = null;
		}
		if ((bool)base.gameObject)
		{
			Object.DestroyImmediate(base.gameObject);
		}
	}

	public void ResetChip()
	{
		originX = -1;
		originY = -1;
		isFill = false;
		SetDragState();
		base.transform.SetParent(fatherTransform, worldPositionStays: true);
		base.transform.position = oriPosition;
		base.transform.eulerAngles = oriAngles;
	}

	public void ChangeImage()
	{
		if (!chipImage)
		{
			return;
		}
		if (needCutout)
		{
			chipTopImage.gameObject.SetActive(value: false);
			return;
		}
		chipTopImage.gameObject.SetActive(value: true);
		chipTopImage.sprite = chipImage;
		if (!needCutout && TangramManager.Instance.isRunTime)
		{
			TangramTileController[] array = tileEntityList;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].CloseImage();
			}
		}
	}

	public void ChangeItemImage(TangramTileController tile)
	{
		if ((bool)chipImage && (bool)tile && needCutout)
		{
			tile.SetImage(chipImage);
		}
	}

	public void GoToFinialPos()
	{
		rectTransform = base.gameObject.GetComponent<RectTransform>();
		rectTransform.localRotation = Quaternion.identity;
		fatherTransform = base.gameObject.transform.parent;
		Vector3 vector = base.transform.position - oriGrid.transform.position;
		base.transform.position = stageManager.tileManager.tileEntites[answerX, answerY].transform.position + vector;
		isDestination = true;
	}

	public bool CheckTileIsDestination()
	{
		if (isDestination)
		{
			return true;
		}
		int num = Mathf.RoundToInt(Mathf.Abs(base.transform.eulerAngles.y) / 90f) % 4;
		if (answerX == originX && answerY == originY && num == 0)
		{
			return true;
		}
		return false;
	}

	public void RotateChip()
	{
		if (isFill)
		{
			TangramManager.Instance.curStageManager.tileManager.RemoveTile(this);
			isFill = false;
			TangramManager.Instance.curStageManager.chipManager.RefreshOtherChipState(this);
		}
		base.transform.Rotate(new Vector3(0f, 0f, -90f));
		base.transform.SetParent(GetComponentInParent<TangramGameStageManager>().transform, worldPositionStays: true);
		base.transform.SetAsLastSibling();
		TangramManager.Instance.curStageManager.tileManager.GetTileIndexByPosition(rectTransform.anchoredPosition);
		bool num = Mathf.RoundToInt(Mathf.Abs(rectTransform.localRotation.eulerAngles.z) / 90f) % 2 == 1;
		int num2 = (num ? height : width);
		int num3 = (num ? width : height);
		if (isLocate)
		{
			Vector2 vector = new Vector2(0f, 0f);
			if ((num2 % 2 == 1 && num3 % 2 == 0) || (num2 % 2 == 0 && num3 % 2 == 1))
			{
				switch (Mathf.RoundToInt(Mathf.Abs(rectTransform.localRotation.eulerAngles.z)) / 90)
				{
				case 0:
					vector.x = TangramManager.Instance.curStageManager.CUBE_SIZE / 2f;
					vector.y = (0f - TangramManager.Instance.curStageManager.CUBE_SIZE) / 2f;
					break;
				case 1:
					vector.x = TangramManager.Instance.curStageManager.CUBE_SIZE / 2f;
					vector.y = TangramManager.Instance.curStageManager.CUBE_SIZE / 2f;
					break;
				case 2:
					vector.x = (0f - TangramManager.Instance.curStageManager.CUBE_SIZE) / 2f;
					vector.y = TangramManager.Instance.curStageManager.CUBE_SIZE / 2f;
					break;
				case 3:
					vector.x = (0f - TangramManager.Instance.curStageManager.CUBE_SIZE) / 2f;
					vector.y = (0f - TangramManager.Instance.curStageManager.CUBE_SIZE) / 2f;
					break;
				}
			}
			rectTransform.anchoredPosition += vector;
			RefreshOriginPos();
			TangramManager.Instance.curStageManager.chipManager.RefreshIsCanPlace(this);
			if (TangramManager.Instance.curStageManager.tileManager.CheckTileCanPlace(this))
			{
				TangramManager.Instance.curStageManager.tileManager.FillTile(this);
			}
		}
		AdjustShadowGoPos();
	}

	public void SetDragState()
	{
		if (controller == null)
		{
			controller = base.transform.GetComponent<IUIController>();
		}
		if (isFill)
		{
			controller.SetSelectedState("none");
		}
		else if (isDrag)
		{
			controller.SetSelectedState("canplace");
		}
		else
		{
			controller.SetSelectedState("idle");
		}
	}

	public void InitNewChip(List<TangramChipTileData> dataList, int index)
	{
		GenerateTileList(dataList, index);
	}

	public void InitNewChip(TangramChipData chipData)
	{
		answerX = chipData.answerX;
		answerY = chipData.answerY;
		needCutout = chipData.needCutout;
		startRotate = chipData.startAngle;
		canRotate = chipData.isRotate;
		if (!string.IsNullOrEmpty(chipData.spritePath))
		{
			Sprite sprite = AssetEx.LoadSprite(chipData.spritePath.Substring("Assets/ABResources/".Length));
			if (sprite == null)
			{
				sprite = AtlasManager.GetSpriteWithoutAtlas(chipData.spritePath.Substring("Assets/UIResources/UI_AB/".Length));
			}
			chipImage = sprite;
		}
		rotateBtnGo.SetActive(value: false);
		InitNewChip(chipData.relevanceList, chipData.chipIndex);
		base.transform.eulerAngles = chipData.eulerAngles;
		base.transform.localPosition = chipData.position;
		oriPosition = base.transform.position;
		oriAngles = chipData.eulerAngles;
		SetDragState();
	}

	public void GenerateTileList(List<TangramChipTileData> dataList, int index)
	{
		rectTransform = base.gameObject.GetComponent<RectTransform>();
		base.transform.localPosition = new Vector3(0f, 0f, 0f);
		chipIndex = (short)index;
		List<TangramChipTileData> list = new List<TangramChipTileData>();
		minX = -1;
		minY = -1;
		maxX = -1;
		maxY = -1;
		foreach (TangramChipTileData data in dataList)
		{
			if (data.chipIndex == index)
			{
				minX = ((minX == -1) ? data.x : Mathf.Min(minX, data.x));
				minY = ((minY == -1) ? data.y : Mathf.Min(minY, data.y));
				maxX = ((maxX == -1) ? data.x : Mathf.Max(maxX, data.x));
				maxY = ((maxY == -1) ? data.y : Mathf.Max(maxY, data.y));
				TangramChipTileData tangramChipTileData = new TangramChipTileData(data.x, data.y);
				tangramChipTileData.chipIndex = data.chipIndex;
				tangramChipTileData.tileType = data.tileType;
				list.Add(tangramChipTileData);
			}
		}
		answerX = minX;
		answerY = minY;
		width = maxX - minX + 1;
		height = maxY - minY + 1;
		relevanceList = list;
		RefreshTileInfo(list);
	}

	private void Update()
	{
		LoadItemTile();
		if (tmpTileData != null && tileEntityList != null && tmpTileData.Count > 0 && tmpTileData.Count <= tmpTileIndex)
		{
			LoadItemTile();
			LoadItemTile();
			LoadItemTile();
		}
	}

	private bool CheckIsNeedInstantiateShadow(int x, int y, int row)
	{
		if (minX == x || maxX == x || minY == y || maxY == y)
		{
			return true;
		}
		for (int i = 0; i <= 3; i++)
		{
			int num = nextX[i];
			int num2 = nextY[i];
			int num3 = x - minX + num + (y - minY + num2) * row;
			if (tileInfo.Length > num3 && num3 >= 0)
			{
				if (tileInfo[num3] != TangramGameConst.TILE_TYPE.FULL)
				{
					return true;
				}
				continue;
			}
			return true;
		}
		return false;
	}

	private void LoadItemTile()
	{
		if (tmpTileData == null || tileEntityList == null || tmpTileData.Count <= 0)
		{
			return;
		}
		_ = maxY;
		_ = minY;
		int num = maxX - minX + 1;
		if (tmpTileData.Count > tmpTileIndex)
		{
			TangramChipTileData tangramChipTileData = tmpTileData[tmpTileIndex];
			GameObject gameObject = Object.Instantiate(baseCube, tileGameList.transform);
			int num2 = tangramChipTileData.x - minX + (tangramChipTileData.y - minY) * num;
			tileEntityList[num2] = gameObject.GetComponent<TangramTileController>();
			tileEntityList[num2].x = tangramChipTileData.x - minX;
			tileEntityList[num2].y = tangramChipTileData.y - minY;
			List<TangramChipTileData> list = new List<TangramChipTileData>();
			TangramChipTileData tangramChipTileData2 = new TangramChipTileData(tangramChipTileData.x, tangramChipTileData.y);
			tangramChipTileData2.tileType = tangramChipTileData.tileType;
			tangramChipTileData2.chipIndex = tangramChipTileData.chipIndex;
			list.Add(tangramChipTileData2);
			if (tangramChipTileData.tileType != TangramGameConst.TILE_TYPE.FULL && tangramChipTileData.tileType != TangramGameConst.TILE_TYPE.EMPTY)
			{
				list.Add(new TangramChipTileData(tangramChipTileData.x, tangramChipTileData.y));
				tileEntityList[num2].tileTpye = TangramGameConst.TILE_DATA_TYPE.TIGGER;
				tileEntityList[num2].oldType = TangramGameConst.TILE_DATA_TYPE.TIGGER;
			}
			tileEntityList[num2].dataList = list;
			tileEntityList[num2].isChipTile = true;
			tileEntityList[num2].curType = tangramChipTileData.tileType;
			if (CheckIsNeedInstantiateShadow(tangramChipTileData.x, tangramChipTileData.y, num))
			{
				GameObject gameObject2;
				GameObject gameObject3;
				if (tangramChipTileData.tileType != TangramGameConst.TILE_TYPE.FULL && tangramChipTileData.tileType != TangramGameConst.TILE_TYPE.EMPTY)
				{
					gameObject2 = Object.Instantiate(trueTriggerBg, trueBgTrs);
					gameObject3 = Object.Instantiate(falseTriggerBg, falseBgTrs);
					RotateTriggerGo(tangramChipTileData.tileType, gameObject2.transform);
					RotateTriggerGo(tangramChipTileData.tileType, gameObject3.transform);
				}
				else
				{
					gameObject2 = Object.Instantiate(trueCubeBg, trueBgTrs);
					gameObject3 = Object.Instantiate(falseCubeBg, falseBgTrs);
				}
				gameObject2.transform.localPosition = new Vector3((float)(tangramChipTileData.x - minX) * stageManager.CUBE_SIZE, (float)(tangramChipTileData.y - minY) * stageManager.CUBE_SIZE, 0f);
				gameObject3.transform.localPosition = new Vector3((float)(tangramChipTileData.x - minX) * stageManager.CUBE_SIZE, (float)(tangramChipTileData.y - minY) * stageManager.CUBE_SIZE, 0f);
			}
			tileEntityList[num2].RefreshState();
			gameObject.transform.localPosition = new Vector3((float)(tangramChipTileData.x - minX) * stageManager.CUBE_SIZE - rectTransform.sizeDelta.x / 2f + (float)offsetDeltaX, (float)(tangramChipTileData.y - minY) * stageManager.CUBE_SIZE - rectTransform.sizeDelta.y / 2f + (float)offsetDeltaY, 0f);
			gameObject.transform.SetParent(base.transform.parent);
			tmpTileIndex++;
			ChangeItemImage(tileEntityList[num2]);
			stageManager.tileManager.showNodeCanvas.alpha = Mathf.Max((float)tmpTileIndex / (float)tmpTileData.Count, stageManager.tileManager.showNodeCanvas.alpha);
			if (tmpTileIndex == tmpTileData.Count)
			{
				stageManager.tileManager.shadowCubeNode.gameObject.SetActive(value: true);
				stageManager.tileManager.shadowTriggerNode.gameObject.SetActive(value: true);
			}
		}
		else if (tmptileLength > tmpEmptyTitleIndex)
		{
			stageManager.tileManager.shadowCubeCanvas.alpha = Mathf.Max((float)tmpEmptyTitleIndex / (float)tmptileLength, stageManager.tileManager.shadowCubeCanvas.alpha);
			stageManager.tileManager.shadowTriggerCanvas.alpha = stageManager.tileManager.shadowCubeCanvas.alpha;
			TangramTileController tangramTileController = tileEntityList[tmpEmptyTitleIndex];
			while (tangramTileController != null)
			{
				tmpEmptyTitleIndex++;
				if (tmpEmptyTitleIndex > tmptileLength - 1)
				{
					return;
				}
				tangramTileController = tileEntityList[tmpEmptyTitleIndex];
			}
			int num3 = tmpEmptyTitleIndex % num;
			int num4 = tmpEmptyTitleIndex / num;
			GameObject gameObject4 = Object.Instantiate(baseCube, base.transform);
			tileEntityList[tmpEmptyTitleIndex] = gameObject4.GetComponent<TangramTileController>();
			tileEntityList[tmpEmptyTitleIndex].isChipTile = true;
			tileEntityList[tmpEmptyTitleIndex].SetNullTile();
			gameObject4.transform.localPosition = new Vector3((float)num3 * stageManager.CUBE_SIZE - rectTransform.sizeDelta.x / 2f + (float)offsetDeltaX, (float)num4 * stageManager.CUBE_SIZE - rectTransform.sizeDelta.y / 2f + (float)offsetDeltaY, 0f);
			gameObject4.transform.SetParent(base.transform.parent);
		}
		else if (tmptileLength > tmpIndex)
		{
			if (tmpIndex == 0)
			{
				oriGrid = tileEntityList[0];
			}
			tileEntityList[tmpIndex].transform.SetParent(tileGameList.transform);
			tileEntityList[tmpIndex].transform.GetComponent<TangramGameChipEvent>().chipEntity = this;
			if (tmpIndex == tmptileLength - 1)
			{
				ChangeImage();
				oriShadowCenter = shadowRect.anchoredPosition;
				isLoadComplete = true;
				SetChipPosData();
			}
			tmpIndex++;
		}
	}

	private void SetChipPosData()
	{
		rotateBtnGo.SetActive(canRotate);
	}

	private void RefreshTileInfo(List<TangramChipTileData> dataList)
	{
		tmpTileIndex = 0;
		tmpEmptyTitleIndex = 0;
		tmpIndex = 0;
		int num = maxY - minY + 1;
		int num2 = maxX - minX + 1;
		tileInfo = new TangramGameConst.TILE_TYPE[num * num2];
		tileEntityList = new TangramTileController[num * num2];
		for (int i = 0; i < tileInfo.Length; i++)
		{
			tileInfo[i] = TangramGameConst.TILE_TYPE.EMPTY;
		}
		foreach (TangramChipTileData data in dataList)
		{
			tileInfo[data.x - minX + (data.y - minY) * num2] = data.tileType;
		}
		tmpTileData = dataList;
		tmptileLength = tileEntityList.GetLength(0);
		rectTransform.sizeDelta = new Vector2((float)(maxX - minX + 1) * stageManager.CUBE_SIZE, (float)(maxY - minY + 1) * stageManager.CUBE_SIZE);
		rectTransform.localPosition = new Vector3((float)(maxX - minX + 1) * stageManager.CUBE_SIZE / 2f - stageManager.CUBE_SIZE / 2f, (float)(maxY - minY + 1) * stageManager.CUBE_SIZE / 2f - stageManager.CUBE_SIZE / 2f, 0f);
		if (controller == null)
		{
			controller = base.transform.GetComponent<IUIController>();
		}
		controller.SetSelectedState("none");
	}

	private void AdjustShadowGoPos()
	{
		switch (Mathf.RoundToInt(Mathf.Abs(rectTransform.eulerAngles.z) / 90f) % 4)
		{
		case 0:
			shadowRect.anchoredPosition = oriShadowCenter + new Vector2(8f, -8f);
			break;
		case 1:
			shadowRect.anchoredPosition = oriShadowCenter + new Vector2(-8f, -8f);
			break;
		case 2:
			shadowRect.anchoredPosition = oriShadowCenter + new Vector2(-8f, 8f);
			break;
		case 3:
			shadowRect.anchoredPosition = oriShadowCenter + new Vector2(8f, 8f);
			break;
		}
	}

	private void RotateTriggerGo(TangramGameConst.TILE_TYPE type, Transform trs)
	{
		switch (type)
		{
		case TangramGameConst.TILE_TYPE.LEFT_LOW:
			trs.eulerAngles = new Vector3(0f, 0f, 0f) + trs.transform.parent.eulerAngles;
			break;
		case TangramGameConst.TILE_TYPE.LEFT_HIGH:
			trs.transform.eulerAngles = new Vector3(0f, 0f, 270f) + trs.transform.parent.eulerAngles;
			break;
		case TangramGameConst.TILE_TYPE.RIGHT_HIGH:
			trs.transform.eulerAngles = new Vector3(0f, 0f, 180f) + trs.transform.parent.eulerAngles;
			break;
		case TangramGameConst.TILE_TYPE.RIGHT_LOW:
			trs.transform.eulerAngles = new Vector3(0f, 0f, 90f) + trs.transform.parent.eulerAngles;
			break;
		}
	}

	private void OnValidate()
	{
		ChangeImage();
		rotateBtnGo.SetActive(canRotate);
	}
}
