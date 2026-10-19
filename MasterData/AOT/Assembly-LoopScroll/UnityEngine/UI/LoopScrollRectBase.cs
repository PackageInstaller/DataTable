using System;
using System.Collections;
using System.Collections.Generic;
using ThirdParties.LoopScrollTools.Runtime;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.Pool;

namespace UnityEngine.UI;

[AddComponentMenu("")]
[DisallowMultipleComponent]
[RequireComponent(typeof(RectTransform))]
public abstract class LoopScrollRectBase : UIBehaviour, IInitializePotentialDragHandler, IEventSystemHandler, IBeginDragHandler, IEndDragHandler, IDragHandler, IScrollHandler, ICanvasElement, ILayoutElement, ILayoutGroup, ILayoutController
{
	public enum LoopScrollRectDirection
	{
		Vertical,
		Horizontal
	}

	public enum ReachBoundDirection
	{
		Up,
		Down,
		Left,
		Right
	}

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

	[NonSerialized]
	[HideInInspector]
	public LoopScrollPrefabSource prefabSource;

	[Tooltip("Total count, negative means INFINITE mode")]
	public int totalCount;

	[NonSerialized]
	[HideInInspector]
	public LoopScrollSizeHelper sizeHelper;

	protected float threshold;

	[Tooltip("Reverse direction for dragging")]
	public bool reverseDirection;

	[Tooltip("Scroll Group")]
	public LoopScrollGroup group;

	[Tooltip("Extend ViewPort Bound")]
	public Vector3 viewPortExtends;

	public UnityEvent<int> BeforeItemGet;

	public UnityEvent<ILoopScrollDataSource> OnItemLoad;

	public UnityEvent<ILoopScrollDataSource> OnItemUnload;

	public UnityEvent<ILoopScrollDataSource> OnItemShow;

	public UnityEvent<ILoopScrollDataSource> OnItemHide;

	public UnityEvent<ILoopScrollDataSource, ReachBoundDirection> OnItemReachBound;

	public UnityEvent<ILoopScrollDataSource, ReachBoundDirection, bool> OnItemCenterReachBound;

	protected int itemTypeStart;

	protected int itemTypeEnd;

	protected LoopScrollRectDirection direction = LoopScrollRectDirection.Horizontal;

	private bool m_ContentSpaceInit;

	private float m_ContentSpacing;

	protected float m_ContentLeftPadding;

	protected float m_ContentRightPadding;

	protected float m_ContentTopPadding;

	protected float m_ContentBottomPadding;

	protected GridLayoutGroup m_GridLayout;

	protected ILoopScrollDataSource m_LastReachBoundItem;

	protected ILoopScrollDataSource m_LastReachBoundItemEnd;

	protected ILoopScrollDataSource m_LastCenterReachBoundItem;

	protected ILoopScrollDataSource m_LastCenterReachBoundItemEnd;

	protected bool m_LastCenterInsideStart;

	protected bool m_LastCenterInsideEnd;

	protected Camera m_UICamera;

	protected bool m_ContentConstraintCountInit;

	protected int m_ContentConstraintCount;

	protected GridLayoutGroup.Constraint m_CachedConstraint;

	[SerializeField]
	protected RectTransform m_Content;

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

	[SerializeField]
	private ScrollRectEvent m_OnVerticalStop = new ScrollRectEvent();

	[SerializeField]
	private ScrollRectEvent m_OnHorizontalStop = new ScrollRectEvent();

	public float verticalTriggerSpeed;

	public float horizontalTriggerSpeed;

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

	private int m_LayoutDirtyVersion;

	private int m_LastEnsuredLayoutVersion = -1;

	private int m_LastBoundsUpdateFrame = -1;

	private bool m_LastBoundsUpdateWithItems;

	private Vector2 m_LastBoundsUpdateContentPosition;

	private Rect m_LastBoundsUpdateViewRect;

	private Rect m_LastBoundsUpdateContentRect;

	private int m_LastBoundsUpdateItemStart;

	private int m_LastBoundsUpdateItemEnd;

	private int m_LastBoundsUpdateCachedRectCount;

	private bool m_HSliderExpand;

	private bool m_VSliderExpand;

	private float m_HSliderHeight;

	private float m_VSliderWidth;

	[NonSerialized]
	private RectTransform m_Rect;

	private RectTransform m_HorizontalScrollbarRect;

	private RectTransform m_VerticalScrollbarRect;

	protected List<RectTransform> m_CachedAvailableRect;

	private DrivenRectTransformTracker m_Tracker;

	protected int deletedItemTypeStart;

	protected int deletedItemTypeEnd;

	private int m_StableTempPoolReuseDepth;

	private int m_StableReuseOldItemTypeStart;

	private readonly Vector3[] m_Corners = new Vector3[4];

	public int ItemIndexStart => itemTypeStart;

	public int ItemIndexEnd => itemTypeEnd;

	public LoopScrollRectDirection Direction => direction;

	protected float contentSpacing
	{
		get
		{
			if (m_ContentSpaceInit)
			{
				return m_ContentSpacing;
			}
			m_ContentSpaceInit = true;
			m_ContentSpacing = 0f;
			if (m_Content != null)
			{
				HorizontalOrVerticalLayoutGroup component = m_Content.GetComponent<HorizontalOrVerticalLayoutGroup>();
				if (component != null)
				{
					m_ContentSpacing = component.spacing;
					m_ContentLeftPadding = component.padding.left;
					m_ContentRightPadding = component.padding.right;
					m_ContentTopPadding = component.padding.top;
					m_ContentBottomPadding = component.padding.bottom;
				}
				m_GridLayout = m_Content.GetComponent<GridLayoutGroup>();
				if (m_GridLayout != null)
				{
					m_ContentSpacing = GetAbsDimension(m_GridLayout.spacing);
					m_ContentLeftPadding = m_GridLayout.padding.left;
					m_ContentRightPadding = m_GridLayout.padding.right;
					m_ContentTopPadding = m_GridLayout.padding.top;
					m_ContentBottomPadding = m_GridLayout.padding.bottom;
				}
			}
			return m_ContentSpacing;
		}
	}

