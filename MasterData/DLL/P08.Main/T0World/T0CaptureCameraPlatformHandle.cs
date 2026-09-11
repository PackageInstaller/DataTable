using UnityEngine.EventSystems;

namespace T0World;

public abstract class T0CaptureCameraPlatformHandle
{
	protected T0CaptureCameraController m_controller;

	public void InitHandler(T0CaptureCameraController controller)
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
}
