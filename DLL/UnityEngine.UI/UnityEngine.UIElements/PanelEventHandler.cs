using System;
using System.Runtime.CompilerServices;
using UnityEngine.EventSystems;

namespace UnityEngine.UIElements;

[AddComponentMenu("UI Toolkit/Panel Event Handler (UI Toolkit)")]
public class PanelEventHandler : UIBehaviour, IPointerMoveHandler, IEventSystemHandler, IPointerUpHandler, IPointerDownHandler, ISubmitHandler, ICancelHandler, IMoveHandler, IScrollHandler, ISelectHandler, IDeselectHandler, IPointerExitHandler, IPointerEnterHandler, IRuntimePanelComponent
{
	private enum PointerEventType
	{
		Default,
		Down,
		Up
	}

	private class PointerEvent : IPointerEvent
	{
		[CompilerGenerated]
		private EventModifiers _003Cmodifiers_003Ek__BackingField;

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

		public Vector2 radius { get; private set; }

		public Vector2 radiusVariance { get; private set; }

		public EventModifiers modifiers
		{
			[CompilerGenerated]
			get
			{
				//IL_0001: Unknown result type (might be due to invalid IL or missing references)
				return _003Cmodifiers_003Ek__BackingField;
			}
			[CompilerGenerated]
			private set
			{
				//IL_0001: Unknown result type (might be due to invalid IL or missing references)
				//IL_0002: Unknown result type (might be due to invalid IL or missing references)
				_003Cmodifiers_003Ek__BackingField = value;
			}
		}

		public bool shiftKey
		{
			get
			{
				//IL_0001: Unknown result type (might be due to invalid IL or missing references)
				//IL_0007: Unknown result type (might be due to invalid IL or missing references)
				//IL_0009: Invalid comparison between Unknown and I4
				return (modifiers & 1) > 0;
			}
		}

		public bool ctrlKey
		{
			get
			{
				//IL_0001: Unknown result type (might be due to invalid IL or missing references)
				//IL_0007: Unknown result type (might be due to invalid IL or missing references)
				//IL_0009: Invalid comparison between Unknown and I4
				return (modifiers & 2) > 0;
			}
		}

		public bool commandKey
		{
			get
			{
				//IL_0001: Unknown result type (might be due to invalid IL or missing references)
				//IL_0007: Unknown result type (might be due to invalid IL or missing references)
				//IL_0009: Invalid comparison between Unknown and I4
				return (modifiers & 8) > 0;
			}
		}

		public bool altKey
		{
			get
			{
				//IL_0001: Unknown result type (might be due to invalid IL or missing references)
				//IL_0007: Unknown result type (might be due to invalid IL or missing references)
				//IL_0009: Invalid comparison between Unknown and I4
				return (modifiers & 4) > 0;
			}
		}

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
			//IL_019e: Unknown result type (might be due to invalid IL or missing references)
			pointerId = self.eventSystem.currentInputModule.ConvertUIToolkitPointerId(eventData);
			pointerType = (InRange(pointerId, PointerId.touchPointerIdBase, PointerId.touchPointerCount) ? PointerType.touch : (InRange(pointerId, PointerId.penPointerIdBase, PointerId.penPointerCount) ? PointerType.pen : PointerType.mouse));
			isPrimary = pointerId == PointerId.mousePointerId || pointerId == PointerId.touchPointerIdBase || pointerId == PointerId.penPointerIdBase;
			button = (int)eventData.button;
			clickCount = eventData.clickCount;
			int num = Screen.height;
			Vector3 vector = Display.RelativeMouseAt(eventData.position);
			if (vector != Vector3.zero)
			{
				int num2 = (int)vector.z;
				if (num2 > 0 && num2 < Display.displays.Length)
				{
					num = Display.displays[num2].systemHeight;
				}
			}
			else
			{
				vector = eventData.position;
			}
			Vector2 delta = eventData.delta;
			vector.y = (float)num - vector.y;
			delta.y = 0f - delta.y;
			Vector3 vector2 = (position = vector);
			localPosition = vector2;
			deltaPosition = delta;
			deltaTime = 0f;
			pressure = eventData.pressure;
			tangentialPressure = eventData.tangentialPressure;
			altitudeAngle = eventData.altitudeAngle;
			azimuthAngle = eventData.azimuthAngle;
			twist = eventData.twist;
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
				button = ((button >= 0) ? button : 0);
				clickCount = Mathf.Max(1, clickCount);
				switch (eventType)
				{
				case PointerEventType.Down:
					PointerDeviceState.PressButton(pointerId, button);
					break;
				case PointerEventType.Up:
					PointerDeviceState.ReleaseButton(pointerId, button);
					break;
				}
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

	private readonly PointerEvent m_PointerEvent;

	private bool m_Selecting;

	private Event m_Event;

	private static EventModifiers s_Modifiers;

	public IPanel panel
	{
		get
		{
			return (IPanel)(object)m_Panel;
		}
		set
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			//IL_0007: Expected O, but got Unknown
			BaseRuntimePanel val = (BaseRuntimePanel)value;
			if (m_Panel != val)
			{
				UnregisterCallbacks();
				m_Panel = val;
				RegisterCallbacks();
			}
		}
	}

