using System;
using UnityEngine.EventSystems;
using UnityEngine.Events;

namespace UnityEngine.UI;

[AddComponentMenu("UI/LScroll Rect", 37)]
[SelectionBase]
[ExecuteAlways]
[DisallowMultipleComponent]
[RequireComponent(typeof(RectTransform))]
public class LScrollRect : UIBehaviour, IInitializePotentialDragHandler, IEventSystemHandler, IBeginDragHandler, IEndDragHandler, IDragHandler, IScrollHandler, ICanvasElement, ILayoutElement, ILayoutGroup, ILayoutController
{
	public enum MovementType
	{
		Unrestricted,
		Elastic,
		Clamped
	}

	public enum ScrollbarVisibility
	{
		Permanent,
		AutoHide,
		AutoHideAndExpandViewport
	}

	[Serializable]
	public class ScrollRectEvent : UnityEvent<Vector2>
	{
	}

	public delegate void UpdateItems(Bounds viewBounds, Bounds contentBounds);

	[SerializeField]
	private RectTransform m_Content;

	[SerializeField]
	private bool m_Horizontal = true;

	[SerializeField]
	private bool m_Vertical = true;

	[SerializeField]
	private MovementType m_MovementType = MovementType.Elastic;

	[SerializeField]
	private float m_Elasticity = 0.1f;

	[SerializeField]
	private bool m_Inertia = true;

	[SerializeField]
	private float m_DecelerationRate = 0.135f;

	[SerializeField]
	private float m_ScrollSensitivity = 1f;

	[SerializeField]
	private RectTransform m_Viewport;

	[SerializeField]
	private Scrollbar m_HorizontalScrollbar;

	[SerializeField]
	private Scrollbar m_VerticalScrollbar;

	[SerializeField]
	private ScrollbarVisibility m_HorizontalScrollbarVisibility;

	[SerializeField]
	private ScrollbarVisibility m_VerticalScrollbarVisibility;

	[SerializeField]
	private float m_HorizontalScrollbarSpacing;

	[SerializeField]
	private float m_VerticalScrollbarSpacing;

	[SerializeField]
	private ScrollRectEvent m_OnValueChanged = new ScrollRectEvent();

	private Vector2 m_PointerStartLocalCursor = Vector2.zero;

	protected Vector2 m_ContentStartPosition = Vector2.zero;

	private RectTransform m_ViewRect;

	protected Bounds m_ContentBounds;

	private Bounds m_ViewBounds;

	private Vector2 m_Velocity;

	private bool m_Dragging;

	private bool m_Scrolling;

	private Vector2 m_PrevPosition = Vector2.zero;

	private Bounds m_PrevContentBounds;

	private Bounds m_PrevViewBounds;

	[NonSerialized]
	private bool m_HasRebuiltLayout;

	private bool m_HSliderExpand;

	private bool m_VSliderExpand;

	private float m_HSliderHeight;

	private float m_VSliderWidth;

	[NonSerialized]
	private RectTransform m_Rect;

	private RectTransform m_HorizontalScrollbarRect;

	private RectTransform m_VerticalScrollbarRect;

	private DrivenRectTransformTracker m_Tracker;

	public UpdateItems onUpdateItems;

	private readonly Vector3[] m_Corners = new Vector3[4];

	public RectTransform content
	{
		get
		{
			return m_Content;
		}
		set
		{
			m_Content = value;
		}
	}

	public bool horizontal
	{
		get
		{
			return m_Horizontal;
		}
		set
		{
			m_Horizontal = value;
		}
	}

	public bool vertical
	{
		get
		{
			return m_Vertical;
		}
		set
		{
			m_Vertical = value;
		}
	}

	public MovementType movementType
	{
		get
		{
			return m_MovementType;
		}
		set
		{
			m_MovementType = value;
		}
	}

	public float elasticity
	{
		get
		{
			return m_Elasticity;
		}
		set
		{
			m_Elasticity = value;
		}
	}

	public bool inertia
	{
		get
		{
			return m_Inertia;
		}
		set
		{
			m_Inertia = value;
		}
	}

	public float decelerationRate
	{
		get
		{
			return m_DecelerationRate;
		}
		set
		{
			m_DecelerationRate = value;
		}
	}

