using System;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;
using UnityEngine.UI;

namespace UnityEngine.InputSystem.UI;

[HelpURL("https://docs.unity3d.com/Packages/com.unity.inputsystem@1.7/manual/UISupport.html#virtual-mouse-cursor-control")]
[AddComponentMenu("Input/Virtual Mouse")]
public class VirtualMouseInput : MonoBehaviour
{
	public enum CursorMode
	{
		SoftwareCursor,
		HardwareCursorIfAvailable
	}

	[Header("Cursor")]
	[Tooltip("Whether the component should set the cursor position of the hardware mouse cursor, if one is available. If so, the software cursor pointed (to by 'Cursor Graphic') will be hidden.")]
	[SerializeField]
	private CursorMode m_CursorMode;

	[Tooltip("The graphic that represents the software cursor. This is hidden if a hardware cursor (see 'Cursor Mode') is used.")]
	[SerializeField]
	private Graphic m_CursorGraphic;

	[SerializeField]
	[Tooltip("The transform for the software cursor. Will only be set if a software cursor is used (see 'Cursor Mode'). Moving the cursor updates the anchored position of the transform.")]
	private RectTransform m_CursorTransform;

	[Header("Motion")]
	[SerializeField]
	[Tooltip("Speed in pixels per second with which to move the cursor. Scaled by the input from 'Stick Action'.")]
	private float m_CursorSpeed = 400f;

	[SerializeField]
	[Tooltip("Scale factor to apply to 'Scroll Wheel Action' when setting the mouse 'scrollWheel' control.")]
	private float m_ScrollSpeed = 45f;

	[SerializeField]
	[Space(10f)]
	[Tooltip("Vector2 action that moves the cursor left/right (X) and up/down (Y) on screen.")]
	private InputActionProperty m_StickAction;

	[SerializeField]
	[Tooltip("Button action that triggers a left-click on the mouse.")]
	private InputActionProperty m_LeftButtonAction;

	[Tooltip("Button action that triggers a middle-click on the mouse.")]
	[SerializeField]
	private InputActionProperty m_MiddleButtonAction;

	[SerializeField]
	[Tooltip("Button action that triggers a right-click on the mouse.")]
	private InputActionProperty m_RightButtonAction;

	[Tooltip("Button action that triggers a forward button (button #4) click on the mouse.")]
	[SerializeField]
	private InputActionProperty m_ForwardButtonAction;

	[SerializeField]
	[Tooltip("Button action that triggers a back button (button #5) click on the mouse.")]
	private InputActionProperty m_BackButtonAction;

	[SerializeField]
	[Tooltip("Vector2 action that feeds into the mouse 'scrollWheel' action (scaled by 'Scroll Speed').")]
	private InputActionProperty m_ScrollWheelAction;

	private Canvas m_Canvas;

	private Mouse m_VirtualMouse;

	private Mouse m_SystemMouse;

	private Action m_AfterInputUpdateDelegate;

	private Action<InputAction.CallbackContext> m_ButtonActionTriggeredDelegate;

	private double m_LastTime;

	private Vector2 m_LastStickValue;

	public RectTransform cursorTransform
	{
		get
		{
			return m_CursorTransform;
		}
		set
		{
			m_CursorTransform = value;
		}
	}

	public float cursorSpeed
	{
		get
		{
			return m_CursorSpeed;
		}
		set
		{
			m_CursorSpeed = value;
		}
	}

	public CursorMode cursorMode
	{
		get
		{
			return m_CursorMode;
		}
		set
		{
			if (m_CursorMode != value)
			{
				if (m_CursorMode == CursorMode.HardwareCursorIfAvailable && m_SystemMouse != null)
				{
					InputSystem.EnableDevice(m_SystemMouse);
					m_SystemMouse = null;
				}
				m_CursorMode = value;
				if (m_CursorMode == CursorMode.HardwareCursorIfAvailable)
				{
					TryEnableHardwareCursor();
				}
				else if (m_CursorGraphic != null)
				{
					m_CursorGraphic.enabled = true;
				}
			}
		}
	}

