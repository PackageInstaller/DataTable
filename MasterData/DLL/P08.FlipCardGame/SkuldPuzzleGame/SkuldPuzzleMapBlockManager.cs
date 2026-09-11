using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace SkuldPuzzleGame;

public class SkuldPuzzleMapBlockManager : MonoBehaviour
{
	public GameObject mapBlockPrefab;

	[HideInInspector]
	public SkuldPuzzleMapBlockEntity[] mapBlockEntityList;

	public Transform blockContent;

	[SerializeField]
	private Transform centerPositionNode;

	[SerializeField]
	private Vector2 oriPosition;

	[SerializeField]
	private float gridSpaceSize;

	private int errorCount;

	public int errorTipsBlockID = -1;

	[SerializeField]
	private Button errorMaskBtn;

	[SerializeField]
	private Transform expectNode;

	[SerializeField]
	private Image backBgImg;

	[SerializeField]
	private Image maskImg;

	[SerializeField]
	private Image pictureImg;

	[SerializeField]
	private Transform decorateNode;

	[SerializeField]
	private GameObject decoratePrefab;

	public List<SkuldPuzzleDecorateEntity> decorateEntityList;

	public int CreateExpectChipID = -1;

	[SerializeField]
	private Transform errorNode;

	[SerializeField]
	private GameObject errorPrefab;

	public List<GameObject> errorObjList;

	public void ShowErrorTip(SkuldPuzzleChipBlockEntity chipBlockEntity)
	{
		HideErrorTip();
		int originX = chipBlockEntity.originX;
		int originY = chipBlockEntity.originY;
		errorTipsBlockID = -1;
		errorCount = 0;
		foreach (SkuldPuzzleTileData tileData in chipBlockEntity.tileDataList)
		{
			SkuldPuzzleTools.CalculateTrueTileIndex(originX, originY, tileData.x, tileData.y, chipBlockEntity.GetRotateAngle(), out var x, out var y);
			int num = x + y * SkuldPuzzleGameManager.Instance.width;
			if (CheckTileInSide(x, y))
			{
				if (!mapBlockEntityList[x + y * SkuldPuzzleGameManager.Instance.width].CheckTileCanPlace(chipBlockEntity))
				{
					ShowErrorTipItem(x, y);
					continue;
				}
				foreach (SkuldPuzzleTileData tileData2 in chipBlockEntity.tileDataList)
				{
					SkuldPuzzleTools.CalculateTrueTileIndex(originX, originY, tileData2.x, tileData2.y, chipBlockEntity.GetRotateAngle(), out var x2, out var y2);
					int num2 = x2 + y2 * SkuldPuzzleGameManager.Instance.width;
					if (num != num2 && SkuldPuzzleGameManager.Instance.banLineManager.IsMeetBan(num, num2))
					{
						ShowErrorTipItem(x, y);
					}
				}
			}
			else
			{
				ShowErrorTipItem(x, y);
			}
		}
		if (errorCount > 0)
		{
			errorTipsBlockID = chipBlockEntity.GetChipBlockByID();
			ShowErrorMaskBtn(isShow: true);
		}
	}

	public void ShowErrorTipItem(int x, int y)
	{
		errorCount++;
		if (errorCount > errorObjList.Count)
		{
			errorObjList.Add(Object.Instantiate(errorPrefab, errorNode));
		}
		GameObject obj = errorObjList[errorCount - 1];
		obj.SetActive(value: true);
		obj.transform.localPosition = new Vector3(oriPosition.x + (float)x * gridSpaceSize, oriPosition.y + (float)y * gridSpaceSize, 0f);
	}

	public void HideErrorTip()
	{
		errorTipsBlockID = -1;
		errorCount = 0;
		ShowErrorMaskBtn(isShow: false);
		foreach (GameObject errorObj in errorObjList)
		{
			errorObj.SetActive(value: false);
		}
	}

	public void ShowErrorMaskBtn(bool isShow)
	{
		if (errorMaskBtn != null)
		{
			errorMaskBtn.gameObject.SetActive(isShow);
		}
	}

	public void OnClickErrorMaskBtn()
	{
		SkuldPuzzleChipBlockEntity chipBlockByID = SkuldPuzzleGameManager.Instance.chipBlockManager.GetChipBlockByID(errorTipsBlockID);
		if (chipBlockByID != null)
		{
			chipBlockByID.ExitMapBlaock();
		}
		HideErrorTip();
	}

