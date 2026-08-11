using System;
using System.Collections;
using UnityEngine.EventSystems;
using UnityEngine.Events;

namespace UnityEngine.UI;

[RequireComponent(typeof(RectTransform))]
[ExecuteAlways]
[AddComponentMenu("UI/Scrollbar", 36)]
public class Scrollbar : Selectable, IBeginDragHandler, IEventSystemHandler, IDragHandler, IInitializePotentialDragHandler, ICanvasElement
{
	public enum Direction
	{
		LeftToRight,
		RightToLeft,
		BottomToTop,
		TopToBottom
	}

	[Serializable]
	public class ScrollEvent : UnityEvent<float>
	{
	}

	private enum Axis
	{
		Horizontal,
		Vertical
	}

	[SerializeField]
	private RectTransform m_HandleRect;

	[SerializeField]
	private Direction m_Direction;

	[Range(0f, 1f)]
	[SerializeField]
	private float m_Value;

	[Range(0f, 1f)]
	[SerializeField]
	private float m_Size = 0.2f;

	[Range(0f, 11f)]
	[SerializeField]
	private int m_NumberOfSteps;

	[Space(6f)]
	[SerializeField]
	private ScrollEvent m_OnValueChanged = new ScrollEvent();

	private RectTransform m_ContainerRect;

	private Vector2 m_Offset = Vector2.zero;

	private DrivenRectTransformTracker m_Tracker;

	private Coroutine m_PointerDownRepeat;

	private bool isPointerDownAndNotDragging;

	private bool m_DelayedUpdateVisuals;

	public RectTransform handleRect
	{
		get
		{
			return m_HandleRect;
		}
		set
		{
			if (SetPropertyUtility.SetClass(ref m_HandleRect, value))
			{
				UpdateCachedReferences();
				UpdateVisuals();
			}
		}
	}

	public Direction direction
	{
		get
		{
			return m_Direction;
		}
		set
		{
			if (SetPropertyUtility.SetStruct(ref m_Direction, value))
			{
				UpdateVisuals();
			}
		}
	}

	public float value
	{
		get
		{
			float num = m_Value;
			if (m_NumberOfSteps > 1)
			{
				num = Mathf.Round(num * (float)(m_NumberOfSteps - 1)) / (float)(m_NumberOfSteps - 1);
			}
			return num;
		}
		set
		{
			Set(value);
		}
	}

	public float size
	{
		get
		{
			return m_Size;
		}
		set
		{
			if (SetPropertyUtility.SetStruct(ref m_Size, Mathf.Clamp01(value)))
			{
				UpdateVisuals();
			}
		}
	}

	public int numberOfSteps
	{
		get
		{
			return m_NumberOfSteps;
		}
		set
		{
			if (SetPropertyUtility.SetStruct(ref m_NumberOfSteps, value))
			{
				Set(m_Value);
				UpdateVisuals();
			}
		}
	}

	public ScrollEvent onValueChanged
	{
		get
		{
			return m_OnValueChanged;
		}
		set
		{
			m_OnValueChanged = value;
		}
	}

	private float stepSize
	{
		get
		{
			if (m_NumberOfSteps <= 1)
			{
				return 0.1f;
			}
			return 1f / (float)(m_NumberOfSteps - 1);
		}
	}

	private Axis axis
	{
		get
		{
			if (m_Direction != Direction.LeftToRight && m_Direction != Direction.RightToLeft)
			{
				return Axis.Vertical;
			}
			return Axis.Horizontal;
		}
	}

	private bool reverseValue
	{
		get
		{
			if (m_Direction != Direction.RightToLeft)
			{
				return m_Direction == Direction.TopToBottom;
			}
			return true;
		}
	}

	protected Scrollbar()
	{
	}

	public virtual void SetValueWithoutNotify(float input)
	{
		Set(input, sendCallback: false);
	}

	public virtual void Rebuild(CanvasUpdate executing)
	{
	}

	public virtual void LayoutComplete()
	{
	}

	public virtual void GraphicUpdateComplete()
	{
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		UpdateCachedReferences();
		Set(m_Value, sendCallback: false);
		UpdateVisuals();
	}

	protected override void OnDisable()
	{
		m_Tracker.Clear();
		base.OnDisable();
	}

	protected virtual void Update()
	{
		if (m_DelayedUpdateVisuals)
		{
			m_DelayedUpdateVisuals = false;
			UpdateVisuals();
		}
	}

