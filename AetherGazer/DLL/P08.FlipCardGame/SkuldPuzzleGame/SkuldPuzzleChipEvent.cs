using System;
using UnityEngine;
using UnityEngine.EventSystems;

namespace SkuldPuzzleGame;

public class SkuldPuzzleChipEvent : EventTrigger
{
	public SkuldPuzzleChipBlockEntity chipEntity;

	private Vector3 offsetPos;

	private float timeCount;

	private const float freshTime = 0.03f;

	public override void OnBeginDrag(PointerEventData eventData)
	{
		if (SkuldPuzzleGameManager.Instance.mapBlockManager.errorTipsBlockID < 0 && SkuldPuzzleGameManager.Instance.IsCanDragChip(chipEntity.chipBlockData.chipID) && chipEntity.CheckIsCanHandleInErrorTips() && !chipEntity.isStoryMode && !chipEntity.isFilling)
		{
			SkuldPuzzleGameManager.Instance.SetDragChipEntityID(chipEntity.chipBlockData.chipID);
			chipEntity.isDrag = true;
			offsetPos = eventData.pointerCurrentRaycast.worldPosition - chipEntity.blockNode.position;
			if (chipEntity.isFillInMap && !chipEntity.CheckIsSameErrorTipsBlockID())
			{
				SkuldPuzzleGameManager.Instance.mapBlockManager.RefreshTileFullState(chipEntity, isFull: false);
			}
			chipEntity.isFillInMap = false;
			chipEntity.SetChipIsInGrid(isExitGrid: true);
			SkuldPuzzleGameManager.Instance.conditionManager.UpdateConditionStatus();
			SkuldPuzzleGameManager.Instance.mapBlockManager.HideErrorTip();
		}
	}

	public override void OnDrag(PointerEventData eventData)
	{
		if (chipEntity.CheckIsCanHandleInErrorTips() && !chipEntity.isStoryMode && !chipEntity.isFilling && eventData.dragging && (bool)chipEntity && chipEntity.isDrag)
		{
			timeCount += Time.deltaTime;
			if (timeCount > 0.03f)
			{
				timeCount = 0f;
				Ray ray = eventData.pressEventCamera.ScreenPointToRay(eventData.position);
				FollowRay(ray, eventData);
			}
		}
	}

	private void FollowRay(Ray ray, PointerEventData eventData)
	{
		if (!(eventData.pointerCurrentRaycast.worldPosition == Vector3.zero))
		{
			chipEntity.blockNode.position = eventData.pointerCurrentRaycast.worldPosition - offsetPos;
			chipEntity.RefreshOriginPos();
			if (SkuldPuzzleGameManager.Instance.mapBlockManager.CheckTileCanPlace(chipEntity))
			{
				SkuldPuzzleGameManager.Instance.mapBlockManager.UpdataTileCanPlaceExpectState(chipEntity);
				return;
			}
			SkuldPuzzleGameManager.Instance.mapBlockManager.HideExpectNode(isShow: false);
			SkuldPuzzleGameManager.Instance.mapBlockManager.ResetTileDefaultState();
		}
	}

	public override void OnEndDrag(PointerEventData eventData)
	{
		if (chipEntity.CheckIsCanHandleInErrorTips() && !chipEntity.isStoryMode && !chipEntity.isFilling && chipEntity.isDrag)
		{
			chipEntity.isDrag = false;
			offsetPos = Vector3.zero;
			PutChipToMap();
			SkuldPuzzleGameManager.Instance.SetDragChipEntityID(-1);
		}
	}

	public void PutChipToMap()
	{
		if (SkuldPuzzleGameManager.Instance.mapBlockManager.CheckTileCanPlace(chipEntity))
		{
			PutChipToMapWithOriginPos();
		}
		else
		{
			chipEntity.isFilling = false;
			chipEntity.isFillInMap = false;
			chipEntity.SetChipIsInGrid(isExitGrid: false);
		}
		SkuldPuzzleGameManager.Instance.mapBlockManager.HideExpectNode(isShow: false);
	}

	public void PutChipToMapWithOriginPos()
	{
		chipEntity.isFillInMap = true;
		chipEntity.isFilling = true;
		SkuldPuzzleGameManager.Instance.isFillingInMap = true;
		Vector3 endPos = SkuldPuzzleGameManager.Instance.mapBlockManager.GetTilePositionByXY(chipEntity.originX, chipEntity.originY);
		Vector3 vector = new Vector3(chipEntity.blockNode.position.x - chipEntity.oriPosNode.position.x, chipEntity.blockNode.position.y - chipEntity.oriPosNode.position.y, chipEntity.blockNode.position.z - chipEntity.oriPosNode.position.z);
		endPos = new Vector3(endPos.x + vector.x, endPos.y + vector.y, endPos.z + vector.z);
		LeanTween.value(0f, 1f, 0.2f).setOnUpdate(delegate(float value)
		{
			Vector3 position = new Vector3(Mathf.Lerp(chipEntity.blockNode.position.x, endPos.x, value), Mathf.Lerp(chipEntity.blockNode.position.y, endPos.y, value), Mathf.Lerp(chipEntity.blockNode.position.z, endPos.z, value));
			chipEntity.blockNode.position = position;
		}).setOnComplete((Action)delegate
		{
			SkuldPuzzleGameManager.Instance.isFillingInMap = false;
			chipEntity.isFilling = false;
			SkuldPuzzleGameManager.Instance.mapBlockManager.RefreshTileFullState(chipEntity, isFull: true);
			SkuldPuzzleGameManager.Instance.conditionManager.UpdateConditionStatus();
			AudioManager.Instance.Play("effect", "minigame_activity_4_0", "minigame_activity_4_0_pintu_down", useStream: false);
		})
			.setEase(LeanTweenType.easeOutQuad);
	}

	public override void OnPointerClick(PointerEventData eventData)
	{
		if (SkuldPuzzleGameManager.Instance.IsCanDragChip(chipEntity.chipBlockData.chipID) && chipEntity.CheckIsCanHandleInErrorTips() && !chipEntity.isFilling && !SkuldPuzzleGameManager.Instance.isFillingInMap)
		{
			if (chipEntity.isFillInMap)
			{
				AudioManager.Instance.Play("effect", "minigame_activity_4_0", "minigame_activity_4_0_pintu_rotate", useStream: false);
				chipEntity.RotateChipInMapBalock();
			}
			else if (!chipEntity.isDrag)
			{
				AudioManager.Instance.Play("effect", "minigame_activity_4_0", "minigame_activity_4_0_pintu_rotate", useStream: false);
				chipEntity.RotateChip();
			}
		}
	}
}