	public int contentConstraintCount
	{
		get
		{
			if (m_ContentConstraintCountInit)
			{
				return m_ContentConstraintCount;
			}
			m_ContentConstraintCountInit = true;
			m_ContentConstraintCount = 1;
			if (m_Content != null)
			{
				GridLayoutGroup component = m_Content.GetComponent<GridLayoutGroup>();
				if (component != null)
				{
					m_CachedConstraint = component.constraint;
					if (component.constraint == GridLayoutGroup.Constraint.Flexible)
					{
						if (this is LoopVerticalScrollRect || this is LoopVerticalScrollRectMulti)
						{
							int num = Mathf.FloorToInt((m_Content.rect.width + component.spacing.x) / (component.cellSize.x + component.spacing.x));
							component.constraint = GridLayoutGroup.Constraint.FixedColumnCount;
							component.constraintCount = num;
							SetConstraint(num);
							Debug.LogWarning($"[LoopScrollRect] unsupported GridLayoutGroup Flexible!Change Layout To FixedColumn {num}");
						}
						else
						{
							int num2 = Mathf.FloorToInt((m_Content.rect.height + component.spacing.y) / (component.cellSize.y + component.spacing.y));
							component.constraint = GridLayoutGroup.Constraint.FixedRowCount;
							component.constraintCount = num2;
							SetConstraint(num2);
							Debug.LogWarning($"[LoopScrollRect] unsupported GridLayoutGroup Flexible!Change Layout To FixedRow {num2}");
						}
					}
					else
					{
						SetConstraint(component.constraintCount);
					}
				}
			}
			return m_ContentConstraintCount;
		}
	}

	public int StartLine => Mathf.CeilToInt((float)itemTypeStart / (float)contentConstraintCount);

	public int EndLine => Mathf.CeilToInt((float)itemTypeEnd / (float)contentConstraintCount);

	protected int CurrentLines => Mathf.CeilToInt((float)(itemTypeEnd - itemTypeStart) / (float)contentConstraintCount);

	protected int TotalLines => Mathf.CeilToInt((float)totalCount / (float)contentConstraintCount);

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

	public ScrollRectEvent onVerticalStop
	{
		get
		{
			return m_OnVerticalStop;
		}
		set
		{
			m_OnVerticalStop = value;
		}
	}

	public ScrollRectEvent onHorizontalStop
	{
		get
		{
			return m_OnHorizontalStop;
		}
		set
		{
			m_OnHorizontalStop = value;
		}
	}

	public IReadOnlyList<RectTransform> Children => m_CachedAvailableRect;

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
				m_ViewRect = (RectTransform)transform;
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

	public Vector2 ScrollToCellCoroutineSpeed { get; private set; }

	protected bool IsStableTempPoolReuse => m_StableTempPoolReuseDepth > 0;

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
			if (totalCount > 0 && itemTypeEnd > itemTypeStart)
			{
				GetHorizonalOffsetAndSize(out var totalSize, out var offset);
				if (totalSize <= m_ViewBounds.size.x)
				{
					return (m_ViewBounds.min.x > offset) ? 1 : 0;
				}
				return (m_ViewBounds.min.x - offset) / (totalSize - m_ViewBounds.size.x);
			}
			return 0.5f;
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
			if (totalCount > 0 && itemTypeEnd > itemTypeStart)
			{
				GetVerticalOffsetAndSize(out var totalSize, out var offset);
				float num = offset - totalSize;
				if (totalSize <= m_ViewBounds.size.y)
				{
					return (m_ViewBounds.min.y > num) ? 1 : 0;
				}
				return (m_ViewBounds.min.y - num) / (totalSize - m_ViewBounds.size.y);
			}
			return 0.5f;
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

	protected abstract float GetSize(RectTransform item, bool includeSpacing = true);

	protected abstract float GetDimension(Vector2 vector);

	protected abstract float GetAbsDimension(Vector2 vector);

	protected abstract Vector2 GetVector(float value);

	public void ForceUpdateConstraint()
	{
		if (m_Content == null)
		{
			return;
		}
		GridLayoutGroup component = m_Content.GetComponent<GridLayoutGroup>();
		if (m_CachedConstraint == GridLayoutGroup.Constraint.Flexible && (bool)component)
		{
			if (this is LoopVerticalScrollRect || this is LoopVerticalScrollRectMulti)
			{
				int num = Mathf.FloorToInt((m_Content.rect.width + component.spacing.x) / (component.cellSize.x + component.spacing.x));
				component.constraint = GridLayoutGroup.Constraint.FixedColumnCount;
				component.constraintCount = num;
				SetConstraint(num);
			}
			else
			{
				int num2 = Mathf.FloorToInt((m_Content.rect.height + component.spacing.y) / (component.cellSize.y + component.spacing.y));
				component.constraint = GridLayoutGroup.Constraint.FixedRowCount;
				component.constraintCount = num2;
				SetConstraint(num2);
			}
		}
	}

	protected void SetConstraint(int constraint)
	{
		m_ContentConstraintCountInit = true;
		m_ContentConstraintCount = constraint;
	}

	protected virtual bool UpdateItems(ref Bounds viewBounds, ref Bounds contentBounds)
	{
		return false;
	}

	protected override void Awake()
	{
		base.Awake();
		if (Application.isPlaying)
		{
			m_UICamera = GameObject.FindGameObjectWithTag("UICamera")?.GetComponent<Camera>();
			if (m_CachedAvailableRect == null)
			{
				m_CachedAvailableRect = CollectionPool<List<RectTransform>, RectTransform>.Get();
			}
			if ((bool)group)
			{
				group.RegisterRect(this);
			}
		}
	}

	protected override void OnDestroy()
	{
		if ((bool)group)
		{
			group.UnRegisterRect(this);
		}
		if (m_CachedAvailableRect != null)
		{
			m_CachedAvailableRect.Clear();
			CollectionPool<List<RectTransform>, RectTransform>.Release(m_CachedAvailableRect);
		}
		m_CachedAvailableRect = null;
		base.OnDestroy();
	}

	protected void ResetVisibleCellRange()
	{
		itemTypeStart = 0;
		itemTypeEnd = 0;
		totalCount = 0;
		deletedItemTypeStart = 0;
		deletedItemTypeEnd = 0;
	}