	public float scrollSensitivity
	{
		get
		{
			return m_ScrollSensitivity;
		}
		set
		{
			m_ScrollSensitivity = value;
		}
	}

	public RectTransform viewport
	{
		get
		{
			return m_Viewport;
		}
		set
		{
			m_Viewport = value;
			SetDirtyCaching();
		}
	}

	public Scrollbar horizontalScrollbar
	{
		get
		{
			return m_HorizontalScrollbar;
		}
		set
		{
			if ((bool)m_HorizontalScrollbar)
			{
				m_HorizontalScrollbar.onValueChanged.RemoveListener(SetHorizontalNormalizedPosition);
			}
			m_HorizontalScrollbar = value;
			if ((bool)m_HorizontalScrollbar)
			{
				m_HorizontalScrollbar.onValueChanged.AddListener(SetHorizontalNormalizedPosition);
			}
			SetDirtyCaching();
		}
	}

	public Scrollbar verticalScrollbar
	{
		get
		{
			return m_VerticalScrollbar;
		}
		set
		{
			if ((bool)m_VerticalScrollbar)
			{
				m_VerticalScrollbar.onValueChanged.RemoveListener(SetVerticalNormalizedPosition);
			}
			m_VerticalScrollbar = value;
			if ((bool)m_VerticalScrollbar)
			{
				m_VerticalScrollbar.onValueChanged.AddListener(SetVerticalNormalizedPosition);
			}
			SetDirtyCaching();
		}
	}

	public ScrollbarVisibility horizontalScrollbarVisibility
	{
		get
		{
			return m_HorizontalScrollbarVisibility;
		}
		set
		{
			m_HorizontalScrollbarVisibility = value;
			SetDirtyCaching();
		}
	}

	public ScrollbarVisibility verticalScrollbarVisibility
	{
		get
		{
			return m_VerticalScrollbarVisibility;
		}
		set
		{
			m_VerticalScrollbarVisibility = value;
			SetDirtyCaching();
		}
	}

	public float horizontalScrollbarSpacing
	{
		get
		{
			return m_HorizontalScrollbarSpacing;
		}
		set
		{
			m_HorizontalScrollbarSpacing = value;
			SetDirty();
		}
	}

	public float verticalScrollbarSpacing
	{
		get
		{
			return m_VerticalScrollbarSpacing;
		}
		set
		{
			m_VerticalScrollbarSpacing = value;
			SetDirty();
		}
	}

	public ScrollRectEvent onValueChanged
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

	protected RectTransform viewRect
	{
		get
		{
			if (m_ViewRect == null)
			{
				m_ViewRect = m_Viewport;
			}
			if (m_ViewRect == null)
			{
				m_ViewRect = (RectTransform)base.transform;
			}
			return m_ViewRect;
		}
	}

	public Vector2 velocity
	{
		get
		{
			return m_Velocity;
		}
		set
		{
			m_Velocity = value;
		}
	}

	private RectTransform rectTransform
	{
		get
		{
			if (m_Rect == null)
			{
				m_Rect = GetComponent<RectTransform>();
			}
			return m_Rect;
		}
	}

	public Vector2 normalizedPosition
	{
		get
		{
			return new Vector2(horizontalNormalizedPosition, verticalNormalizedPosition);
		}
		set
		{
			SetNormalizedPosition(value.x, 0);
			SetNormalizedPosition(value.y, 1);
		}
	}

	public float horizontalNormalizedPosition
	{
		get
		{
			UpdateBounds();
			if (m_ContentBounds.size.x <= m_ViewBounds.size.x || Mathf.Approximately(m_ContentBounds.size.x, m_ViewBounds.size.x))
			{
				return (m_ViewBounds.min.x > m_ContentBounds.min.x) ? 1 : 0;
			}
			return (m_ViewBounds.min.x - m_ContentBounds.min.x) / (m_ContentBounds.size.x - m_ViewBounds.size.x);
		}
		set
		{
			SetNormalizedPosition(value, 0);
		}
	}

