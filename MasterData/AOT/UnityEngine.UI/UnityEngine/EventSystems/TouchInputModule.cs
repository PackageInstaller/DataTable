using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine.Serialization;

namespace UnityEngine.EventSystems;

[AddComponentMenu("Event/Touch Input Module")]
[Obsolete("TouchInputModule is no longer required as Touch input is now handled in StandaloneInputModule.")]
public class TouchInputModule : PointerInputModule
{
	private Vector2 m_LastMousePosition;

	private Vector2 m_MousePosition;

	private PointerEventData m_InputPointerEvent;

	[SerializeField]
	[FormerlySerializedAs("m_AllowActivationOnStandalone")]
	private bool m_ForceModuleActive;

	[Obsolete("allowActivationOnStandalone has been deprecated. Use forceModuleActive instead (UnityUpgradable) -> forceModuleActive")]
	public bool allowActivationOnStandalone
	{
		get
		{
			return m_ForceModuleActive;
		}
		set
		{
			m_ForceModuleActive = value;
		}
	}

	public bool forceModuleActive
	{
		get
		{
			return m_ForceModuleActive;
		}
		set
		{
			m_ForceModuleActive = value;
		}
	}

	protected TouchInputModule()
	{
	}

	public override void UpdateModule()
	{
		if (!eventSystem.isFocused)
		{
			if (m_InputPointerEvent != null && m_InputPointerEvent.pointerDrag != null && m_InputPointerEvent.dragging)
			{
				ExecuteEvents.Execute(m_InputPointerEvent.pointerDrag, m_InputPointerEvent, ExecuteEvents.endDragHandler);
			}
			m_InputPointerEvent = null;
		}
		m_LastMousePosition = m_MousePosition;
		m_MousePosition = input.mousePosition;
	}

	public override bool IsModuleSupported()
	{
		if (!forceModuleActive)
		{
			return input.touchSupported;
		}
		return true;
	}

	public override bool ShouldActivateModule()
	{
		if (!base.ShouldActivateModule())
		{
			return false;
		}
		if (m_ForceModuleActive)
		{
			return true;
		}
		if (UseFakeInput())
		{
			return input.GetMouseButtonDown(0) | ((m_MousePosition - m_LastMousePosition).sqrMagnitude > 0f);
		}
		return input.touchCount > 0;
	}

	private bool UseFakeInput()
	{
		return !input.touchSupported;
	}

	public override void Process()
	{
		if (UseFakeInput())
		{
			FakeTouches();
		}
		else
		{
			ProcessTouchEvents();
		}
	}

	private void FakeTouches()
	{
		MouseButtonEventData eventData = GetMousePointerEventData(0).GetButtonState(PointerEventData.InputButton.Left).eventData;
		if (eventData.PressedThisFrame())
		{
			eventData.buttonData.delta = Vector2.zero;
		}
		ProcessTouchPress(eventData.buttonData, eventData.PressedThisFrame(), eventData.ReleasedThisFrame());
		if (input.GetMouseButton(0))
		{
			ProcessMove(eventData.buttonData);
			ProcessDrag(eventData.buttonData);
		}
	}

