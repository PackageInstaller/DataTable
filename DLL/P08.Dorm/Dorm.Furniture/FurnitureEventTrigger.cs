using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Dorm.Furniture;

public class FurnitureEventTrigger : EventTrigger
{
	public FurnitureEntity goodsEntity;

	private Vector3 offsetPos;

	private bool isNeedInitOffset;

	protected bool isPassingDragEvent;

	private float timeCount;

	private const float freshTime = 0.03f;

	private bool hasPassedEvent;

	private List<GameObject> lastRaycastDragObject;

	private List<GameObject> lastRaycastPointerDownObject;

	public bool isStartByDragMode;

	protected virtual bool CheckCanPlace()
	{
		return FurnitureManager.Instance.IsFurnitureCanPlace(goodsEntity);
	}

	public override void OnBeginDrag(PointerEventData eventData)
	{
		if (goodsEntity.furnitureStatus != FurnitureEntity.FurnitureStatus.mEditing || goodsEntity.CheckIsHide())
		{
			isPassingDragEvent = true;
			if ((bool)DormRoomManager.Instance)
			{
				DormRoomManager.Instance.isRotateCamera = true;
			}
			Pass(eventData, ExecuteEvents.beginDragHandler, EventTriggerType.BeginDrag);
		}
		else if (FurnitureManager.Instance.isSuitEidtMode && !DormRoomManager.Instance.isRotateCamera)
		{
			if (goodsEntity.parent != null && goodsEntity.parent.entityId == FurnitureManager.Instance.editSuit.entityId)
			{
				if (goodsEntity.parent.child.Count > 0)
				{
					isPassingDragEvent = true;
					PassToSuitParent(eventData, ExecuteEvents.beginDragHandler, EventTriggerType.BeginDrag);
					return;
				}
				OnStartEdit();
				isNeedInitOffset = true;
				isPassingDragEvent = false;
				goodsEntity.isDrag = true;
			}
			else if (goodsEntity.entityId == FurnitureManager.Instance.editSuit.entityId)
			{
				OnStartEdit();
				isNeedInitOffset = true;
				isPassingDragEvent = false;
			}
		}
		else
		{
			OnStartEdit();
			isNeedInitOffset = true;
			isPassingDragEvent = false;
		}
	}

	protected virtual bool CheckCanEdit()
	{
		if ((bool)DormRoomManager.Instance)
		{
			return DormRoomManager.Instance.isCanEdit;
		}
		return false;
	}

	protected virtual bool ShouldConsumeDrag(PointerEventData eventData)
	{
		if ((bool)DormRoomManager.Instance && CheckCanEdit() && goodsEntity.furnitureStatus == FurnitureEntity.FurnitureStatus.mEditing)
		{
			if (eventData.dragging && !isPassingDragEvent)
			{
				return !DormRoomManager.Instance.isRotateCamera;
			}
			return false;
		}
		return false;
	}

	public override void OnDrag(PointerEventData eventData)
	{
		if (ShouldConsumeDrag(eventData))
		{
			timeCount += Time.deltaTime;
			if (timeCount > 0.03f)
			{
				timeCount = 0f;
				Ray ray = Camera.main.ScreenPointToRay(eventData.position);
				FollowRay(ray);
			}
		}
		else if (FurnitureManager.Instance.isSuitEidtMode && goodsEntity.parent != null && goodsEntity.parent.entityId == FurnitureManager.Instance.editSuit.entityId)
		{
			PassToSuitParent(eventData, ExecuteEvents.dragHandler, EventTriggerType.Drag);
		}
		else
		{
			Pass(eventData, ExecuteEvents.dragHandler, EventTriggerType.Drag);
		}
	}

	protected virtual Vector3 SnapPos(Vector3 inputPos)
	{
		bool flag = Mathf.RoundToInt(Mathf.Abs(DormCoordinate.Instance.GetRotationByType(goodsEntity.TileType, goodsEntity.trs.localEulerAngles)) / 90f) % 2 == 1;
		if (goodsEntity.child.Count > 0)
		{
			int width = (int)((flag ? goodsEntity.suitWid : goodsEntity.suitLen) / 0.25f);
			int height = (int)((flag ? goodsEntity.suitLen : goodsEntity.suitWid) / 0.25f);
			return DormCoordinate.Instance.FindNearestPosition(goodsEntity.TileType, inputPos, isLimit: true, wallMountLayOnGround: true, width, height);
		}
		int width2 = (flag ? goodsEntity.height : goodsEntity.width);
		int height2 = (flag ? goodsEntity.width : goodsEntity.height);
		bool wallMountLayOnGround = goodsEntity.WallMountLayOnGround;
		return DormCoordinate.Instance.FindNearestPosition(goodsEntity.TileType, inputPos, isLimit: true, wallMountLayOnGround, width2, height2);
	}

