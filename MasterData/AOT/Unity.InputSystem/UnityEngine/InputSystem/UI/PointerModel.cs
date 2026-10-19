using UnityEngine.EventSystems;

namespace UnityEngine.InputSystem.UI;

internal struct PointerModel
{
	public struct ButtonState
	{
		private bool m_IsPressed;

		private PointerEventData.FramePressState m_FramePressState;

		private float m_PressTime;

		private RaycastResult m_PressRaycast;

		private GameObject m_PressObject;

		private GameObject m_RawPressObject;

		private GameObject m_LastPressObject;

		private GameObject m_DragObject;

		private Vector2 m_PressPosition;

		private float m_ClickTime;

		private int m_ClickCount;

		private bool m_Dragging;

		private bool m_ClickedOnSameGameObject;

		private bool m_IgnoreNextClick;

		public bool isPressed
		{
			get
			{
				return m_IsPressed;
			}
			set
			{
				if (m_IsPressed != value)
				{
					m_IsPressed = value;
					if ((m_FramePressState == PointerEventData.FramePressState.NotChanged) & value)
					{
						m_FramePressState = PointerEventData.FramePressState.Pressed;
					}
					else if (m_FramePressState == PointerEventData.FramePressState.NotChanged && !value)
					{
						m_FramePressState = PointerEventData.FramePressState.Released;
					}
					else if (m_FramePressState == PointerEventData.FramePressState.Pressed && !value)
					{
						m_FramePressState = PointerEventData.FramePressState.PressedAndReleased;
					}
				}
			}
		}

		public bool ignoreNextClick
		{
			get
			{
				return m_IgnoreNextClick;
			}
			set
			{
				m_IgnoreNextClick = value;
			}
		}

		public float pressTime
		{
			get
			{
				return m_PressTime;
			}
			set
			{
				m_PressTime = value;
			}
		}

		public bool clickedOnSameGameObject
		{
			get
			{
				return m_ClickedOnSameGameObject;
			}
			set
			{
				m_ClickedOnSameGameObject = value;
			}
		}

		public bool wasPressedThisFrame
		{
			get
			{
				if (m_FramePressState != PointerEventData.FramePressState.Pressed)
				{
					return m_FramePressState == PointerEventData.FramePressState.PressedAndReleased;
				}
				return true;
			}
		}

		public bool wasReleasedThisFrame
		{
			get
			{
				if (m_FramePressState != PointerEventData.FramePressState.Released)
				{
					return m_FramePressState == PointerEventData.FramePressState.PressedAndReleased;
				}
				return true;
			}
		}

		public void CopyPressStateTo(PointerEventData eventData)
		{
			eventData.pointerPressRaycast = m_PressRaycast;
			eventData.pressPosition = m_PressPosition;
			eventData.clickCount = m_ClickCount;
			eventData.clickTime = m_ClickTime;
			eventData.pointerPress = m_LastPressObject;
			eventData.pointerPress = m_PressObject;
			eventData.rawPointerPress = m_RawPressObject;
			eventData.pointerDrag = m_DragObject;
			eventData.dragging = m_Dragging;
			if (ignoreNextClick)
			{
				eventData.eligibleForClick = false;
			}
		}

		public void CopyPressStateFrom(PointerEventData eventData)
		{
			m_PressRaycast = eventData.pointerPressRaycast;
			m_PressObject = eventData.pointerPress;
			m_RawPressObject = eventData.rawPointerPress;
			m_LastPressObject = eventData.lastPress;
			m_PressPosition = eventData.pressPosition;
			m_ClickTime = eventData.clickTime;
			m_ClickCount = eventData.clickCount;
			m_DragObject = eventData.pointerDrag;
			m_Dragging = eventData.dragging;
		}

		public void OnEndFrame()
		{
			m_FramePressState = PointerEventData.FramePressState.NotChanged;
		}
	}

	public bool changedThisFrame;

	public ButtonState leftButton;

	public ButtonState rightButton;

	public ButtonState middleButton;

	public ExtendedPointerEventData eventData;

	private Vector2 m_ScreenPosition;

	private Vector2 m_ScrollDelta;

	private Vector3 m_WorldPosition;

	private Quaternion m_WorldOrientation;

	private float m_Pressure;

	private float m_AzimuthAngle;

	private float m_AltitudeAngle;

	private float m_Twist;

	private Vector2 m_Radius;

	public UIPointerType pointerType => eventData.pointerType;

	public Vector2 screenPosition
	{
		get
		{
			return m_ScreenPosition;
		}
		set
		{
			if (m_ScreenPosition != value)
			{
				m_ScreenPosition = value;
				changedThisFrame = true;
			}
		}
	}

	public Vector3 worldPosition
	{
		get
		{
			return m_WorldPosition;
		}
		set
		{
			if (m_WorldPosition != value)
			{
				m_WorldPosition = value;
				changedThisFrame = true;
			}
		}
	}

	public Quaternion worldOrientation
	{
		get
		{
			return m_WorldOrientation;
		}
		set
		{
			if (m_WorldOrientation != value)
			{
				m_WorldOrientation = value;
				changedThisFrame = true;
			}
		}
	}

	public Vector2 scrollDelta
	{
		get
		{
			return m_ScrollDelta;
		}
		set
		{
			if (m_ScrollDelta != value)
			{
				changedThisFrame = true;
				m_ScrollDelta = value;
			}
		}
	}

	public float pressure
	{
		get
		{
			return m_Pressure;
		}
		set
		{
			if (m_Pressure != value)
			{
				changedThisFrame = true;
				m_Pressure = value;
			}
		}
	}

	public float azimuthAngle
	{
		get
		{
			return m_AzimuthAngle;
		}
		set
		{
			if (m_AzimuthAngle != value)
			{
				changedThisFrame = true;
				m_AzimuthAngle = value;
			}
		}
	}

	public float altitudeAngle
	{
		get
		{
			return m_AltitudeAngle;
		}
		set
		{
			if (m_AltitudeAngle != value)
			{
				changedThisFrame = true;
				m_AltitudeAngle = value;
			}
		}
	}

	public float twist
	{
		get
		{
			return m_Twist;
		}
		set
		{
			if (m_Twist != value)
			{
				changedThisFrame = true;
				m_Twist = value;
			}
		}
	}

	public Vector2 radius
	{
		get
		{
			return m_Radius;
		}
		set
		{
			if (m_Radius != value)
			{
				changedThisFrame = true;
				m_Radius = value;
			}
		}
	}

	public PointerModel(ExtendedPointerEventData eventData)
	{
		this.eventData = eventData;
		changedThisFrame = false;
		leftButton = default;
		leftButton.OnEndFrame();
		rightButton = default;
		rightButton.OnEndFrame();
		middleButton = default;
		middleButton.OnEndFrame();
		m_ScreenPosition = default;
		m_ScrollDelta = default;
		m_WorldOrientation = default;
		m_WorldPosition = default;
		m_Pressure = 0f;
		m_AzimuthAngle = 0f;
		m_AltitudeAngle = 0f;
		m_Twist = 0f;
		m_Radius = default;
	}

	public void OnFrameFinished()
	{
		changedThisFrame = false;
		scrollDelta = default;
		leftButton.OnEndFrame();
		rightButton.OnEndFrame();
		middleButton.OnEndFrame();
	}

	public void CopyTouchOrPenStateFrom(PointerEventData eventData)
	{
		pressure = eventData.pressure;
		azimuthAngle = eventData.azimuthAngle;
		altitudeAngle = eventData.altitudeAngle;
		twist = eventData.twist;
		radius = eventData.radius;
	}
}
