using System;
using System.Collections.Generic;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace UnityEngine.InputSystem.OnScreen;

[AddComponentMenu("Input/On-Screen Stick")]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.inputsystem@1.19/manual/OnScreen.html#on-screen-sticks")]
public class OnScreenStick : OnScreenControl, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler, IDragHandler
{
	public enum Behaviour
	{
		RelativePositionWithStaticOrigin,
		ExactPositionWithStaticOrigin,
		ExactPositionWithDynamicOrigin
	}

	private const string kDynamicOriginClickable = "DynamicOriginClickable";

	[FormerlySerializedAs("movementRange")]
	[SerializeField]
	[Min(0f)]
	private float m_MovementRange = 50f;

	[Min(0f)]
	[SerializeField]
	[Tooltip("Defines the circular region where the onscreen control may have it's origin placed.")]
	private float m_DynamicOriginRange = 100f;

	[InputControl(layout = "Vector2")]
	[SerializeField]
	private string m_ControlPath;

	[Tooltip("Choose how the onscreen stick will move relative to it's origin and the press position.\n\nRelativePositionWithStaticOrigin: The control's center of origin is fixed. The control will begin un-actuated at it's centered position and then move relative to the pointer or finger motion.\n\nExactPositionWithStaticOrigin: The control's center of origin is fixed. The stick will immediately jump to the exact position of the click or touch and begin tracking motion from there.\n\nExactPositionWithDynamicOrigin: The control's center of origin is determined by the initial press position. The stick will begin un-actuated at this center position and then track the current pointer or finger position.")]
	[SerializeField]
	private Behaviour m_Behaviour;

	[Tooltip("Set this to true to prevent cancellation of pointer events due to device switching. Cancellation will appear as the stick jumping back and forth between the pointer position and the stick center.")]
	[SerializeField]
	private bool m_UseIsolatedInputActions;

	[Tooltip("The action that will be used to detect pointer down events on the stick control. Note that if no bindings are set, default ones will be provided.")]
	[SerializeField]
	private InputAction m_PointerDownAction;

	[Tooltip("The action that will be used to detect pointer movement on the stick control. Note that if no bindings are set, default ones will be provided.")]
	[SerializeField]
	private InputAction m_PointerMoveAction;

	private Vector3 m_StartPos;

	private Vector2 m_PointerDownPos;

	[NonSerialized]
	private List<RaycastResult> m_RaycastResults;

	[NonSerialized]
	private PointerEventData m_PointerEventData;

	[NonSerialized]
	private TouchControl m_TouchControl;

	[NonSerialized]
	private bool m_IsIsolationActive;

	public float movementRange
	{
		get
		{
			return m_MovementRange;
		}
		set
		{
			m_MovementRange = value;
		}
	}

	public float dynamicOriginRange
	{
		get
		{
			return m_DynamicOriginRange;
		}
		set
		{
			if (m_DynamicOriginRange != value)
			{
				m_DynamicOriginRange = value;
				UpdateDynamicOriginClickableArea();
			}
		}
	}

	public bool useIsolatedInputActions
	{
		get
		{
			return m_UseIsolatedInputActions;
		}
		set
		{
			m_UseIsolatedInputActions = value;
		}
	}

	protected override string controlPathInternal
	{
		get
		{
			return m_ControlPath;
		}
		set
		{
			m_ControlPath = value;
		}
	}

