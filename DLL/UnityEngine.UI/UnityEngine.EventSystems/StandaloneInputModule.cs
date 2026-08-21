using System;
using UnityEngine.Serialization;

namespace UnityEngine.EventSystems;

[AddComponentMenu("Event/Standalone Input Module")]
public class StandaloneInputModule : PointerInputModule
{
	[Obsolete("Mode is no longer needed on input module as it handles both mouse and keyboard simultaneously.", false)]
	public enum InputMode
	{
		Mouse,
		Buttons
	}

	private float m_PrevActionTime;

	private Vector2 m_LastMoveVector;

	private int m_ConsecutiveMoveCount;

	private Vector2 m_LastMousePosition;

	private Vector2 m_MousePosition;

	private GameObject m_CurrentFocusedGameObject;

	private PointerEventData m_InputPointerEvent;

	[SerializeField]
	private string m_HorizontalAxis = "Horizontal";

	[SerializeField]
	private string m_VerticalAxis = "Vertical";

	[SerializeField]
	private string m_SubmitButton = "Submit";

	[SerializeField]
	private string m_CancelButton = "Cancel";

	[SerializeField]
	private float m_InputActionsPerSecond = 10f;

	[SerializeField]
	private float m_RepeatDelay = 0.5f;

	[SerializeField]
	[HideInInspector]
	[FormerlySerializedAs("m_AllowActivationOnMobileDevice")]
	private bool m_ForceModuleActive;

	[Obsolete("Mode is no longer needed on input module as it handles both mouse and keyboard simultaneously.", false)]
	public InputMode inputMode => InputMode.Mouse;

	[Obsolete("allowActivationOnMobileDevice has been deprecated. Use forceModuleActive instead (UnityUpgradable) -> forceModuleActive")]
	public bool allowActivationOnMobileDevice
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

	[Obsolete("forceModuleActive has been deprecated. There is no need to force the module awake as StandaloneInputModule works for all platforms")]
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

	public float inputActionsPerSecond
	{
		get
		{
			return m_InputActionsPerSecond;
		}
		set
		{
			m_InputActionsPerSecond = value;
		}
	}

	public float repeatDelay
	{
		get
		{
			return m_RepeatDelay;
		}
		set
		{
			m_RepeatDelay = value;
		}
	}

	public string horizontalAxis
	{
		get
		{
			return m_HorizontalAxis;
		}
		set
		{
			m_HorizontalAxis = value;
		}
	}

	public string verticalAxis
	{
		get
		{
			return m_VerticalAxis;
		}
		set
		{
			m_VerticalAxis = value;
		}
	}

	public string submitButton
	{
		get
		{
			return m_SubmitButton;
		}
		set
		{
			m_SubmitButton = value;
		}
	}

	public string cancelButton
	{
		get
		{
			return m_CancelButton;
		}
		set
		{
			m_CancelButton = value;
		}
	}

	protected StandaloneInputModule()
	{
	}

	private bool ShouldIgnoreEventsOnNoFocus()
	{
		return true;
	}

	public override void UpdateModule()
	{
		if (!base.eventSystem.isFocused && ShouldIgnoreEventsOnNoFocus())
		{
			if (m_InputPointerEvent != null && m_InputPointerEvent.pointerDrag != null && m_InputPointerEvent.dragging)
			{
				ReleaseMouse(m_InputPointerEvent, m_InputPointerEvent.pointerCurrentRaycast.gameObject);
			}
			m_InputPointerEvent = null;
		}
		else
		{
			m_LastMousePosition = m_MousePosition;
			m_MousePosition = base.input.mousePosition;
		}
	}