	protected void ResetReachBoundItemCache()
	{
		m_LastReachBoundItem = null;
		m_LastReachBoundItemEnd = null;
		m_LastCenterReachBoundItem = null;
		m_LastCenterReachBoundItemEnd = null;
		m_LastCenterInsideStart = false;
		m_LastCenterInsideEnd = false;
	}

	protected void DetachCellFromContent(Transform trans)
	{
		if (!trans || !trans.gameObject || !this || !transform)
		{
			return;
		}
		LayoutElement component = trans.GetComponent<LayoutElement>();
		CanvasGroup component2 = trans.GetComponent<CanvasGroup>();
		if ((bool)component2)
		{
			component2.alpha = 0f;
			component2.interactable = false;
			component2.blocksRaycasts = false;
			if ((bool)component)
			{
				component.ignoreLayout = true;
			}
		}
		else
		{
			trans.SetParent(transform, worldPositionStays: false);
		}
		if (trans.GetSiblingIndex() != 0)
		{
			trans.SetSiblingIndex(-999);
		}
		if (trans is RectTransform item)
		{
			m_CachedAvailableRect?.Remove(item);
		}
	}

	protected void NotifyCellHidden(ILoopScrollDataSource source)
	{
		if (source != null)
		{
			OnItemHide?.Invoke(source);
			source.OnHide();
		}
	}

	protected void NotifyCellUnloaded(ILoopScrollDataSource source)
	{
		if (source != null)
		{
			source.OnUnLoad();
			OnItemUnload?.Invoke(source);
		}
	}

	protected void RecycleAllCachedCells(bool unload = false)
	{
		if (m_CachedAvailableRect == null)
		{
			return;
		}
		for (int num = m_CachedAvailableRect.Count - 1; num >= 0; num--)
		{
			RectTransform rectTransform = m_CachedAvailableRect[num];
			if ((bool)rectTransform && (bool)rectTransform.gameObject)
			{
				ReturnObject(rectTransform.gameObject, unload);
			}
		}
	}

	public void ClearCells()
	{
		if (Application.isPlaying)
		{
			ResetVisibleCellRange();
			ResetReachBoundItemCache();
			RecycleAllCachedCells();
		}
	}

	public int GetFirstItem(out float offset)
	{
		if (direction == LoopScrollRectDirection.Vertical)
		{
			offset = m_ViewBounds.max.y - m_ContentBounds.max.y;
		}
		else
		{
			offset = m_ContentBounds.min.x - m_ViewBounds.min.x;
		}
		int num = 0;
		if (itemTypeEnd > itemTypeStart)
		{
			float size = GetSize(m_CachedAvailableRect[0], includeSpacing: false);
			while (size + offset <= 0f && itemTypeStart + num + contentConstraintCount < itemTypeEnd)
			{
				offset += size;
				num += contentConstraintCount;
				size = GetSize(m_CachedAvailableRect[num]);
			}
		}
		return num + itemTypeStart;
	}

	public int GetLastItem(out float offset)
	{
		if (direction == LoopScrollRectDirection.Vertical)
		{
			offset = m_ContentBounds.min.y - m_ViewBounds.min.y;
		}
		else
		{
			offset = m_ViewBounds.max.x - m_ContentBounds.max.x;
		}
		int num = 0;
		if (itemTypeEnd > itemTypeStart)
		{
			int count = m_CachedAvailableRect.Count;
			float size = GetSize(m_CachedAvailableRect[count - num - 1], includeSpacing: false);
			while (size + offset <= 0f && itemTypeStart < itemTypeEnd - num - contentConstraintCount)
			{
				offset += size;
				num += contentConstraintCount;
				size = GetSize(m_CachedAvailableRect[count - num - 1]);
			}
		}
		offset = 0f - offset;
		return itemTypeEnd - num - 1;
	}

	public LoopScrollAsyncOperation ScrollToCell(int index, float speed)
	{
		if (totalCount >= 0 && (index < 0 || index >= totalCount))
		{
			Debug.LogErrorFormat("invalid index {0}", index);
			return null;
		}
		StopAllCoroutines();
		if (speed <= 0f)
		{
			RefillCells(index);
			return null;
		}
		LoopScrollAsyncOperation loopScrollAsyncOperation = LoopScrollAsyncOperation.LoopScrollAsyncOperationPool.Get();
		StartCoroutine(ScrollToCellCoroutine(index, speed, loopScrollAsyncOperation));
		return loopScrollAsyncOperation;
	}

	public LoopScrollAsyncOperation ScrollToCellWithinTime(int index, float time)
	{
		if (totalCount >= 0 && (index < 0 || index >= totalCount))
		{
			Debug.LogErrorFormat("invalid index {0}", index);
			return null;
		}
		StopAllCoroutines();
		if (time <= 0f)
		{
			RefillCells(index);
			return null;
		}
		float num = 0f;
		float offset = 0f;
		int num2 = (reverseDirection ? GetLastItem(out offset) : GetFirstItem(out offset));
		int num3 = index / contentConstraintCount;
		int num4 = num2 / contentConstraintCount;
		if (num3 == num4)
		{
			num = offset;
		}
		else if (sizeHelper != null)
		{
			num = GetDimension(sizeHelper.GetItemsSize(num2) - sizeHelper.GetItemsSize(index)) + contentSpacing * (float)(num4 - num3 - 1);
			num += offset;
		}
		else
		{
			num = (GetAbsDimension(m_ContentBounds.size) - contentSpacing * (float)(CurrentLines - 1)) / (float)CurrentLines * (float)(num4 - num3) + contentSpacing * (float)(num4 - num3 - 1);
			num -= offset;
		}
		LoopScrollAsyncOperation loopScrollAsyncOperation = LoopScrollAsyncOperation.LoopScrollAsyncOperationPool.Get();
		StartCoroutine(ScrollToCellCoroutine(index, Mathf.Abs(num) / time, loopScrollAsyncOperation));
		return loopScrollAsyncOperation;
	}

