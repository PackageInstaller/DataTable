using Cinemachine;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Capture.Runtime;

public class CaptureCameraController : MonoBehaviour, IDragHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler, IScrollHandler, IEndDragHandler, IBeginDragHandler, IPointerClickHandler
{
	private CameraPlatformHandle curLogicHandler;

	private CameraLogic logic;

	public float speed = 1f;

	public float speedY = 1f;

	public float multiSpeed = 0.02f;

	public float multiSpeedY = 0.02f;

	public float multiCameraMoveLimitX = 3f;

	public float multiCameraMoveLimitY = 3f;

	public float multiFovSpeed = 5f;

	public float multiCameraMaxFov = 50f;

	public float multiCameraMinFov = 17f;

	public float singleCameraMaxFov = 50f;

	public float singleCameraMinFov = 10f;

	public bool pauseCameraLogic;

	private bool isInDragging;

	private GameObject dragObj;

	public LuaHelper.ETLCallBack1 onPointerClick;

	public bool IsSingle
	{
		get
		{
			if (WorldManager.Instance != null)
			{
				return WorldManager.Instance.GetGameContext().m_stageData.mode == CaptureGameMode.Single;
			}
			return false;
		}
		private set
		{
		}
	}

	public void Init(CameraLogic cameraLogic)
	{
		logic = cameraLogic;
		curLogicHandler = new StandaloneCameraHandler();
		curLogicHandler.InitHandler(this);
	}

	public void UpdateSingleCamera(float dragDelta, float deltaHeight)
	{
		if (!pauseCameraLogic)
		{
			logic?.UpdateSingleCamera(dragDelta, deltaHeight);
		}
	}

	public void UpdateSingleCameraFov(float deltaFov)
	{
		if (!pauseCameraLogic)
		{
			logic?.UpdateSingleCameraFov(0f - deltaFov);
			DispatchFovChanged();
		}
	}

	public void ChangeSingleCameraFov(float fov)
	{
		if (!pauseCameraLogic)
		{
			logic?.ChangeSingleCameraFov(fov);
		}
	}

	public void UpdateMultiCamera(float dragDelta, float deltaHeight)
	{
		if (!pauseCameraLogic)
		{
			logic?.UpdateMultiCamera(dragDelta, deltaHeight);
		}
	}

	public void UpdateMultiCameraFov(float deltaFov)
	{
		if (!pauseCameraLogic)
		{
			logic?.UpdateMultiCameraFov(0f - deltaFov);
			DispatchFovChanged();
		}
	}

	public void ChangeMultiCameraFov(float fov)
	{
		if (!pauseCameraLogic)
		{
			logic?.ChangeMultiCameraFov(fov);
		}
	}

	private void DispatchFovChanged()
	{
		LuaHelper.CallFunction("CaptureGameBridge.CameraFovChangedEvent");
	}

	public float GetVirtualCameraAxisValue(int axis)
	{
		if (IsSingle)
		{
			CinemachineFreeLook singleCaptureCamera = WorldManager.Instance.GetGameContext().singleCaptureCamera;
			switch (axis)
			{
			case 1:
				return singleCaptureCamera.m_XAxis.Value;
			case 2:
				return singleCaptureCamera.m_YAxis.Value;
			}
		}
		return 0f;
	}

	public float GetVirtualCameraFov()
	{
		if (IsSingle)
		{
			return WorldManager.Instance.GetGameContext().singleCaptureCamera.m_Lens.FieldOfView;
		}
		return WorldManager.Instance.GetGameContext().multiCaptureCamera.m_Lens.FieldOfView;
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
		if (pauseCameraLogic && Physics.Raycast(Camera.main.ScreenPointToRay(Input.mousePosition), out var hitInfo, 100f))
		{
			dragObj = hitInfo.collider.gameObject;
			curLogicHandler?.OnCaptureEntityBeginDrag(dragObj, eventData);
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		curLogicHandler?.OnDrag(eventData);
		if (pauseCameraLogic && dragObj != null)
		{
			curLogicHandler?.OnCaptureEntityDrag(dragObj, eventData);
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		curLogicHandler?.OnPointDown(eventData);
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

	public void OnPointerClick(PointerEventData eventData)
	{
		if (!isInDragging)
		{
			if (!pauseCameraLogic)
			{
				curLogicHandler?.OnPointerClick(eventData);
			}
			else if (dragObj == null)
			{
				onPointerClick?.Invoke(base.gameObject, eventData);
			}
		}
	}
}
