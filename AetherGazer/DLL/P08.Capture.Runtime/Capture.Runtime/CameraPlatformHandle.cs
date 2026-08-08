using UnityEngine;
using UnityEngine.EventSystems;

namespace Capture.Runtime;

public abstract class CameraPlatformHandle
{
	protected CaptureCameraController m_controller;

	public void InitHandler(CaptureCameraController controller)
	{
		m_controller = controller;
	}

	public abstract void OnPointDown(PointerEventData eventData);

	public abstract void OnPointUp(PointerEventData eventData);

	public abstract void OnPointerClick(PointerEventData eventData);

	public abstract void OnBeginDrag(PointerEventData eventData);

	public abstract void OnDrag(PointerEventData eventData);

	public abstract void OnEndDrag(PointerEventData eventData);

	public abstract void OnScroll(PointerEventData eventData);

	public abstract void Execute();

	protected void OnCaptureEntityClick(GameObject gameObject, PointerEventData eventData)
	{
		CaptureEntityTrigger captureEntityTrigger = WorldManager.Instance.GetGameContext().TryGetTrigger(gameObject);
		if (captureEntityTrigger != null)
		{
			captureEntityTrigger.OnPointerClick(gameObject, eventData);
		}
	}

	public void OnCaptureEntityBeginDrag(GameObject gameObject, PointerEventData eventData)
	{
		CaptureEntityTrigger captureEntityTrigger = WorldManager.Instance.GetGameContext().TryGetTrigger(gameObject);
		if (captureEntityTrigger != null)
		{
			captureEntityTrigger.OnBeginDrag(eventData);
		}
	}

	public void OnCaptureEntityDrag(GameObject gameObject, PointerEventData eventData)
	{
		CaptureEntityTrigger captureEntityTrigger = WorldManager.Instance.GetGameContext().TryGetTrigger(gameObject);
		if (captureEntityTrigger != null)
		{
			captureEntityTrigger.OnDrag(eventData);
		}
	}
}
