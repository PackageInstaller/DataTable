using System;
using UnityEngine;
using UnityEngine.EventSystems;

namespace TetrisGame;

public class TetrisGameChipEvent : EventTrigger
{
	public TetrisGameChipEntity chipEntity;

	private Vector3 offsetPos;

	private Vector3 offsetTilePos;

	private float timeCount;

	private const float freshTime = 0.03f;

	private Vector3 endPos;

	[HideInInspector]
	public TetrisGameTileEntity hoverOn;

	public override void OnBeginDrag(PointerEventData eventData)
	{
		if (TetrisGameManager.Instance.isCanEdit && chipEntity.gameManager.editChip == null && !chipEntity.isRotating && !chipEntity.isFilling && !chipEntity.isPutInMap)
		{
			chipEntity.transform.localScale = new Vector3(1f, 1f, 1f);
			chipEntity.gameManager.editChip = chipEntity;
			chipEntity.isDrag = true;
			offsetTilePos = chipEntity.oriGrid.transform.position - chipEntity.transform.position;
			offsetPos = eventData.pointerCurrentRaycast.worldPosition - chipEntity.transform.position;
			chipEntity.transform.SetParent(GetComponentInParent<TetrisGameManager>().transform, worldPositionStays: true);
			AudioManager.Instance.Play("effect", "minigame_activity_3_6", "minigame_activity_3_6_block_up", useStream: false);
		}
	}

	public override void OnDrag(PointerEventData eventData)
	{
		if (eventData.dragging && (bool)chipEntity && chipEntity.isDrag)
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
		chipEntity.transform.position = eventData.pointerCurrentRaycast.worldPosition - offsetPos;
		chipEntity.RefreshOriginPos();
		Vector2 vector = new Vector2(chipEntity.originX, chipEntity.originY);
		if (TetrisGameManager.Instance.isMeetRightPos(chipEntity, chipEntity.originX, chipEntity.originY) && TetrisGameManager.Instance.tileManager.CheckTileCanPlace(chipEntity))
		{
			if (TetrisGameManager.Instance.tileManager.GetTilePositionByIndex((int)vector.x, (int)vector.y, out var position))
			{
				endPos = position - offsetTilePos;
				TetrisGameManager.Instance.chipManager.UpdataIsCanPlaceState(chipEntity);
			}
		}
		else
		{
			TetrisGameManager.Instance.tileManager.ResetTileCanPlaceExpectState();
		}
	}

	public override void OnEndDrag(PointerEventData eventData)
	{
		if (!chipEntity.isDrag)
		{
			return;
		}
		chipEntity.gameManager.editChip = null;
		chipEntity.isDrag = false;
		offsetPos = Vector3.zero;
		TetrisGameManager.Instance.editChip = null;
		chipEntity.RefreshOriginPos();
		new Vector2(chipEntity.originX, chipEntity.originY);
		if (TetrisGameManager.Instance.isMeetRightPos(chipEntity, chipEntity.originX, chipEntity.originY) && TetrisGameManager.Instance.tileManager.CheckTileCanPlace(chipEntity))
		{
			AudioManager.Instance.Play("effect", "minigame_activity_3_6", "minigame_activity_3_6_block_down", useStream: false);
			chipEntity.RefreshOriginPos();
			LeanTween.value(0f, 1f, 0.2f).setOnUpdate(delegate(float value)
			{
				Vector3 position = new Vector3(Mathf.Lerp(chipEntity.transform.position.x, endPos.x, value), Mathf.Lerp(chipEntity.transform.position.y, endPos.y, value), Mathf.Lerp(chipEntity.transform.position.z, endPos.z, value));
				chipEntity.transform.position = position;
				chipEntity.isFilling = true;
			}).setOnComplete((Action)delegate
			{
				chipEntity.RefreshOriginPos();
				int funNum = TetrisGameManager.Instance.tileManager.FillTile(chipEntity);
				_ = 0;
				int disposeNum = TetrisGameManager.Instance.tileManager.disposeNum;
				TetrisGameManager.Instance.tileManager.disposeNum = 0;
				TetrisGameManager.Instance.tileManager.ResetTileCanPlaceExpectState();
				TetrisGameManager.Instance.chipManager.DisposeSingleChip(chipEntity.chipIndex);
				chipEntity.isPutInMap = true;
				TetrisGameBridge.PlaceChip(funNum, chipEntity.CalculateCellNum(), disposeNum);
				chipEntity.isFilling = false;
				TetrisGameManager.Instance.ClearGuideInfo();
				if (chipEntity.chipType == ChipType.Bubble)
				{
					LuaHelper.CallFunction("TetrisGameSkillRecords", 1010);
				}
			})
				.setEase(LeanTweenType.easeOutQuad);
		}
		else
		{
			chipEntity.transform.SetParent(chipEntity.fatherTransform, worldPositionStays: true);
			chipEntity.ResetChip();
		}
	}

	public override void OnPointerClick(PointerEventData eventData)
	{
		if ((chipEntity.putInX < 0 || chipEntity.putInY < 0) && TetrisGameManager.Instance.isCanEdit && (bool)chipEntity && !chipEntity.isDrag && TetrisGameManager.Instance.canRotate && chipEntity.fatherTransform.childCount > 0)
		{
			AudioManager.Instance.Play("effect", "minigame_activity_3_6", "minigame_activity_3_6_block_rotate", useStream: false);
			chipEntity.RotateChip();
		}
	}
}