	protected virtual void FollowRay(Ray ray)
	{
		if (Physics.Raycast(ray, out var hitInfo, float.PositiveInfinity, DormConst.GROUND_LAYER_MASK) && IsTypeCorrect(hitInfo.collider.gameObject))
		{
			if (isNeedInitOffset)
			{
				offsetPos = hitInfo.point - goodsEntity.go.transform.position;
				isNeedInitOffset = false;
			}
			Vector3 inputPos = hitInfo.point - offsetPos;
			goodsEntity.trs.position = SnapPos(inputPos);
			if (goodsEntity.child.Count > 0)
			{
				goodsEntity.RefreshSuitIsCanPlace();
				return;
			}
			bool flag = CheckCanPlace();
			FurnitureManager.Instance.RefreshIsCanPlace(goodsEntity, flag);
			UpdateCanPlaceVisualEffect(flag);
			FurnitureManager.RefreshFurnitureInteractPosVfx(goodsEntity);
		}
	}

	private bool IsTypeCorrect(GameObject go)
	{
		RoomWallTag component = go.GetComponent<RoomWallTag>();
		if (component != null && component.tileType == goodsEntity.TileType)
		{
			return true;
		}
		if (DormLuaBridge.IsWallTileType(component.tileType) && DormLuaBridge.IsWallTileType(goodsEntity.TileType))
		{
			TileType tileType = goodsEntity.TileType;
			bool num = goodsEntity.TileType != component.tileType;
			goodsEntity.trs.forward = component.transform.forward;
			goodsEntity.TileType = component.tileType;
			if ((bool)DormRoomManager.Instance)
			{
				goodsEntity.trs.parent = DormRoomManager.Instance.GetTrsByType(goodsEntity.TileType);
			}
			if (num)
			{
				DormLuaBridge.RemoveFurnitureFromWallDitherAlphaControl(goodsEntity.trs, tileType);
				DormLuaBridge.AddFurnitureToWallDitherAlphaControl(goodsEntity.trs, component.tileType);
			}
			offsetPos = Vector3.zero;
			return true;
		}
		return false;
	}

	public override void OnEndDrag(PointerEventData eventData)
	{
		if (isPassingDragEvent)
		{
			if (FurnitureManager.Instance.isSuitEidtMode && goodsEntity.parent != null && goodsEntity.parent.entityId == FurnitureManager.Instance.editSuit.entityId)
			{
				PassToSuitParent(eventData, ExecuteEvents.endDragHandler, EventTriggerType.EndDrag);
			}
			else
			{
				Pass(eventData, ExecuteEvents.endDragHandler, EventTriggerType.EndDrag);
				if ((bool)DormRoomManager.Instance)
				{
					DormRoomManager.Instance.isRotateCamera = false;
				}
			}
		}
		else
		{
			goodsEntity.isDrag = false;
			OnStopEdit();
		}
		eventData.Use();
		isPassingDragEvent = false;
	}

