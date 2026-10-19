using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace UnityEngine.UIElements;

[AddComponentMenu("UI Toolkit/Panel Event Handler (UI Toolkit)")]
public class PanelEventHandler : UIBehaviour, IPointerMoveHandler, IEventSystemHandler, IPointerUpHandler, IPointerDownHandler, ISubmitHandler, ICancelHandler, IMoveHandler, IScrollHandler, ISelectHandler, IDeselectHandler, IPointerExitHandler, IPointerEnterHandler, IRuntimePanelComponent, IPointerClickHandler
{
	private enum PointerEventType
	{
		Default,
		Down,
		Up
	}

	private class PointerEvent : IPointerEvent
	{
		public int pointerId { get; private set; }

		public string pointerType { get; private set; }

		public bool isPrimary { get; private set; }

		public int button { get; private set; }

		public int pressedButtons { get; private set; }

		public Vector3 position { get; private set; }

		public Vector3 localPosition { get; private set; }

		public Vector3 deltaPosition { get; private set; }

		public float deltaTime { get; private set; }

		public int clickCount { get; private set; }

		public float pressure { get; private set; }

		public float tangentialPressure { get; private set; }

		public float altitudeAngle { get; private set; }

		public float azimuthAngle { get; private set; }

		public float twist { get; private set; }

		public Vector2 tilt { get; private set; }

		public PenStatus penStatus { get; private set; }

		public Vector2 radius { get; private set; }

		public Vector2 radiusVariance { get; private set; }

		public EventModifiers modifiers { get; private set; }

		public bool shiftKey => (modifiers & EventModifiers.Shift) != 0;

		public bool ctrlKey => (modifiers & EventModifiers.Control) != 0;

		public bool commandKey => (modifiers & EventModifiers.Command) != 0;

		public bool altKey => (modifiers & EventModifiers.Alt) != 0;

		public bool actionKey
		{
			get
			{
				if (Application.platform != RuntimePlatform.OSXEditor && Application.platform != RuntimePlatform.OSXPlayer)
				{
					return ctrlKey;
				}
				return commandKey;
			}
		}

		public void Read(PanelEventHandler self, PointerEventData eventData, PointerEventType eventType)
		{
			pointerId = self.eventSystem.currentInputModule.ConvertUIToolkitPointerId(eventData);
			PointerEvent pointerEvent = this;
			string text;
			if (InRange(pointerId, PointerId.touchPointerIdBase, PointerId.touchPointerCount))
			{
				text = PointerType.touch;
			}
			else
			{
				text = (InRange(pointerId, PointerId.penPointerIdBase, PointerId.penPointerCount) ? PointerType.pen : PointerType.mouse);
			}
			pointerEvent.pointerType = text;
			isPrimary = pointerId == PointerId.mousePointerId || pointerId == PointerId.touchPointerIdBase || pointerId == PointerId.penPointerIdBase;
			int num = Screen.height;
			Vector3 relativeMousePositionForRaycast = MultipleDisplayUtilities.GetRelativeMousePositionForRaycast(eventData);
			int num2 = (int)relativeMousePositionForRaycast.z;
			if (num2 > 0 && num2 < Display.displays.Length)
			{
				num = Display.displays[num2].renderingHeight;
			}
			Vector2 delta = eventData.delta;
			relativeMousePositionForRaycast.y = (float)num - relativeMousePositionForRaycast.y;
			delta.y = 0f - delta.y;
			Vector3 vector = (position = relativeMousePositionForRaycast);
			localPosition = vector;
			deltaPosition = delta;
			deltaTime = 0f;
			pressure = eventData.pressure;
			tangentialPressure = eventData.tangentialPressure;
			altitudeAngle = eventData.altitudeAngle;
			azimuthAngle = eventData.azimuthAngle;
			twist = eventData.twist;
			tilt = eventData.tilt;
			penStatus = eventData.penStatus;
			radius = eventData.radius;
			radiusVariance = eventData.radiusVariance;
			modifiers = s_Modifiers;
			if (eventType == PointerEventType.Default)
			{
				button = -1;
				clickCount = 0;
			}
			else
			{
				button = Mathf.Max(0, (int)eventData.button);
				clickCount = eventData.clickCount;
				switch (eventType)
				{
				case PointerEventType.Down:
					if (Time.unscaledTime > self.m_LastClickTime + (float)ClickDetector.s_DoubleClickTime * 0.001f)
					{
						clickCount = 0;
					}
					clickCount++;
					PointerDeviceState.PressButton(pointerId, button);
					break;
				case PointerEventType.Up:
					PointerDeviceState.ReleaseButton(pointerId, button);
					break;
				}
				clickCount = Mathf.Max(1, clickCount);
			}
			pressedButtons = PointerDeviceState.GetPressedButtons(pointerId);
			static bool InRange(int i, int start, int count)
			{
				if (i >= start)
				{
					return i < start + count;
				}
				return false;
			}
		}