	private IEnumerator ScrollToCellCoroutine(int index, float speed, LoopScrollAsyncOperation asyncOperation)
	{
		bool needMoving = true;
		while (needMoving)
		{
			yield return null;
			if (m_Dragging)
			{
				continue;
			}
			float num;
			if (index < itemTypeStart)
			{
				num = (0f - Time.deltaTime) * speed;
			}
			else if (index >= itemTypeEnd)
			{
				num = Time.deltaTime * speed;
			}
			else
			{
				m_ViewBounds = new Bounds(viewRect.rect.center, viewRect.rect.size);
				Bounds bounds4Item = GetBounds4Item(index);
				float num2;
				if (direction != LoopScrollRectDirection.Vertical)
				{
					num2 = (reverseDirection ? (bounds4Item.max.x - m_ViewBounds.max.x) : (bounds4Item.min.x - m_ViewBounds.min.x));
				}
				else
				{
					num2 = (reverseDirection ? (m_ViewBounds.min.y - bounds4Item.min.y) : (m_ViewBounds.max.y - bounds4Item.max.y));
				}
				if (totalCount >= 0)
				{
					if (num2 > 0f && itemTypeEnd == totalCount && !reverseDirection)
					{
						bounds4Item = GetBounds4Item(totalCount - 1);
						if ((direction == LoopScrollRectDirection.Vertical && bounds4Item.min.y > m_ViewBounds.min.y) || (direction == LoopScrollRectDirection.Horizontal && bounds4Item.max.x < m_ViewBounds.max.x))
						{
							break;
						}
					}
					else if (num2 < 0f && itemTypeStart == 0 && reverseDirection)
					{
						bounds4Item = GetBounds4Item(0);
						if ((direction == LoopScrollRectDirection.Vertical && bounds4Item.max.y < m_ViewBounds.max.y) || (direction == LoopScrollRectDirection.Horizontal && bounds4Item.min.x > m_ViewBounds.min.x))
						{
							break;
						}
					}
				}
				float num3 = Time.deltaTime * speed;
				if (Mathf.Abs(num2) < num3)
				{
					needMoving = false;
					num = num2;
				}
				else
				{
					num = Mathf.Sign(num2) * num3;
				}
			}
			if (num != 0f)
			{
				Vector2 vector = GetVector(num);
				m_Content.anchoredPosition += vector;
				m_PrevPosition += vector;
				m_ContentStartPosition += vector;
				ScrollToCellCoroutineSpeed = vector;
				UpdateBounds(updateItems: true);
			}
		}
		StopMovement();
		UpdatePrevData();
		asyncOperation.OnComplete();
	}

	protected abstract void ProvideData(ILoopScrollDataSource transform, int index);

	protected abstract void OnItemLoaded(ILoopScrollDataSource transform, int index);

	protected abstract void OnItemUnLoaded(ILoopScrollDataSource transform, int index);

	public void RefreshCells()
	{
		if (!Application.isPlaying || !isActiveAndEnabled)
		{
			return;
		}
		itemTypeEnd = itemTypeStart;
		for (int i = 0; i < m_CachedAvailableRect.Count; i++)
		{
			if (itemTypeEnd < totalCount)
			{
				ProvideData(m_CachedAvailableRect[i].GetComponent<ILoopScrollDataSource>(), itemTypeEnd);
				itemTypeEnd++;
			}
			else
			{
				ReturnObject(m_CachedAvailableRect[i].gameObject);
				i--;
			}
		}
		UpdateBounds(updateItems: true);
		UpdateScrollbars(Vector2.zero);
	}

	public void RefillCellsFromEnd(int endItem = 0, bool alignStart = false)
	{
		if (!Application.isPlaying)
		{
			return;
		}
		m_StableTempPoolReuseDepth++;
		try
		{
			RefillCellsFromEndInternal(endItem, alignStart);
		}
		finally
		{
			m_StableTempPoolReuseDepth--;
		}
	}

	private void RefillCellsFromEndInternal(int endItem, bool alignStart)
	{
		m_StableReuseOldItemTypeStart = itemTypeStart;
		itemTypeEnd = (reverseDirection ? endItem : (totalCount - endItem));
		itemTypeStart = itemTypeEnd;
		if (totalCount >= 0 && itemTypeStart % contentConstraintCount != 0)
		{
			itemTypeStart = itemTypeStart / contentConstraintCount * contentConstraintCount;
		}
		ReturnToTempPool(!reverseDirection, m_CachedAvailableRect.Count);
		float absDimension = GetAbsDimension(viewRect.rect.size);
		float num = 0f;
		bool flag = true;
		float num2;
		for (; absDimension > num; num += num2)
		{
			num2 = (reverseDirection ? NewItemAtEnd(!flag) : NewItemAtStart(!flag));
			if (num2 < 0f)
			{
				break;
			}
			flag = false;
		}
		float num3;
		for (; absDimension > num; num += num3)
		{
			num3 = (reverseDirection ? NewItemAtStart(!flag) : NewItemAtEnd(!flag));
			if (num3 < 0f)
			{
				break;
			}
			flag = false;
		}
		Vector2 anchoredPosition = m_Content.anchoredPosition;
		float num4 = (alignStart ? 0f : Mathf.Max(0f, num - absDimension));
		if (reverseDirection)
		{
			num4 = 0f - num4;
		}
		if (direction == LoopScrollRectDirection.Vertical)
		{
			anchoredPosition.y = num4;
		}
		else
		{
			anchoredPosition.x = 0f - num4;
		}
		m_Content.anchoredPosition = anchoredPosition;
		m_ContentStartPosition = anchoredPosition;
		ClearTempPool();
		LayoutRebuilder.ForceRebuildLayoutImmediate(m_Content);
		Canvas.ForceUpdateCanvases();
		MarkLayoutRebuilt();
		UpdateBounds();
		UpdateScrollbars(Vector2.zero);
		StopMovement();
		UpdatePrevData();
	}

	public void RefillCells(int startItem = 0, bool fillViewRect = false, float contentOffset = 0f)
	{
		if (!Application.isPlaying)
		{
			return;
		}
		m_StableTempPoolReuseDepth++;
		try
		{
			RefillCellsInternal(startItem, fillViewRect, contentOffset);
		}
		finally
		{
			m_StableTempPoolReuseDepth--;
		}
	}