	private void UpdateCachedReferences()
	{
		if ((bool)m_HandleRect && m_HandleRect.parent != null)
		{
			m_ContainerRect = m_HandleRect.parent.GetComponent<RectTransform>();
		}
		else
		{
			m_ContainerRect = null;
		}
	}

	private void Set(float input, bool sendCallback = true)
	{
		float num = m_Value;
		m_Value = input;
		if (num != value)
		{
			UpdateVisuals();
			if (sendCallback)
			{
				UISystemProfilerApi.AddMarker("Scrollbar.value", (Object)this);
				m_OnValueChanged.Invoke(value);
			}
		}
	}

	protected override void OnRectTransformDimensionsChange()
	{
		base.OnRectTransformDimensionsChange();
		if (IsActive())
		{
			UpdateVisuals();
		}
	}

	private void UpdateVisuals()
	{
		m_Tracker.Clear();
		if (m_ContainerRect != null)
		{
			m_Tracker.Add(this, m_HandleRect, DrivenTransformProperties.Anchors);
			Vector2 zero = Vector2.zero;
			Vector2 one = Vector2.one;
			float num = Mathf.Clamp01(value) * (1f - size);
			if (reverseValue)
			{
				zero[(int)axis] = 1f - num - size;
				one[(int)axis] = 1f - num;
			}
			else
			{
				zero[(int)axis] = num;
				one[(int)axis] = num + size;
			}
			m_HandleRect.anchorMin = zero;
			m_HandleRect.anchorMax = one;
		}
	}

	private void UpdateDrag(PointerEventData eventData)
	{
		if (eventData.button != PointerEventData.InputButton.Left || m_ContainerRect == null)
		{
			return;
		}
		Vector2 position = Vector2.zero;
		Vector2 vector = default(Vector2);
		if (MultipleDisplayUtilities.GetRelativeMousePositionForDrag(eventData, ref position) && RectTransformUtility.ScreenPointToLocalPointInRectangle(m_ContainerRect, position, eventData.pressEventCamera, ref vector))
		{
			Vector2 handleCorner = vector - m_Offset - m_ContainerRect.rect.position - (m_HandleRect.rect.size - m_HandleRect.sizeDelta) * 0.5f;
			float num = ((axis == Axis.Horizontal) ? m_ContainerRect.rect.width : m_ContainerRect.rect.height) * (1f - size);
			if (!(num <= 0f))
			{
				DoUpdateDrag(handleCorner, num);
			}
		}
	}

	private void DoUpdateDrag(Vector2 handleCorner, float remainingSize)
	{
		switch (m_Direction)
		{
		case Direction.LeftToRight:
			Set(Mathf.Clamp01(handleCorner.x / remainingSize));
			break;
		case Direction.RightToLeft:
			Set(Mathf.Clamp01(1f - handleCorner.x / remainingSize));
			break;
		case Direction.BottomToTop:
			Set(Mathf.Clamp01(handleCorner.y / remainingSize));
			break;
		case Direction.TopToBottom:
			Set(Mathf.Clamp01(1f - handleCorner.y / remainingSize));
			break;
		}
	}

	private bool MayDrag(PointerEventData eventData)
	{
		if (IsActive() && IsInteractable())
		{
			return eventData.button == PointerEventData.InputButton.Left;
		}
		return false;
	}

	public virtual void OnBeginDrag(PointerEventData eventData)
	{
		isPointerDownAndNotDragging = false;
		if (MayDrag(eventData) && !(m_ContainerRect == null))
		{
			m_Offset = Vector2.zero;
			Vector2 vector = default(Vector2);
			if (RectTransformUtility.RectangleContainsScreenPoint(m_HandleRect, eventData.pointerPressRaycast.screenPosition, eventData.enterEventCamera) && RectTransformUtility.ScreenPointToLocalPointInRectangle(m_HandleRect, eventData.pointerPressRaycast.screenPosition, eventData.pressEventCamera, ref vector))
			{
				m_Offset = vector - m_HandleRect.rect.center;
			}
		}
	}

	public virtual void OnDrag(PointerEventData eventData)
	{
		if (MayDrag(eventData) && m_ContainerRect != null)
		{
			UpdateDrag(eventData);
		}
	}