	public float verticalNormalizedPosition
	{
		get
		{
			UpdateBounds();
			if (m_ContentBounds.size.y <= m_ViewBounds.size.y || Mathf.Approximately(m_ContentBounds.size.y, m_ViewBounds.size.y))
			{
				return (m_ViewBounds.min.y > m_ContentBounds.min.y) ? 1 : 0;
			}
			return (m_ViewBounds.min.y - m_ContentBounds.min.y) / (m_ContentBounds.size.y - m_ViewBounds.size.y);
		}
		set
		{
			SetNormalizedPosition(value, 1);
		}
	}

	private bool hScrollingNeeded
	{
		get
		{
			if (Application.isPlaying)
			{
				return m_ContentBounds.size.x > m_ViewBounds.size.x + 0.01f;
			}
			return true;
		}
	}

	private bool vScrollingNeeded
	{
		get
		{
			if (Application.isPlaying)
			{
				return m_ContentBounds.size.y > m_ViewBounds.size.y + 0.01f;
			}
			return true;
		}
	}

	public virtual float minWidth => -1f;

	public virtual float preferredWidth => -1f;

	public virtual float flexibleWidth => -1f;

	public virtual float minHeight => -1f;

	public virtual float preferredHeight => -1f;

	public virtual float flexibleHeight => -1f;

	public virtual int layoutPriority => -1;

	public void AddContentPosition(Vector2 newPos)
	{
		m_ContentStartPosition += newPos;
		content.anchoredPosition += newPos;
		if (m_Dragging)
		{
			m_PrevPosition += newPos;
		}
	}

	public Bounds GetViewBounds()
	{
		return new Bounds(viewRect.rect.center, viewRect.rect.size);
	}

	public Bounds GetContentBounds()
	{
		if (!CanvasUpdateRegistry.IsRebuildingLayout())
		{
			Canvas.ForceUpdateCanvases();
		}
		return GetBounds();
	}

	protected LScrollRect()
	{
	}

	public virtual void Rebuild(CanvasUpdate executing)
	{
		if (executing == CanvasUpdate.Prelayout)
		{
			UpdateCachedData();
		}
		if (executing == CanvasUpdate.PostLayout)
		{
			UpdateBounds();
			UpdateScrollbars(Vector2.zero);
			UpdatePrevData();
			m_HasRebuiltLayout = true;
		}
	}

	public virtual void LayoutComplete()
	{
	}

	public virtual void GraphicUpdateComplete()
	{
	}

	private void UpdateCachedData()
	{
		Transform transform = base.transform;
		m_HorizontalScrollbarRect = ((m_HorizontalScrollbar == null) ? null : (m_HorizontalScrollbar.transform as RectTransform));
		m_VerticalScrollbarRect = ((m_VerticalScrollbar == null) ? null : (m_VerticalScrollbar.transform as RectTransform));
		bool num = viewRect.parent == transform;
		bool flag = !m_HorizontalScrollbarRect || m_HorizontalScrollbarRect.parent == transform;
		bool flag2 = !m_VerticalScrollbarRect || m_VerticalScrollbarRect.parent == transform;
		bool flag3 = num & flag & flag2;
		m_HSliderExpand = flag3 && (bool)m_HorizontalScrollbarRect && horizontalScrollbarVisibility == ScrollbarVisibility.AutoHideAndExpandViewport;
		m_VSliderExpand = flag3 && (bool)m_VerticalScrollbarRect && verticalScrollbarVisibility == ScrollbarVisibility.AutoHideAndExpandViewport;
		m_HSliderHeight = ((m_HorizontalScrollbarRect == null) ? 0f : m_HorizontalScrollbarRect.rect.height);
		m_VSliderWidth = ((m_VerticalScrollbarRect == null) ? 0f : m_VerticalScrollbarRect.rect.width);
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if ((bool)m_HorizontalScrollbar)
		{
			m_HorizontalScrollbar.onValueChanged.AddListener(SetHorizontalNormalizedPosition);
		}
		if ((bool)m_VerticalScrollbar)
		{
			m_VerticalScrollbar.onValueChanged.AddListener(SetVerticalNormalizedPosition);
		}
		CanvasUpdateRegistry.RegisterCanvasElementForLayoutRebuild(this);
		SetDirty();
	}