	private void ReleaseMouse(PointerEventData pointerEvent, GameObject currentOverGo)
	{
		ExecuteEvents.Execute(pointerEvent.pointerPress, pointerEvent, ExecuteEvents.pointerUpHandler);
		GameObject eventHandler = ExecuteEvents.GetEventHandler<IPointerClickHandler>(currentOverGo);
		if (pointerEvent.pointerClick == eventHandler && pointerEvent.eligibleForClick)
		{
			ExecuteEvents.Execute(pointerEvent.pointerClick, pointerEvent, ExecuteEvents.pointerClickHandler);
		}
		if (pointerEvent.pointerDrag != null && pointerEvent.dragging)
		{
			ExecuteEvents.ExecuteHierarchy(currentOverGo, pointerEvent, ExecuteEvents.dropHandler);
		}
		pointerEvent.eligibleForClick = false;
		pointerEvent.pointerPress = null;
		pointerEvent.rawPointerPress = null;
		pointerEvent.pointerClick = null;
		if (pointerEvent.pointerDrag != null && pointerEvent.dragging)
		{
			ExecuteEvents.Execute(pointerEvent.pointerDrag, pointerEvent, ExecuteEvents.endDragHandler);
		}
		pointerEvent.dragging = false;
		pointerEvent.pointerDrag = null;
		if (currentOverGo != pointerEvent.pointerEnter)
		{
			HandlePointerExitAndEnter(pointerEvent, null);
			HandlePointerExitAndEnter(pointerEvent, currentOverGo);
		}
		m_InputPointerEvent = pointerEvent;
	}

	public override bool ShouldActivateModule()
	{
		if (!base.ShouldActivateModule())
		{
			return false;
		}
		bool flag = m_ForceModuleActive;
		flag |= base.input.GetButtonDown(m_SubmitButton);
		flag |= base.input.GetButtonDown(m_CancelButton);
		flag |= !Mathf.Approximately(base.input.GetAxisRaw(m_HorizontalAxis), 0f);
		flag |= !Mathf.Approximately(base.input.GetAxisRaw(m_VerticalAxis), 0f);
		flag |= (m_MousePosition - m_LastMousePosition).sqrMagnitude > 0f;
		flag |= base.input.GetMouseButtonDown(0);
		if (base.input.touchCount > 0)
		{
			flag = true;
		}
		return flag;
	}

	public override void ActivateModule()
	{
		if (base.eventSystem.isFocused || !ShouldIgnoreEventsOnNoFocus())
		{
			base.ActivateModule();
			m_MousePosition = base.input.mousePosition;
			m_LastMousePosition = base.input.mousePosition;
			GameObject gameObject = base.eventSystem.currentSelectedGameObject;
			if (gameObject == null)
			{
				gameObject = base.eventSystem.firstSelectedGameObject;
			}
			base.eventSystem.SetSelectedGameObject(gameObject, GetBaseEventData());
		}
	}

	public override void DeactivateModule()
	{
		base.DeactivateModule();
		ClearSelection();
	}

	public override void Process()
	{
		if (!base.eventSystem.isFocused && ShouldIgnoreEventsOnNoFocus())
		{
			return;
		}
		bool flag = SendUpdateEventToSelectedObject();
		if (!ProcessTouchEvents() && base.input.mousePresent)
		{
			ProcessMouseEvent();
		}
		if (base.eventSystem.sendNavigationEvents)
		{
			if (!flag)
			{
				flag |= SendMoveEventToSelectedObject();
			}
			if (!flag)
			{
				SendSubmitEventToSelectedObject();
			}
		}
	}