	public Graphic cursorGraphic
	{
		get
		{
			return m_CursorGraphic;
		}
		set
		{
			m_CursorGraphic = value;
			TryFindCanvas();
		}
	}

	public float scrollSpeed
	{
		get
		{
			return m_ScrollSpeed;
		}
		set
		{
			m_ScrollSpeed = value;
		}
	}

	public Mouse virtualMouse => m_VirtualMouse;

	public InputActionProperty stickAction
	{
		get
		{
			return m_StickAction;
		}
		set
		{
			SetAction(ref m_StickAction, value);
		}
	}

	public InputActionProperty leftButtonAction
	{
		get
		{
			return m_LeftButtonAction;
		}
		set
		{
			if (m_ButtonActionTriggeredDelegate != null)
			{
				SetActionCallback(m_LeftButtonAction, m_ButtonActionTriggeredDelegate, install: false);
			}
			SetAction(ref m_LeftButtonAction, value);
			if (m_ButtonActionTriggeredDelegate != null)
			{
				SetActionCallback(m_LeftButtonAction, m_ButtonActionTriggeredDelegate);
			}
		}
	}

	public InputActionProperty rightButtonAction
	{
		get
		{
			return m_RightButtonAction;
		}
		set
		{
			if (m_ButtonActionTriggeredDelegate != null)
			{
				SetActionCallback(m_RightButtonAction, m_ButtonActionTriggeredDelegate, install: false);
			}
			SetAction(ref m_RightButtonAction, value);
			if (m_ButtonActionTriggeredDelegate != null)
			{
				SetActionCallback(m_RightButtonAction, m_ButtonActionTriggeredDelegate);
			}
		}
	}

	public InputActionProperty middleButtonAction
	{
		get
		{
			return m_MiddleButtonAction;
		}
		set
		{
			if (m_ButtonActionTriggeredDelegate != null)
			{
				SetActionCallback(m_MiddleButtonAction, m_ButtonActionTriggeredDelegate, install: false);
			}
			SetAction(ref m_MiddleButtonAction, value);
			if (m_ButtonActionTriggeredDelegate != null)
			{
				SetActionCallback(m_MiddleButtonAction, m_ButtonActionTriggeredDelegate);
			}
		}
	}

	public InputActionProperty forwardButtonAction
	{
		get
		{
			return m_ForwardButtonAction;
		}
		set
		{
			if (m_ButtonActionTriggeredDelegate != null)
			{
				SetActionCallback(m_ForwardButtonAction, m_ButtonActionTriggeredDelegate, install: false);
			}
			SetAction(ref m_ForwardButtonAction, value);
			if (m_ButtonActionTriggeredDelegate != null)
			{
				SetActionCallback(m_ForwardButtonAction, m_ButtonActionTriggeredDelegate);
			}
		}
	}

	public InputActionProperty backButtonAction
	{
		get
		{
			return m_BackButtonAction;
		}
		set
		{
			if (m_ButtonActionTriggeredDelegate != null)
			{
				SetActionCallback(m_BackButtonAction, m_ButtonActionTriggeredDelegate, install: false);
			}
			SetAction(ref m_BackButtonAction, value);
			if (m_ButtonActionTriggeredDelegate != null)
			{
				SetActionCallback(m_BackButtonAction, m_ButtonActionTriggeredDelegate);
			}
		}
	}

	public InputActionProperty scrollWheelAction
	{
		get
		{
			return m_ScrollWheelAction;
		}
		set
		{
			SetAction(ref m_ScrollWheelAction, value);
		}
	}

