using UnityEngine;
using UnityEngine.EventSystems;

namespace T0World;

public class T0CaptureCameraController : MonoBehaviour, IDragHandler, IEventSystemHandler, IPointerDownHandler, IPointerClickHandler, IPointerUpHandler, IScrollHandler, IEndDragHandler, IBeginDragHandler
{
	protected T0CaptureCameraPlatformHandle curLogicHandler;

	protected T0CaptureCameraLogic logic;

	public float scorllSpeed = 1f;

	public float speed = 1f;

	public float speedY = 1f;

	public float CameraMaxFov = 50f;

	public float CameraMinFov = 10f;

	public bool pauseCameraLogic;

	private bool isInDragging;

	private GameObject dragObj;

	public virtual void Init(T0CaptureCameraLogic cameraLogic)
	{
		logic = cameraLogic;
		curLogicHandler = new T0StandaloneCameraHandler();
		curLogicHandler.InitHandler(this);
	}

	public void UpdateSingleCamera(float dragDelta, float deltaHeight)
	{
		if (!pauseCameraLogic)
		{
			logic?.UpdateSingleCamera(dragDelta, deltaHeight);
		}
	}

	public void UpdateCameraFov(float deltaFov)
	{
		if (!pauseCameraLogic)
		{
			logic?.UpdateCameraFov(0f - deltaFov);
		}
	}

	public void Execute()
	{
		curLogicHandler?.Execute();
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		curLogicHandler?.OnPointUp(eventData);
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		isInDragging = true;
		curLogicHandler?.OnBeginDrag(eventData);
	}

	public void OnDrag(PointerEventData eventData)
	{
		curLogicHandler?.OnDrag(eventData);
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		curLogicHandler?.OnPointDown(eventData);
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		curLogicHandler?.OnPointerClick(eventData);
	}

	public void OnScroll(PointerEventData eventData)
	{
		curLogicHandler?.OnScroll(eventData);
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		curLogicHandler?.OnEndDrag(eventData);
		dragObj = null;
		isInDragging = false;
	}
}