	private void RefillCellsInternal(int startItem, bool fillViewRect, float contentOffset)
	{
		if (m_CachedAvailableRect == null)
		{
			m_CachedAvailableRect = CollectionPool<List<RectTransform>, RectTransform>.Get();
		}
		m_ContentSpaceInit = false;
		m_ContentConstraintCountInit = false;
		ResetReachBoundItemCache();
		m_StableReuseOldItemTypeStart = itemTypeStart;
		itemTypeStart = (reverseDirection ? (totalCount - startItem) : startItem);
		if (totalCount >= 0 && itemTypeStart % contentConstraintCount != 0)
		{
			itemTypeStart = itemTypeStart / contentConstraintCount * contentConstraintCount;
		}
		itemTypeEnd = itemTypeStart;
		ReturnToTempPool(reverseDirection, m_CachedAvailableRect.Count);
		float num = GetAbsDimension(viewRect.rect.size) + Mathf.Abs(contentOffset);
		float num2 = 0f;
		float num3 = 0f;
		bool flag = true;
		bool flag2 = false;
		float num4;
		for (; num > num2; num2 += num4)
		{
			num4 = (reverseDirection ? NewItemAtStart(!flag) : NewItemAtEnd(!flag));
			if (num4 < 0f)
			{
				break;
			}
			flag = false;
			num3 = num4;
		}
		float num5;
		for (; num > num2; num2 += num5)
		{
			num5 = (reverseDirection ? NewItemAtEnd(!flag) : NewItemAtStart(!flag));
			if (num5 < 0f)
			{
				break;
			}
			flag2 = true;
			flag = false;
		}
		if (fillViewRect && num3 > 0f && num2 < num)
		{
			int num6 = (int)((num - num2) / num3);
			int num7 = startItem - num6;
			if (num7 < 0)
			{
				num7 = 0;
			}
			if (num7 != startItem)
			{
				RefillCells(num7);
			}
		}
		Vector2 anchoredPosition = m_Content.anchoredPosition;
		if (direction == LoopScrollRectDirection.Vertical)
		{
			anchoredPosition.y = 0f - contentOffset;
		}
		else
		{
			anchoredPosition.x = contentOffset;
		}
		m_Content.anchoredPosition = anchoredPosition;
		m_ContentStartPosition = anchoredPosition;
		ClearTempPool();
		LayoutRebuilder.ForceRebuildLayoutImmediate(m_Content);
		Canvas.ForceUpdateCanvases();
		MarkLayoutRebuilt();
		if (flag2)
		{
			if (!reverseDirection)
			{
				MoveToEnd();
			}
			else
			{
				MoveToStart();
			}
		}
		UpdateBounds();
		UpdateScrollbarVisibility();
		UpdateScrollbars(Vector2.zero);
		StopMovement();
		UpdatePrevData();
	}

	protected float NewItemAtStart(bool includeSpacing = true)
	{
		if (totalCount >= 0 && itemTypeStart - contentConstraintCount < 0)
		{
			return -1f;
		}
		float num = 0f;
		for (int i = 0; i < contentConstraintCount; i++)
		{
			itemTypeStart--;
			RectTransform fromTempPool = GetFromTempPool(itemTypeStart);
			SetSiblingIndexAndSync(fromTempPool.transform, deletedItemTypeStart);
			num = Mathf.Max(GetSize(fromTempPool, includeSpacing), num);
		}
		threshold = Mathf.Max(threshold, num);
		if (num > 0f)
		{
			MarkLayoutRebuildRequired();
			if (!reverseDirection)
			{
				Vector2 vector = GetVector(num);
				m_Content.anchoredPosition += vector;
				m_PrevPosition += vector;
				m_ContentStartPosition += vector;
			}
		}
		return num;
	}

	protected float DeleteItemAtStart()
	{
		if ((m_Dragging || m_Velocity != Vector2.zero) && totalCount >= 0 && itemTypeEnd >= totalCount - contentConstraintCount)
		{
			return 0f;
		}
		int num = m_CachedAvailableRect.Count - deletedItemTypeStart - deletedItemTypeEnd;
		if (num == 0)
		{
			return 0f;
		}
		float num2 = 0f;
		for (int i = 0; i < contentConstraintCount; i++)
		{
			RectTransform item = m_CachedAvailableRect[deletedItemTypeStart];
			num2 = Mathf.Max(GetSize(item), num2);
			ReturnToTempPool(fromStart: true);
			num--;
			itemTypeStart++;
			if (num == 0)
			{
				break;
			}
		}
		if (num2 > 0f)
		{
			MarkLayoutRebuildRequired();
			if (!reverseDirection)
			{
				Vector2 vector = GetVector(num2);
				m_Content.anchoredPosition -= vector;
				m_PrevPosition -= vector;
				m_ContentStartPosition -= vector;
			}
		}
		return num2;
	}

	protected float NewItemAtEnd(bool includeSpacing = true)
	{
		if (totalCount >= 0 && itemTypeEnd >= totalCount)
		{
			return -1f;
		}
		float num = 0f;
		int num2 = m_CachedAvailableRect.Count - deletedItemTypeStart - deletedItemTypeEnd;
		int num3 = contentConstraintCount - num2 % contentConstraintCount;
		for (int i = 0; i < num3; i++)
		{
			RectTransform fromTempPool = GetFromTempPool(itemTypeEnd);
			SetSiblingIndexAndSync(fromTempPool.transform, m_CachedAvailableRect.Count - deletedItemTypeEnd - 1);
			num = Mathf.Max(GetSize(fromTempPool, includeSpacing), num);
			itemTypeEnd++;
			if (totalCount >= 0 && itemTypeEnd >= totalCount)
			{
				break;
			}
		}
		threshold = Mathf.Max(threshold, num);
		if (num > 0f)
		{
			MarkLayoutRebuildRequired();
			if (reverseDirection)
			{
				Vector2 vector = GetVector(num);
				m_Content.anchoredPosition -= vector;
				m_PrevPosition -= vector;
				m_ContentStartPosition -= vector;
			}
		}
		return num;
	}