	public override void OnPointerClick(PointerEventData eventData)
	{
		bool num = FurnitureManager.Instance.isCustomEidtMode || goodsEntity.furnitureStatus == FurnitureEntity.FurnitureStatus.mPlaced || FurnitureManager.Instance.editingFurniture == null;
		bool flag = CheckCanEdit();
		if (!(num & flag) || eventData.dragging || eventData.used)
		{
			return;
		}
		if (goodsEntity.CheckIsHide() && eventData.pointerClick == goodsEntity.MainColliderTrs.gameObject)
		{
			Pass(eventData, ExecuteEvents.pointerClickHandler, EventTriggerType.PointerClick);
			return;
		}
		if (!FurnitureManager.Instance.isSuitEidtMode)
		{
			FurnitureManager.Instance.editingFurniture = goodsEntity;
			FurnitureManager.Instance.editingFurnitureTileTypeTmp = goodsEntity.TileType;
			FurnitureManager.Instance.editingFurnitureForwardTmp = goodsEntity.trs.forward;
			FurnitureManager.Instance.editingFurniturePosTmp = goodsEntity.trs.position;
			FurnitureManager.Instance.editingFurnitureRotationTmp = goodsEntity.trs.localEulerAngles;
			FurnitureManager.Instance.isChangePosition = true;
			goodsEntity.isChangePosition = true;
			FurnitureManager.RemoveFurnitureOccupy(goodsEntity);
			FurnitureManager.Instance.ChangeFurnitureState(goodsEntity, FurnitureEntity.FurnitureStatus.mEditing, ignoreRefreshCanPlace: true);
			bool flag2 = CheckCanPlace();
			FurnitureManager.Instance.RefreshIsCanPlace(goodsEntity, flag2);
			UpdateCanPlaceVisualEffect(flag2);
			int num2 = -1;
			if (goodsEntity.parent != null)
			{
				num2 = goodsEntity.parent.entityId;
			}
			LuaHelper.CallFunction("Dorm.OnClickFurniture", goodsEntity.id, goodsEntity.entityId, num2);
		}
		else if (FurnitureManager.Instance.isCustomEidtMode && goodsEntity.child.Count == 0)
		{
			int entityId = FurnitureManager.Instance.editSuit.entityId;
			if (goodsEntity.parent != null && goodsEntity.parent.entityId == entityId && FurnitureManager.Instance.editSuit.child.Count == 1)
			{
				return;
			}
			if (goodsEntity.TileType != TileType.FLOOR)
			{
				LuaHelper.CallFunction("OnClickIllegalSuitFurniture", goodsEntity.id, goodsEntity.entityId, "wallFur");
				return;
			}
			if (goodsEntity.parent != null && goodsEntity.parent.entityId != entityId)
			{
				LuaHelper.CallFunction("OnClickIllegalSuitFurniture", goodsEntity.id, goodsEntity.entityId, "otherSuit");
				return;
			}
			if (!FurnitureManager.Instance.editSuit.isCanPlace)
			{
				LuaHelper.CallFunction("OnClickIllegalSuitFurniture", goodsEntity.id, goodsEntity.entityId, "cantPlace");
				return;
			}
			bool num3 = FurnitureManager.Instance.SetFurInSuitChild(goodsEntity.entityId, entityId, setTrsParent: true);
			FurnitureEntity furnitureEntity = FurnitureManager.Instance.Get(entityId);
			if (num3 && !FurnitureManager.Instance.suitFurTempPosDic.ContainsKey(goodsEntity.entityId))
			{
				FurniturePosData value = default(FurniturePosData);
				value.editingFurnitureTileTypeTmp = goodsEntity.TileType;
				value.editingFurnitureForwardTmp = goodsEntity.trs.forward;
				value.editingFurniturePosTmp = goodsEntity.trs.position;
				value.editingFurnitureRotationTmp = goodsEntity.trs.localEulerAngles;
				value.suitEid = 0;
				FurnitureManager.Instance.suitFurTempPosDic.Add(goodsEntity.entityId, value);
			}
			FurnitureManager.Instance.editSuit.RefreshSuitIsCanPlace();
			furnitureEntity.ReCalculateWideAndLen();
		}
		eventData.Use();
	}

	public override void OnPointerEnter(PointerEventData eventData)
	{
		_ = goodsEntity.furnitureStatus;
		_ = 2;
	}

	public override void OnPointerExit(PointerEventData eventData)
	{
		_ = goodsEntity.furnitureStatus;
		_ = 2;
	}

	public override void OnPointerDown(PointerEventData eventData)
	{
		Pass(eventData, ExecuteEvents.pointerDownHandler, EventTriggerType.PointerDown);
	}

	public override void OnPointerUp(PointerEventData eventData)
	{
		Pass(eventData, ExecuteEvents.pointerUpHandler, EventTriggerType.PointerUp);
	}