	private GameObject selectableGameObject
	{
		get
		{
			BaseRuntimePanel obj = m_Panel;
			if (obj == null)
			{
				return null;
			}
			return obj.selectableGameObject;
		}
	}

	private EventSystem eventSystem => UIElementsRuntimeUtility.activeEventSystem as EventSystem;

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
			((CallbackEventHandler)((BaseVisualElementPanel)m_Panel).visualTree).RegisterCallback<FocusEvent>((EventCallback<FocusEvent>)OnElementFocus, (TrickleDown)1);
			((CallbackEventHandler)((BaseVisualElementPanel)m_Panel).visualTree).RegisterCallback<BlurEvent>((EventCallback<BlurEvent>)OnElementBlur, (TrickleDown)1);
		}
	}

	private void UnregisterCallbacks()
	{
		if (m_Panel != null)
		{
			m_Panel.destroyed -= OnPanelDestroyed;
			((CallbackEventHandler)((BaseVisualElementPanel)m_Panel).visualTree).UnregisterCallback<FocusEvent>((EventCallback<FocusEvent>)OnElementFocus, (TrickleDown)1);
			((CallbackEventHandler)((BaseVisualElementPanel)m_Panel).visualTree).UnregisterCallback<BlurEvent>((EventCallback<BlurEvent>)OnElementBlur, (TrickleDown)1);
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
			BaseRuntimePanel obj = m_Panel;
			if (obj != null)
			{
				((Panel)obj).Focus();
			}
		}
		finally
		{
			m_Selecting = false;
		}
	}

	public void OnDeselect(BaseEventData eventData)
	{
		BaseRuntimePanel obj = m_Panel;
		if (obj != null)
		{
			((Panel)obj).Blur();
		}
	}

	public void OnPointerMove(PointerEventData eventData)
	{
		if (m_Panel == null || !ReadPointerData(m_PointerEvent, eventData))
		{
			return;
		}
		PointerMoveEvent pooled = PointerEventBase<PointerMoveEvent>.GetPooled((IPointerEvent)(object)m_PointerEvent);
		try
		{
			SendEvent((EventBase)(object)pooled, (BaseEventData)eventData);
		}
		finally
		{
			((IDisposable)pooled)?.Dispose();
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (m_Panel == null || !ReadPointerData(m_PointerEvent, eventData, PointerEventType.Up))
		{
			return;
		}
		PointerUpEvent pooled = PointerEventBase<PointerUpEvent>.GetPooled((IPointerEvent)(object)m_PointerEvent);
		try
		{
			SendEvent((EventBase)(object)pooled, (BaseEventData)eventData);
			if (((PointerEventBase<PointerUpEvent>)(object)pooled).pressedButtons == 0)
			{
				PointerDeviceState.SetPlayerPanelWithSoftPointerCapture(((PointerEventBase<PointerUpEvent>)(object)pooled).pointerId, (IPanel)null);
			}
		}
		finally
		{
			((IDisposable)pooled)?.Dispose();
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
		PointerDownEvent pooled = PointerEventBase<PointerDownEvent>.GetPooled((IPointerEvent)(object)m_PointerEvent);
		try
		{
			SendEvent((EventBase)(object)pooled, (BaseEventData)eventData);
			PointerDeviceState.SetPlayerPanelWithSoftPointerCapture(((PointerEventBase<PointerDownEvent>)(object)pooled).pointerId, (IPanel)(object)m_Panel);
		}
		finally
		{
			((IDisposable)pooled)?.Dispose();
		}
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		if (m_Panel == null || !ReadPointerData(m_PointerEvent, eventData))
		{
			return;
		}
		if (eventData.pointerCurrentRaycast.gameObject == base.gameObject && eventData.pointerPressRaycast.gameObject != base.gameObject && m_PointerEvent.pointerId != PointerId.mousePointerId)
		{
			PointerCancelEvent pooled = PointerEventBase<PointerCancelEvent>.GetPooled((IPointerEvent)(object)m_PointerEvent);
			try
			{
				SendEvent((EventBase)(object)pooled, (BaseEventData)eventData);
			}
			finally
			{
				((IDisposable)pooled)?.Dispose();
			}
		}
		m_Panel.PointerLeavesPanel(m_PointerEvent.pointerId, (Vector2)m_PointerEvent.position);
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		if (m_Panel != null && ReadPointerData(m_PointerEvent, eventData))
		{
			m_Panel.PointerEntersPanel(m_PointerEvent.pointerId, (Vector2)m_PointerEvent.position);
		}
	}

	public void OnSubmit(BaseEventData eventData)
	{
		if (m_Panel == null)
		{
			return;
		}
		ProcessImguiEvents(isSelected: true);
		NavigationSubmitEvent pooled = EventBase<NavigationSubmitEvent>.GetPooled();
		try
		{
			SendEvent((EventBase)(object)pooled, eventData);
		}
		finally
		{
			((IDisposable)pooled)?.Dispose();
		}
	}

	public void OnCancel(BaseEventData eventData)
	{
		if (m_Panel == null)
		{
			return;
		}
		ProcessImguiEvents(isSelected: true);
		NavigationCancelEvent pooled = EventBase<NavigationCancelEvent>.GetPooled();
		try
		{
			SendEvent((EventBase)(object)pooled, eventData);
		}
		finally
		{
			((IDisposable)pooled)?.Dispose();
		}
	}

	public void OnMove(AxisEventData eventData)
	{
		if (m_Panel == null)
		{
			return;
		}
		ProcessImguiEvents(isSelected: true);
		NavigationMoveEvent pooled = NavigationMoveEvent.GetPooled(eventData.moveVector);
		try
		{
			SendEvent((EventBase)(object)pooled, (BaseEventData)eventData);
		}
		finally
		{
			((IDisposable)pooled)?.Dispose();
		}
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
		WheelEvent pooled = WheelEvent.GetPooled((Vector3)scrollDelta, (IPointerEvent)(object)m_PointerEvent);
		try
		{
			SendEvent((EventBase)(object)pooled, (BaseEventData)eventData);
		}
		finally
		{
			((IDisposable)pooled)?.Dispose();
		}
	}

	private void SendEvent(EventBase e, BaseEventData sourceEventData)
	{
		((BaseVisualElementPanel)m_Panel).SendEvent(e, (DispatchMode)1);
		if (e.isPropagationStopped)
		{
			sourceEventData.Use();
		}
	}

	private void SendEvent(EventBase e, Event sourceEvent)
	{
		((BaseVisualElementPanel)m_Panel).SendEvent(e, (DispatchMode)1);
		if (e.isPropagationStopped)
		{
			sourceEvent.Use();
		}
	}

	private void Update()
	{
		if (m_Panel != null && eventSystem != null && eventSystem.currentSelectedGameObject == selectableGameObject)
		{
			ProcessImguiEvents(isSelected: true);
		}
	}

	private void LateUpdate()
	{
		ProcessImguiEvents(isSelected: false);
	}

	private void ProcessImguiEvents(bool isSelected)
	{
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Invalid comparison between Unknown and I4
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Invalid comparison between Unknown and I4
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		//IL_002d: Invalid comparison between Unknown and I4
		//IL_004b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_006c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Invalid comparison between Unknown and I4
		bool flag = true;
		while (Event.PopEvent(m_Event))
		{
			if ((int)m_Event.type == 11 || (int)m_Event.type == 7 || (int)m_Event.type == 8)
			{
				continue;
			}
			s_Modifiers = (EventModifiers)(flag ? m_Event.modifiers : (s_Modifiers | m_Event.modifiers));
			flag = false;
			if (isSelected)
			{
				ProcessKeyboardEvent(m_Event);
				if ((int)m_Event.type != 12)
				{
					ProcessTabEvent(m_Event);
				}
			}
		}
	}

	private void ProcessKeyboardEvent(Event e)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Invalid comparison between Unknown and I4
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Invalid comparison between Unknown and I4
		if ((int)e.type == 5)
		{
			SendKeyUpEvent(e);
		}
		else if ((int)e.type == 4)
		{
			SendKeyDownEvent(e);
		}
	}

	private void ProcessTabEvent(Event e)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Invalid comparison between Unknown and I4
		if ((int)e.type == 4 && e.character == '\t')
		{
			SendTabEvent(e, (!e.shift) ? 1 : (-1));
		}
	}

	private void SendTabEvent(Event e, int direction)
	{
		NavigationTabEvent pooled = NavigationTabEvent.GetPooled(direction);
		try
		{
			SendEvent((EventBase)(object)pooled, e);
		}
		finally
		{
			((IDisposable)pooled)?.Dispose();
		}
	}

	private void SendKeyUpEvent(Event e)
	{
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		KeyUpEvent pooled = KeyboardEventBase<KeyUpEvent>.GetPooled('\0', e.keyCode, e.modifiers);
		try
		{
			SendEvent((EventBase)(object)pooled, e);
		}
		finally
		{
			((IDisposable)pooled)?.Dispose();
		}
	}

	private void SendKeyDownEvent(Event e)
	{
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		KeyDownEvent pooled = KeyboardEventBase<KeyDownEvent>.GetPooled(e.character, e.keyCode, e.modifiers);
		try
		{
			SendEvent((EventBase)(object)pooled, e);
		}
		finally
		{
			((IDisposable)pooled)?.Dispose();
		}
	}

	private bool ReadPointerData(PointerEvent pe, PointerEventData eventData, PointerEventType eventType = PointerEventType.Default)
	{
		if (eventSystem == null || eventSystem.currentInputModule == null)
		{
			return false;
		}
		pe.Read(this, eventData, eventType);
		Vector2 vector = default(Vector2);
		Vector2 vector2 = default(Vector2);
		m_Panel.ScreenToPanel((Vector2)pe.position, (Vector2)pe.deltaPosition, ref vector, ref vector2, true);
		pe.SetPosition(vector, vector2);
		return true;
	}

	public PanelEventHandler()
	{
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Expected O, but got Unknown
		m_PointerEvent = new PointerEvent();
		m_Event = new Event();
		base._002Ector();
	}
}
