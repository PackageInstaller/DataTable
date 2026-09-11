using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Pipelines.SimPipeline;

namespace T0World;

public class T0MobileCameraHandler : T0CaptureCameraPlatformHandle
{
	private enum state
	{
		None,
		BeginDrag,
		Dragging,
		BeginScale,
		Scaling
	}

	private bool isInDragging;

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
		_ = CanvasManager.Instance.uiCamera;
		isPointing = false;
		isInDragging = true;
		if (m_state == state.BeginDrag)
		{
			m_state = state.Dragging;
			Touch touch = Input.GetTouch(0);
			fingerID = touch.fingerId;
			m_PointerStartLocalCursor = touch.position;
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
				m_PointerStartLocalCursor = touch2.position;
				m_controller.UpdateSingleCamera(0f, 0f);
			}
			else
			{
				Vector3 vector = touch2.position;
				Vector3 vector2 = vector - m_PointerStartLocalCursor;
				UpdateCameraDrag(vector2.x, vector2.y);
				m_PointerStartLocalCursor = vector;
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
		m_controller.UpdateSingleCamera(0f, 0f);
	}

	public virtual void BackToNormalState()
	{
		T0WorldScene.Scene.mWorldUI.ChangePhotoViewMode(T0CaptureModeStateEnum.photo);
	}

	public override void OnPointerClick(PointerEventData eventData)
	{
		BackToNormalState();
	}

	public override void OnPointDown(PointerEventData eventData)
	{
		if (touchCount == 0)
		{
			isInDragging = false;
		}
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
			if (!isInDragging)
			{
				BackToNormalState();
			}
		}
	}

	public override void OnScroll(PointerEventData eventData)
	{
		m_controller.UpdateCameraFov(eventData.scrollDelta.y * m_controller.scorllSpeed * 0.2f);
	}

	private void UpdateCameraScale(float scaleDelta)
	{
		m_controller.UpdateCameraFov(scaleDelta * m_controller.speed * 0.2f);
	}

	private void UpdateCameraDrag(float dragDelta, float deltaHeight)
	{
		float num = 3f;
		dragDelta = dragDelta * m_controller.speed * 0.2f;
		deltaHeight = deltaHeight * m_controller.speedY * num * 0.2f;
		m_controller.UpdateSingleCamera(dragDelta, deltaHeight);
	}
}
