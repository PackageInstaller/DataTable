using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace SkuldPuzzleGame;

public class SkuldPuzzleChipBlockEntity : MonoBehaviour
{
	[Header("策划编辑部分")]
	public SkuldPuzzleChipBlockData chipBlockData;

	public Sprite chipBlockSprite;

	[Header("策划不要管")]
	[SerializeField]
	private int chipWidth;

	[SerializeField]
	private int chipHeight;

	private SkuldPuzzleShapeChipData shapeChipData;

	public SkuldPuzzleChipEvent chipEvent;

	public bool isFillInMap;

	public bool isFilling;

	public bool isStoryMode;

	[SerializeField]
	private GameObject clickAreaObj;

	public Transform oriPosNode;

	[HideInInspector]
	public bool isDrag;

	[HideInInspector]
	public int originX;

	[HideInInspector]
	public int originY;

	[HideInInspector]
	public bool isRotating;

	public List<SkuldPuzzleTileData> tileDataList;

	public Transform blockNode;

	[SerializeField]
	private Image backBgImg;

	[SerializeField]
	private UIImageOutline backBgOutLine;

	[SerializeField]
	private Image maskImg;

	[SerializeField]
	private Image pictureImg;

	[SerializeField]
	private Transform decorateNode;

	[SerializeField]
	private GameObject decoratePrefab;

	public List<SkuldPuzzleDecorateEntity> decorateEntityList;

	[SerializeField]
	private Transform blackBlock;

	[SerializeField]
	private Image blackImg;

	[SerializeField]
	private GameObject chipImgNode;

	private GameObject cloneChipImgNodeObj;

	private IUIController controller;

	[SerializeField]
	private Transform colliderNode;

	[SerializeField]
	private GameObject colliderPrefab;

	[SerializeField]
	private List<GameObject> colliderObjList;

	public void InitChipBlockData(SkuldPuzzleChipBlockData blockData)
	{
		chipEvent.chipEntity = this;
		isDrag = false;
		isFillInMap = false;
		isFilling = false;
		originX = -1;
		originY = -1;
		chipBlockData = blockData;
		controller = base.transform.GetComponent<IUIController>();
		InitShapeChipData();
		InitChipShape();
		InitChipSpirte();
		InitDecorate();
		Invoke("InitBlackBlock", 0.2f);
		InitCollider();
	}

	private void InitShapeChipData()
	{
		if (SkuldPuzzleGameManager.Instance != null)
		{
			shapeChipData = SkuldPuzzleGameManager.Instance.GetShapeTemplate(chipBlockData.shapeTemplateId);
			chipWidth = shapeChipData.width;
			chipHeight = shapeChipData.height;
		}
	}

	private void InitChipShape()
	{
		if (shapeChipData != null)
		{
			backBgImg.sprite = SkuldPuzzleTools.GetPuzzleBgSprte(shapeChipData.shapeTemplateId, chipBlockData.colorType);
			backBgImg.SetNativeSize();
			maskImg.sprite = SkuldPuzzleTools.GetPuzzleBgSprte(shapeChipData.shapeTemplateId);
			maskImg.SetNativeSize();
			blackImg.sprite = SkuldPuzzleTools.GetPuzzleBgSprte(shapeChipData.shapeTemplateId, chipBlockData.colorType);
			blackImg.SetNativeSize();
			tileDataList = shapeChipData.tileList;
		}
		RefreshContentLayout();
	}

	private void InitChipSpirte()
	{
		pictureImg.sprite = SkuldPuzzleTools.GetPuzzleSprite(chipBlockData.spritePath);
		pictureImg.color = SkuldPuzzleConst.ChipColorDic[chipBlockData.colorType];
		pictureImg.transform.localPosition = new Vector2(chipBlockData.pixelBeginX, chipBlockData.pixelBeginY);
		pictureImg.transform.localScale = Vector3.one * chipBlockData.pixelScale;
	}

	public void InitDecorate()
	{
		foreach (SkuldPuzzleDecorateData drcorate in chipBlockData.drcorateList)
		{
			GenerateDecorateEntity(drcorate);
		}
	}

	public void InitBlackBlock()
	{
		if (cloneChipImgNodeObj != null)
		{
			UnityEngine.Object.DestroyImmediate(cloneChipImgNodeObj);
		}
		cloneChipImgNodeObj = null;
		cloneChipImgNodeObj = UnityEngine.Object.Instantiate(chipImgNode, blackBlock);
		cloneChipImgNodeObj.transform.SetAsFirstSibling();
		if (controller != null)
		{
			controller.SetSelectedState("false");
		}
	}