	private void ProcessTouchEvents()
	{
		for (int i = 0; i < input.touchCount; i++)
		{
			Touch touch = input.GetTouch(i);
			if (touch.type != TouchType.Indirect)
			{
				PointerEventData touchPointerEventData = GetTouchPointerEventData(touch, out var pressed, out var released);
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
		}
	}

	protected void ProcessTouchPress(PointerEventData pointerEvent, bool pressed, bool released)
	{
		GameObject gameObject = pointerEvent.pointerCurrentRaycast.gameObject;
		if (pressed)
		{
			pointerEvent.eligibleForClick = true;
			pointerEvent.delta = Vector2.zero;
			pointerEvent.dragging = false;
			pointerEvent.useDragThreshold = true;
			pointerEvent.pressPosition = pointerEvent.position;
			pointerEvent.pointerPressRaycast = pointerEvent.pointerCurrentRaycast;
			DeselectIfSelectionChanged(gameObject, pointerEvent);
			if (pointerEvent.pointerEnter != gameObject)
			{
				HandlePointerExitAndEnter(pointerEvent, gameObject);
				pointerEvent.pointerEnter = gameObject;
			}
			GameObject gameObject2 = ExecuteEvents.ExecuteHierarchy(gameObject, pointerEvent, ExecuteEvents.pointerDownHandler);
			if (gameObject2 == null)
			{
				gameObject2 = ExecuteEvents.GetEventHandler<IPointerClickHandler>(gameObject);
			}
			float unscaledTime = Time.unscaledTime;
			if (gameObject2 == pointerEvent.lastPress)
			{
				if (unscaledTime - pointerEvent.clickTime < 0.3f)
				{
					int clickCount = pointerEvent.clickCount + 1;
					pointerEvent.clickCount = clickCount;
				}
				else
				{
					pointerEvent.clickCount = 1;
				}
				pointerEvent.clickTime = unscaledTime;
			}
			else
			{
				pointerEvent.clickCount = 1;
			}
			pointerEvent.pointerPress = gameObject2;
			pointerEvent.rawPointerPress = gameObject;
			pointerEvent.clickTime = unscaledTime;
			pointerEvent.pointerDrag = ExecuteEvents.GetEventHandler<IDragHandler>(gameObject);
			if (pointerEvent.pointerDrag != null)
			{
				ExecuteEvents.Execute(pointerEvent.pointerDrag, pointerEvent, ExecuteEvents.initializePotentialDrag);
			}
			m_InputPointerEvent = pointerEvent;
		}
		if (released)
		{
			ExecuteEvents.Execute(pointerEvent.pointerPress, pointerEvent, ExecuteEvents.pointerUpHandler);
			GameObject eventHandler = ExecuteEvents.GetEventHandler<IPointerClickHandler>(gameObject);
			if (pointerEvent.pointerPress == eventHandler && pointerEvent.eligibleForClick)
			{
				ExecuteEvents.Execute(pointerEvent.pointerPress, pointerEvent, ExecuteEvents.pointerClickHandler);
			}
			else if (pointerEvent.pointerDrag != null && pointerEvent.dragging)
			{
				ExecuteEvents.ExecuteHierarchy(gameObject, pointerEvent, ExecuteEvents.dropHandler);
			}
			pointerEvent.eligibleForClick = false;
			pointerEvent.pointerPress = null;
			pointerEvent.rawPointerPress = null;
			if (pointerEvent.pointerDrag != null && pointerEvent.dragging)
			{
				ExecuteEvents.Execute(pointerEvent.pointerDrag, pointerEvent, ExecuteEvents.endDragHandler);
			}
			pointerEvent.dragging = false;
			pointerEvent.pointerDrag = null;
			ExecuteEvents.ExecuteHierarchy(pointerEvent.pointerEnter, pointerEvent, ExecuteEvents.pointerExitHandler);
			pointerEvent.pointerEnter = null;
			m_InputPointerEvent = pointerEvent;
		}
	}

	public override void DeactivateModule()
	{
		base.DeactivateModule();
		ClearSelection();
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.AppendLine(UseFakeInput() ? "Input: Faked" : "Input: Touch");
		if (UseFakeInput())
		{
			PointerEventData lastPointerEventData = GetLastPointerEventData(-1);
			if (lastPointerEventData != null)
			{
				stringBuilder.AppendLine(lastPointerEventData.ToString());
			}
		}
		else
		{
			foreach (KeyValuePair<int, PointerEventData> pointerDatum in m_PointerData)
			{
				stringBuilder.AppendLine(pointerDatum.ToString());
			}
		}
		return stringBuilder.ToString();
	}
}