	protected void OnEnable()
	{
		if (m_CursorMode == CursorMode.HardwareCursorIfAvailable)
		{
			TryEnableHardwareCursor();
		}
		if (m_VirtualMouse == null)
		{
			m_VirtualMouse = (Mouse)InputSystem.AddDevice("VirtualMouse");
		}
		else if (!m_VirtualMouse.added)
		{
			InputSystem.AddDevice(m_VirtualMouse);
		}
		if (m_CursorTransform != null)
		{
			Vector2 anchoredPosition = m_CursorTransform.anchoredPosition;
			InputState.Change(m_VirtualMouse.position, anchoredPosition);
			m_SystemMouse?.WarpCursorPosition(anchoredPosition);
		}
		if (m_AfterInputUpdateDelegate == null)
		{
			m_AfterInputUpdateDelegate = OnAfterInputUpdate;
		}
		InputSystem.onAfterUpdate += m_AfterInputUpdateDelegate;
		if (m_ButtonActionTriggeredDelegate == null)
		{
			m_ButtonActionTriggeredDelegate = OnButtonActionTriggered;
		}
		SetActionCallback(m_LeftButtonAction, m_ButtonActionTriggeredDelegate);
		SetActionCallback(m_RightButtonAction, m_ButtonActionTriggeredDelegate);
		SetActionCallback(m_MiddleButtonAction, m_ButtonActionTriggeredDelegate);
		SetActionCallback(m_ForwardButtonAction, m_ButtonActionTriggeredDelegate);
		SetActionCallback(m_BackButtonAction, m_ButtonActionTriggeredDelegate);
		m_StickAction.action?.Enable();
		m_LeftButtonAction.action?.Enable();
		m_RightButtonAction.action?.Enable();
		m_MiddleButtonAction.action?.Enable();
		m_ForwardButtonAction.action?.Enable();
		m_BackButtonAction.action?.Enable();
		m_ScrollWheelAction.action?.Enable();
	}

	protected void OnDisable()
	{
		if (m_VirtualMouse != null && m_VirtualMouse.added)
		{
			InputSystem.RemoveDevice(m_VirtualMouse);
		}
		if (m_SystemMouse != null)
		{
			InputSystem.EnableDevice(m_SystemMouse);
			m_SystemMouse = null;
		}
		if (m_AfterInputUpdateDelegate != null)
		{
			InputSystem.onAfterUpdate -= m_AfterInputUpdateDelegate;
		}
		m_StickAction.action?.Disable();
		m_LeftButtonAction.action?.Disable();
		m_RightButtonAction.action?.Disable();
		m_MiddleButtonAction.action?.Disable();
		m_ForwardButtonAction.action?.Disable();
		m_BackButtonAction.action?.Disable();
		m_ScrollWheelAction.action?.Disable();
		if (m_ButtonActionTriggeredDelegate != null)
		{
			SetActionCallback(m_LeftButtonAction, m_ButtonActionTriggeredDelegate, install: false);
			SetActionCallback(m_RightButtonAction, m_ButtonActionTriggeredDelegate, install: false);
			SetActionCallback(m_MiddleButtonAction, m_ButtonActionTriggeredDelegate, install: false);
			SetActionCallback(m_ForwardButtonAction, m_ButtonActionTriggeredDelegate, install: false);
			SetActionCallback(m_BackButtonAction, m_ButtonActionTriggeredDelegate, install: false);
		}
		m_LastTime = 0.0;
		m_LastStickValue = default(Vector2);
	}

	private void TryFindCanvas()
	{
		m_Canvas = m_CursorGraphic?.GetComponentInParent<Canvas>();
	}

	private void TryEnableHardwareCursor()
	{
		ReadOnlyArray<InputDevice> devices = InputSystem.devices;
		for (int i = 0; i < devices.Count; i++)
		{
			InputDevice inputDevice = devices[i];
			if (inputDevice.native && inputDevice is Mouse systemMouse)
			{
				m_SystemMouse = systemMouse;
				break;
			}
		}
		if (m_SystemMouse == null)
		{
			if (m_CursorGraphic != null)
			{
				m_CursorGraphic.enabled = true;
			}
			return;
		}
		InputSystem.DisableDevice(m_SystemMouse);
		if (m_VirtualMouse != null)
		{
			m_SystemMouse.WarpCursorPosition(m_VirtualMouse.position.value);
		}
		if (m_CursorGraphic != null)
		{
			m_CursorGraphic.enabled = false;
		}
	}