	public void Pass<T>(PointerEventData data, ExecuteEvents.EventFunction<T> function, EventTriggerType eventTriggerType = EventTriggerType.PointerEnter) where T : IEventSystemHandler
	{
		if (hasPassedEvent)
		{
			return;
		}
		hasPassedEvent = true;
		List<RaycastResult> list = new List<RaycastResult>();
		EventSystem.current.RaycastAll(data, list);
		GameObject gameObject = data.pointerCurrentRaycast.gameObject;
		switch (eventTriggerType)
		{
		case EventTriggerType.BeginDrag:
			lastRaycastDragObject = list.Select((RaycastResult hit) => ExecuteEvents.GetEventHandler<T>(hit.gameObject)).ToList();
			break;
		case EventTriggerType.PointerDown:
			lastRaycastPointerDownObject = list.Select((RaycastResult hit) => ExecuteEvents.GetEventHandler<T>(hit.gameObject)).ToList();
			break;
		}
		List<GameObject> list2 = new List<GameObject>();
		for (int num = 0; num < list.Count; num++)
		{
			GameObject gameObject2 = list[num].gameObject;
			if (gameObject != gameObject2 && !data.used)
			{
				GameObject eventHandler = ExecuteEvents.GetEventHandler<T>(gameObject2);
				if (ExecuteEvents.Execute(eventHandler, data, function))
				{
					list2.Add(eventHandler);
				}
			}
		}
		if (lastRaycastDragObject != null && (eventTriggerType == EventTriggerType.EndDrag || eventTriggerType == EventTriggerType.Drag))
		{
			for (int num2 = 0; num2 < lastRaycastDragObject.Count; num2++)
			{
				GameObject gameObject3 = lastRaycastDragObject[num2];
				if ((bool)gameObject3 && gameObject != gameObject3 && !list2.Contains(gameObject3))
				{
					GameObject eventHandler2 = ExecuteEvents.GetEventHandler<T>(gameObject3);
					if (ExecuteEvents.Execute(eventHandler2, data, function))
					{
						list2.Add(eventHandler2);
					}
				}
			}
			if (eventTriggerType == EventTriggerType.EndDrag)
			{
				lastRaycastDragObject.Clear();
			}
		}
		if (lastRaycastPointerDownObject != null && eventTriggerType == EventTriggerType.PointerUp)
		{
			for (int num3 = 0; num3 < lastRaycastPointerDownObject.Count; num3++)
			{
				GameObject gameObject4 = lastRaycastPointerDownObject[num3];
				if ((bool)gameObject4 && gameObject != gameObject4 && !list2.Contains(gameObject4))
				{
					GameObject eventHandler3 = ExecuteEvents.GetEventHandler<T>(gameObject4);
					if ((bool)ExecuteEvents.ExecuteHierarchy(eventHandler3, data, function))
					{
						list2.Add(eventHandler3);
					}
				}
			}
			lastRaycastPointerDownObject.Clear();
		}
		hasPassedEvent = false;
	}

	public void PassToSuitParent<T>(PointerEventData data, ExecuteEvents.EventFunction<T> function, EventTriggerType eventTriggerType = EventTriggerType.PointerEnter) where T : IEventSystemHandler
	{
		ExecuteEvents.Execute(goodsEntity.parent.go, data, function);
	}

	protected virtual void OnStartEdit()
	{
		if ((bool)DormRoomManager.Instance)
		{
			DormRoomManager.Instance.ChangeState(DormRoomManager.RoomState.mEditFurniture);
		}
	}

	protected virtual void OnStopEdit()
	{
		if ((bool)DormRoomManager.Instance)
		{
			DormRoomManager.Instance.ChangeState(DormRoomManager.RoomState.mFreelook);
		}
		offsetPos = Vector3.zero;
	}

	protected virtual void UpdateCanPlaceVisualEffect(bool canPlace)
	{
		DormRoomManager.Instance.EnableWarningMode(!canPlace);
	}

	private void Update()
	{
		if (!isStartByDragMode)
		{
			return;
		}
		if (UnityEngine.Input.GetMouseButton(0))
		{
			OnStartEdit();
			Ray ray = Camera.main.ScreenPointToRay(UnityEngine.Input.mousePosition);
			FollowRay(ray);
			return;
		}
		if (UnityEngine.Input.touchCount == 1)
		{
			Touch touch = UnityEngine.Input.GetTouch(0);
			Vector2 deltaPosition = touch.deltaPosition;
			if (touch.phase == TouchPhase.Moved && deltaPosition.sqrMagnitude > 0f)
			{
				OnStartEdit();
				Ray ray2 = Camera.main.ScreenPointToRay(touch.position);
				FollowRay(ray2);
				return;
			}
			if (touch.phase == TouchPhase.Stationary)
			{
				return;
			}
		}
		isStartByDragMode = false;
		OnStopEdit();
	}
}
