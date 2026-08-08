using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Pipelines.SimPipeline;

namespace Capture.Runtime;

public class MobileCameraHandler : CameraPlatformHandle
{
	private enum state
	{
		None,
		BeginDrag,
		Dragging,
		BeginScale,
		Scaling
	}

	private bool isPointing;

	private int touchCount;

	private int fingerID = 1;

	public RectTransform Viewport;

	private Vector3 m_PointerStartLocalCursor;

	private float m_startPointDistance;

	private state m_state;

	public override void Execute()
	{
	}

	public override void OnBeginDrag(PointerEventData eventData)
	{
		Vector3 zero = Vector3.zero;
		zero = Input.mousePosition;
		Camera uiCamera = CanvasManager.Instance.uiCamera;
		if ((bool)uiCamera)
		{
			RectTransformUtility.ScreenPointToWorldPointInRectangle(Viewport, zero, uiCamera, out m_PointerStartLocalCursor);
		}
		isPointing = false;
	}

	public override void OnDrag(PointerEventData eventData)
	{
		if (Input.touchCount <= 0)
		{
			touchCount = 1;
			return;
		}
		Camera uiCamera = CanvasManager.Instance.uiCamera;
		isPointing = false;
		if (m_state == state.BeginDrag)
		{
			m_state = state.Dragging;
			Touch touch = Input.GetTouch(0);
			fingerID = touch.fingerId;
			Vector3 vector = touch.position;
			RectTransformUtility.ScreenPointToWorldPointInRectangle(Viewport, vector, uiCamera, out m_PointerStartLocalCursor);
		}
		else if (m_state == state.BeginScale)
		{
			m_state = state.Scaling;
			m_startPointDistance = Vector3.Distance(Input.GetTouch(0).position, Input.GetTouch(1).position);
		}
		if (m_state == state.Dragging)
		{
			Touch touch2 = Input.GetTouch(0);
			if (touch2.fingerId != fingerID)
			{
				fingerID = touch2.fingerId;
				RectTransformUtility.ScreenPointToWorldPointInRectangle(Viewport, touch2.position, uiCamera, out m_PointerStartLocalCursor);
				if (m_controller.IsSingle)
				{
					m_controller.UpdateSingleCamera(0f, 0f);
				}
			}
			else
			{
				RectTransformUtility.ScreenPointToWorldPointInRectangle(Viewport, touch2.position, uiCamera, out var worldPoint);
				Vector3 vector2 = worldPoint - m_PointerStartLocalCursor;
				UpdateCameraDrag(vector2.x, vector2.y);
				m_PointerStartLocalCursor = worldPoint;
			}
		}
		else if (m_state == state.Scaling)
		{
			float num = Vector3.Distance(Input.GetTouch(0).position, Input.GetTouch(1).position);
			float scaleDelta = num - m_startPointDistance;
			UpdateCameraScale(scaleDelta);
			m_startPointDistance = num;
		}
	}

	public override void OnEndDrag(PointerEventData eventData)
	{
		if (m_controller.IsSingle)
		{
			m_controller.UpdateSingleCamera(0f, 0f);
		}
	}

	public override void OnPointDown(PointerEventData eventData)
	{
		touchCount++;
		if (touchCount == 1)
		{
			m_state = state.BeginDrag;
			isPointing = true;
		}
		if (touchCount >= 2)
		{
			m_state = state.BeginScale;
		}
	}

	public override void OnPointUp(PointerEventData eventData)
	{
		touchCount--;
		if (touchCount == 1)
		{
			m_state = state.BeginDrag;
		}
		if (touchCount <= 0)
		{
			m_state = state.None;
			_ = isPointing;
		}
	}

	public override void OnScroll(PointerEventData eventData)
	{
		if (m_controller.IsSingle)
		{
			m_controller.UpdateSingleCameraFov(eventData.scrollDelta.y * m_controller.multiFovSpeed / Time.deltaTime / (float)Application.targetFrameRate * 0.2f);
		}
		else
		{
			m_controller.UpdateMultiCameraFov(eventData.scrollDelta.y * m_controller.multiFovSpeed / Time.deltaTime / (float)Application.targetFrameRate * 0.2f);
		}
	}

	private void UpdateCameraScale(float scaleDelta)
	{
		if (m_controller.IsSingle)
		{
			m_controller.UpdateSingleCameraFov(scaleDelta * m_controller.multiFovSpeed / Time.deltaTime / (float)Application.targetFrameRate * 0.2f);
		}
		else
		{
			m_controller.UpdateMultiCameraFov(scaleDelta * m_controller.multiFovSpeed / Time.deltaTime / (float)Application.targetFrameRate * 0.2f);
		}
	}

	private void UpdateCameraDrag(float dragDelta, float deltaHeight)
	{
		if (m_controller.IsSingle)
		{
			dragDelta = dragDelta * m_controller.speed / Time.deltaTime / (float)Application.targetFrameRate * 0.2f;
			deltaHeight = deltaHeight * m_controller.speedY / Time.deltaTime / (float)Application.targetFrameRate * 0.2f;
			m_controller.UpdateSingleCamera(dragDelta, deltaHeight);
		}
		else
		{
			dragDelta = dragDelta * m_controller.multiSpeed / Time.deltaTime / (float)Application.targetFrameRate * 0.2f;
			deltaHeight = deltaHeight * m_controller.multiSpeedY / Time.deltaTime / (float)Application.targetFrameRate * 0.2f;
			m_controller.UpdateMultiCamera(dragDelta, deltaHeight);
		}
	}

	public override void OnPointerClick(PointerEventData eventData)
	{
		if (!m_controller.IsSingle && Physics.Raycast(Camera.main.ScreenPointToRay(Input.mousePosition), out var hitInfo, 100f))
		{
			OnCaptureEntityClick(hitInfo.collider.gameObject, eventData);
		}
	}
}
