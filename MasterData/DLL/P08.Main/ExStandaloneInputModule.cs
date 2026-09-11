using UnityEngine;
using UnityEngine.EventSystems;

public class ExStandaloneInputModule : StandaloneInputModule
{
	public void ClickAt(Vector2 pos, TouchPhase phase)
	{
		Input.simulateMouseWithTouches = true;
		PointerEventData touchPointerEventData = GetTouchPointerEventData(new Touch
		{
			position = pos,
			phase = phase,
			fingerId = 99,
			pressure = 1f
		}, out var pressed, out var released);
		ProcessTouchPress(touchPointerEventData, pressed, released);
		if (!released)
		{
			ProcessMove(touchPointerEventData);
			ProcessDrag(touchPointerEventData);
		}
		else
		{
			RemovePointerData(touchPointerEventData);
		}
	}

	public void MoveAt(Vector2 pos, Vector2 lastPos)
	{
		Vector2 vector = pos - lastPos;
		if (!Mathf.Approximately(vector.x, 0f) || !Mathf.Approximately(vector.y, 0f))
		{
			Input.simulateMouseWithTouches = true;
			PointerEventData buttonData = GetMousePointerEventData().GetButtonState(PointerEventData.InputButton.Left).eventData.buttonData;
			buttonData.delta = pos - lastPos;
			buttonData.position = pos;
			base.eventSystem.RaycastAll(buttonData, m_RaycastResultCache);
			RaycastResult pointerCurrentRaycast = BaseInputModule.FindFirstRaycast(m_RaycastResultCache);
			buttonData.pointerCurrentRaycast = pointerCurrentRaycast;
			m_RaycastResultCache.Clear();
			ProcessMove(buttonData);
		}
	}

	public void ScrollAt(Vector2 pos, Vector2 scrollDelta)
	{
		if (!Mathf.Approximately(scrollDelta.sqrMagnitude, 0f))
		{
			Input.simulateMouseWithTouches = true;
			PointerEventData buttonData = GetMousePointerEventData().GetButtonState(PointerEventData.InputButton.Left).eventData.buttonData;
			buttonData.position = pos;
			buttonData.scrollDelta = scrollDelta;
			base.eventSystem.RaycastAll(buttonData, m_RaycastResultCache);
			RaycastResult pointerCurrentRaycast = BaseInputModule.FindFirstRaycast(m_RaycastResultCache);
			buttonData.pointerCurrentRaycast = pointerCurrentRaycast;
			m_RaycastResultCache.Clear();
			ExecuteEvents.ExecuteHierarchy(ExecuteEvents.GetEventHandler<IScrollHandler>(buttonData.pointerCurrentRaycast.gameObject), buttonData, ExecuteEvents.scrollHandler);
			ProcessMove(buttonData);
		}
	}
}