	protected float DeleteItemAtEnd()
	{
		if ((m_Dragging || m_Velocity != Vector2.zero) && totalCount >= 0 && itemTypeStart < contentConstraintCount)
		{
			return 0f;
		}
		int num = m_CachedAvailableRect.Count - deletedItemTypeStart - deletedItemTypeEnd;
		if (num == 0)
		{
			return 0f;
		}
		float num2 = 0f;
		for (int i = 0; i < contentConstraintCount; i++)
		{
			RectTransform item = m_CachedAvailableRect[m_CachedAvailableRect.Count - deletedItemTypeEnd - 1];
			num2 = Mathf.Max(GetSize(item), num2);
			ReturnToTempPool(fromStart: false);
			num--;
			itemTypeEnd--;
			if (itemTypeEnd % contentConstraintCount == 0 || num == 0)
			{
				break;
			}
		}
		if (num2 > 0f)
		{
			MarkLayoutRebuildRequired();
			if (reverseDirection)
			{
				Vector2 vector = GetVector(num2);
				m_Content.anchoredPosition += vector;
				m_PrevPosition += vector;
				m_ContentStartPosition += vector;
			}
		}
		return num2;
	}

	protected int GetStableTempPoolIndex(int itemIdx, bool fromStart)
	{
		int num = ((m_CachedAvailableRect != null) ? m_CachedAvailableRect.Count : 0);
		if (num <= 0)
		{
			return 0;
		}
		int num2 = itemIdx - m_StableReuseOldItemTypeStart;
		if (fromStart)
		{
			int num3 = Mathf.Min(deletedItemTypeStart + 1, num);
			if (num2 >= 0 && num2 < num3)
			{
				return num2;
			}
			return Mathf.Clamp(deletedItemTypeStart, 0, num - 1);
		}
		int num4 = Mathf.Max(0, num - deletedItemTypeEnd - 1);
		if (num2 >= num4 && num2 < num)
		{
			return num2;
		}
		return num4;
	}

	protected abstract RectTransform GetFromTempPool(int itemIdx);

	protected abstract void ReturnToTempPool(bool fromStart, int count = 1);

	protected abstract void ClearTempPool();

	protected abstract void ReturnObject(GameObject loopScrollBaseItem);

	protected virtual void ReturnObject(GameObject loopScrollBaseItem, bool unload)
	{
		ReturnObject(loopScrollBaseItem);
	}

	[Obsolete("SrollToCell(int, float) has been renamed to ScrollToCell(int, float).")]
	public void SrollToCell(int index, float speed)
	{
		ScrollToCell(index, speed);
	}

	[Obsolete("SrollToCellWithinTime(int, float) has been renamed to ScrollToCellWithinTime(int, float).")]
	public void SrollToCellWithinTime(int index, float time)
	{
		ScrollToCellWithinTime(index, time);
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
			MarkLayoutRebuilt();
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
		bool flag = viewRect.parent == transform;
		bool flag2 = !m_HorizontalScrollbarRect || m_HorizontalScrollbarRect.parent == transform;
		bool flag3 = !m_VerticalScrollbarRect || m_VerticalScrollbarRect.parent == transform;
		bool flag4 = flag & flag2 & flag3;
		m_HSliderExpand = flag4 && (bool)m_HorizontalScrollbarRect && horizontalScrollbarVisibility == ScrollbarVisibility.AutoHideAndExpandViewport;
		m_VSliderExpand = flag4 && (bool)m_VerticalScrollbarRect && verticalScrollbarVisibility == ScrollbarVisibility.AutoHideAndExpandViewport;
		m_HSliderHeight = ((m_HorizontalScrollbarRect == null) ? 0f : m_HorizontalScrollbarRect.rect.height);
		m_VSliderWidth = ((m_VerticalScrollbarRect == null) ? 0f : m_VerticalScrollbarRect.rect.width);
	}

	private void MoveToStart()
	{
		if (!(m_Content == null) && m_CachedAvailableRect != null && m_CachedAvailableRect.Count != 0)
		{
			RectTransform rectTransform = viewRect;
			RectTransform rectTransform2 = content;
			Vector2 zero = Vector2.zero;
			if (direction == LoopScrollRectDirection.Vertical)
			{
				zero.y = rectTransform.rect.yMax - rectTransform2.rect.yMax;
			}
			else
			{
				zero.x = rectTransform.rect.xMin - rectTransform2.rect.xMin;
			}
			m_Content.anchoredPosition += zero;
			m_ContentStartPosition += zero;
		}
	}

	private void MoveToEnd()
	{
		if (!(m_Content == null) && m_CachedAvailableRect != null && m_CachedAvailableRect.Count != 0)
		{
			RectTransform rectTransform = viewRect;
			RectTransform rectTransform2 = content;
			Vector2 zero = Vector2.zero;
			if (direction == LoopScrollRectDirection.Vertical)
			{
				zero.y = rectTransform.rect.yMin - rectTransform2.rect.yMin;
			}
			else
			{
				zero.x = rectTransform.rect.xMax - rectTransform2.rect.xMax;
			}
			m_Content.anchoredPosition += zero;
			m_ContentStartPosition += zero;
		}
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
		MarkLayoutRebuildRequired();
		m_Tracker.Clear();
		m_Velocity = Vector2.zero;
		m_ContentConstraintCountInit = false;
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
		if (!m_HasRebuiltLayout && !CanvasUpdateRegistry.IsRebuildingLayout() && m_LastEnsuredLayoutVersion != m_LayoutDirtyVersion)
		{
			if (m_Content != null)
			{
				LayoutRebuilder.ForceRebuildLayoutImmediate(m_Content);
			}
			else
			{
				Canvas.ForceUpdateCanvases();
			}
			MarkLayoutRebuilt();
		}
	}

	private void MarkLayoutRebuildRequired()
	{
		m_HasRebuiltLayout = false;
		m_LayoutDirtyVersion++;
	}

	private void MarkLayoutRebuilt()
	{
		m_HasRebuiltLayout = true;
		m_LastEnsuredLayoutVersion = m_LayoutDirtyVersion;
	}

	public virtual void StopMovement()
	{
		ScrollToCellCoroutineSpeed = (m_Velocity = Vector2.zero);
	}