	public void AddErrorMaskBtnListener()
	{
		if (errorMaskBtn != null)
		{
			errorMaskBtn.RemoveAllListener();
			errorMaskBtn.onClick.AddListener(delegate
			{
				OnClickErrorMaskBtn();
			});
			ShowErrorMaskBtn(isShow: false);
		}
	}

	public void CreateStage(int width, int height)
	{
		Vector3 localPosition = centerPositionNode.localPosition;
		int num = SkuldPuzzleConst.cubeSize + SkuldPuzzleConst.cubeSpace;
		DisposeBlockEntityListData();
		mapBlockEntityList = new SkuldPuzzleMapBlockEntity[width * height];
		for (int i = 0; i < width * height; i++)
		{
			GameObject obj = Object.Instantiate(mapBlockPrefab, blockContent);
			SkuldPuzzleMapBlockEntity component = obj.GetComponent<SkuldPuzzleMapBlockEntity>();
			mapBlockEntityList[i] = component;
			int num2 = i % width;
			int num3 = i / width;
			obj.transform.localPosition = new Vector2(localPosition.x + (float)(num2 * num) - (float)(width * num / 2) + (float)(num / 2), localPosition.y + (float)(num3 * num) - (float)(height * num / 2) + (float)(num / 2));
		}
	}

	public SkuldPuzzleMapBlockData[] GetMapBlockData()
	{
		SkuldPuzzleMapBlockData[] array = new SkuldPuzzleMapBlockData[mapBlockEntityList.Length];
		for (int i = 0; i < mapBlockEntityList.Length; i++)
		{
			array[i] = mapBlockEntityList[i].GetMapBlockData();
		}
		return array;
	}

	public void CreateStage(SkuldPuzzleStageSaveData stageData)
	{
		CreateStage(stageData.width, stageData.height);
		SkuldPuzzleMapBlockData[] mapBlockData = stageData.mapBlockData;
		for (int i = 0; i < mapBlockData.Length; i++)
		{
			mapBlockEntityList[i].InitData(mapBlockData[i]);
		}
		AddErrorMaskBtnListener();
		errorTipsBlockID = -1;
		oriPosition = mapBlockEntityList[0].transform.localPosition;
		gridSpaceSize = mapBlockEntityList[1].transform.localPosition.x - mapBlockEntityList[0].transform.localPosition.x;
		CreateExpectChipID = -1;
		decorateEntityList = new List<SkuldPuzzleDecorateEntity>();
		errorObjList = new List<GameObject>();
		HideExpectNode(isShow: false);
	}

	public Vector3 GetCenterPosition()
	{
		return centerPositionNode.localPosition;
	}

	public bool CheckTileInSide(int x, int y)
	{
		if (x < 0 || x >= SkuldPuzzleGameManager.Instance.width || y < 0 || y >= SkuldPuzzleGameManager.Instance.height)
		{
			return false;
		}
		return true;
	}

	public bool CheckChipIsCanPlaceByXY(int originX, int originY, SkuldPuzzleChipBlockEntity chipBlockEntity)
	{
		foreach (SkuldPuzzleTileData tileData in chipBlockEntity.tileDataList)
		{
			SkuldPuzzleTools.CalculateTrueTileIndex(originX, originY, tileData.x, tileData.y, chipBlockEntity.GetRotateAngle(), out var x, out var y);
			if (!CheckTileInSide(x, y) || !mapBlockEntityList[x + y * SkuldPuzzleGameManager.Instance.width].CheckTileCanPlace(chipBlockEntity))
			{
				return false;
			}
		}
		return true;
	}

	public bool CheckTileCanPlace(SkuldPuzzleChipBlockEntity chipBlockEntity)
	{
		int originX = chipBlockEntity.originX;
		int originY = chipBlockEntity.originY;
		if (!CheckChipIsCanPlaceByXY(originX, originY, chipBlockEntity))
		{
			return false;
		}
		foreach (SkuldPuzzleTileData tileData in chipBlockEntity.tileDataList)
		{
			SkuldPuzzleTools.CalculateTrueTileIndex(originX, originY, tileData.x, tileData.y, chipBlockEntity.GetRotateAngle(), out var x, out var y);
			int num = x + y * SkuldPuzzleGameManager.Instance.width;
			foreach (SkuldPuzzleTileData tileData2 in chipBlockEntity.tileDataList)
			{
				SkuldPuzzleTools.CalculateTrueTileIndex(originX, originY, tileData2.x, tileData2.y, chipBlockEntity.GetRotateAngle(), out var x2, out var y2);
				int num2 = x2 + y2 * SkuldPuzzleGameManager.Instance.width;
				if (num != num2 && SkuldPuzzleGameManager.Instance.banLineManager.IsMeetBan(num, num2))
				{
					return false;
				}
			}
		}
		return true;
	}