		public void SetPosition(Vector3 positionOverride, Vector3 deltaOverride)
		{
			Vector3 vector = (position = positionOverride);
			localPosition = vector;
			deltaPosition = deltaOverride;
		}
	}

	private BaseRuntimePanel m_Panel;

	private readonly PointerEvent m_PointerEvent = new PointerEvent();

	private float m_LastClickTime;

	private bool m_Selecting;

	private Event m_Event = new Event();

	private static EventModifiers s_Modifiers;

	public IPanel panel
	{
		get
		{
			return m_Panel;
		}
		set
		{
			BaseRuntimePanel baseRuntimePanel = (BaseRuntimePanel)value;
			if (m_Panel != baseRuntimePanel)
			{
				UnregisterCallbacks();
				m_Panel = baseRuntimePanel;
				RegisterCallbacks();
			}
		}
	}

	private GameObject selectableGameObject => m_Panel?.selectableGameObject;

	private EventSystem eventSystem => UIElementsRuntimeUtility.activeEventSystem as EventSystem;

	private bool isCurrentFocusedPanel
	{
		get
		{
			if (m_Panel != null && eventSystem != null)
			{
				return eventSystem.currentSelectedGameObject == selectableGameObject;
			}
			return false;
		}
	}

	private Focusable currentFocusedElement => m_Panel?.focusController.GetLeafFocusedElement();

	protected override void OnEnable()
	{
		base.OnEnable();
		RegisterCallbacks();
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		UnregisterCallbacks();
	}

	private void RegisterCallbacks()
	{
		if (m_Panel != null)
		{
			m_Panel.destroyed += OnPanelDestroyed;
			m_Panel.visualTree.RegisterCallback<FocusEvent>(OnElementFocus, TrickleDown.TrickleDown);
			m_Panel.visualTree.RegisterCallback<BlurEvent>(OnElementBlur, TrickleDown.TrickleDown);
		}
	}

	private void UnregisterCallbacks()
	{
		if (m_Panel != null)
		{
			m_Panel.destroyed -= OnPanelDestroyed;
			m_Panel.visualTree.UnregisterCallback<FocusEvent>(OnElementFocus, TrickleDown.TrickleDown);
			m_Panel.visualTree.UnregisterCallback<BlurEvent>(OnElementBlur, TrickleDown.TrickleDown);
		}
	}

	private void OnPanelDestroyed()
	{
		panel = null;
	}

	private void OnElementFocus(FocusEvent e)
	{
		if (!m_Selecting && eventSystem != null)
		{
			eventSystem.SetSelectedGameObject(selectableGameObject);
		}
	}

	private void OnElementBlur(BlurEvent e)
	{
	}

	public void OnSelect(BaseEventData eventData)
	{
		m_Selecting = true;
		try
		{
			m_Panel?.Focus();
		}
		finally
		{
			m_Selecting = false;
		}
	}