	private void UpdateMotion()
	{
		if (m_VirtualMouse == null)
		{
			return;
		}
		InputAction action = m_StickAction.action;
		if (action == null)
		{
			return;
		}
		Vector2 lastStickValue = action.ReadValue<Vector2>();
		if (Mathf.Approximately(0f, lastStickValue.x) && Mathf.Approximately(0f, lastStickValue.y))
		{
			m_LastTime = 0.0;
			m_LastStickValue = default(Vector2);
		}
		else
		{
			double currentTime = InputState.currentTime;
			if (Mathf.Approximately(0f, m_LastStickValue.x) && Mathf.Approximately(0f, m_LastStickValue.y))
			{
				m_LastTime = currentTime;
			}
			float num = (float)(currentTime - m_LastTime);
			Vector2 vector = new Vector2(m_CursorSpeed * lastStickValue.x * num, m_CursorSpeed * lastStickValue.y * num);
			Vector2 vector2 = m_VirtualMouse.position.value + vector;
			if ((Object)(object)m_Canvas != null)
			{
				Rect pixelRect = m_Canvas.pixelRect;
				vector2.x = Mathf.Clamp(vector2.x, pixelRect.xMin, pixelRect.xMax);
				vector2.y = Mathf.Clamp(vector2.y, pixelRect.yMin, pixelRect.yMax);
			}
			InputState.Change(m_VirtualMouse.position, vector2);
			InputState.Change(m_VirtualMouse.delta, vector);
			if (m_CursorTransform != null && (m_CursorMode == CursorMode.SoftwareCursor || (m_CursorMode == CursorMode.HardwareCursorIfAvailable && m_SystemMouse == null)))
			{
				m_CursorTransform.anchoredPosition = vector2;
			}
			m_LastStickValue = lastStickValue;
			m_LastTime = currentTime;
			m_SystemMouse?.WarpCursorPosition(vector2);
		}
		InputAction action2 = m_ScrollWheelAction.action;
		if (action2 != null)
		{
			Vector2 state = action2.ReadValue<Vector2>();
			state.x *= m_ScrollSpeed;
			state.y *= m_ScrollSpeed;
			InputState.Change(m_VirtualMouse.scroll, state);
		}
	}

	private void OnButtonActionTriggered(InputAction.CallbackContext context)
	{
		if (m_VirtualMouse != null)
		{
			InputAction action = context.action;
			MouseButton? mouseButton = null;
			if (action == m_LeftButtonAction.action)
			{
				mouseButton = MouseButton.Left;
			}
			else if (action == m_RightButtonAction.action)
			{
				mouseButton = MouseButton.Right;
			}
			else if (action == m_MiddleButtonAction.action)
			{
				mouseButton = MouseButton.Middle;
			}
			else if (action == m_ForwardButtonAction.action)
			{
				mouseButton = MouseButton.Forward;
			}
			else if (action == m_BackButtonAction.action)
			{
				mouseButton = MouseButton.Back;
			}
			if (mouseButton.HasValue)
			{
				bool state = context.control.IsPressed();
				m_VirtualMouse.CopyState<MouseState>(out var state2);
				state2.WithButton(mouseButton.Value, state);
				InputState.Change(m_VirtualMouse, state2);
			}
		}
	}

	private static void SetActionCallback(InputActionProperty field, Action<InputAction.CallbackContext> callback, bool install = true)
	{
		InputAction action = field.action;
		if (action != null)
		{
			if (install)
			{
				action.started += callback;
				action.canceled += callback;
			}
			else
			{
				action.started -= callback;
				action.canceled -= callback;
			}
		}
	}

	private static void SetAction(ref InputActionProperty field, InputActionProperty value)
	{
		InputActionProperty inputActionProperty = field;
		field = value;
		if (!(inputActionProperty.reference == null))
		{
			return;
		}
		InputAction action = inputActionProperty.action;
		if (action != null && action.enabled)
		{
			action.Disable();
			if (value.reference == null)
			{
				value.action?.Enable();
			}
		}
	}

	private void OnAfterInputUpdate()
	{
		UpdateMotion();
	}
}