	public void GenerateDecorateEntity(SkuldPuzzleDecorateData decorateData)
	{
		SkuldPuzzleDecorateEntity component = UnityEngine.Object.Instantiate(decoratePrefab, decorateNode).GetComponent<SkuldPuzzleDecorateEntity>();
		component.InitData(decorateData);
		decorateEntityList.Add(component);
	}

	public void RefreshContentLayout()
	{
		int num = chipWidth - 1;
		int num2 = chipHeight - 1;
		int num3 = -num * SkuldPuzzleConst.chipCubeSize - num * SkuldPuzzleConst.cubeSpace;
		int num4 = -num2 * SkuldPuzzleConst.chipCubeSize - num2 * SkuldPuzzleConst.cubeSpace;
		oriPosNode.localPosition = new Vector2(num3 / 2, num4 / 2);
	}

	public void InitCollider()
	{
		DisposeColliderList();
		colliderObjList = new List<GameObject>();
		foreach (SkuldPuzzleTileData tileData in tileDataList)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(colliderPrefab, colliderNode);
			gameObject.transform.localPosition = new Vector2((float)(tileData.x * 153) + oriPosNode.localPosition.x, (float)(tileData.y * 153) + oriPosNode.localPosition.y);
			colliderObjList.Add(gameObject);
		}
	}

	public bool CheckIsSameErrorTipsBlockID()
	{
		return SkuldPuzzleGameManager.Instance.mapBlockManager.errorTipsBlockID == GetChipBlockByID();
	}

	public bool CheckIsCanHandleInErrorTips()
	{
		if (SkuldPuzzleGameManager.Instance.mapBlockManager.errorTipsBlockID == -1)
		{
			return true;
		}
		if (CheckIsSameErrorTipsBlockID())
		{
			return true;
		}
		return false;
	}

	public SkuldPuzzleShapeChipData GetShapeChipData()
	{
		return shapeChipData;
	}

	public int GetChipBlockByID()
	{
		return chipBlockData.chipID;
	}

	public ColorType GetColorType()
	{
		return chipBlockData.colorType;
	}

	public SkuldPuzzleChipBlockData GetChipBlockData()
	{
		return chipBlockData;
	}

	public void RefreshOriginPos()
	{
		oriPosNode.SetParent(SkuldPuzzleGameManager.Instance.mapBlockManager.blockContent);
		Vector2 tileIndexByPosition = SkuldPuzzleGameManager.Instance.mapBlockManager.GetTileIndexByPosition(oriPosNode.localPosition);
		oriPosNode.SetParent(blockNode.transform);
		int x = (int)tileIndexByPosition.x;
		int y = (int)tileIndexByPosition.y;
		if (SkuldPuzzleGameManager.Instance.mapBlockManager.CheckTileInSide(x, y))
		{
			originX = x;
			originY = y;
		}
		else
		{
			originX = -1;
			originY = -1;
		}
	}

	public void SetChipIsInGrid(bool isExitGrid)
	{
		if (isExitGrid)
		{
			clickAreaObj.SetActive(value: false);
			blockNode.SetParent(SkuldPuzzleGameManager.Instance.chipBlockManager.transform);
			blockNode.localScale = Vector3.one;
			blockNode.SetAsLastSibling();
			backBgOutLine._OutlineWidth = 0f;
		}
		else
		{
			clickAreaObj.SetActive(value: true);
			blockNode.SetParent(base.transform);
			blockNode.localPosition = Vector3.zero;
			blockNode.localScale = Vector3.one * 0.3f;
			backBgOutLine._OutlineWidth = 4f;
		}
		if (controller != null)
		{
			controller.SetSelectedState(isExitGrid ? "true" : "false");
		}
	}

	public float GetRotateAngle()
	{
		return blockNode.eulerAngles.z;
	}

	public void RotateChipInMapBalock()
	{
		if (!isStoryMode && !isRotating)
		{
			if (SkuldPuzzleGameManager.Instance.mapBlockManager.errorTipsBlockID == -1)
			{
				SkuldPuzzleGameManager.Instance.mapBlockManager.RefreshTileFullState(this, isFull: false);
			}
			Vector3 eulerAngles = new Vector3(0f, 0f, blockNode.eulerAngles.z - 90f);
			blockNode.eulerAngles = eulerAngles;
			blackBlock.eulerAngles = eulerAngles;
			Vector3 tilePositionByXY = SkuldPuzzleGameManager.Instance.mapBlockManager.GetTilePositionByXY(originX, originY);
			Vector3 vector = new Vector3(blockNode.position.x - oriPosNode.position.x, blockNode.position.y - oriPosNode.position.y, blockNode.position.z - oriPosNode.position.z);
			tilePositionByXY = new Vector3(tilePositionByXY.x + vector.x, tilePositionByXY.y + vector.y, tilePositionByXY.z + vector.z);
			blockNode.position = tilePositionByXY;
			RefreshOriginPos();
			if (SkuldPuzzleGameManager.Instance.mapBlockManager.CheckTileCanPlace(this))
			{
				SkuldPuzzleGameManager.Instance.mapBlockManager.RefreshTileFullState(this, isFull: true);
				SkuldPuzzleGameManager.Instance.conditionManager.UpdateConditionStatus();
				SkuldPuzzleGameManager.Instance.mapBlockManager.HideErrorTip();
			}
			else
			{
				SkuldPuzzleGameManager.Instance.mapBlockManager.ShowErrorTip(this);
			}
		}
	}

	public void RotateChip()
	{
		if (!isRotating)
		{
			Vector3 vector = new Vector3(0f, 0f, -90f);
			Vector3 beginAngle = blockNode.eulerAngles;
			Vector3 targetAngle = beginAngle + vector;
			isRotating = true;
			LeanTween.value(0f, 1f, 0.1f).setOnUpdate(delegate(float value)
			{
				blockNode.eulerAngles = Vector3.Lerp(beginAngle, targetAngle, value);
				blackBlock.eulerAngles = Vector3.Lerp(beginAngle, targetAngle, value);
			}).setOnComplete((Action)delegate
			{
				blockNode.eulerAngles = targetAngle;
				blackBlock.eulerAngles = targetAngle;
				isRotating = false;
			})
				.setEase(LeanTweenType.easeOutQuad);
		}
	}

	public void RotateChip(DIR dir)
	{
		if (!isRotating)
		{
			_ = blockNode.eulerAngles;
			Vector3 eulerAngles = new Vector3(0f, 0f, (int)(dir - 0) * -90);
			blockNode.eulerAngles = eulerAngles;
			blackBlock.eulerAngles = eulerAngles;
		}
	}

	public bool IsSameDir(DIR dir)
	{
		int num = (int)(dir - 0) * -90;
		int num2 = (int)blockNode.eulerAngles.z;
		int num3 = (num + 360) % 360;
		num2 = (num2 + 360) % 360;
		return num3 == num2;
	}

	public void OpenStoryMode(bool open)
	{
		if (open && chipBlockData.storyData.storyFillX > -1 && chipBlockData.storyData.storyFillY > -1)
		{
			isStoryMode = true;
			if (!isFillInMap)
			{
				SetChipIsInGrid(isExitGrid: true);
				originX = chipBlockData.storyData.storyFillX;
				originY = chipBlockData.storyData.storyFillY;
				RotateChip(chipBlockData.storyData.storyFillDir);
				chipEvent.PutChipToMap();
			}
		}
		else
		{
			isStoryMode = false;
		}
	}

	public void ExitMapBlaock(bool isStoryMode = true)
	{
		if (isFillInMap && (!isStoryMode || originX != chipBlockData.storyData.storyFillX || originY != chipBlockData.storyData.storyFillY || !IsSameDir(chipBlockData.storyData.storyFillDir)))
		{
			if (!CheckIsSameErrorTipsBlockID())
			{
				SkuldPuzzleGameManager.Instance.mapBlockManager.RefreshTileFullState(this, isFull: false);
			}
			isFillInMap = false;
			SetChipIsInGrid(isExitGrid: false);
		}
	}

	public void Dispose()
	{
		if ((bool)base.gameObject)
		{
			SetChipIsInGrid(isExitGrid: false);
			UnityEngine.Object.DestroyImmediate(base.gameObject);
		}
		DisposeList();
	}

	private void DisposeColliderList()
	{
		if (colliderObjList == null)
		{
			return;
		}
		foreach (GameObject colliderObj in colliderObjList)
		{
			UnityEngine.Object.DestroyImmediate(colliderObj);
		}
		colliderObjList.Clear();
		colliderObjList = null;
	}

	public void DisposeList()
	{
		DisposeColliderList();
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
}