	public Vector2 GetTileIndexByPosition(Vector2 position)
	{
		Vector2 vector = position - oriPosition;
		int num = Mathf.FloorToInt(vector.x / (float)SkuldPuzzleConst.cubeSize + 0.5f);
		int num2 = Mathf.FloorToInt(vector.y / (float)SkuldPuzzleConst.cubeSize + 0.5f);
		return new Vector2(num, num2);
	}

	public Vector3 GetTilePositionByXY(int chipX, int chipY)
	{
		if (mapBlockEntityList[chipX + chipY * SkuldPuzzleGameManager.Instance.width] != null)
		{
			return mapBlockEntityList[chipX + chipY * SkuldPuzzleGameManager.Instance.width].transform.position;
		}
		return Vector3.zero;
	}

	public SkuldPuzzleMapBlockEntity GetTileEntityByXY(int chipX, int chipY)
	{
		if (!CheckTileInSide(chipX, chipY))
		{
			return null;
		}
		if (mapBlockEntityList[chipX + chipY * SkuldPuzzleGameManager.Instance.width] != null)
		{
			return mapBlockEntityList[chipX + chipY * SkuldPuzzleGameManager.Instance.width];
		}
		return null;
	}

	public void CreateExpectEffect(SkuldPuzzleChipBlockEntity chipBlockEntity)
	{
		if (chipBlockEntity.GetChipBlockByID() == CreateExpectChipID)
		{
			return;
		}
		CreateExpectChipID = chipBlockEntity.GetChipBlockByID();
		SkuldPuzzleChipBlockData chipBlockData = chipBlockEntity.GetChipBlockData();
		backBgImg.sprite = SkuldPuzzleTools.GetPuzzleBgSprte(chipBlockEntity.GetShapeChipData().shapeTemplateId, chipBlockData.colorType);
		backBgImg.SetNativeSize();
		maskImg.sprite = SkuldPuzzleTools.GetPuzzleBgSprte(chipBlockEntity.GetShapeChipData().shapeTemplateId);
		maskImg.SetNativeSize();
		pictureImg.sprite = SkuldPuzzleTools.GetPuzzleSprite(chipBlockData.spritePath);
		pictureImg.color = SkuldPuzzleConst.ChipColorDic[chipBlockData.colorType];
		pictureImg.transform.localPosition = new Vector2(chipBlockData.pixelBeginX, chipBlockData.pixelBeginY);
		foreach (SkuldPuzzleDecorateEntity decorateEntity in decorateEntityList)
		{
			decorateEntity.gameObject.SetActive(value: false);
		}
		int num = 0;
		foreach (SkuldPuzzleDecorateData drcorate in chipBlockData.drcorateList)
		{
			SkuldPuzzleDecorateEntity skuldPuzzleDecorateEntity;
			if (num < decorateEntityList.Count)
			{
				skuldPuzzleDecorateEntity = decorateEntityList[num];
			}
			else
			{
				skuldPuzzleDecorateEntity = Object.Instantiate(decoratePrefab, decorateNode).GetComponent<SkuldPuzzleDecorateEntity>();
				decorateEntityList.Add(skuldPuzzleDecorateEntity);
			}
			num++;
			skuldPuzzleDecorateEntity.InitData(drcorate);
			skuldPuzzleDecorateEntity.gameObject.SetActive(value: true);
		}
	}

	public void HideExpectNode(bool isShow)
	{
		expectNode.gameObject.SetActive(isShow);
	}

	public bool CheckPosIsSame(Vector3 pos1, Vector3 pos2)
	{
		if (Mathf.Abs(pos1.x - pos2.x) < 0.1f && Mathf.Abs(pos1.y - pos2.y) < 0.1f && Mathf.Abs(pos1.z - pos2.z) < 0.1f)
		{
			return true;
		}
		return false;
	}