	public virtual void OnScroll(PointerEventData data)
	{
		ScrollScrollView(data);
	}

	public void ScrollScrollView(PointerEventData data)
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
		if ((bool)group)
		{
			group.OnInitializePotentialDrag(eventData);
		}
		else
		{
			InitializePotentialDragScrollView(eventData);
		}
	}

	public void InitializePotentialDragScrollView(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			m_Velocity = Vector2.zero;
			ResetReachBoundItemCache();
		}
	}

	public virtual void OnBeginDrag(PointerEventData eventData)
	{
		if ((bool)group)
		{
			group.OnBeginDrag(eventData);
		}
		else
		{
			BeginDragScrollView(eventData);
		}
	}

	public void BeginDragScrollView(PointerEventData eventData)
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
		if ((bool)group)
		{
			group.OnEndDrag(eventData);
		}
		else
		{
			EndDragScrollView(eventData);
		}
	}

	public void EndDragScrollView(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			m_Dragging = false;
		}
	}

	public virtual void OnDrag(PointerEventData eventData)
	{
		if ((bool)group)
		{
			group.OnDrag(eventData);
		}
		else
		{
			DragScrollView(eventData);
		}
	}

	public void DragScrollView(PointerEventData eventData)
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

	public bool CanDrag(int num)
	{
		return totalCount > num;
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
		if ((position - m_Content.anchoredPosition).sqrMagnitude > Mathf.Epsilon)
		{
			m_Content.anchoredPosition = position;
			UpdateBounds(updateItems: true);
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
					anchoredPosition[i] += m_Velocity[i] * unscaledDeltaTime;
				}
				else
				{
					m_Velocity[i] = 0f;
				}
				if (i == 0)
				{
					if (Mathf.Abs(m_Velocity[i]) <= horizontalTriggerSpeed)
					{
						m_OnHorizontalStop.Invoke(m_Velocity);
					}
				}
				else if (Mathf.Abs(m_Velocity[i]) <= verticalTriggerSpeed)
				{
					m_OnVerticalStop.Invoke(m_Velocity);
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

	public void GetHorizonalOffsetAndSize(out float totalSize, out float offset)
	{
		if (sizeHelper != null)
		{
			totalSize = sizeHelper.GetItemsSize(TotalLines).x + contentSpacing * (float)(TotalLines - 1);
			offset = m_ContentBounds.min.x - sizeHelper.GetItemsSize(StartLine).x - contentSpacing * (float)StartLine;
		}
		else
		{
			float num = (m_ContentBounds.size.x - contentSpacing * (float)(CurrentLines - 1)) / (float)CurrentLines;
			totalSize = num * (float)TotalLines + contentSpacing * (float)(TotalLines - 1);
			offset = m_ContentBounds.min.x - num * (float)StartLine - contentSpacing * (float)StartLine;
		}
	}

	public void GetVerticalOffsetAndSize(out float totalSize, out float offset)
	{
		if (sizeHelper != null)
		{
			totalSize = sizeHelper.GetItemsSize(TotalLines).y + contentSpacing * (float)(TotalLines - 1);
			offset = m_ContentBounds.max.y + sizeHelper.GetItemsSize(StartLine).y + contentSpacing * (float)StartLine;
		}
		else
		{
			float num = (m_ContentBounds.size.y - contentSpacing * (float)(CurrentLines - 1)) / (float)CurrentLines;
			totalSize = num * (float)TotalLines + contentSpacing * (float)(TotalLines - 1);
			offset = m_ContentBounds.max.y + num * (float)StartLine + contentSpacing * (float)StartLine;
		}
	}

	private void UpdateScrollbars(Vector2 offset)
	{
		if ((bool)m_HorizontalScrollbar && m_HorizontalScrollbar.gameObject.activeSelf)
		{
			if (m_ContentBounds.size.x > 0f && totalCount > 0)
			{
				GetHorizonalOffsetAndSize(out var totalSize, out var _);
				m_HorizontalScrollbar.size = Mathf.Clamp01((m_ViewBounds.size.x - Mathf.Abs(offset.x)) / totalSize);
			}
			else
			{
				m_HorizontalScrollbar.size = 1f;
			}
			m_HorizontalScrollbar.value = horizontalNormalizedPosition;
		}
		if ((bool)m_VerticalScrollbar && m_VerticalScrollbar.gameObject.activeSelf)
		{
			if (m_ContentBounds.size.y > 0f && totalCount > 0)
			{
				GetVerticalOffsetAndSize(out var totalSize2, out var _);
				m_VerticalScrollbar.size = Mathf.Clamp01((m_ViewBounds.size.y - Mathf.Abs(offset.y)) / totalSize2);
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
		if (totalCount <= 0 || itemTypeEnd <= itemTypeStart)
		{
			return;
		}
		EnsureLayoutHasRebuilt();
		UpdateBounds();
		float num = m_Content.anchoredPosition[axis];
		float totalSize;
		float offset;
		if (axis == 0)
		{
			GetHorizonalOffsetAndSize(out totalSize, out offset);
			if (totalSize >= m_ViewBounds.size.x)
			{
				num += m_ViewBounds.min.x - value * (totalSize - m_ViewBounds.size.x) - offset;
			}
		}
		else
		{
			GetVerticalOffsetAndSize(out totalSize, out offset);
			if (totalSize >= m_ViewBounds.size.y)
			{
				num -= offset - (1f - value) * (totalSize - m_ViewBounds.size.y) - m_ViewBounds.max.y;
			}
		}
		Vector3 vector = m_Content.anchoredPosition;
		if (Mathf.Abs(vector[axis] - num) > 0.01f)
		{
			vector[axis] = num;
			m_Content.anchoredPosition = vector;
			m_Velocity[axis] = 0f;
			UpdateBounds(updateItems: true);
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
			LayoutRebuilder.ForceRebuildLayoutImmediate(m_Content);
			m_ViewBounds = new Bounds(viewRect.rect.center, viewRect.rect.size);
			m_ContentBounds = GetBounds();
		}
		if (m_VSliderExpand && vScrollingNeeded)
		{
			viewRect.sizeDelta = new Vector2(0f - (m_VSliderWidth + m_VerticalScrollbarSpacing), viewRect.sizeDelta.y);
			LayoutRebuilder.ForceRebuildLayoutImmediate(m_Content);
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

	public void ResetConstraint()
	{
		GridLayoutGroup component = m_Content.GetComponent<GridLayoutGroup>();
		if ((bool)component)
		{
			component.constraint = m_CachedConstraint;
		}
		m_ContentConstraintCountInit = false;
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

	public void UpdateBounds(bool updateItems = false)
	{
		if (CanSkipUpdateBounds(updateItems))
		{
			return;
		}
		m_ViewBounds = new Bounds(viewRect.rect.center, viewRect.rect.size);
		m_ContentBounds = GetBounds();
		if (m_Content == null)
		{
			return;
		}
		if ((Application.isPlaying & updateItems) && UpdateItems(ref m_ViewBounds, ref m_ContentBounds))
		{
			EnsureLayoutHasRebuilt();
			m_ContentBounds = GetBounds();
		}
		Vector3 contentSize = m_ContentBounds.size;
		Vector3 contentPos = m_ContentBounds.center;
		Vector2 contentPivot = m_Content.pivot;
		AdjustBounds(ref m_ViewBounds, ref contentPivot, ref contentSize, ref contentPos);
		m_ContentBounds.size = contentSize;
		m_ContentBounds.center = contentPos;
		if (movementType == MovementType.Clamped)
		{
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
		CacheUpdateBoundsState(updateItems);
	}

	private bool CanSkipUpdateBounds(bool updateItems)
	{
		if (!Application.isPlaying || m_Content == null)
		{
			return false;
		}
		if (m_LastBoundsUpdateFrame != Time.frameCount)
		{
			return false;
		}
		if (updateItems && !m_LastBoundsUpdateWithItems)
		{
			return false;
		}
		if (m_Content.anchoredPosition == m_LastBoundsUpdateContentPosition && viewRect.rect == m_LastBoundsUpdateViewRect && m_Content.rect == m_LastBoundsUpdateContentRect && itemTypeStart == m_LastBoundsUpdateItemStart && itemTypeEnd == m_LastBoundsUpdateItemEnd)
		{
			return GetCachedAvailableRectCount() == m_LastBoundsUpdateCachedRectCount;
		}
		return false;
	}

	private void CacheUpdateBoundsState(bool updateItems)
	{
		if (Application.isPlaying && !(m_Content == null))
		{
			m_LastBoundsUpdateFrame = Time.frameCount;
			m_LastBoundsUpdateWithItems = updateItems;
			m_LastBoundsUpdateContentPosition = m_Content.anchoredPosition;
			m_LastBoundsUpdateViewRect = viewRect.rect;
			m_LastBoundsUpdateContentRect = m_Content.rect;
			m_LastBoundsUpdateItemStart = itemTypeStart;
			m_LastBoundsUpdateItemEnd = itemTypeEnd;
			m_LastBoundsUpdateCachedRectCount = GetCachedAvailableRectCount();
		}
	}

	private int GetCachedAvailableRectCount()
	{
		if (m_CachedAvailableRect != null)
		{
			return m_CachedAvailableRect.Count;
		}
		return 0;
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
			return default;
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

	private Bounds GetBounds4Item(int index)
	{
		if (m_Content == null)
		{
			return default;
		}
		int num = index - itemTypeStart;
		if (num < 0 || num >= m_CachedAvailableRect.Count)
		{
			return default;
		}
		RectTransform rectTransform = m_CachedAvailableRect[num];
		if (rectTransform == null)
		{
			return default;
		}
		rectTransform.GetWorldCorners(m_Corners);
		Matrix4x4 viewWorldToLocalMatrix = viewRect.worldToLocalMatrix;
		return InternalGetBounds(m_Corners, ref viewWorldToLocalMatrix);
	}

	private Vector2 CalculateOffset(Vector2 delta)
	{
		if (totalCount < 0 || movementType == MovementType.Unrestricted)
		{
			return delta;
		}
		Bounds contentBounds = m_ContentBounds;
		if (m_Horizontal)
		{
			GetHorizonalOffsetAndSize(out var totalSize, out var offset);
			Vector3 center = contentBounds.center;
			center.x = offset;
			contentBounds.Encapsulate(center);
			center.x = offset + totalSize;
			contentBounds.Encapsulate(center);
		}
		if (m_Vertical)
		{
			GetVerticalOffsetAndSize(out var totalSize2, out var offset2);
			Vector3 center2 = contentBounds.center;
			center2.y = offset2;
			contentBounds.Encapsulate(center2);
			center2.y = offset2 - totalSize2;
			contentBounds.Encapsulate(center2);
		}
		return InternalCalculateOffset(ref m_ViewBounds, ref contentBounds, m_Horizontal, m_Vertical, m_MovementType, ref delta);
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
	}

	protected abstract void SetContentToIndex(int index);

	protected void SetSiblingIndexAndSync(Transform t, int index)
	{
		if (t == null)
		{
			return;
		}
		int siblingIndex = index;
		if (t.parent != null)
		{
			siblingIndex = Mathf.Clamp(index, 0, t.parent.childCount - 1);
			if (t.GetSiblingIndex() != siblingIndex)
			{
				t.SetSiblingIndex(siblingIndex);
			}
		}
		else
		{
			t.SetSiblingIndex(siblingIndex);
		}
		if (m_CachedAvailableRect == null || m_CachedAvailableRect.Count == 0)
		{
			return;
		}
		RectTransform rectTransform = (t as RectTransform) ?? t.GetComponent<RectTransform>();
		if (rectTransform == null)
		{
			return;
		}
		int num = -1;
		for (int i = 0; i < m_CachedAvailableRect.Count; i++)
		{
			if (m_CachedAvailableRect[i] == rectTransform)
			{
				num = i;
				break;
			}
		}
		if (num >= 0)
		{
			int num2 = Mathf.Clamp(index, 0, m_CachedAvailableRect.Count - 1);
			if (num != num2)
			{
				m_CachedAvailableRect.RemoveAt(num);
				m_CachedAvailableRect.Insert(num2, rectTransform);
			}
		}
	}
}
