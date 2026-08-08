using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

namespace TangramGame;

public class TangramGameChipEvent : EventTrigger
{
	public TangramGameChip chipEntity;

	private Vector3 offsetPos;

	private Vector3 offsetTilePos;

	private float timeCount;

	private const float freshTime = 0.03f;

	[HideInInspector]
	public TangramTileController hoverOn;

	public override void OnBeginDrag(PointerEventData eventData)
	{
		if (!chipEntity || !chipEntity.isLoadComplete || chipEntity.isDestination || !TangramManager.Instance.canEdit || !(TangramManager.Instance.editChip == null) || chipEntity.isDestination)
		{
			return;
		}
		List<RaycastResult> list = new List<RaycastResult>();
		EventSystem.current.RaycastAll(eventData, list);
		foreach (RaycastResult item in list)
		{
			TangramTileController componentInParent = item.gameObject.GetComponentInParent<TangramTileController>();
			if (componentInParent != null && componentInParent.gameObject.CompareTag("Item"))
			{
				offsetTilePos = componentInParent.transform.position - chipEntity.transform.position;
				chipEntity.isDrag = true;
			}
		}
		if (chipEntity.isDrag)
		{
			AudioManager.Instance.Play("effect", "minigame_activity_3_5", "minigame_activity_3_5_key_up", useStream: false);
			TangramManager.Instance.editChip = chipEntity;
			offsetPos = eventData.pointerCurrentRaycast.worldPosition - chipEntity.transform.position;
			if (chipEntity.isFill)
			{
				TangramManager.Instance.curStageManager.tileManager.RemoveTile(chipEntity);
			}
			chipEntity.isFill = false;
			chipEntity.transform.SetParent(GetComponentInParent<TangramGameStageManager>().transform, worldPositionStays: true);
			chipEntity.transform.SetAsLastSibling();
			chipEntity.SetDragState();
			TangramManager.Instance.curStageManager.chipManager.RefreshOtherChipState(chipEntity);
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
				TangramManager.Instance.curStageManager.chipManager.RefreshOtherChipState(chipEntity);
			}
		}
	}

	private void FollowRay(Ray ray, PointerEventData eventData)
	{
		chipEntity.transform.position = eventData.pointerCurrentRaycast.worldPosition - offsetPos;
		chipEntity.isLocate = false;
		List<RaycastResult> list = new List<RaycastResult>();
		EventSystem.current.RaycastAll(eventData, list);
		foreach (RaycastResult item in list)
		{
			TangramTileController componentInParent = item.gameObject.GetComponentInParent<TangramTileController>();
			if (componentInParent != null && componentInParent.gameObject.CompareTag("ground"))
			{
				hoverOn = componentInParent;
				if ((bool)hoverOn && !hoverOn.isChipTile && TangramManager.Instance.curStageManager.tileManager.GetTilePositionByIndex(hoverOn.x, hoverOn.y, out var position))
				{
					chipEntity.transform.position = position - offsetTilePos;
					chipEntity.isLocate = true;
					chipEntity.RefreshOriginPos();
					TangramManager.Instance.curStageManager.chipManager.RefreshIsCanPlace(chipEntity, isDrag: true);
					break;
				}
			}
			else
			{
				chipEntity.RefreshOriginPos();
				TangramManager.Instance.curStageManager.chipManager.RefreshIsCanPlace(chipEntity);
			}
		}
	}

	public override void OnEndDrag(PointerEventData eventData)
	{
		if (TangramManager.Instance.canEdit && (bool)chipEntity && chipEntity.isDrag)
		{
			AudioManager.Instance.Play("effect", "minigame_activity_3_5", "minigame_activity_3_5_key_down", useStream: false);
			TangramManager.Instance.editChip = null;
			chipEntity.isDrag = false;
			offsetPos = Vector3.zero;
			if (!chipEntity.isLocate)
			{
				chipEntity.ResetChip();
			}
			else if (TangramManager.Instance.curStageManager.tileManager.CheckTileCanPlace(chipEntity))
			{
				TangramManager.Instance.curStageManager.tileManager.FillTile(chipEntity);
			}
			chipEntity.transform.SetAsLastSibling();
			chipEntity.SetDragState();
			TangramManager.Instance.curStageManager.tileManager.CheckStageFin();
		}
	}

	public override void OnPointerClick(PointerEventData eventData)
	{
		if ((bool)chipEntity && chipEntity.canRotate && !chipEntity.isDrag && !chipEntity.isDestination)
		{
			chipEntity.RotateChip();
			chipEntity.SetDragState();
			TangramManager.Instance.curStageManager.tileManager.CheckStageFin();
		}
	}
}