	public void FillExpectTile(SkuldPuzzleChipBlockEntity chipBlockEntity)
	{
		int originX = chipBlockEntity.originX;
		int originY = chipBlockEntity.originY;
		Vector3 tilePositionByXY = SkuldPuzzleGameManager.Instance.mapBlockManager.GetTilePositionByXY(originX, originY);
		Vector3 vector = new Vector3(chipBlockEntity.blockNode.position.x - chipBlockEntity.oriPosNode.position.x, chipBlockEntity.blockNode.position.y - chipBlockEntity.oriPosNode.position.y, chipBlockEntity.blockNode.position.z - chipBlockEntity.oriPosNode.position.z);
		tilePositionByXY = new Vector3(tilePositionByXY.x + vector.x, tilePositionByXY.y + vector.y, tilePositionByXY.z + vector.z);
		CreateExpectEffect(chipBlockEntity);
		if (!CheckPosIsSame(expectNode.position, tilePositionByXY) || !CheckPosIsSame(expectNode.eulerAngles, chipBlockEntity.blockNode.eulerAngles))
		{
			AudioManager.Instance.Play("effect", "minigame_activity_4_0", "minigame_activity_4_0_pintu_stand", useStream: false);
		}
		expectNode.position = tilePositionByXY;
		expectNode.eulerAngles = chipBlockEntity.blockNode.eulerAngles;
		HideExpectNode(isShow: true);
		foreach (SkuldPuzzleTileData tileData in chipBlockEntity.tileDataList)
		{
			SkuldPuzzleTools.CalculateTrueTileIndex(originX, originY, tileData.x, tileData.y, chipBlockEntity.GetRotateAngle(), out var x, out var y);
			if (CheckTileInSide(x, y) && mapBlockEntityList[x + y * SkuldPuzzleGameManager.Instance.width].CheckTileCanPlace(chipBlockEntity))
			{
				mapBlockEntityList[x + y * SkuldPuzzleGameManager.Instance.width].RefreshTileExpectShow(chipBlockEntity.blockNode.eulerAngles);
			}
		}
	}

	public void RefreshTileFullState(SkuldPuzzleChipBlockEntity chipBlockEntity, bool isFull)
	{
		foreach (SkuldPuzzleTileData tileData in chipBlockEntity.tileDataList)
		{
			SkuldPuzzleTools.CalculateTrueTileIndex(chipBlockEntity.originX, chipBlockEntity.originY, tileData.x, tileData.y, chipBlockEntity.GetRotateAngle(), out var x, out var y);
			if (CheckTileInSide(x, y))
			{
				mapBlockEntityList[x + y * SkuldPuzzleGameManager.Instance.width].SetTileTileTypeState(isFull, chipBlockEntity.GetChipBlockByID());
			}
		}
	}

	public void UpdataTileCanPlaceExpectState(SkuldPuzzleChipBlockEntity chipBlockEntity)
	{
		ResetTileDefaultState();
		FillExpectTile(chipBlockEntity);
	}

	public void ResetTileDefaultState()
	{
		for (int i = 0; i < mapBlockEntityList.GetLength(0); i++)
		{
			if (mapBlockEntityList[i] != null)
			{
				mapBlockEntityList[i].RefreshControllerShow();
			}
		}
	}

	public void DisposeErrorObjList()
	{
		if (errorObjList == null)
		{
			return;
		}
		foreach (GameObject errorObj in errorObjList)
		{
			if (errorObj != null)
			{
				Object.Destroy(errorObj);
			}
		}
		errorObjList.Clear();
		errorObjList = null;
	}

	public void DisposeDecorateEntityList()
	{
		if (decorateEntityList == null)
		{
			return;
		}
		foreach (SkuldPuzzleDecorateEntity decorateEntity in decorateEntityList)
		{
			if (decorateEntity != null)
			{
				decorateEntity.Dispose();
			}
		}
		decorateEntityList.Clear();
		decorateEntityList = null;
	}

	public void DisposeBlockEntityListData()
	{
		if (mapBlockEntityList == null)
		{
			return;
		}
		SkuldPuzzleMapBlockEntity[] array = mapBlockEntityList;
		foreach (SkuldPuzzleMapBlockEntity skuldPuzzleMapBlockEntity in array)
		{
			if (skuldPuzzleMapBlockEntity != null)
			{
				skuldPuzzleMapBlockEntity.Dispose();
			}
		}
		mapBlockEntityList = null;
	}

	public void Dispose()
	{
		DisposeErrorObjList();
		DisposeDecorateEntityList();
		DisposeBlockEntityListData();
	}
}