	private bool ProcessTouchEvents()
	{
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Invalid comparison between Unknown and I4
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		for (int i = 0; i < base.input.touchCount; i++)
		{
			Touch touch = base.input.GetTouch(i);
			if ((int)((Touch)(ref touch)).type != 1)
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
		return base.input.touchCount > 0;
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
			GameObject eventHandler = ExecuteEvents.GetEventHandler<IPointerClickHandler>(gameObject);
			if (gameObject2 == null)
			{
				gameObject2 = eventHandler;
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
			pointerEvent.pointerClick = eventHandler;
			pointerEvent.clickTime = unscaledTime;
			pointerEvent.pointerDrag = ExecuteEvents.GetEventHandler<IDragHandler>(gameObject);
			if (pointerEvent.pointerDrag != null)
			{
				ExecuteEvents.Execute(pointerEvent.pointerDrag, pointerEvent, ExecuteEvents.initializePotentialDrag);
			}
		}
		if (released)
		{
			ExecuteEvents.Execute(pointerEvent.pointerPress, pointerEvent, ExecuteEvents.pointerUpHandler);
			GameObject eventHandler2 = ExecuteEvents.GetEventHandler<IPointerClickHandler>(gameObject);
			if (pointerEvent.pointerClick == eventHandler2 && pointerEvent.eligibleForClick)
			{
				ExecuteEvents.Execute(pointerEvent.pointerClick, pointerEvent, ExecuteEvents.pointerClickHandler);
			}
			if (pointerEvent.pointerDrag != null && pointerEvent.dragging)
			{
				ExecuteEvents.ExecuteHierarchy(gameObject, pointerEvent, ExecuteEvents.dropHandler);
			}
			pointerEvent.eligibleForClick = false;
			pointerEvent.pointerPress = null;
			pointerEvent.rawPointerPress = null;
			pointerEvent.pointerClick = null;
			if (pointerEvent.pointerDrag != null && pointerEvent.dragging)
			{
				ExecuteEvents.Execute(pointerEvent.pointerDrag, pointerEvent, ExecuteEvents.endDragHandler);
			}
			pointerEvent.dragging = false;
			pointerEvent.pointerDrag = null;
			ExecuteEvents.ExecuteHierarchy(pointerEvent.pointerEnter, pointerEvent, ExecuteEvents.pointerExitHandler);
			pointerEvent.pointerEnter = null;
		}
		m_InputPointerEvent = pointerEvent;
	}

	protected bool SendSubmitEventToSelectedObject()
	{
		if (base.eventSystem.currentSelectedGameObject == null)
		{
			return false;
		}
		BaseEventData baseEventData = GetBaseEventData();
		if (base.input.GetButtonDown(m_SubmitButton))
		{
			ExecuteEvents.Execute(base.eventSystem.currentSelectedGameObject, baseEventData, ExecuteEvents.submitHandler);
		}
		if (base.input.GetButtonDown(m_CancelButton))
		{
			ExecuteEvents.Execute(base.eventSystem.currentSelectedGameObject, baseEventData, ExecuteEvents.cancelHandler);
		}
		return baseEventData.used;
	}

	private Vector2 GetRawMoveVector()
	{
		Vector2 zero = Vector2.zero;
		zero.x = base.input.GetAxisRaw(m_HorizontalAxis);
		zero.y = base.input.GetAxisRaw(m_VerticalAxis);
		if (base.input.GetButtonDown(m_HorizontalAxis))
		{
			if (zero.x < 0f)
			{
				zero.x = -1f;
			}
			if (zero.x > 0f)
			{
				zero.x = 1f;
			}
		}
		if (base.input.GetButtonDown(m_VerticalAxis))
		{
			if (zero.y < 0f)
			{
				zero.y = -1f;
			}
			if (zero.y > 0f)
			{
				zero.y = 1f;
			}
		}
		return zero;
	}

	protected bool SendMoveEventToSelectedObject()
	{
		float unscaledTime = Time.unscaledTime;
		Vector2 rawMoveVector = GetRawMoveVector();
		if (Mathf.Approximately(rawMoveVector.x, 0f) && Mathf.Approximately(rawMoveVector.y, 0f))
		{
			m_ConsecutiveMoveCount = 0;
			return false;
		}
		bool flag = Vector2.Dot(rawMoveVector, m_LastMoveVector) > 0f;
		if (flag && m_ConsecutiveMoveCount == 1)
		{
			if (unscaledTime <= m_PrevActionTime + m_RepeatDelay)
			{
				return false;
			}
		}
		else if (unscaledTime <= m_PrevActionTime + 1f / m_InputActionsPerSecond)
		{
			return false;
		}
		AxisEventData axisEventData = GetAxisEventData(rawMoveVector.x, rawMoveVector.y, 0.6f);
		if (axisEventData.moveDir != MoveDirection.None)
		{
			ExecuteEvents.Execute(base.eventSystem.currentSelectedGameObject, axisEventData, ExecuteEvents.moveHandler);
			if (!flag)
			{
				m_ConsecutiveMoveCount = 0;
			}
			m_ConsecutiveMoveCount++;
			m_PrevActionTime = unscaledTime;
			m_LastMoveVector = rawMoveVector;
		}
		else
		{
			m_ConsecutiveMoveCount = 0;
		}
		return axisEventData.used;
	}

	protected void ProcessMouseEvent()
	{
		ProcessMouseEvent(0);
	}

	[Obsolete("This method is no longer checked, overriding it with return true does nothing!")]
	protected virtual bool ForceAutoSelect()
	{
		return false;
	}

	protected void ProcessMouseEvent(int id)
	{
		MouseState mousePointerEventData = GetMousePointerEventData(id);
		MouseButtonEventData eventData = mousePointerEventData.GetButtonState(PointerEventData.InputButton.Left).eventData;
		m_CurrentFocusedGameObject = eventData.buttonData.pointerCurrentRaycast.gameObject;
		ProcessMousePress(eventData);
		ProcessMove(eventData.buttonData);
		ProcessDrag(eventData.buttonData);
		ProcessMousePress(mousePointerEventData.GetButtonState(PointerEventData.InputButton.Right).eventData);
		ProcessDrag(mousePointerEventData.GetButtonState(PointerEventData.InputButton.Right).eventData.buttonData);
		ProcessMousePress(mousePointerEventData.GetButtonState(PointerEventData.InputButton.Middle).eventData);
		ProcessDrag(mousePointerEventData.GetButtonState(PointerEventData.InputButton.Middle).eventData.buttonData);
		if (!Mathf.Approximately(eventData.buttonData.scrollDelta.sqrMagnitude, 0f))
		{
			ExecuteEvents.ExecuteHierarchy(ExecuteEvents.GetEventHandler<IScrollHandler>(eventData.buttonData.pointerCurrentRaycast.gameObject), eventData.buttonData, ExecuteEvents.scrollHandler);
		}
	}

	protected bool SendUpdateEventToSelectedObject()
	{
		if (base.eventSystem.currentSelectedGameObject == null)
		{
			return false;
		}
		BaseEventData baseEventData = GetBaseEventData();
		ExecuteEvents.Execute(base.eventSystem.currentSelectedGameObject, baseEventData, ExecuteEvents.updateSelectedHandler);
		return baseEventData.used;
	}

	protected void ProcessMousePress(MouseButtonEventData data)
	{
		PointerEventData buttonData = data.buttonData;
		GameObject gameObject = buttonData.pointerCurrentRaycast.gameObject;
		if (data.PressedThisFrame())
		{
			buttonData.eligibleForClick = true;
			buttonData.delta = Vector2.zero;
			buttonData.dragging = false;
			buttonData.useDragThreshold = true;
			buttonData.pressPosition = buttonData.position;
			buttonData.pointerPressRaycast = buttonData.pointerCurrentRaycast;
			DeselectIfSelectionChanged(gameObject, buttonData);
			GameObject gameObject2 = ExecuteEvents.ExecuteHierarchy(gameObject, buttonData, ExecuteEvents.pointerDownHandler);
			GameObject eventHandler = ExecuteEvents.GetEventHandler<IPointerClickHandler>(gameObject);
			if (gameObject2 == null)
			{
				gameObject2 = eventHandler;
			}
			float unscaledTime = Time.unscaledTime;
			if (gameObject2 == buttonData.lastPress)
			{
				if (unscaledTime - buttonData.clickTime < 0.3f)
				{
					int clickCount = buttonData.clickCount + 1;
					buttonData.clickCount = clickCount;
				}
				else
				{
					buttonData.clickCount = 1;
				}
				buttonData.clickTime = unscaledTime;
			}
			else
			{
				buttonData.clickCount = 1;
			}
			buttonData.pointerPress = gameObject2;
			buttonData.rawPointerPress = gameObject;
			buttonData.pointerClick = eventHandler;
			buttonData.clickTime = unscaledTime;
			buttonData.pointerDrag = ExecuteEvents.GetEventHandler<IDragHandler>(gameObject);
			if (buttonData.pointerDrag != null)
			{
				ExecuteEvents.Execute(buttonData.pointerDrag, buttonData, ExecuteEvents.initializePotentialDrag);
			}
			m_InputPointerEvent = buttonData;
		}
		if (data.ReleasedThisFrame())
		{
			ReleaseMouse(buttonData, gameObject);
		}
	}

	protected GameObject GetCurrentFocusedGameObject()
	{
		return m_CurrentFocusedGameObject;
	}
}
