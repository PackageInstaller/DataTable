using UnityEngine;
using UnityEngine.EventSystems;

namespace Dorm.Furniture;

internal class FurnitureRotationTrigger : EventTrigger
{
	private Transform parentTrs;

	private Transform mainCameraTrs;

	private GameObject triggerPanelGo;

	private bool isInDrag;

	private Vector3 startPos;

	private Vector3 startVector;

	private Vector3 startRotation;

	private void Awake()
	{
		parentTrs = base.transform.parent;
		mainCameraTrs = Camera.main.transform;
		triggerPanelGo = parentTrs.Find("triggerPanel").gameObject;
	}

	public override void OnBeginDrag(PointerEventData eventData)
	{
		isInDrag = true;
		triggerPanelGo.SetActive(value: true);
		if (Physics.Raycast(eventData.pressEventCamera.ScreenPointToRay(eventData.position), out var hitInfo, float.PositiveInfinity, DormConst.EVENT_LAYER_ID))
		{
			startPos = hitInfo.point;
			startVector = startPos - FurnitureManager.Instance.editingFurniture.trs.position;
			startRotation = FurnitureManager.Instance.editingFurniture.trs.localEulerAngles;
		}
		DormRoomManager.Instance.ChangeState(DormRoomManager.RoomState.mEditFurniture);
	}

	public override void OnEndDrag(PointerEventData eventData)
	{
		isInDrag = false;
		triggerPanelGo.SetActive(value: false);
		DormRoomManager.Instance.ChangeState(DormRoomManager.RoomState.mFreelook);
	}

	public override void OnDrag(PointerEventData eventData)
	{
		if (eventData.dragging && isInDrag && FurnitureManager.Instance.editingFurniture != null && Physics.Raycast(eventData.pressEventCamera.ScreenPointToRay(eventData.position), out var hitInfo, float.PositiveInfinity, DormConst.EVENT_LAYER_ID))
		{
			Vector3 vector = hitInfo.point - FurnitureManager.Instance.editingFurniture.trs.position;
			float num = Vector3.Angle(startVector, vector);
			Vector3 lhs = Vector3.Cross(startVector, vector);
			num *= Mathf.Sign(Vector3.Dot(lhs, new Vector3(0f, 1f, 0f)));
			FurnitureManager.Instance.editingFurniture.trs.localEulerAngles = startRotation + new Vector3(0f, num, 0f);
			FurnitureManager.Instance.RefreshIsCanPlace(FurnitureManager.Instance.editingFurniture);
			FurnitureManager.RefreshFurnitureInteractPosVfx(FurnitureManager.Instance.editingFurniture);
		}
	}

	private void Update()
	{
		if (!isInDrag && parentTrs != null && mainCameraTrs != null)
		{
			Vector3 forward = mainCameraTrs.forward;
			Vector3 vector = new Vector3(forward.x, 0f, forward.z);
			parentTrs.forward = vector.normalized;
		}
	}
}
