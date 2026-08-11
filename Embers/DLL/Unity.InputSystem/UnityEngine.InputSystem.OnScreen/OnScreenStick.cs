using System;
using System.Collections.Generic;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace UnityEngine.InputSystem.OnScreen;

[HelpURL("https://docs.unity3d.com/Packages/com.unity.inputsystem@1.7/manual/OnScreen.html#on-screen-sticks")]
[AddComponentMenu("Input/On-Screen Stick")]
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

	[SerializeField]
	[Tooltip("Defines the circular region where the onscreen control may have it's origin placed.")]
	[Min(0f)]
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

	[SerializeField]
	[Tooltip("The action that will be used to detect pointer down events on the stick control. Note that if no bindings are set, default ones will be provided.")]
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
					m_PointerDownAction = new InputAction();
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
			m_PointerDownAction.started += OnPointerDown;
			m_PointerDownAction.canceled += OnPointerUp;
			m_PointerDownAction.Enable();
			m_PointerMoveAction.Enable();
		}
		m_StartPos = ((RectTransform)base.transform).anchoredPosition;
		if (m_Behaviour == Behaviour.ExactPositionWithDynamicOrigin)
		{
			m_PointerDownPos = m_StartPos;
			GameObject obj = new GameObject("DynamicOriginClickable", typeof(Image));
			obj.transform.SetParent(base.transform);
			Image component = obj.GetComponent<Image>();
			component.color = new Color(1f, 1f, 1f, 0f);
			RectTransform obj2 = (RectTransform)obj.transform;
			obj2.sizeDelta = new Vector2(m_DynamicOriginRange * 2f, m_DynamicOriginRange * 2f);
			obj2.localScale = new Vector3(1f, 1f, 0f);
			obj2.anchoredPosition3D = Vector3.zero;
			component.sprite = SpriteUtilities.CreateCircleSprite(16, new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, byte.MaxValue));
			component.alphaHitTestMinimumThreshold = 0.5f;
		}
	}

	private void BeginInteraction(Vector2 pointerPosition, Camera uiCamera)
	{
		RectTransform rectTransform = base.transform.parent?.GetComponentInParent<RectTransform>();
		if (rectTransform == null)
		{
			Debug.LogError("OnScreenStick needs to be attached as a child to a UI Canvas to function properly.");
			return;
		}
		switch (m_Behaviour)
		{
		case Behaviour.RelativePositionWithStaticOrigin:
			RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform, pointerPosition, uiCamera, ref m_PointerDownPos);
			break;
		case Behaviour.ExactPositionWithStaticOrigin:
			RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform, pointerPosition, uiCamera, ref m_PointerDownPos);
			MoveStick(pointerPosition, uiCamera);
			break;
		case Behaviour.ExactPositionWithDynamicOrigin:
		{
			Vector2 vector = default(Vector2);
			RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform, pointerPosition, uiCamera, ref vector);
			Vector2 pointerDownPos = (((RectTransform)base.transform).anchoredPosition = vector);
			m_PointerDownPos = pointerDownPos;
			break;
		}
		}
	}

	private void MoveStick(Vector2 pointerPosition, Camera uiCamera)
	{
		RectTransform rectTransform = base.transform.parent?.GetComponentInParent<RectTransform>();
		if (rectTransform == null)
		{
			Debug.LogError("OnScreenStick needs to be attached as a child to a UI Canvas to function properly.");
			return;
		}
		Vector2 vector = default(Vector2);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform, pointerPosition, uiCamera, ref vector);
		Vector2 vector2 = vector - m_PointerDownPos;
		switch (m_Behaviour)
		{
		case Behaviour.RelativePositionWithStaticOrigin:
			vector2 = Vector2.ClampMagnitude(vector2, movementRange);
			((RectTransform)base.transform).anchoredPosition = (Vector2)m_StartPos + vector2;
			break;
		case Behaviour.ExactPositionWithStaticOrigin:
			vector2 = vector - (Vector2)m_StartPos;
			vector2 = Vector2.ClampMagnitude(vector2, movementRange);
			((RectTransform)base.transform).anchoredPosition = (Vector2)m_StartPos + vector2;
			break;
		case Behaviour.ExactPositionWithDynamicOrigin:
			vector2 = Vector2.ClampMagnitude(vector2, movementRange);
			((RectTransform)base.transform).anchoredPosition = m_PointerDownPos + vector2;
			break;
		}
		Vector2 value = new Vector2(vector2.x / movementRange, vector2.y / movementRange);
		SendValueToControl(value);
	}

	private void EndInteraction()
	{
		((RectTransform)base.transform).anchoredPosition = (m_PointerDownPos = m_StartPos);
		SendValueToControl(Vector2.zero);
	}

	private void OnPointerDown(InputAction.CallbackContext ctx)
	{
		Vector2 vector = Vector2.zero;
		if (ctx.control?.device is Pointer pointer)
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
			if (!(raycastResult.gameObject != base.gameObject))
			{
				flag = true;
				break;
			}
		}
		if (flag)
		{
			BeginInteraction(vector, GetCameraFromCanvas());
			m_PointerMoveAction.performed += OnPointerMove;
		}
	}

	private void OnPointerMove(InputAction.CallbackContext ctx)
	{
		Vector2 pointerPosition = ((Pointer)ctx.control.device).position.ReadValue();
		MoveStick(pointerPosition, GetCameraFromCanvas());
	}

	private void OnPointerUp(InputAction.CallbackContext ctx)
	{
		EndInteraction();
		m_PointerMoveAction.performed -= OnPointerMove;
	}

	private Camera GetCameraFromCanvas()
	{
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0044: Unknown result type (might be due to invalid IL or missing references)
		Canvas componentInParent = GetComponentInParent<Canvas>();
		RenderMode? val = ((componentInParent != null) ? new RenderMode?(componentInParent.renderMode) : ((RenderMode?)null));
		if (val != (RenderMode?)0 && (val != (RenderMode?)1 || !(((componentInParent != null) ? componentInParent.worldCamera : null) == null)))
		{
			return ((componentInParent != null) ? componentInParent.worldCamera : null) ?? Camera.main;
		}
		return null;
	}

	private void OnDrawGizmosSelected()
	{
		Gizmos.matrix = ((RectTransform)base.transform.parent).localToWorldMatrix;
		Vector2 vector = ((RectTransform)base.transform).anchoredPosition;
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