	public Behaviour behaviour
	{
		get
		{
			return m_Behaviour;
		}
		set
		{
			m_Behaviour = value;
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (!m_UseIsolatedInputActions)
		{
			if (eventData == null)
			{
				throw new ArgumentNullException("eventData");
			}
			BeginInteraction(eventData.position, eventData.pressEventCamera);
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (!m_UseIsolatedInputActions)
		{
			if (eventData == null)
			{
				throw new ArgumentNullException("eventData");
			}
			MoveStick(eventData.position, eventData.pressEventCamera);
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (!m_UseIsolatedInputActions)
		{
			EndInteraction();
		}
	}

	private void Start()
	{
		if (m_UseIsolatedInputActions)
		{
			m_RaycastResults = new List<RaycastResult>();
			m_PointerEventData = new PointerEventData(EventSystem.current);
			if (m_PointerDownAction == null || m_PointerDownAction.bindings.Count == 0)
			{
				if (m_PointerDownAction == null)
				{
					m_PointerDownAction = new InputAction(null, InputActionType.PassThrough);
				}
				else if (m_PointerDownAction.m_Type != InputActionType.PassThrough)
				{
					m_PointerDownAction.m_Type = InputActionType.PassThrough;
				}
				m_PointerDownAction.AddBinding("<Mouse>/leftButton");
				m_PointerDownAction.AddBinding("<Pen>/tip");
				m_PointerDownAction.AddBinding("<Touchscreen>/touch*/press");
				m_PointerDownAction.AddBinding("<XRController>/trigger");
			}
			if (m_PointerMoveAction == null || m_PointerMoveAction.bindings.Count == 0)
			{
				if (m_PointerMoveAction == null)
				{
					m_PointerMoveAction = new InputAction();
				}
				m_PointerMoveAction.AddBinding("<Mouse>/position");
				m_PointerMoveAction.AddBinding("<Pen>/position");
				m_PointerMoveAction.AddBinding("<Touchscreen>/touch*/position");
			}
			m_PointerDownAction.performed += OnPointerChanged;
			m_PointerDownAction.Enable();
			m_PointerMoveAction.Enable();
		}
		if (transform is RectTransform)
		{
			m_StartPos = ((RectTransform)transform).anchoredPosition;
			if (m_Behaviour == Behaviour.ExactPositionWithDynamicOrigin)
			{
				m_PointerDownPos = m_StartPos;
				GameObject gameObject = new GameObject("DynamicOriginClickable", typeof(Image));
				gameObject.transform.SetParent(transform);
				Image component = gameObject.GetComponent<Image>();
				component.color = new Color(1f, 1f, 1f, 0f);
				RectTransform rectTransform = (RectTransform)gameObject.transform;
				rectTransform.sizeDelta = new Vector2(m_DynamicOriginRange * 2f, m_DynamicOriginRange * 2f);
				rectTransform.localScale = new Vector3(1f, 1f, 0f);
				rectTransform.anchoredPosition3D = Vector3.zero;
				component.sprite = SpriteUtilities.CreateCircleSprite(16, new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, byte.MaxValue));
				component.alphaHitTestMinimumThreshold = 0.5f;
			}
		}
	}

	private void OnDestroy()
	{
		if (m_UseIsolatedInputActions)
		{
			m_PointerDownAction.performed -= OnPointerChanged;
		}
	}

	private void BeginInteraction(Vector2 pointerPosition, Camera uiCamera)
	{
		RectTransform canvasRectTransform = UGUIOnScreenControlUtils.GetCanvasRectTransform(transform);
		if (canvasRectTransform == null)
		{
			Debug.LogError(GetWarningMessage());
			return;
		}
		switch (m_Behaviour)
		{
		case Behaviour.RelativePositionWithStaticOrigin:
			RectTransformUtility.ScreenPointToLocalPointInRectangle(canvasRectTransform, pointerPosition, uiCamera, out m_PointerDownPos);
			break;
		case Behaviour.ExactPositionWithStaticOrigin:
			RectTransformUtility.ScreenPointToLocalPointInRectangle(canvasRectTransform, pointerPosition, uiCamera, out m_PointerDownPos);
			MoveStick(pointerPosition, uiCamera);
			break;
		case Behaviour.ExactPositionWithDynamicOrigin:
		{
			RectTransformUtility.ScreenPointToLocalPointInRectangle(canvasRectTransform, pointerPosition, uiCamera, out var localPoint);
			Vector2 pointerDownPos = (((RectTransform)transform).anchoredPosition = localPoint);
			m_PointerDownPos = pointerDownPos;
			break;
		}
		}
	}

	private void MoveStick(Vector2 pointerPosition, Camera uiCamera)
	{
		RectTransform canvasRectTransform = UGUIOnScreenControlUtils.GetCanvasRectTransform(transform);
		if (canvasRectTransform == null)
		{
			Debug.LogError(GetWarningMessage());
			return;
		}
		RectTransformUtility.ScreenPointToLocalPointInRectangle(canvasRectTransform, pointerPosition, uiCamera, out var localPoint);
		Vector2 vector = localPoint - m_PointerDownPos;
		switch (m_Behaviour)
		{
		case Behaviour.RelativePositionWithStaticOrigin:
			vector = Vector2.ClampMagnitude(vector, movementRange);
			((RectTransform)transform).anchoredPosition = (Vector2)m_StartPos + vector;
			break;
		case Behaviour.ExactPositionWithStaticOrigin:
			vector = localPoint - (Vector2)m_StartPos;
			vector = Vector2.ClampMagnitude(vector, movementRange);
			((RectTransform)transform).anchoredPosition = (Vector2)m_StartPos + vector;
			break;
		case Behaviour.ExactPositionWithDynamicOrigin:
			vector = Vector2.ClampMagnitude(vector, movementRange);
			((RectTransform)transform).anchoredPosition = m_PointerDownPos + vector;
			break;
		}
		Vector2 value = new Vector2(vector.x / movementRange, vector.y / movementRange);
		SendValueToControl(value);
	}

	private void EndInteraction()
	{
		((RectTransform)transform).anchoredPosition = (m_PointerDownPos = m_StartPos);
		SendValueToControl(Vector2.zero);
	}

	private void OnPointerDown(InputAction.CallbackContext ctx)
	{
		if (m_IsIsolationActive)
		{
			return;
		}
		Vector2 vector = Vector2.zero;
		TouchControl touchControl = null;
		if (ctx.control?.parent is TouchControl touchControl2)
		{
			touchControl = touchControl2;
			vector = touchControl2.position.ReadValue();
		}
		else if (ctx.control?.device is Pointer pointer)
		{
			vector = pointer.position.ReadValue();
		}
		m_PointerEventData.position = vector;
		EventSystem.current.RaycastAll(m_PointerEventData, m_RaycastResults);
		if (m_RaycastResults.Count == 0)
		{
			return;
		}
		bool flag = false;
		foreach (RaycastResult raycastResult in m_RaycastResults)
		{
			if (!(raycastResult.gameObject != gameObject))
			{
				flag = true;
				break;
			}
		}
		if (flag)
		{
			BeginInteraction(vector, GetCameraFromCanvas());
			if (touchControl != null)
			{
				m_TouchControl = touchControl;
				m_PointerMoveAction.ApplyBindingOverride(touchControl.path + "/position", null, "<Touchscreen>/touch*/position");
			}
			m_PointerMoveAction.performed += OnPointerMove;
			m_IsIsolationActive = true;
		}
	}

	private void OnPointerChanged(InputAction.CallbackContext ctx)
	{
		if (ctx.control.IsPressed())
		{
			OnPointerDown(ctx);
		}
		else
		{
			OnPointerUp(ctx);
		}
	}

	private void OnPointerMove(InputAction.CallbackContext ctx)
	{
		Vector2 pointerPosition;
		if (m_TouchControl != null)
		{
			if (!m_TouchControl.isInProgress)
			{
				return;
			}
			pointerPosition = m_TouchControl.position.ReadValue();
		}
		else
		{
			pointerPosition = ((Pointer)ctx.control.device).position.ReadValue();
		}
		MoveStick(pointerPosition, GetCameraFromCanvas());
	}

	private void OnPointerUp(InputAction.CallbackContext ctx)
	{
		if (!m_IsIsolationActive)
		{
			return;
		}
		if (m_TouchControl != null)
		{
			if (m_TouchControl.isInProgress)
			{
				return;
			}
			m_PointerMoveAction.ApplyBindingOverride(null, null, "<Touchscreen>/touch*/position");
			m_TouchControl = null;
		}
		EndInteraction();
		m_PointerMoveAction.performed -= OnPointerMove;
		m_IsIsolationActive = false;
	}

	private Camera GetCameraFromCanvas()
	{
		Canvas componentInParent = GetComponentInParent<Canvas>();
		RenderMode? renderMode = componentInParent?.renderMode;
		if (renderMode != RenderMode.ScreenSpaceOverlay && (renderMode != RenderMode.ScreenSpaceCamera || !(componentInParent?.worldCamera == null)))
		{
			return componentInParent?.worldCamera ?? Camera.main;
		}
		return null;
	}

	private void OnDrawGizmosSelected()
	{
		RectTransform rectTransform = transform.parent as RectTransform;
		if (!(rectTransform == null))
		{
			Gizmos.matrix = rectTransform.localToWorldMatrix;
			Vector2 vector = rectTransform.anchoredPosition;
			if (Application.isPlaying)
			{
				vector = m_StartPos;
			}
			Gizmos.color = new Color32(84, 173, 219, byte.MaxValue);
			Vector2 center = vector;
			if (Application.isPlaying && m_Behaviour == Behaviour.ExactPositionWithDynamicOrigin)
			{
				center = m_PointerDownPos;
			}
			DrawGizmoCircle(center, m_MovementRange);
			if (m_Behaviour == Behaviour.ExactPositionWithDynamicOrigin)
			{
				Gizmos.color = new Color32(158, 84, 219, byte.MaxValue);
				DrawGizmoCircle(vector, m_DynamicOriginRange);
			}
		}
	}

	private void DrawGizmoCircle(Vector2 center, float radius)
	{
		for (int i = 0; i < 32; i++)
		{
			float f = (float)i / 32f * MathF.PI * 2f;
			float f2 = (float)(i + 1) / 32f * MathF.PI * 2f;
			Gizmos.DrawLine(new Vector3(center.x + Mathf.Cos(f) * radius, center.y + Mathf.Sin(f) * radius, 0f), new Vector3(center.x + Mathf.Cos(f2) * radius, center.y + Mathf.Sin(f2) * radius, 0f));
		}
	}

	private void UpdateDynamicOriginClickableArea()
	{
		Transform transform = base.transform.Find("DynamicOriginClickable");
		if ((bool)transform)
		{
			((RectTransform)transform).sizeDelta = new Vector2(m_DynamicOriginRange * 2f, m_DynamicOriginRange * 2f);
		}
	}
}
