using UnityEngine;
using UnityEngine.EventSystems;

namespace Capture.Runtime;

public class StandaloneCameraHandler : CameraPlatformHandle
{
	public override void Execute()
	{
	}

	public override void OnBeginDrag(PointerEventData eventData)
	{
	}

	public override void OnDrag(PointerEventData eventData)
	{
		if (m_controller.IsSingle)
		{
			float dragDelta = eventData.delta.x * m_controller.speed / Time.deltaTime / (float)Application.targetFrameRate * 0.2f;
			float deltaHeight = eventData.delta.y * m_controller.speedY / Time.deltaTime / (float)Application.targetFrameRate * 0.2f;
			m_controller.UpdateSingleCamera(dragDelta, deltaHeight);
		}
		else
		{
			float dragDelta2 = eventData.delta.x * m_controller.multiSpeed / Time.deltaTime / (float)Application.targetFrameRate * 0.2f;
			float deltaHeight2 = eventData.delta.y * m_controller.multiSpeedY / Time.deltaTime / (float)Application.targetFrameRate * 0.2f;
			m_controller.UpdateMultiCamera(dragDelta2, deltaHeight2);
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
	}

	public override void OnPointerClick(PointerEventData eventData)
	{
		if (Physics.Raycast(Camera.main.ScreenPointToRay(Input.mousePosition), out var hitInfo, 100f))
		{
			OnCaptureEntityClick(hitInfo.collider.gameObject, eventData);
		}
	}

	public override void OnPointUp(PointerEventData eventData)
	{
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
}