	protected override void OnDisable()
	{
		CanvasUpdateRegistry.UnRegisterCanvasElementForRebuild(this);
		if ((bool)m_HorizontalScrollbar)
		{
			m_HorizontalScrollbar.onValueChanged.RemoveListener(SetHorizontalNormalizedPosition);
		}
		if ((bool)m_VerticalScrollbar)
		{
			m_VerticalScrollbar.onValueChanged.RemoveListener(SetVerticalNormalizedPosition);
		}
		m_Dragging = false;
		m_Scrolling = false;
		m_HasRebuiltLayout = false;
		m_Tracker.Clear();
		m_Velocity = Vector2.zero;
		LayoutRebuilder.MarkLayoutForRebuild(rectTransform);
		base.OnDisable();
	}

	public override bool IsActive()
	{
		if (base.IsActive())
		{
			return m_Content != null;
		}
		return false;
	}

	private void EnsureLayoutHasRebuilt()
	{
		if (!m_HasRebuiltLayout && !CanvasUpdateRegistry.IsRebuildingLayout())
		{
			Canvas.ForceUpdateCanvases();
		}
	}

	public virtual void StopMovement()
	{
		m_Velocity = Vector2.zero;
	}

	public virtual void OnScroll(PointerEventData data)
	{
		if (!IsActive())
		{
			return;
		}
		EnsureLayoutHasRebuilt();
		UpdateBounds();
		Vector2 scrollDelta = data.scrollDelta;
		scrollDelta.y *= -1f;
		if (vertical && !horizontal)
		{
			if (Mathf.Abs(scrollDelta.x) > Mathf.Abs(scrollDelta.y))
			{
				scrollDelta.y = scrollDelta.x;
			}
			scrollDelta.x = 0f;
		}
		if (horizontal && !vertical)
		{
			if (Mathf.Abs(scrollDelta.y) > Mathf.Abs(scrollDelta.x))
			{
				scrollDelta.x = scrollDelta.y;
			}
			scrollDelta.y = 0f;
		}
		if (data.IsScrolling())
		{
			m_Scrolling = true;
		}
		Vector2 anchoredPosition = m_Content.anchoredPosition;
		anchoredPosition += scrollDelta * m_ScrollSensitivity;
		if (m_MovementType == MovementType.Clamped)
		{
			anchoredPosition += CalculateOffset(anchoredPosition - m_Content.anchoredPosition);
		}
		SetContentAnchoredPosition(anchoredPosition);
		UpdateBounds();
	}