	public override void OnPointerDown(PointerEventData eventData)
	{
		if (MayDrag(eventData))
		{
			base.OnPointerDown(eventData);
			isPointerDownAndNotDragging = true;
			m_PointerDownRepeat = StartCoroutine(ClickRepeat(eventData.pointerPressRaycast.screenPosition, eventData.enterEventCamera));
		}
	}

	protected IEnumerator ClickRepeat(PointerEventData eventData)
	{
		return ClickRepeat(eventData.pointerPressRaycast.screenPosition, eventData.enterEventCamera);
	}

	protected IEnumerator ClickRepeat(Vector2 screenPosition, Camera camera)
	{
		Vector2 vector = default(Vector2);
		while (isPointerDownAndNotDragging)
		{
			if (!RectTransformUtility.RectangleContainsScreenPoint(m_HandleRect, screenPosition, camera) && RectTransformUtility.ScreenPointToLocalPointInRectangle(m_HandleRect, screenPosition, camera, ref vector))
			{
				float num = ((((axis == Axis.Horizontal) ? vector.x : vector.y) < 0f) ? size : (0f - size));
				value += (reverseValue ? num : (0f - num));
				value = Mathf.Clamp01(value);
				value = Mathf.Round(value * 10000f) / 10000f;
			}
			yield return new WaitForEndOfFrame();
		}
		StopCoroutine(m_PointerDownRepeat);
	}

	public override void OnPointerUp(PointerEventData eventData)
	{
		base.OnPointerUp(eventData);
		isPointerDownAndNotDragging = false;
	}

	public override void OnMove(AxisEventData eventData)
	{
		if (!IsActive() || !IsInteractable())
		{
			base.OnMove(eventData);
			return;
		}
		switch (eventData.moveDir)
		{
		case MoveDirection.Left:
			if (axis == Axis.Horizontal && FindSelectableOnLeft() == null)
			{
				Set(Mathf.Clamp01(reverseValue ? (value + stepSize) : (value - stepSize)));
			}
			else
			{
				base.OnMove(eventData);
			}
			break;
		case MoveDirection.Right:
			if (axis == Axis.Horizontal && FindSelectableOnRight() == null)
			{
				Set(Mathf.Clamp01(reverseValue ? (value - stepSize) : (value + stepSize)));
			}
			else
			{
				base.OnMove(eventData);
			}
			break;
		case MoveDirection.Up:
			if (axis == Axis.Vertical && FindSelectableOnUp() == null)
			{
				Set(Mathf.Clamp01(reverseValue ? (value - stepSize) : (value + stepSize)));
			}
			else
			{
				base.OnMove(eventData);
			}
			break;
		case MoveDirection.Down:
			if (axis == Axis.Vertical && FindSelectableOnDown() == null)
			{
				Set(Mathf.Clamp01(reverseValue ? (value + stepSize) : (value - stepSize)));
			}
			else
			{
				base.OnMove(eventData);
			}
			break;
		}
	}

	public override Selectable FindSelectableOnLeft()
	{
		if (base.navigation.mode == Navigation.Mode.Automatic && axis == Axis.Horizontal)
		{
			return null;
		}
		return base.FindSelectableOnLeft();
	}

	public override Selectable FindSelectableOnRight()
	{
		if (base.navigation.mode == Navigation.Mode.Automatic && axis == Axis.Horizontal)
		{
			return null;
		}
		return base.FindSelectableOnRight();
	}

	public override Selectable FindSelectableOnUp()
	{
		if (base.navigation.mode == Navigation.Mode.Automatic && axis == Axis.Vertical)
		{
			return null;
		}
		return base.FindSelectableOnUp();
	}

	public override Selectable FindSelectableOnDown()
	{
		if (base.navigation.mode == Navigation.Mode.Automatic && axis == Axis.Vertical)
		{
			return null;
		}
		return base.FindSelectableOnDown();
	}

	public virtual void OnInitializePotentialDrag(PointerEventData eventData)
	{
		eventData.useDragThreshold = false;
	}

	public void SetDirection(Direction direction, bool includeRectLayouts)
	{
		Axis axis = this.axis;
		bool flag = reverseValue;
		this.direction = direction;
		if (includeRectLayouts)
		{
			if (this.axis != axis)
			{
				RectTransformUtility.FlipLayoutAxes(base.transform as RectTransform, true, true);
			}
			if (reverseValue != flag)
			{
				RectTransformUtility.FlipLayoutOnAxis(base.transform as RectTransform, (int)this.axis, true, true);
			}
		}
	}
}
