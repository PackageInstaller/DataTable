using UnityEngine.EventSystems;

namespace P08.SimBusiness.Input;

public class SimBusinessCameraTrigger : CameraEventTrigger
{
	protected override void OnCameraDrag(PointerEventData eventData)
	{
		if ((bool)SimBusinessMgr.instance)
		{
			SimBusinessMgr.instance.OnDragCamera(eventData);
		}
	}

	protected override void OnCameraZoom(float zoomValue)
	{
	}
}
