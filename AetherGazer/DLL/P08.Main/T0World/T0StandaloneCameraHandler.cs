using UnityEngine.EventSystems;

namespace T0World;

public class T0StandaloneCameraHandler : T0CaptureCameraPlatformHandle
{
	public bool isInDragging;

	public override void Execute()
	{
	}

	public override void OnBeginDrag(PointerEventData eventData)
	{
	}

	public override void OnDrag(PointerEventData eventData)
	{
		isInDragging = true;
		float dragDelta = eventData.delta.x * m_controller.speed * 0.2f;
		float deltaHeight = eventData.delta.y * m_controller.speedY * 0.2f;
		m_controller.UpdateSingleCamera(dragDelta, deltaHeight);
	}

	public override void OnEndDrag(PointerEventData eventData)
	{
		m_controller.UpdateSingleCamera(0f, 0f);
	}

	public override void OnPointDown(PointerEventData eventData)
	{
		isInDragging = false;
	}

	public override void OnPointerClick(PointerEventData eventData)
	{
		BackToNormalState();
	}

	public override void OnPointUp(PointerEventData eventData)
	{
		if (!isInDragging)
		{
			BackToNormalState();
		}
	}

	public override void OnScroll(PointerEventData eventData)
	{
		float num = 1f;
		if (PlatformHelper.IsPC())
		{
			num = 0.05f;
		}
		m_controller.UpdateCameraFov(eventData.scrollDelta.y * m_controller.scorllSpeed * 0.2f * num);
	}

	public virtual void BackToNormalState()
	{
		T0WorldScene.Scene.mWorldUI.ChangePhotoViewMode(T0CaptureModeStateEnum.photo);
	}
}
