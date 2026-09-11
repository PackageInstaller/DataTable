using UnityEngine;
using UnityEngine.EventSystems;

public class CameraEventTrigger : MonoBehaviour, IBeginDragHandler, IEventSystemHandler, IDragHandler, IEndDragHandler
{
	private Collider collider;

	private bool isOnDrag;

	private float lastTouchDis = -1f;

	internal bool fixedAtCamFarClip;

	private const float offset = 0.01f;

	protected virtual void OnCameraDrag(PointerEventData eventData)
	{
		CAMERA_MOVE_TYPE moveType = DormCameraManager.Instance.moveType;
		if (DormCameraManager.Instance.LookStatus == DormCameraManager.CAMERA_LOOKAT_STATUS.ROLE)
		{
			BlockDrag();
		}
		else if (eventData.delta.sqrMagnitude > 0f && Input.touchCount <= 1)
		{
			switch (moveType)
			{
			case CAMERA_MOVE_TYPE.RESTAURANT:
				DormCameraManager.Instance.MoveGameplayCamera(eventData);
				break;
			case CAMERA_MOVE_TYPE.DORM:
				DormCameraManager.Instance.RotateCamera(eventData);
				break;
			}
			eventData.Use();
		}
	}

	protected virtual void OnCameraZoom(float zoomValue)
	{
		float scaleRate = DormCameraManager.Instance.scaleRate;
		CAMERA_MOVE_TYPE moveType = DormCameraManager.Instance.moveType;
		zoomValue *= scaleRate;
		if (zoomValue != 0f)
		{
			switch (moveType)
			{
			case CAMERA_MOVE_TYPE.RESTAURANT:
				DormCameraManager.Instance.AddYAxis(zoomValue);
				break;
			case CAMERA_MOVE_TYPE.DORM:
				DormCameraManager.Instance.ScaleCamera(zoomValue);
				break;
			}
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (!eventData.used)
		{
			isOnDrag = true;
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (isOnDrag)
		{
			OnCameraDrag(eventData);
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		isOnDrag = false;
		eventData.Reset();
	}

	private void Start()
	{
		collider = GetComponent<Collider>();
	}

	private void Update()
	{
		if (!collider.enabled)
		{
			return;
		}
		if (Input.touchCount == 2)
		{
			float num = Vector2.Distance(Input.touches[0].position, Input.touches[1].position);
			if (-1f == lastTouchDis)
			{
				lastTouchDis = num;
			}
			float zoomValue = num - lastTouchDis;
			lastTouchDis = num;
			OnCameraZoom(zoomValue);
		}
		else
		{
			lastTouchDis = -1f;
		}
	}

	private void LateUpdate()
	{
		if (!(Camera.main == null))
		{
			float min = Camera.main.nearClipPlane + 0.01f;
			float num = Camera.main.farClipPlane - 0.01f;
			if (fixedAtCamFarClip)
			{
				base.transform.localPosition = new Vector3(0f, 0f, num);
			}
			if (base.transform.parent == Camera.main.transform)
			{
				base.transform.localPosition = new Vector3(0f, 0f, Mathf.Clamp(base.transform.localPosition.z, min, num));
			}
		}
	}

	internal void BlockDrag()
	{
		isOnDrag = false;
	}
}
