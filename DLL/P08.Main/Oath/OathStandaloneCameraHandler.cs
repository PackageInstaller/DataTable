using T0World;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Oath;

public class OathStandaloneCameraHandler : T0StandaloneCameraHandler
{
	public override void BackToNormalState()
	{
		OathSceneLoader.Scene.context.captureViewUI?.ChangeViewMode(OathCaptureModeStateEnum.photo);
	}

	public override void OnDrag(PointerEventData eventData)
	{
		float num = 1f;
		if (PlatformHelper.IsPC())
		{
			num = 4f;
		}
		isInDragging = true;
		float dragDelta = eventData.delta.x * m_controller.speed / Time.deltaTime / (float)Application.targetFrameRate * 0.2f * num;
		float deltaHeight = eventData.delta.y * m_controller.speedY / Time.deltaTime / (float)Application.targetFrameRate * 0.2f * num;
		m_controller.UpdateSingleCamera(dragDelta, deltaHeight);
	}
}