	public void OnDeselect(BaseEventData eventData)
	{
		m_Panel?.Blur();
	}

	public void OnPointerMove(PointerEventData eventData)
	{
		if (m_Panel == null || !ReadPointerData(m_PointerEvent, eventData))
		{
			return;
		}
		using PointerMoveEvent e = PointerEventBase<PointerMoveEvent>.GetPooled(m_PointerEvent);
		SendEvent(e, eventData);
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (m_Panel == null || !ReadPointerData(m_PointerEvent, eventData, PointerEventType.Up))
		{
			return;
		}
		using PointerUpEvent pointerUpEvent = PointerEventBase<PointerUpEvent>.GetPooled(m_PointerEvent);
		SendEvent(pointerUpEvent, eventData);
		if (pointerUpEvent.pressedButtons == 0)
		{
			PointerDeviceState.SetPlayerPanelWithSoftPointerCapture(pointerUpEvent.pointerId, null);
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (m_Panel == null || !ReadPointerData(m_PointerEvent, eventData, PointerEventType.Down))
		{
			return;
		}
		if (eventSystem != null)
		{
			eventSystem.SetSelectedGameObject(selectableGameObject);
		}
		using PointerDownEvent pointerDownEvent = PointerEventBase<PointerDownEvent>.GetPooled(m_PointerEvent);
		SendEvent(pointerDownEvent, eventData);
		PointerDeviceState.SetPlayerPanelWithSoftPointerCapture(pointerDownEvent.pointerId, m_Panel);
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		if (m_Panel == null || !ReadPointerData(m_PointerEvent, eventData))
		{
			return;
		}
		if (eventData.pointerCurrentRaycast.gameObject == gameObject && eventData.pointerPressRaycast.gameObject != gameObject && m_PointerEvent.pointerId != PointerId.mousePointerId)
		{
			using PointerCancelEvent pointerCancelEvent = PointerEventBase<PointerCancelEvent>.GetPooled(m_PointerEvent);
			SendEvent(pointerCancelEvent, eventData);
			if (pointerCancelEvent.pressedButtons == 0)
			{
				PointerDeviceState.SetPlayerPanelWithSoftPointerCapture(pointerCancelEvent.pointerId, null);
			}
		}
		m_Panel.PointerLeavesPanel(m_PointerEvent.pointerId, m_PointerEvent.position);
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		if (m_Panel != null && ReadPointerData(m_PointerEvent, eventData))
		{
			m_Panel.PointerEntersPanel(m_PointerEvent.pointerId, m_PointerEvent.position);
		}
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		m_LastClickTime = Time.unscaledTime;
	}

	public void OnSubmit(BaseEventData eventData)
	{
		if (m_Panel == null)
		{
			return;
		}
		Focusable target = currentFocusedElement ?? m_Panel.visualTree;
		ProcessImguiEvents(target);
		using NavigationSubmitEvent navigationSubmitEvent = NavigationEventBase<NavigationSubmitEvent>.GetPooled(s_Modifiers);
		navigationSubmitEvent.target = target;
		SendEvent(navigationSubmitEvent, eventData);
	}

	public void OnCancel(BaseEventData eventData)
	{
		if (m_Panel == null)
		{
			return;
		}
		Focusable target = currentFocusedElement ?? m_Panel.visualTree;
		ProcessImguiEvents(target);
		using NavigationCancelEvent navigationCancelEvent = NavigationEventBase<NavigationCancelEvent>.GetPooled(s_Modifiers);
		navigationCancelEvent.target = target;
		SendEvent(navigationCancelEvent, eventData);
	}

	public void OnMove(AxisEventData eventData)
	{
		if (m_Panel == null)
		{
			return;
		}
		Focusable target = currentFocusedElement ?? m_Panel.visualTree;
		ProcessImguiEvents(target);
		using NavigationMoveEvent navigationMoveEvent = NavigationMoveEvent.GetPooled(eventData.moveVector, s_Modifiers);
		navigationMoveEvent.target = target;
		SendEvent(navigationMoveEvent, eventData);
	}

	public void OnScroll(PointerEventData eventData)
	{
		if (m_Panel == null || !ReadPointerData(m_PointerEvent, eventData))
		{
			return;
		}
		Vector2 scrollDelta = eventData.scrollDelta;
		scrollDelta.y = 0f - scrollDelta.y;
		scrollDelta /= 20f;
		using WheelEvent e = WheelEvent.GetPooled(scrollDelta, m_PointerEvent);
		SendEvent(e, eventData);
	}

	private void SendEvent(EventBase e, BaseEventData sourceEventData)
	{
		m_Panel.SendEvent(e);
		if (e.isPropagationStopped)
		{
			sourceEventData.Use();
		}
	}

	private void SendEvent(EventBase e, Event sourceEvent)
	{
		m_Panel.SendEvent(e);
	}

	internal void Update()
	{
		if (isCurrentFocusedPanel)
		{
			ProcessImguiEvents(currentFocusedElement ?? m_Panel.visualTree);
		}
	}

	private void LateUpdate()
	{
		ProcessImguiEvents(null);
	}

	private void ProcessImguiEvents(Focusable target)
	{
		bool flag = true;
		while (Event.PopEvent(m_Event))
		{
			if (m_Event.type == EventType.Ignore || m_Event.type == EventType.Repaint || m_Event.type == EventType.Layout)
			{
				continue;
			}
			s_Modifiers = (flag ? m_Event.modifiers : (s_Modifiers | m_Event.modifiers));
			flag = false;
			if (target != null)
			{
				ProcessKeyboardEvent(m_Event, target);
				if (eventSystem.sendNavigationEvents)
				{
					ProcessTabEvent(m_Event, target);
				}
			}
		}
	}

	private void ProcessKeyboardEvent(Event e, Focusable target)
	{
		if (e.type == EventType.KeyUp)
		{
			SendKeyUpEvent(e, target);
		}
		else if (e.type == EventType.KeyDown)
		{
			SendKeyDownEvent(e, target);
		}
	}

	private void ProcessTabEvent(Event e, Focusable target)
	{
		if (e.ShouldSendNavigationMoveEventRuntime())
		{
			SendTabEvent(e, e.shift ? NavigationMoveEvent.Direction.Previous : NavigationMoveEvent.Direction.Next, target);
		}
	}

	private void SendTabEvent(Event e, NavigationMoveEvent.Direction direction, Focusable target)
	{
		using NavigationMoveEvent navigationMoveEvent = NavigationMoveEvent.GetPooled(direction, s_Modifiers);
		navigationMoveEvent.target = target;
		SendEvent(navigationMoveEvent, e);
	}

	private void SendKeyUpEvent(Event e, Focusable target)
	{
		using KeyUpEvent keyUpEvent = (KeyUpEvent)UIElementsRuntimeUtility.CreateEvent(e);
		keyUpEvent.target = target;
		SendEvent(keyUpEvent, e);
	}

	private void SendKeyDownEvent(Event e, Focusable target)
	{
		using KeyDownEvent keyDownEvent = (KeyDownEvent)UIElementsRuntimeUtility.CreateEvent(e);
		keyDownEvent.target = target;
		SendEvent(keyDownEvent, e);
	}

	private bool ReadPointerData(PointerEvent pe, PointerEventData eventData, PointerEventType eventType = PointerEventType.Default)
	{
		if (eventSystem == null || eventSystem.currentInputModule == null)
		{
			return false;
		}
		pe.Read(this, eventData, eventType);
		m_Panel.ScreenToPanel(pe.position, pe.deltaPosition, out var panelPosition, out var panelDelta, allowOutside: true);
		pe.SetPosition(panelPosition, panelDelta);
		return true;
	}
}