	public virtual void OnInitializePotentialDrag(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			m_Velocity = Vector2.zero;
		}
	}

	public virtual void OnBeginDrag(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left && IsActive())
		{
			UpdateBounds();
			m_PointerStartLocalCursor = Vector2.zero;
			RectTransformUtility.ScreenPointToLocalPointInRectangle(viewRect, eventData.position, eventData.pressEventCamera, out m_PointerStartLocalCursor);
			m_ContentStartPosition = m_Content.anchoredPosition;
			m_Dragging = true;
		}
	}

	public virtual void OnEndDrag(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			m_Dragging = false;
		}
	}

	public virtual void OnDrag(PointerEventData eventData)
	{
		if (!m_Dragging || eventData.button != PointerEventData.InputButton.Left || !IsActive() || !RectTransformUtility.ScreenPointToLocalPointInRectangle(viewRect, eventData.position, eventData.pressEventCamera, out var localPoint))
		{
			return;
		}
		UpdateBounds();
		Vector2 vector = localPoint - m_PointerStartLocalCursor;
		Vector2 vector2 = m_ContentStartPosition + vector;
		Vector2 vector3 = CalculateOffset(vector2 - m_Content.anchoredPosition);
		vector2 += vector3;
		if (m_MovementType == MovementType.Elastic)
		{
			if (vector3.x != 0f)
			{
				vector2.x -= RubberDelta(vector3.x, m_ViewBounds.size.x);
			}
			if (vector3.y != 0f)
			{
				vector2.y -= RubberDelta(vector3.y, m_ViewBounds.size.y);
			}
		}
		SetContentAnchoredPosition(vector2);
	}

	protected virtual void SetContentAnchoredPosition(Vector2 position)
	{
		if (!m_Horizontal)
		{
			position.x = m_Content.anchoredPosition.x;
		}
		if (!m_Vertical)
		{
			position.y = m_Content.anchoredPosition.y;
		}
		if (position != m_Content.anchoredPosition)
		{
			m_Content.anchoredPosition = position;
			UpdateBounds();
		}
	}

	protected virtual void LateUpdate()
	{
		if (!m_Content)
		{
			return;
		}
		EnsureLayoutHasRebuilt();
		UpdateBounds();
		float unscaledDeltaTime = Time.unscaledDeltaTime;
		Vector2 vector = CalculateOffset(Vector2.zero);
		if (!m_Dragging && (vector != Vector2.zero || m_Velocity != Vector2.zero))
		{
			Vector2 anchoredPosition = m_Content.anchoredPosition;
			for (int i = 0; i < 2; i++)
			{
				if (m_MovementType == MovementType.Elastic && vector[i] != 0f)
				{
					float currentVelocity = m_Velocity[i];
					float num = m_Elasticity;
					if (m_Scrolling)
					{
						num *= 3f;
					}
					anchoredPosition[i] = Mathf.SmoothDamp(m_Content.anchoredPosition[i], m_Content.anchoredPosition[i] + vector[i], ref currentVelocity, num, float.PositiveInfinity, unscaledDeltaTime);
					if (Mathf.Abs(currentVelocity) < 1f)
					{
						currentVelocity = 0f;
					}
					m_Velocity[i] = currentVelocity;
				}
				else if (m_Inertia)
				{
					m_Velocity[i] *= Mathf.Pow(m_DecelerationRate, unscaledDeltaTime);
					if (Mathf.Abs(m_Velocity[i]) < 1f)
					{
						m_Velocity[i] = 0f;
					}
					anchoredPosition[i] += m_Velocity[i] * unscaledDeltaTime;
				}
				else
				{
					m_Velocity[i] = 0f;
				}
			}
			if (m_MovementType == MovementType.Clamped)
			{
				vector = CalculateOffset(anchoredPosition - m_Content.anchoredPosition);
				anchoredPosition += vector;
			}
			SetContentAnchoredPosition(anchoredPosition);
		}
		if (m_Dragging && m_Inertia)
		{
			Vector3 b = (m_Content.anchoredPosition - m_PrevPosition) / unscaledDeltaTime;
			m_Velocity = Vector3.Lerp(m_Velocity, b, unscaledDeltaTime * 10f);
		}
		if (m_ViewBounds != m_PrevViewBounds || m_ContentBounds != m_PrevContentBounds || m_Content.anchoredPosition != m_PrevPosition)
		{
			UpdateScrollbars(vector);
			UISystemProfilerApi.AddMarker("ScrollRect.value", this);
			m_OnValueChanged.Invoke(normalizedPosition);
			UpdatePrevData();
		}
		UpdateScrollbarVisibility();
		m_Scrolling = false;
	}

	protected void UpdatePrevData()
	{
		if (m_Content == null)
		{
			m_PrevPosition = Vector2.zero;
		}
		else
		{
			m_PrevPosition = m_Content.anchoredPosition;
		}
		m_PrevViewBounds = m_ViewBounds;
		m_PrevContentBounds = m_ContentBounds;
	}

	private void UpdateScrollbars(Vector2 offset)
	{
		if ((bool)m_HorizontalScrollbar)
		{
			if (m_ContentBounds.size.x > 0f)
			{
				m_HorizontalScrollbar.size = Mathf.Clamp01((m_ViewBounds.size.x - Mathf.Abs(offset.x)) / m_ContentBounds.size.x);
			}
			else
			{
				m_HorizontalScrollbar.size = 1f;
			}
			m_HorizontalScrollbar.value = horizontalNormalizedPosition;
		}
		if ((bool)m_VerticalScrollbar)
		{
			if (m_ContentBounds.size.y > 0f)
			{
				m_VerticalScrollbar.size = Mathf.Clamp01((m_ViewBounds.size.y - Mathf.Abs(offset.y)) / m_ContentBounds.size.y);
			}
			else
			{
				m_VerticalScrollbar.size = 1f;
			}
			m_VerticalScrollbar.value = verticalNormalizedPosition;
		}
	}

	private void SetHorizontalNormalizedPosition(float value)
	{
		SetNormalizedPosition(value, 0);
	}

	private void SetVerticalNormalizedPosition(float value)
	{
		SetNormalizedPosition(value, 1);
	}

	protected virtual void SetNormalizedPosition(float value, int axis)
	{
		EnsureLayoutHasRebuilt();
		UpdateBounds();
		float num = m_ContentBounds.size[axis] - m_ViewBounds.size[axis];
		float num2 = m_ViewBounds.min[axis] - value * num;
		float num3 = m_Content.localPosition[axis] + num2 - m_ContentBounds.min[axis];
		Vector3 localPosition = m_Content.localPosition;
		if (Mathf.Abs(localPosition[axis] - num3) > 0.01f)
		{
			localPosition[axis] = num3;
			m_Content.localPosition = localPosition;
			m_Velocity[axis] = 0f;
			UpdateBounds();
		}
	}

	private static float RubberDelta(float overStretching, float viewSize)
	{
		return (1f - 1f / (Mathf.Abs(overStretching) * 0.55f / viewSize + 1f)) * viewSize * Mathf.Sign(overStretching);
	}

	protected override void OnRectTransformDimensionsChange()
	{
		SetDirty();
	}

	public virtual void CalculateLayoutInputHorizontal()
	{
	}

	public virtual void CalculateLayoutInputVertical()
	{
	}

	public virtual void SetLayoutHorizontal()
	{
		m_Tracker.Clear();
		if (m_HSliderExpand || m_VSliderExpand)
		{
			m_Tracker.Add(this, viewRect, DrivenTransformProperties.Anchors | DrivenTransformProperties.AnchoredPosition | DrivenTransformProperties.SizeDelta);
			viewRect.anchorMin = Vector2.zero;
			viewRect.anchorMax = Vector2.one;
			viewRect.sizeDelta = Vector2.zero;
			viewRect.anchoredPosition = Vector2.zero;
			LayoutRebuilder.ForceRebuildLayoutImmediate(content);
			m_ViewBounds = new Bounds(viewRect.rect.center, viewRect.rect.size);
			m_ContentBounds = GetBounds();
		}
		if (m_VSliderExpand && vScrollingNeeded)
		{
			viewRect.sizeDelta = new Vector2(0f - (m_VSliderWidth + m_VerticalScrollbarSpacing), viewRect.sizeDelta.y);
			LayoutRebuilder.ForceRebuildLayoutImmediate(content);
			m_ViewBounds = new Bounds(viewRect.rect.center, viewRect.rect.size);
			m_ContentBounds = GetBounds();
		}
		if (m_HSliderExpand && hScrollingNeeded)
		{
			viewRect.sizeDelta = new Vector2(viewRect.sizeDelta.x, 0f - (m_HSliderHeight + m_HorizontalScrollbarSpacing));
			m_ViewBounds = new Bounds(viewRect.rect.center, viewRect.rect.size);
			m_ContentBounds = GetBounds();
		}
		if (m_VSliderExpand && vScrollingNeeded && viewRect.sizeDelta.x == 0f && viewRect.sizeDelta.y < 0f)
		{
			viewRect.sizeDelta = new Vector2(0f - (m_VSliderWidth + m_VerticalScrollbarSpacing), viewRect.sizeDelta.y);
		}
	}

	public virtual void SetLayoutVertical()
	{
		UpdateScrollbarLayout();
		m_ViewBounds = new Bounds(viewRect.rect.center, viewRect.rect.size);
		m_ContentBounds = GetBounds();
	}

	private void UpdateScrollbarVisibility()
	{
		UpdateOneScrollbarVisibility(vScrollingNeeded, m_Vertical, m_VerticalScrollbarVisibility, m_VerticalScrollbar);
		UpdateOneScrollbarVisibility(hScrollingNeeded, m_Horizontal, m_HorizontalScrollbarVisibility, m_HorizontalScrollbar);
	}

	private static void UpdateOneScrollbarVisibility(bool xScrollingNeeded, bool xAxisEnabled, ScrollbarVisibility scrollbarVisibility, Scrollbar scrollbar)
	{
		if (!scrollbar)
		{
			return;
		}
		if (scrollbarVisibility == ScrollbarVisibility.Permanent)
		{
			if (scrollbar.gameObject.activeSelf != xAxisEnabled)
			{
				scrollbar.gameObject.SetActive(xAxisEnabled);
			}
		}
		else if (scrollbar.gameObject.activeSelf != xScrollingNeeded)
		{
			scrollbar.gameObject.SetActive(xScrollingNeeded);
		}
	}

	private void UpdateScrollbarLayout()
	{
		if (m_VSliderExpand && (bool)m_HorizontalScrollbar)
		{
			m_Tracker.Add(this, m_HorizontalScrollbarRect, DrivenTransformProperties.AnchoredPositionX | DrivenTransformProperties.AnchorMinX | DrivenTransformProperties.AnchorMaxX | DrivenTransformProperties.SizeDeltaX);
			m_HorizontalScrollbarRect.anchorMin = new Vector2(0f, m_HorizontalScrollbarRect.anchorMin.y);
			m_HorizontalScrollbarRect.anchorMax = new Vector2(1f, m_HorizontalScrollbarRect.anchorMax.y);
			m_HorizontalScrollbarRect.anchoredPosition = new Vector2(0f, m_HorizontalScrollbarRect.anchoredPosition.y);
			if (vScrollingNeeded)
			{
				m_HorizontalScrollbarRect.sizeDelta = new Vector2(0f - (m_VSliderWidth + m_VerticalScrollbarSpacing), m_HorizontalScrollbarRect.sizeDelta.y);
			}
			else
			{
				m_HorizontalScrollbarRect.sizeDelta = new Vector2(0f, m_HorizontalScrollbarRect.sizeDelta.y);
			}
		}
		if (m_HSliderExpand && (bool)m_VerticalScrollbar)
		{
			m_Tracker.Add(this, m_VerticalScrollbarRect, DrivenTransformProperties.AnchoredPositionY | DrivenTransformProperties.AnchorMinY | DrivenTransformProperties.AnchorMaxY | DrivenTransformProperties.SizeDeltaY);
			m_VerticalScrollbarRect.anchorMin = new Vector2(m_VerticalScrollbarRect.anchorMin.x, 0f);
			m_VerticalScrollbarRect.anchorMax = new Vector2(m_VerticalScrollbarRect.anchorMax.x, 1f);
			m_VerticalScrollbarRect.anchoredPosition = new Vector2(m_VerticalScrollbarRect.anchoredPosition.x, 0f);
			if (hScrollingNeeded)
			{
				m_VerticalScrollbarRect.sizeDelta = new Vector2(m_VerticalScrollbarRect.sizeDelta.x, 0f - (m_HSliderHeight + m_HorizontalScrollbarSpacing));
			}
			else
			{
				m_VerticalScrollbarRect.sizeDelta = new Vector2(m_VerticalScrollbarRect.sizeDelta.x, 0f);
			}
		}
	}

	protected void UpdateBounds()
	{
		m_ViewBounds.center = viewRect.rect.center;
		m_ViewBounds.size = viewRect.rect.size;
		m_ContentBounds = GetBounds();
		if (m_Content == null)
		{
			return;
		}
		if (Application.isPlaying)
		{
			if (onUpdateItems != null)
			{
				onUpdateItems(m_ViewBounds, m_ContentBounds);
			}
			EnsureLayoutHasRebuilt();
			m_ContentBounds = GetBounds();
		}
		Vector3 contentSize = m_ContentBounds.size;
		Vector3 contentPos = m_ContentBounds.center;
		Vector2 contentPivot = m_Content.pivot;
		AdjustBounds(ref m_ViewBounds, ref contentPivot, ref contentSize, ref contentPos);
		m_ContentBounds.size = contentSize;
		m_ContentBounds.center = contentPos;
		if (movementType != MovementType.Clamped)
		{
			return;
		}
		Vector2 zero = Vector2.zero;
		if (m_ViewBounds.max.x > m_ContentBounds.max.x)
		{
			zero.x = Math.Min(m_ViewBounds.min.x - m_ContentBounds.min.x, m_ViewBounds.max.x - m_ContentBounds.max.x);
		}
		else if (m_ViewBounds.min.x < m_ContentBounds.min.x)
		{
			zero.x = Math.Max(m_ViewBounds.min.x - m_ContentBounds.min.x, m_ViewBounds.max.x - m_ContentBounds.max.x);
		}
		if (m_ViewBounds.min.y < m_ContentBounds.min.y)
		{
			zero.y = Math.Max(m_ViewBounds.min.y - m_ContentBounds.min.y, m_ViewBounds.max.y - m_ContentBounds.max.y);
		}
		else if (m_ViewBounds.max.y > m_ContentBounds.max.y)
		{
			zero.y = Math.Min(m_ViewBounds.min.y - m_ContentBounds.min.y, m_ViewBounds.max.y - m_ContentBounds.max.y);
		}
		if (zero.sqrMagnitude > float.Epsilon)
		{
			contentPos = m_Content.anchoredPosition + zero;
			if (!m_Horizontal)
			{
				contentPos.x = m_Content.anchoredPosition.x;
			}
			if (!m_Vertical)
			{
				contentPos.y = m_Content.anchoredPosition.y;
			}
			AdjustBounds(ref m_ViewBounds, ref contentPivot, ref contentSize, ref contentPos);
		}
	}

	internal static void AdjustBounds(ref Bounds viewBounds, ref Vector2 contentPivot, ref Vector3 contentSize, ref Vector3 contentPos)
	{
		Vector3 vector = viewBounds.size - contentSize;
		if (vector.x > 0f)
		{
			contentPos.x -= vector.x * (contentPivot.x - 0.5f);
			contentSize.x = viewBounds.size.x;
		}
		if (vector.y > 0f)
		{
			contentPos.y -= vector.y * (contentPivot.y - 0.5f);
			contentSize.y = viewBounds.size.y;
		}
	}

	private Bounds GetBounds()
	{
		if (m_Content == null)
		{
			return default(Bounds);
		}
		m_Content.GetWorldCorners(m_Corners);
		Matrix4x4 viewWorldToLocalMatrix = viewRect.worldToLocalMatrix;
		return InternalGetBounds(m_Corners, ref viewWorldToLocalMatrix);
	}

	internal static Bounds InternalGetBounds(Vector3[] corners, ref Matrix4x4 viewWorldToLocalMatrix)
	{
		Vector3 vector = new Vector3(float.MaxValue, float.MaxValue, float.MaxValue);
		Vector3 vector2 = new Vector3(float.MinValue, float.MinValue, float.MinValue);
		for (int i = 0; i < 4; i++)
		{
			Vector3 lhs = viewWorldToLocalMatrix.MultiplyPoint3x4(corners[i]);
			vector = Vector3.Min(lhs, vector);
			vector2 = Vector3.Max(lhs, vector2);
		}
		Bounds result = new Bounds(vector, Vector3.zero);
		result.Encapsulate(vector2);
		return result;
	}

	private Vector2 CalculateOffset(Vector2 delta)
	{
		return InternalCalculateOffset(ref m_ViewBounds, ref m_ContentBounds, m_Horizontal, m_Vertical, m_MovementType, ref delta);
	}

	internal static Vector2 InternalCalculateOffset(ref Bounds viewBounds, ref Bounds contentBounds, bool horizontal, bool vertical, MovementType movementType, ref Vector2 delta)
	{
		Vector2 zero = Vector2.zero;
		if (movementType == MovementType.Unrestricted)
		{
			return zero;
		}
		Vector2 vector = contentBounds.min;
		Vector2 vector2 = contentBounds.max;
		if (horizontal)
		{
			vector.x += delta.x;
			vector2.x += delta.x;
			float num = viewBounds.max.x - vector2.x;
			float num2 = viewBounds.min.x - vector.x;
			if (num2 < -0.001f)
			{
				zero.x = num2;
			}
			else if (num > 0.001f)
			{
				zero.x = num;
			}
		}
		if (vertical)
		{
			vector.y += delta.y;
			vector2.y += delta.y;
			float num3 = viewBounds.max.y - vector2.y;
			float num4 = viewBounds.min.y - vector.y;
			if (num3 > 0.001f)
			{
				zero.y = num3;
			}
			else if (num4 < -0.001f)
			{
				zero.y = num4;
			}
		}
		return zero;
	}

	protected void SetDirty()
	{
		if (IsActive())
		{
			LayoutRebuilder.MarkLayoutForRebuild(rectTransform);
		}
	}

	protected void SetDirtyCaching()
	{
		if (IsActive())
		{
			CanvasUpdateRegistry.RegisterCanvasElementForLayoutRebuild(this);
			LayoutRebuilder.MarkLayoutForRebuild(rectTransform);
		}
	}
}
