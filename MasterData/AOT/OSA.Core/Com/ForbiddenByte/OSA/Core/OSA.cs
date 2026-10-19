using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using Com.ForbiddenByte.OSA.Core.Data.Animations;
using Com.ForbiddenByte.OSA.Core.Data.Gallery;
using Com.ForbiddenByte.OSA.Core.SubComponents;
using Com.ForbiddenByte.OSA.Core.SubComponents.List;
using UnityEngine;
using UnityEngine.EventSystems;
using frame8.Logic.Misc.Other;
using frame8.Logic.Misc.Other.Extensions;
using frame8.Logic.Misc.Visual.UI;

namespace Com.ForbiddenByte.OSA.Core;

public abstract class OSA<TParams, TItemViewsHolder> : MonoBehaviour, IOSA, IScrollRectProxy, IInitializePotentialDragHandler, IEventSystemHandler, IBeginDragHandler, IDragHandler, IEndDragHandler, IScrollHandler where TParams : BaseParams where TItemViewsHolder : BaseItemViewsHolder
{
	[SerializeField]
	protected TParams _Params;

	protected internal ItemsDescriptor _ItemsDesc;

	protected internal InternalState<TItemViewsHolder> _InternalState;

	protected internal List<TItemViewsHolder> _VisibleItems;

	protected internal double _AVGVisibleItemsCount;

	protected internal List<TItemViewsHolder> _RecyclableItems = new List<TItemViewsHolder>();

	protected internal List<TItemViewsHolder> _BufferredRecyclableItems = new List<TItemViewsHolder>();

	private int _VisibleItemsCount;

	private Coroutine _SmoothScrollCoroutine;

	private bool _SkipComputeVisibilityInUpdateOrOnScroll;

	private float _PrevGalleryEffectAmount;

	private bool _Initialized;

	private bool _SkipInitializationChecks;

	private bool _ForceRebuildLayoutScheduled;

	private bool _Rebuilding;

	private Vector2 _Velocity;

	private Vector2 _VelocityToAddOnDragEnd;

	private bool _IsDragging;

	private int _StackedDragSpeeds;

	private Vector2 _OnInitializePotentialDragPointerPosInCTSpace;

	private Vector2 _OnBeginDragPointerPosInCTSpace;

	private Vector2 _LastOnDragPointerPosInCTSpace;

	private float _LastOnDragTime;

	private float _LastOnEndDragTime;

	private ComputeVisibilityManager<TParams, TItemViewsHolder> _ComputeVisibilityManager;

	private ReleaseFromPullManager<TParams, TItemViewsHolder> _ReleaseFromPull;

	private NestingManager<TParams, TItemViewsHolder> _NestingManager;

	private NavigationManager<TParams, TItemViewsHolder> _NavigationManager;

	private int? _PrimaryEventID;

	private int? _PrimaryEventIDOnLast_OnInitializePotentialDrag;

	private Action _SmoothScrollOnDone;

	private SimpleViewportSnapshot _OnScrollViewSizeChanged_ViewportSnapshot;

	private ComputeVisibilityParams _ComputeVisibilityParams_Reusable_Empty = new ComputeVisibilityParams();

	private ComputeVisibilityParams _ComputeVisibilityParams_Reusable_DragUnchecked = new ComputeVisibilityParams();

	private ComputeVisibilityParams _ComputeVisibilityParams_Reusable_SetNormalizedScrollPos = new ComputeVisibilityParams();

	public bool IsInitialized => _Initialized;

	public Vector2 Velocity
	{
		get
		{
			return _Velocity;
		}
		set
		{
			_Velocity = value;
			float num = _Velocity.magnitude / _Params.effects.MaxSpeed;
			if (num > 1f)
			{
				_Velocity /= num;
			}
		}
	}

	public bool IsHorizontal => _Params.IsHorizontal;

	public bool IsVertical => !_Params.IsHorizontal;

	public RectTransform Content => _Params.Content;

	public RectTransform Viewport => _Params.Viewport;

	double IScrollRectProxy.ContentInsetFromViewportStart => ContentVirtualInsetFromViewportStart;

	double IScrollRectProxy.ContentInsetFromViewportEnd => ContentVirtualInsetFromViewportEnd;

	public BaseParams BaseParameters => Parameters;

	public MonoBehaviour AsMonoBehaviour => this;

	public double ContentVirtualInsetFromViewportStart => _InternalState.ctVirtualInsetFromVPS_Cached;

	public double ContentVirtualInsetFromViewportEnd => _InternalState.CTVirtualInsetFromVPE_Cached;

	public int VisibleItemsCount
	{
		get
		{
			return _VisibleItemsCount;
		}
		internal set
		{
			_VisibleItemsCount = value;
		}
	}

	public int RecyclableItemsCount => _RecyclableItems.Count;

	public int BufferedRecyclableItemsCount => _BufferredRecyclableItems.Count;

	public bool IsDragging => _IsDragging;

	public virtual bool InsertAtIndexSupported => true;

	public virtual bool RemoveFromIndexSupported => true;

	public float Time
	{
		get
		{
			if (!_Params.UseUnscaledTime)
			{
				return UnityEngine.Time.time;
			}
			return UnityEngine.Time.unscaledTime;
		}
	}

	public float DeltaTime
	{
		get
		{
			if (!_Params.UseUnscaledTime)
			{
				return UnityEngine.Time.deltaTime;
			}
			return UnityEngine.Time.unscaledDeltaTime;
		}
	}

	public TParams Parameters => _Params;

	public event Action<double> ScrollPositionChanged;

	public virtual event Action Initialized;

	public virtual event Action<int, int> ItemsRefreshed;

	public virtual event Action ScrollViewSizeChanged;

	protected virtual void Awake()
	{
	}

	protected virtual void OnEnable()
	{
	}

	protected virtual void Start()
	{
		if (!IsInitialized)
		{
			Init();
		}
	}

	protected virtual void Update()
	{
		if (IsInitialized)
		{
			MyUpdate();
		}
	}

	protected virtual void LateUpdate()
	{
		if (IsInitialized)
		{
			MyLateUpdate();
		}
	}

	protected virtual void OnDisable()
	{
		if (IsInitialized)
		{
			MyOnDisable();
		}
	}

	protected virtual void OnDestroy()
	{
		Dispose();
	}

	public void SetNormalizedPosition(double normalizedPosition)
	{
		double pos = (_Params.IsHorizontal ? (1.0 - normalizedPosition) : normalizedPosition);
		SetVirtualAbstractNormalizedScrollPosition(pos, computeVisibilityNow: true, out var _);
	}

	public double GetNormalizedPosition()
	{
		double virtualAbstractNormalizedScrollPosition = _InternalState.GetVirtualAbstractNormalizedScrollPosition();
		if (!_Params.IsHorizontal)
		{
			return virtualAbstractNormalizedScrollPosition;
		}
		return 1.0 - virtualAbstractNormalizedScrollPosition;
	}

	public double GetContentSize()
	{
		return Math.Min(_InternalState.ctVirtualSize, 3.4028234663852886E+38);
	}

	public double GetViewportSize()
	{
		return _InternalState.vpSize;
	}

	public virtual void OnInitializePotentialDrag(PointerEventData eventData)
	{
		if (eventData.button != PointerEventData.InputButton.Left || _PrimaryEventID.HasValue)
		{
			return;
		}
		_PrimaryEventIDOnLast_OnInitializePotentialDrag = eventData.pointerId;
		if (_Params.ForwardDragToParents)
		{
			_NestingManager.OnInitializePotentialDrag(eventData);
		}
		if (!_Params.DragEnabled)
		{
			return;
		}
		float f = _Velocity[_InternalState.hor0_vert1];
		float f2 = _VelocityToAddOnDragEnd[_InternalState.hor0_vert1];
		bool flag = false;
		bool flag2 = false;
		if (_Params.effects.TransientSpeedBetweenDrags)
		{
			float num = Mathf.Max(Time - _LastOnEndDragTime, 0f);
			if (num > 0f && num < 0.5f && Mathf.Abs(f) > 1f && Mathf.Sign(f) == Mathf.Sign(f2))
			{
				flag = true;
			}
		}
		else
		{
			flag2 = true;
		}
		bool flag3 = false;
		if (!flag2 && _Params.effects.CutMovementOnPointerDown)
		{
			flag2 = true;
			flag3 = true;
			if (flag)
			{
				_VelocityToAddOnDragEnd += _Velocity;
			}
		}
		if (flag2)
		{
			StopMovement();
		}
		if (flag3)
		{
			StopScrollingIfAny();
		}
		if (!flag)
		{
			_VelocityToAddOnDragEnd = Vector2.zero;
			_StackedDragSpeeds = 0;
		}
		_OnInitializePotentialDragPointerPosInCTSpace = _InternalState.GetPointerPositionInCTSpace(eventData);
		_ReleaseFromPull.inProgress = false;
	}

	public virtual void OnBeginDrag(PointerEventData eventData)
	{
		if (!_PrimaryEventIDOnLast_OnInitializePotentialDrag.HasValue || _PrimaryEventID.HasValue || _PrimaryEventIDOnLast_OnInitializePotentialDrag != eventData.pointerId)
		{
			return;
		}
		_PrimaryEventID = eventData.pointerId;
		if (_Params.ForwardDragToParents)
		{
			_NestingManager.OnBeginDrag(eventData);
			if (_NestingManager.CurrentDragCapturedByParent)
			{
				return;
			}
		}
		if (!isActiveAndEnabled || !_Params.DragEnabled)
		{
			_PrimaryEventID = null;
			return;
		}
		_OnBeginDragPointerPosInCTSpace = _InternalState.GetPointerPositionInCTSpace(eventData);
		_LastOnDragPointerPosInCTSpace = _OnBeginDragPointerPosInCTSpace;
		if (_Params.effects.TransientSpeedBetweenDrags)
		{
			_VelocityToAddOnDragEnd += _Velocity;
		}
		_Velocity = Vector2.zero;
		_IsDragging = true;
		_LastOnDragTime = Time;
		_ReleaseFromPull.inProgress = false;
	}

	public virtual void OnDrag(PointerEventData eventData)
	{
		if (eventData.pointerId != _PrimaryEventID)
		{
			return;
		}
		if (_Params.ForwardDragToParents && _NestingManager.CurrentDragCapturedByParent)
		{
			_NestingManager.OnDrag(eventData);
		}
		else
		{
			if (!isActiveAndEnabled || !_Params.DragEnabled)
			{
				return;
			}
			Vector2 pointerPositionInCTSpace = _InternalState.GetPointerPositionInCTSpace(eventData);
			Vector2 vectorCTSpace = pointerPositionInCTSpace - _LastOnDragPointerPosInCTSpace;
			double cTAbstractSpaceVectorLongitudinalComponentFromCTSpaceVector = _InternalState.GetCTAbstractSpaceVectorLongitudinalComponentFromCTSpaceVector(vectorCTSpace);
			AllowContentOutsideBoundsMode allowOutsideBoundsMode = ((_Params.effects.ElasticMovement || (_Params.effects.LoopItems && _InternalState.VirtualScrollableArea > 0.0)) ? AllowContentOutsideBoundsMode.ALLOW : AllowContentOutsideBoundsMode.DO_NOT_ALLOW);
			Drag(cTAbstractSpaceVectorLongitudinalComponentFromCTSpaceVector, allowOutsideBoundsMode, cancelSnappingIfAny: true);
			if (_Params.effects.Inertia)
			{
				float num = Time - _LastOnDragTime;
				if (num == 0f)
				{
					num = DeltaTime;
				}
				float num2 = _Velocity[_InternalState.hor0_vert1];
				double num3;
				if (_LastOnDragPointerPosInCTSpace == _OnBeginDragPointerPosInCTSpace)
				{
					Vector2 vectorCTSpace2 = pointerPositionInCTSpace - _OnInitializePotentialDragPointerPosInCTSpace;
					num3 = _InternalState.GetCTAbstractSpaceVectorLongitudinalComponentFromCTSpaceVector(vectorCTSpace2);
				}
				else
				{
					num3 = cTAbstractSpaceVectorLongitudinalComponentFromCTSpaceVector;
					if (Math.Abs(cTAbstractSpaceVectorLongitudinalComponentFromCTSpaceVector) < 1.0)
					{
						num3 = 0.0;
					}
				}
				double num4 = num3 / (double)num * (double)_InternalState.hor1_vertMinus1;
				_Velocity[_InternalState.hor0_vert1] = Mathf.Clamp((float)(((double)num2 + num4) / 2.0), 0f - _Params.effects.MaxSpeed, _Params.effects.MaxSpeed);
			}
			_LastOnDragTime = Time;
			_LastOnDragPointerPosInCTSpace = pointerPositionInCTSpace;
		}
	}

	public virtual void OnEndDrag(PointerEventData eventData)
	{
		if (eventData.pointerId != _PrimaryEventID)
		{
			return;
		}
		_PrimaryEventID = null;
		_PrimaryEventIDOnLast_OnInitializePotentialDrag = null;
		if (_Params.ForwardDragToParents && _NestingManager.CurrentDragCapturedByParent)
		{
			_NestingManager.OnEndDrag(eventData);
			return;
		}
		_IsDragging = false;
		if (!isActiveAndEnabled || !_Params.DragEnabled)
		{
			return;
		}
		if (_Params.effects.Inertia)
		{
			bool flag = false;
			float num = Mathf.Max(Time - _LastOnDragTime, 0f);
			float num2 = Mathf.Max(DeltaTime, 0.1f);
			if (num > num2)
			{
				flag = true;
			}
			else
			{
				Vector2 vectorCTSpace = _InternalState.GetPointerPositionInCTSpace(eventData) - _OnInitializePotentialDragPointerPosInCTSpace;
				if (Math.Abs(_InternalState.GetCTAbstractSpaceVectorLongitudinalComponentFromCTSpaceVector(vectorCTSpace)) < 3.0)
				{
					flag = true;
				}
			}
			if (flag)
			{
				_Velocity[_InternalState.hor0_vert1] = 0f;
			}
			else
			{
				float num3 = _VelocityToAddOnDragEnd[_InternalState.hor0_vert1];
				float num4 = _Velocity[_InternalState.hor0_vert1];
				if (Mathf.Sign(num3) == Mathf.Sign(num4))
				{
					_Velocity[_InternalState.hor0_vert1] = Mathf.Clamp((num4 + num3) * (float)(1 + _StackedDragSpeeds), 0f - _Params.effects.MaxSpeed, _Params.effects.MaxSpeed);
					if (_Params.effects.TransientSpeedBetweenDrags && _StackedDragSpeeds < 10)
					{
						_StackedDragSpeeds++;
					}
				}
				else
				{
					_StackedDragSpeeds = 0;
					_VelocityToAddOnDragEnd = Vector2.zero;
				}
			}
		}
		_LastOnEndDragTime = Time;
	}

	public virtual void OnScroll(PointerEventData eventData)
	{
		if (_IsDragging)
		{
			return;
		}
		if (_Params.ForwardDragToParents && !_NestingManager.CurrentDragCapturedByParent)
		{
			_NestingManager.OnScroll(eventData);
			if (_NestingManager.CurrentScrollConsumedByParent)
			{
				return;
			}
		}
		if (isActiveAndEnabled && _Params.ScrollEnabled)
		{
			Vector2 scrollDelta = eventData.scrollDelta;
			Vector2 vec = scrollDelta;
			_Params.ApplyScrollSensitivityTo(ref vec);
			Vector2 vector = vec;
			vector.x *= _InternalState.hor1_vertMinus1;
			vector.y *= -_InternalState.hor1_vertMinus1;
			double num = ((!(Mathf.Abs(scrollDelta.x) > Mathf.Abs(scrollDelta.y))) ? ((double)vector.y) : ((double)vector.x));
			if (num != 0.0)
			{
				StopMovement();
				Drag(num, AllowContentOutsideBoundsMode.DO_NOT_ALLOW, cancelSnappingIfAny: true);
			}
		}
	}

	public void Init()
	{
		if (!enabled || !gameObject.activeInHierarchy)
		{
			throw new OSAException("Init should only be called when the GameObject is active in hierarchy and the OSA component is enabled");
		}
		_Params.PrepareForInit(firstTime: true);
		_Params.InitIfNeeded(this);
		_ReleaseFromPull = new ReleaseFromPullManager<TParams, TItemViewsHolder>(this);
		if ((bool)_Params.Snapper)
		{
			_Params.Snapper.Adapter = this;
		}
		_ItemsDesc = new ItemsDescriptor(_Params.DefaultItemSize);
		_InternalState = InternalState<TItemViewsHolder>.CreateFromSourceParamsOrThrow(_Params, _ItemsDesc);
		_InternalState.CacheScrollViewInfo();
		_NestingManager = new NestingManager<TParams, TItemViewsHolder>(this);
		_ComputeVisibilityManager = new ComputeVisibilityManager<TParams, TItemViewsHolder>(this);
		_NavigationManager = CreateNavigationManager();
		_VisibleItems = new List<TItemViewsHolder>();
		_AVGVisibleItemsCount = 0.0;
		_SkipInitializationChecks = true;
		Refresh();
		_InternalState.UpdateLastProcessedCTVirtualInsetFromVPStart();
		SetVirtualAbstractNormalizedScrollPosition(1.0, computeVisibilityNow: false, out var _);
		OnScrollPositionChangedInternal();
		_SkipInitializationChecks = false;
		OnInitialized();
		if (_Initialized && Initialized != null)
		{
			Initialized();
		}
	}

	public virtual void Refresh(bool contentPanelEndEdgeStationary = false, bool keepVelocity = false)
	{
		ChangeItemsCount(ItemCountChangeMode.RESET, _ItemsDesc.itemsCount, -1, contentPanelEndEdgeStationary, keepVelocity);
	}

	public virtual void ResetItems(int itemsCount, bool contentPanelEndEdgeStationary = false, bool keepVelocity = false)
	{
		ChangeItemsCount(ItemCountChangeMode.RESET, itemsCount, -1, contentPanelEndEdgeStationary, keepVelocity);
	}

	public virtual void InsertItems(int index, int itemsCount, bool contentPanelEndEdgeStationary = false, bool keepVelocity = false)
	{
		ChangeItemsCount(ItemCountChangeMode.INSERT, itemsCount, index, contentPanelEndEdgeStationary, keepVelocity);
	}

	public virtual void RemoveItems(int index, int itemsCount, bool contentPanelEndEdgeStationary = false, bool keepVelocity = false)
	{
		ChangeItemsCount(ItemCountChangeMode.REMOVE, itemsCount, index, contentPanelEndEdgeStationary, keepVelocity);
	}

	public virtual void ChangeItemsCount(ItemCountChangeMode changeMode, int itemsCount, int indexIfInsertingOrRemoving = -1, bool contentPanelEndEdgeStationary = false, bool keepVelocity = false)
	{
		ChangeItemsCountInternal(changeMode, itemsCount, indexIfInsertingOrRemoving, contentPanelEndEdgeStationary, keepVelocity, stealInsteadOfRecycle: false);
	}

	public virtual int GetItemsCount()
	{
		return _ItemsDesc.itemsCount;
	}

	public TItemViewsHolder GetItemViewsHolder(int vhIndex)
	{
		if (vhIndex >= VisibleItemsCount)
		{
			return null;
		}
		return _VisibleItems[vhIndex];
	}

	public BaseItemViewsHolder GetBaseItemViewsHolder(int vhIndex)
	{
		return GetItemViewsHolder(vhIndex);
	}

	public Type GetViewsHolderType()
	{
		return typeof(TItemViewsHolder);
	}

	public TItemViewsHolder GetItemViewsHolderIfVisible(int withItemIndex)
	{
		int num = 0;
		for (num = 0; num < VisibleItemsCount; num++)
		{
			TItemViewsHolder val = _VisibleItems[num];
			if (val.ItemIndex == withItemIndex)
			{
				return val;
			}
		}
		return null;
	}

	public BaseItemViewsHolder GetBaseItemViewsHolderIfVisible(int withItemIndex)
	{
		return GetItemViewsHolderIfVisible(withItemIndex);
	}

	public TItemViewsHolder GetItemViewsHolderIfVisible(RectTransform withRoot)
	{
		for (int i = 0; i < VisibleItemsCount; i++)
		{
			TItemViewsHolder val = _VisibleItems[i];
			if (val.root == withRoot)
			{
				return val;
			}
		}
		return null;
	}

	public BaseItemViewsHolder GetBaseItemViewsHolderIfVisible(RectTransform withRoot)
	{
		return GetItemViewsHolderIfVisible(withRoot);
	}

	public float ConvertViewportLocalPointToViewportLongitudinalPointStart0End1(Vector2 localPositionInViewport)
	{
		return ConvertLocalPointToLongitudinalPointStart0End1(_Params.Viewport, localPositionInViewport);
	}

	public float ConvertScrollViwLocalPointToScrollViewLongitudinalPointStart0End1(Vector2 localPosition)
	{
		return ConvertLocalPointToLongitudinalPointStart0End1(_Params.ScrollViewRT, localPosition);
	}

	public float ConvertLocalPointToLongitudinalPointStart0End1(RectTransform rectTransform, Vector2 localPosition)
	{
		float num = rectTransform.ConvertLocalPointToPointNormalizedBySize(localPosition)[_InternalState.hor0_vert1];
		if (!_Params.IsHorizontal)
		{
			num = 1f - num;
		}
		return num;
	}

	public virtual TItemViewsHolder GetViewsHolderClosestToViewportPoint(Canvas c, RectTransform canvasRectTransform, Vector2 localPositionInViewport, float itemNormalizedAbstractPoint, out float distance)
	{
		float viewportNormalizedAbstractPoint = ConvertViewportLocalPointToViewportLongitudinalPointStart0End1(localPositionInViewport);
		return GetViewsHolderClosestToViewportLongitudinalNormalizedAbstractPoint(c, canvasRectTransform, viewportNormalizedAbstractPoint, itemNormalizedAbstractPoint, out distance) as TItemViewsHolder;
	}

	public virtual AbstractViewsHolder GetViewsHolderClosestToViewportLongitudinalNormalizedAbstractPoint(Canvas c, RectTransform canvasRectTransform, float viewportNormalizedAbstractPoint, float itemNormalizedAbstractPoint, out float distance)
	{
		int hor0_vert = _InternalState.hor0_vert1;
		int num = 1 - hor0_vert;
		return GetViewsHolderClosestoViewportNormalizedAbastractPoint(viewportPointNormalizedWithYInverted: new Vector2(viewportNormalizedAbstractPoint * (float)num + 0.5f * (float)hor0_vert, viewportNormalizedAbstractPoint * (float)hor0_vert + 0.5f * (float)num), itemPointNormalizedWithYInverted: new Vector2(itemNormalizedAbstractPoint * (float)num + 0.5f * (float)hor0_vert, itemNormalizedAbstractPoint * (float)hor0_vert + 0.5f * (float)num), viewsHolders: _VisibleItems, c: c, canvasRectTransform: canvasRectTransform, distance: out distance);
	}

	public LayoutInfo GetLayoutInfoReadonly()
	{
		return _InternalState.layoutInfo;
	}

	public virtual void RemoveItemWithViewsHolder(TItemViewsHolder viewsHolder, bool stealViewsHolderInsteadOfRecycle, bool contentPanelEndEdgeStationary)
	{
		ChangeItemsCountInternal(ItemCountChangeMode.REMOVE, 1, viewsHolder.ItemIndex, contentPanelEndEdgeStationary, keepVelocity: false, stealViewsHolderInsteadOfRecycle);
		if (stealViewsHolderInsteadOfRecycle && !viewsHolder.root)
		{
			throw new OSAException("RemoveItemWithViewsHolder: Internal error: vh.root destroyed. ItemIndex " + viewsHolder.ItemIndex + ", viewsHolder.root " + viewsHolder.root);
		}
	}

	public virtual void InsertItemWithViewsHolder(TItemViewsHolder viewsHolder, int atIndex, bool contentPanelEndEdgeStationary)
	{
		if (atIndex < 0 || atIndex > _ItemsDesc.itemsCount)
		{
			throw new ArgumentOutOfRangeException("atIndex", atIndex, "should be >=0 and <= itemsCount(=" + _ItemsDesc.itemsCount + ")");
		}
		if (!viewsHolder.root)
		{
			throw new ArgumentOutOfRangeException("Could not give a viewsholder that has its root destroyed/set to null");
		}
		ClearCachedRecyclableItems(includingBufferred: false);
		_RecyclableItems.Insert(0, viewsHolder);
		ChangeItemsCountInternal(ItemCountChangeMode.INSERT, 1, atIndex, contentPanelEndEdgeStationary, keepVelocity: false, stealInsteadOfRecycle: false);
	}

	public virtual bool ScrollByAbstractDelta(float abstractDeltaInCTSpace)
	{
		if (!isActiveAndEnabled)
		{
			return false;
		}
		if (_IsDragging)
		{
			return false;
		}
		StopMovement();
		Drag(abstractDeltaInCTSpace, AllowContentOutsideBoundsMode.DO_NOT_ALLOW, cancelSnappingIfAny: true);
		return true;
	}

	public virtual void ScrollTo(int itemIndex, float normalizedOffsetFromViewportStart = 0f, float normalizedPositionOfItemPivotToUse = 0f)
	{
		AnimationCancelling cancel = _Params.Animation.Cancel;
		CancelAnimations(snapping: true, cancel.SmoothScroll.OnScrollTo, cancel.UserAnimations.OnScrollTo);
		double virtualScrollableArea = _InternalState.VirtualScrollableArea;
		bool flag = virtualScrollableArea > 0.0;
		double virtualInset = ScrollToHelper_GetContentStartVirtualInsetFromViewportStart(virtualScrollableArea, itemIndex, normalizedOffsetFromViewportStart, normalizedPositionOfItemPivotToUse, shortestPathWhenLooping: false);
		ContentSizeOrPositionChangeParams p = new ContentSizeOrPositionChangeParams
		{
			computeVisibilityParams = _ComputeVisibilityParams_Reusable_Empty,
			fireScrollPositionChangedEvent = true,
			allowOutsideBounds = (_Params.effects.LoopItems & flag)
		};
		SetContentVirtualInsetFromViewportStart(virtualInset, ref p, out var _);
		if (_Params.effects.LoopItems)
		{
			ComputeVisibilityForCurrentPositionRawParams(forceFireScrollViewPositionChangedEvent: false, potentialTwinPassCTEndStationaryPrioritizeUserPreference: false, -0.10000000149011612);
			ComputeVisibilityForCurrentPositionRawParams(forceFireScrollViewPositionChangedEvent: true, potentialTwinPassCTEndStationaryPrioritizeUserPreference: false, 0.10000000149011612);
		}
	}

	public virtual bool SmoothScrollTo(int itemIndex, float duration, float normalizedOffsetFromViewportStart = 0f, float normalizedPositionOfItemPivotToUse = 0f, Func<float, bool> onProgress = null, Action onDone = null, bool overrideCurrentScrollingAnimation = false)
	{
		if (IsScrollToAnimationRunning())
		{
			if (!overrideCurrentScrollingAnimation)
			{
				return false;
			}
			AnimationCancelling cancel = _Params.Animation.Cancel;
			CancelAnimations(snapping: true, smoothScrolling: true, cancel.UserAnimations.OnBeginSmoothScroll);
		}
		_SmoothScrollCoroutine = StartCoroutine(SmoothScrollProgressCoroutine(itemIndex, duration, normalizedOffsetFromViewportStart, normalizedPositionOfItemPivotToUse, onProgress, onDone));
		return true;
	}

	public virtual void BringToView(int itemIndex, float? spacingFromViewportEdge = null)
	{
		if (BringToView_CalculateParameters(itemIndex, spacingFromViewportEdge, out var normalizedOffsetFromViewportStart, out var itemPivotToUse))
		{
			ScrollTo(itemIndex, normalizedOffsetFromViewportStart, itemPivotToUse);
		}
	}

	public virtual bool SmoothBringToView(int itemIndex, float duration, float? spacingFromViewportEdge = null, Func<float, bool> onProgress = null, Action onDone = null, bool overrideCurrentScrollingAnimation = false)
	{
		if (!BringToView_CalculateParameters(itemIndex, spacingFromViewportEdge, out var normalizedOffsetFromViewportStart, out var itemPivotToUse))
		{
			return false;
		}
		return SmoothScrollTo(itemIndex, duration, normalizedOffsetFromViewportStart, itemPivotToUse, onProgress, onDone, overrideCurrentScrollingAnimation);
	}

	internal bool BringToView_CalculateParameters(int itemIndex, float? spacingFromViewportEdge, out float normalizedOffsetFromViewportStart, out float itemPivotToUse)
	{
		double itemSignedVisibility = GetItemSignedVisibility(itemIndex, spacingFromViewportEdge);
		float num = (float)((double)(spacingFromViewportEdge ?? _Params.ContentSpacing) / _InternalState.vpSize);
		if (itemSignedVisibility < 0.0)
		{
			normalizedOffsetFromViewportStart = 0f + num;
			itemPivotToUse = 0f;
			return true;
		}
		if (itemSignedVisibility > 0.0)
		{
			normalizedOffsetFromViewportStart = 1f - num;
			itemPivotToUse = 1f;
			return true;
		}
		normalizedOffsetFromViewportStart = (itemPivotToUse = 0f);
		return false;
	}

	public virtual double GetItemSignedVisibility(int itemIndex, float? spacingFromViewportEdge = null)
	{
		double result = 0.0;
		double num = spacingFromViewportEdge ?? _Params.ContentSpacing;
		TItemViewsHolder itemViewsHolderIfVisible = GetItemViewsHolderIfVisible(itemIndex);
		bool flag = itemViewsHolderIfVisible != null;
		int itemViewIndexFromRealIndexChecked = _ItemsDesc.GetItemViewIndexFromRealIndexChecked(itemIndex);
		double num2 = _ItemsDesc[itemIndex] + num;
		double num3 = (flag ? ((double)GetItemRealInsetFromParentStart(itemViewsHolderIfVisible.root)) : _InternalState.GetItemInferredRealInsetFromParentStart(itemViewIndexFromRealIndexChecked)) - num;
		if (num3 < 0.0)
		{
			double num4 = 0.0 - num3;
			if (num4 > num2)
			{
				num4 = num2;
			}
			result = 0.0 - num4 / num2;
		}
		else
		{
			double num5 = (flag ? ((double)GetItemRealInsetFromParentEnd(itemViewsHolderIfVisible.root)) : _InternalState.GetItemInferredRealInsetFromParentEnd(itemViewIndexFromRealIndexChecked)) - num;
			if (num5 < 0.0)
			{
				double num4 = 0.0 - num5;
				if (num4 > num2)
				{
					num4 = num2;
				}
				result = num4 / num2;
			}
		}
		return result;
	}

	public void CancelAllAnimations()
	{
		CancelAnimations(snapping: true, smoothScrolling: true, userAnimations: true);
	}

	protected void CancelAnimations(bool snapping, bool smoothScrolling, bool userAnimations)
	{
		if (snapping && (bool)_Params.Snapper)
		{
			_Params.Snapper.CancelSnappingIfInProgress();
		}
		if (smoothScrolling)
		{
			StopScrollingIfAny();
		}
		if (userAnimations)
		{
			CancelUserAnimations();
		}
	}

	[Obsolete("Please override CancelUserAnimations instead, if the intention was to hook into this callback, or call CancelAllAnimations() if you manually want to cancel animations", true)]
	public virtual void CancelAnimationsIfAny()
	{
	}

	public virtual void StopScrollingIfAny()
	{
		if (IsScrollToAnimationRunning())
		{
			StopCoroutine(_SmoothScrollCoroutine);
			if (_Params.Animation.CallDoneOnScrollCancel && _SmoothScrollOnDone != null)
			{
				_SmoothScrollOnDone();
			}
			_SmoothScrollOnDone = null;
			_SmoothScrollCoroutine = null;
			_SkipComputeVisibilityInUpdateOrOnScroll = false;
		}
	}

	public virtual void StopMovement()
	{
		_Velocity = Vector2.zero;
	}

	public float RequestChangeItemSizeAndUpdateLayout(TItemViewsHolder withVH, float requestedSize, bool itemEndEdgeStationary = false, bool computeVisibility = true, bool correctItemPosition = false, bool keepVelocity = false)
	{
		return RequestChangeItemSizeAndUpdateLayout(withVH.ItemIndex, requestedSize, itemEndEdgeStationary, computeVisibility, correctItemPosition, keepVelocity);
	}

	public float RequestChangeItemSizeAndUpdateLayout(int itemIndex, float requestedSize, bool itemEndEdgeStationary = false, bool computeVisibility = true, bool correctItemPosition = false, bool keepVelocity = false)
	{
		AnimationCancelling cancel = _Params.Animation.Cancel;
		CancelAnimations(snapping: true, cancel.SmoothScroll.OnSizeChanges, cancel.UserAnimations.OnSizeChanges);
		bool skipComputeVisibilityInUpdateOrOnScroll = _SkipComputeVisibilityInUpdateOrOnScroll;
		_SkipComputeVisibilityInUpdateOrOnScroll = true;
		if (!keepVelocity)
		{
			StopMovement();
		}
		int itemViewIndexFromRealIndexChecked = _ItemsDesc.GetItemViewIndexFromRealIndexChecked(itemIndex);
		TItemViewsHolder itemViewsHolderIfVisible = GetItemViewsHolderIfVisible(itemIndex);
		double num = _ItemsDesc[itemViewIndexFromRealIndexChecked];
		double num2 = ChangeItemSizeAndUpdateContentSizeAccordingly(itemViewsHolderIfVisible, itemViewIndexFromRealIndexChecked, num, requestedSize, itemEndEdgeStationary);
		bool flag = num2 < num;
		double num3;
		if (itemEndEdgeStationary)
		{
			if (flag)
			{
				num3 = 0.1;
				if (_InternalState.ctVirtualInsetFromVPS_Cached >= 0.0)
				{
					num3 = 0.0 - num3;
				}
			}
			else
			{
				num3 = -0.1;
			}
		}
		else if (flag)
		{
			num3 = -0.1;
			if (_InternalState.CTVirtualInsetFromVPE_Cached >= 0.0)
			{
				num3 = 0.0 - num3;
			}
		}
		else
		{
			num3 = 0.1;
		}
		if (correctItemPosition)
		{
			CorrectPositionsOfVisibleItems(!computeVisibility, fireScrollPositionChangedEvent: false);
		}
		if (computeVisibility)
		{
			ComputeVisibilityForCurrentPositionRawParams(forceFireScrollViewPositionChangedEvent: true, potentialTwinPassCTEndStationaryPrioritizeUserPreference: false, num3);
		}
		_SkipComputeVisibilityInUpdateOrOnScroll = skipComputeVisibilityInUpdateOrOnScroll;
		return (float)num2;
	}

	public double GetItemVirtualInsetFromParentStart(int itemIndex)
	{
		return _InternalState.GetItemVirtualInsetFromParentStartUsingItemIndexInView(_ItemsDesc.GetItemViewIndexFromRealIndexChecked(itemIndex));
	}

	public float GetItemRealInsetFromParentStart(RectTransform withRoot)
	{
		return withRoot.GetInsetFromParentEdge(_Params.Content, _InternalState.startEdge);
	}

	public float GetItemRealInsetFromParentEnd(RectTransform withRoot)
	{
		return withRoot.GetInsetFromParentEdge(_Params.Content, _InternalState.endEdge);
	}

	public double GetVirtualAbstractNormalizedScrollPosition()
	{
		return _InternalState.GetVirtualAbstractNormalizedScrollPosition();
	}

	public double SetVirtualAbstractNormalizedScrollPosition(double pos, bool computeVisibilityNow, out bool looped, bool keepVelocity = false)
	{
		CancelAllAnimations();
		bool skipComputeVisibilityInUpdateOrOnScroll = _SkipComputeVisibilityInUpdateOrOnScroll;
		_SkipComputeVisibilityInUpdateOrOnScroll = true;
		double num = (1.0 - pos) * (0.0 - _InternalState.VirtualScrollableArea);
		double value = num - _InternalState.ctVirtualInsetFromVPS_Cached;
		ComputeVisibilityParams computeVisibilityParams = null;
		if (computeVisibilityNow)
		{
			computeVisibilityParams = _ComputeVisibilityParams_Reusable_SetNormalizedScrollPos;
			computeVisibilityParams.overrideDelta = value;
		}
		ContentSizeOrPositionChangeParams p = new ContentSizeOrPositionChangeParams
		{
			computeVisibilityParams = computeVisibilityParams,
			fireScrollPositionChangedEvent = true,
			keepVelocity = keepVelocity
		};
		value = SetContentVirtualInsetFromViewportStart(num, ref p, out looped);
		if (computeVisibilityNow)
		{
			RecomputeVisibility_Auto(out var _);
		}
		_SkipComputeVisibilityInUpdateOrOnScroll = skipComputeVisibilityInUpdateOrOnScroll;
		return value;
	}

	public BaseNavigationManager GetBaseNavigationManager()
	{
		return _NavigationManager;
	}

	public void ScheduleForceRebuildLayout()
	{
		_ForceRebuildLayoutScheduled = true;
	}

	public void ForceRebuildLayoutNow()
	{
		ForceRebuildLayout();
	}

	public void ForceUpdateVisibleItems()
	{
		if (_InternalState.computeVisibilityTwinPassScheduled)
		{
			throw new OSAException("You shouldn't call ForceUpdateVisibleItems during a ComputeVisibilityForCurrentPosition, UpdateViewsHolder or CreateViewsHolder");
		}
		for (int i = 0; i < VisibleItemsCount; i++)
		{
			TItemViewsHolder itemViewsHolder = GetItemViewsHolder(i);
			ForceUpdateViewsHolder(itemViewsHolder);
		}
	}

	public bool ForceUpdateViewsHolderIfVisible(int itemIndex)
	{
		if (_InternalState.computeVisibilityTwinPassScheduled)
		{
			throw new OSAException("You shouldn't call ForceUpdateViewsHolderIfVisible during a ComputeVisibilityForCurrentPosition, UpdateViewsHolder or CreateViewsHolder");
		}
		TItemViewsHolder itemViewsHolderIfVisible = GetItemViewsHolderIfVisible(itemIndex);
		if (itemViewsHolderIfVisible == null)
		{
			return false;
		}
		ForceUpdateViewsHolder(itemViewsHolderIfVisible);
		return true;
	}

	public virtual bool IsAnyAnimationRunning()
	{
		if (!IsSnappingAnimationRunning() && !IsScrollToAnimationRunning())
		{
			return IsUserAnimationRunning();
		}
		return true;
	}

	public bool IsSnappingAnimationRunning()
	{
		if ((bool)Parameters.Snapper)
		{
			return Parameters.Snapper.SnappingInProgress;
		}
		return false;
	}

	public bool IsScrollToAnimationRunning()
	{
		return _SmoothScrollCoroutine != null;
	}

	protected virtual NavigationManager<TParams, TItemViewsHolder> CreateNavigationManager()
	{
		return new ListNavigationManager<TParams, TItemViewsHolder>(this);
	}

	protected virtual void OnInitialized()
	{
		_Initialized = true;
	}

	protected virtual void OnItemsRefreshed(int prevCount, int newCount)
	{
	}

	protected virtual void CollectItemsSizes(ItemCountChangeMode changeMode, int count, int indexIfInsertingOrRemoving, ItemsDescriptor itemsDesc)
	{
		int itemsCount = itemsDesc.itemsCount;
		ReadOnlyCollection<int> indicesInViewOfNonDefaultItems = _ItemsDesc.GetIndicesInViewOfNonDefaultItems();
		Dictionary<int, ItemsDescriptor.SizeInfo> sizeInfosOfNonDefaultItems = _ItemsDesc.GetSizeInfosOfNonDefaultItems();
		itemsDesc.ReinitializeSizes(changeMode, count, indexIfInsertingOrRemoving, _Params.DefaultItemSize);
		int itemIndexOfFirstVHIfInsertingOrRemoving = ((VisibleItemsCount > 0) ? _VisibleItems[0].ItemIndex : (-1));
		itemsDesc.ReinitializeRealIndexOfFirstItemInView(itemsCount, changeMode, count, indexIfInsertingOrRemoving, itemIndexOfFirstVHIfInsertingOrRemoving, _Params.effects.LoopItems);
		if (!_Rebuilding || !_Params.optimization.KeepItemsSizesOnLayoutRebuild)
		{
			return;
		}
		int num = -1;
		int count2 = indicesInViewOfNonDefaultItems.Count;
		for (int i = 0; i < count2; i++)
		{
			int num2 = indicesInViewOfNonDefaultItems[i];
			if (i == 0)
			{
				itemsDesc.BeginChangingItemsSizes(num2);
			}
			else if (num + 1 != num2)
			{
				itemsDesc.EndChangingItemsSizes();
				itemsDesc.BeginChangingItemsSizes(num2);
			}
			itemsDesc[num2] = sizeInfosOfNonDefaultItems[num2].size;
			num = num2;
		}
		if (count2 > 0)
		{
			itemsDesc.EndChangingItemsSizes();
		}
	}

	protected abstract TItemViewsHolder CreateViewsHolder(int itemIndex);

	protected abstract void UpdateViewsHolder(TItemViewsHolder newOrRecycled);

	protected virtual void OnItemIndexChangedDueInsertOrRemove(TItemViewsHolder shiftedViewsHolder, int oldIndex, bool wasInsert, int removeOrInsertIndex)
	{
	}

	protected virtual bool IsRecyclable(TItemViewsHolder potentiallyRecyclable, int indexOfItemThatWillBecomeVisible, double sizeOfItemThatWillBecomeVisible)
	{
		return true;
	}

	internal bool InternalShouldDestroyRecyclableItem(TItemViewsHolder inRecycleBin, bool isInExcess)
	{
		return ShouldDestroyRecyclableItem(inRecycleBin, isInExcess);
	}

	internal void InternalDestroyRecyclableItem(TItemViewsHolder vh, bool isVisible)
	{
		OnBeforeDestroyViewsHolder(vh, isVisible);
		try
		{
			UnityEngine.Object.Destroy(vh.root.gameObject);
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
	}

	protected virtual bool ShouldDestroyRecyclableItem(TItemViewsHolder inRecycleBin, bool isInExcess)
	{
		return isInExcess;
	}

	internal void InternalOnBeforeRecycleOrDisableViewsHolder(TItemViewsHolder inRecycleBinOrVisible, int newItemIndex)
	{
		OnBeforeRecycleOrDisableViewsHolder(inRecycleBinOrVisible, newItemIndex);
	}

	protected virtual void OnBeforeRecycleOrDisableViewsHolder(TItemViewsHolder inRecycleBinOrVisible, int newItemIndex)
	{
		if (newItemIndex == -1)
		{
			inRecycleBinOrVisible.UnmarkForRebuild();
		}
		inRecycleBinOrVisible.OnBeforeRecycleOrDisable(newItemIndex);
	}

	protected virtual void OnBeforeDestroyViewsHolder(TItemViewsHolder vh, bool isActive)
	{
		vh.OnBeforeDestroy();
	}

	protected virtual void ClearCachedRecyclableItems(bool includingBufferred = true)
	{
		if (_RecyclableItems != null)
		{
			DestroyAndClearItemsInList(_RecyclableItems);
		}
		if (includingBufferred && _BufferredRecyclableItems != null)
		{
			DestroyAndClearItemsInList(_BufferredRecyclableItems);
		}
	}

	protected virtual void CancelUserAnimations()
	{
	}

	private void DestroyAndClearItemsInList(List<TItemViewsHolder> vhs)
	{
		foreach (TItemViewsHolder vh in vhs)
		{
			if (vh != null && vh.root != null)
			{
				InternalDestroyRecyclableItem(vh, isVisible: false);
			}
		}
		vhs.Clear();
	}

	protected virtual void ClearVisibleItems()
	{
		if (_VisibleItems != null)
		{
			foreach (TItemViewsHolder visibleItem in _VisibleItems)
			{
				if (visibleItem != null)
				{
					OnBeforeRecycleOrDisableViewsHolder(visibleItem, -1);
					if (visibleItem.root != null)
					{
						InternalDestroyRecyclableItem(visibleItem, isVisible: true);
					}
				}
			}
			_VisibleItems.Clear();
			VisibleItemsCount = 0;
		}
		if (_ReleaseFromPull != null)
		{
			_ReleaseFromPull.inProgress = false;
		}
	}

	protected virtual void OnScrollViewSizeChanged()
	{
		_OnScrollViewSizeChanged_ViewportSnapshot = new SimpleViewportSnapshot(this);
	}

	protected virtual void RebuildLayoutDueToScrollViewSizeChange()
	{
		if (!_Params.optimization.KeepItemsPoolOnLayoutRebuild)
		{
			ClearCachedRecyclableItems();
		}
		_Params.PrepareForInit(firstTime: false);
		_Params.InitIfNeeded(this);
		if ((bool)_Params.Snapper)
		{
			_Params.Snapper.Adapter = this;
		}
		_InternalState.CacheScrollViewInfo();
		_ItemsDesc.maxVisibleItemsSeenSinceLastScrollViewSizeChange = 0;
		_ItemsDesc.destroyedItemsSinceLastScrollViewSizeChange = 0;
	}

	protected virtual void PostRebuildLayoutDueToScrollViewSizeChange()
	{
		if (_OnScrollViewSizeChanged_ViewportSnapshot != null && Parameters.optimization.ResponsiveOnScrollViewSizeChange)
		{
			_OnScrollViewSizeChanged_ViewportSnapshot.Restore();
			_OnScrollViewSizeChanged_ViewportSnapshot = null;
		}
	}

	protected virtual float UpdateItemSizeOnTwinPass(TItemViewsHolder viewsHolder)
	{
		return ForceRebuildViewsHolder(viewsHolder);
	}

	protected virtual void OnItemHeightChangedPreTwinPass(TItemViewsHolder viewsHolder)
	{
	}

	protected virtual void OnItemWidthChangedPreTwinPass(TItemViewsHolder viewsHolder)
	{
	}

	protected void ScheduleComputeVisibilityTwinPass(bool preferContentEndEdgeStationaryIfSizeChanges = false)
	{
		_InternalState.computeVisibilityTwinPassScheduled = true;
		_InternalState.preferKeepingCTEndEdgeStationaryInNextComputeVisibilityTwinPass = preferContentEndEdgeStationaryIfSizeChanges;
	}

	protected virtual float ForceRebuildViewsHolder(TItemViewsHolder viewsHolder)
	{
		viewsHolder.MarkForRebuild();
		_InternalState.RebuildLayoutImmediateCompat(viewsHolder.root);
		float result = viewsHolder.root.rect.size[_InternalState.hor0_vert1];
		viewsHolder.UnmarkForRebuild();
		return result;
	}

	protected void ForceRebuildViewsHolderAndUpdateSizeWithAutoEndEdge(TItemViewsHolder viewsHolder, bool keepVelocity = true)
	{
		bool itemEndEdgeStationary = GuessShouldKeepEndStationaryOnResize(viewsHolder);
		ForceRebuildViewsHolderAndUpdateSize(viewsHolder, itemEndEdgeStationary, correctPosition: true, keepVelocity);
	}

	protected void ForceRebuildViewsHolderAndUpdateSize(TItemViewsHolder viewsHolder, bool itemEndEdgeStationary = false, bool correctPosition = true, bool keepVelocity = true)
	{
		float requestedSize = ForceRebuildViewsHolder(viewsHolder);
		RequestChangeItemSizeAndUpdateLayout(viewsHolder, requestedSize, itemEndEdgeStationary, computeVisibility: true, correctPosition, keepVelocity);
	}

	protected bool GuessShouldKeepEndStationaryOnResize(TItemViewsHolder viewsHolder)
	{
		RectTransform root = viewsHolder.root;
		float itemRealInsetFromParentStart = GetItemRealInsetFromParentStart(root);
		bool flag = GetItemRealInsetFromParentEnd(root) > itemRealInsetFromParentStart;
		float num = 0f - Mathf.Max(10f, _Params.ContentSpacing);
		return (ContentVirtualInsetFromViewportEnd > (double)num) | flag;
	}

	protected virtual AbstractViewsHolder GetViewsHolderClosestToViewportNormalizedPoint(ICollection<TItemViewsHolder> viewsHolders, Canvas c, RectTransform canvasRectTransform, Vector2 viewportPointNormalized, Vector2 itemPointNormalized, out float distance)
	{
		TItemViewsHolder result = null;
		float num = float.MaxValue;
		foreach (TItemViewsHolder viewsHolder in viewsHolders)
		{
			float magnitude = UIUtils8.Instance.GetWorldVectorBetweenCustomLocalPivots(_Params.Viewport, viewportPointNormalized, viewsHolder.root, itemPointNormalized, c, canvasRectTransform).magnitude;
			if (magnitude < num)
			{
				result = viewsHolder;
				num = magnitude;
			}
		}
		distance = num;
		return result;
	}

	protected virtual AbstractViewsHolder GetViewsHolderClosestoViewportNormalizedAbastractPoint(ICollection<TItemViewsHolder> viewsHolders, Canvas c, RectTransform canvasRectTransform, Vector2 viewportPointNormalizedWithYInverted, Vector2 itemPointNormalizedWithYInverted, out float distance)
	{
		viewportPointNormalizedWithYInverted.y = 1f - viewportPointNormalizedWithYInverted.y;
		itemPointNormalizedWithYInverted.y = 1f - itemPointNormalizedWithYInverted.y;
		return GetViewsHolderClosestToViewportNormalizedPoint(viewsHolders, c, canvasRectTransform, viewportPointNormalizedWithYInverted, itemPointNormalizedWithYInverted, out distance);
	}

	protected virtual void OnScrollPositionChanged(double normPos)
	{
	}

	protected virtual void OnApplyCustomGalleryEffects(TItemViewsHolder vh, double itemCenterDistFromStart01, double itemCenterPosRelativeToPivot01Signed)
	{
	}

	protected virtual void OnRemoveCustomGalleryEffects(TItemViewsHolder vh)
	{
	}

	protected virtual bool IsUserAnimationRunning()
	{
		return false;
	}

	public void SetViewsHolderEnabled(TItemViewsHolder vh, bool vhEnabled)
	{
		if (_Params.optimization.ScaleToZeroInsteadOfDisable)
		{
			Vector3 localScale;
			if (vhEnabled)
			{
				localScale = Vector3.one;
				if (!vh.root.gameObject.activeSelf)
				{
					vh.root.gameObject.SetActive(value: true);
				}
			}
			else
			{
				localScale = Vector3.zero;
			}
			vh.root.localScale = localScale;
		}
		else if (vh.root.gameObject.activeSelf != vhEnabled)
		{
			vh.root.gameObject.SetActive(vhEnabled);
		}
	}

	public void SetViewsHolderEnabled(TItemViewsHolder vh)
	{
		if (_Params.optimization.ScaleToZeroInsteadOfDisable)
		{
			if (!vh.root.gameObject.activeSelf)
			{
				vh.root.gameObject.SetActive(value: true);
			}
			vh.root.localScale = Vector3.one;
		}
		else if (!vh.root.gameObject.activeSelf)
		{
			vh.root.gameObject.SetActive(value: true);
		}
	}

	public bool IsViewsHolderEnabled(TItemViewsHolder vh)
	{
		if (!vh.root.gameObject.activeSelf)
		{
			return false;
		}
		if (_Params.optimization.ScaleToZeroInsteadOfDisable)
		{
			return vh.root.localScale != Vector3.zero;
		}
		return true;
	}

	public void SetViewsHolderDisabled(TItemViewsHolder vh)
	{
		if (_Params.optimization.ScaleToZeroInsteadOfDisable)
		{
			vh.root.localScale = Vector3.zero;
		}
		else if (vh.root.gameObject.activeSelf)
		{
			vh.root.gameObject.SetActive(value: false);
		}
	}

	protected virtual void Dispose()
	{
		_Initialized = false;
		_ForceRebuildLayoutScheduled = false;
		_Rebuilding = false;
		_StackedDragSpeeds = 0;
		_PrimaryEventID = null;
		_PrimaryEventIDOnLast_OnInitializePotentialDrag = null;
		if (IsScrollToAnimationRunning())
		{
			try
			{
				StopCoroutine(_SmoothScrollCoroutine);
			}
			catch
			{
			}
			_SmoothScrollCoroutine = null;
		}
		ClearCachedRecyclableItems();
		_RecyclableItems = null;
		_BufferredRecyclableItems = null;
		ClearVisibleItems();
		_VisibleItems = null;
		_Params = null;
		_InternalState = null;
		if (ItemsRefreshed != null)
		{
			ItemsRefreshed = null;
		}
	}

	protected virtual void Clear()
	{
		_Initialized = false;
		_ForceRebuildLayoutScheduled = false;
		_Rebuilding = false;
		_StackedDragSpeeds = 0;
		_PrimaryEventID = null;
		_PrimaryEventIDOnLast_OnInitializePotentialDrag = null;
		if (IsScrollToAnimationRunning())
		{
			try
			{
				StopCoroutine(_SmoothScrollCoroutine);
			}
			catch
			{
			}
			_SmoothScrollCoroutine = null;
		}
		ClearCachedRecyclableItems();
		ClearVisibleItems();
		_VisibleItems = null;
		_InternalState = null;
		ItemsRefreshed = null;
	}

	private void Drag(double abstrDeltaInCTSpace, AllowContentOutsideBoundsMode allowOutsideBoundsMode, bool cancelSnappingIfAny)
	{
		Drag(abstrDeltaInCTSpace, allowOutsideBoundsMode, cancelSnappingIfAny, out var _, out var _);
	}

	private void Drag(double abstrDeltaInCTSpace, AllowContentOutsideBoundsMode allowOutsideBoundsMode, bool cancelSnappingIfAny, out bool done, out bool looped)
	{
		done = false;
		looped = false;
		double num = 1.0;
		double num2;
		double num3;
		if (abstrDeltaInCTSpace > 0.0)
		{
			num2 = _InternalState.ctVirtualInsetFromVPS_Cached;
			num3 = abstrDeltaInCTSpace;
		}
		else
		{
			num2 = _InternalState.CTVirtualInsetFromVPE_Cached;
			num3 = 0.0 - abstrDeltaInCTSpace;
		}
		double num4 = num2 + num3;
		bool flag;
		if (num4 >= 0.0)
		{
			flag = allowOutsideBoundsMode switch
			{
				AllowContentOutsideBoundsMode.ALLOW_IF_OUTSIDE_AMOUNT_SHRINKS => num4 < num2, 
				AllowContentOutsideBoundsMode.ALLOW => true, 
				_ => false, 
			};
			bool flag2 = num2 >= 0.0;
			if (!flag)
			{
				if (flag2)
				{
					return;
				}
				double val = 0.0 - num2;
				abstrDeltaInCTSpace = (double)Math.Sign(abstrDeltaInCTSpace) * Math.Min(num3, val);
			}
			if (_Params.effects.ElasticMovement & flag2)
			{
				double num5 = num2 / _InternalState.vpSize;
				if (num5 > 1.0)
				{
					num5 = 1.0;
				}
				num = (double)_Params.effects.PullElasticity * (1.0 - num5);
			}
		}
		else
		{
			flag = allowOutsideBoundsMode != AllowContentOutsideBoundsMode.DO_NOT_ALLOW;
		}
		double abstractDelta = abstrDeltaInCTSpace * num;
		looped = DragVisibleItemsRangeUnchecked(0, VisibleItemsCount, abstractDelta, updateCachedCTVirtualInset: true, updateCachedCTVirtualInset_ComputeVisibility: true, flag, cancelSnappingIfAny);
		done = true;
	}

	internal bool DragVisibleItemsRangeUnchecked(int vhStartIndex, int vhEndIndexExcl, double abstractDelta, bool updateCachedCTVirtualInset, bool updateCachedCTVirtualInset_ComputeVisibility, bool updateCachedCTVirtualInset_AllowOutsideBounds = true, bool updateCachedCTVirtualInset_CancelSnappingIfAny = true)
	{
		double num = (float)(abstractDelta * (double)_InternalState.hor1_vertMinus1);
		for (int i = vhStartIndex; i < vhEndIndexExcl; i++)
		{
			TItemViewsHolder val = _VisibleItems[i];
			Vector3 localPosition = val.root.localPosition;
			localPosition[_InternalState.hor0_vert1] = (float)(num + (double)localPosition[_InternalState.hor0_vert1]);
			val.root.localPosition = localPosition;
		}
		if (updateCachedCTVirtualInset)
		{
			_ComputeVisibilityParams_Reusable_DragUnchecked.overrideDelta = abstractDelta;
			double? contentInsetOverride = null;
			if (VisibleItemsCount == 0)
			{
				contentInsetOverride = _InternalState.ctVirtualInsetFromVPS_Cached + abstractDelta;
			}
			ContentSizeOrPositionChangeParams p = new ContentSizeOrPositionChangeParams
			{
				cancelSnappingIfAny = updateCachedCTVirtualInset_CancelSnappingIfAny,
				allowOutsideBounds = updateCachedCTVirtualInset_AllowOutsideBounds,
				computeVisibilityParams = (updateCachedCTVirtualInset_ComputeVisibility ? _ComputeVisibilityParams_Reusable_DragUnchecked : null),
				fireScrollPositionChangedEvent = true,
				keepVelocity = true,
				contentInsetOverride = contentInsetOverride
			};
			return UpdateCTVrtInsetFromVPS(ref p);
		}
		return false;
	}

	private IEnumerator SmoothScrollProgressCoroutine(int itemIndex, double duration, double normalizedOffsetFromViewportStart = 0.0, double normalizedPositionOfItemPivotToUse = 0.0, Func<float, bool> onProgress = null, Action onDone = null)
	{
		double vsa = _InternalState.VirtualScrollableArea;
		if (vsa <= 0.0)
		{
			_SmoothScrollCoroutine = null;
			onProgress?.Invoke(1f);
			onDone?.Invoke();
			yield break;
		}
		bool ignorOnScroll_lastValue = _SkipComputeVisibilityInUpdateOrOnScroll;
		_SkipComputeVisibilityInUpdateOrOnScroll = true;
		StopMovement();
		if (_Params.optimization.ForceLayoutRebuildOnBeginSmoothScroll)
		{
			_InternalState.RebuildLayoutImmediateCompat(_Params.ScrollViewRT);
		}
		Func<double> getTargetVrtInset = () =>
		{
			vsa = _InternalState.VirtualScrollableArea;
			return ScrollToHelper_GetContentStartVirtualInsetFromViewportStart(vsa, itemIndex, normalizedOffsetFromViewportStart, normalizedPositionOfItemPivotToUse, shortestPathWhenLooping: true);
		};
		yield return null;
		Coroutine mySmoothScrollCoroutine = _SmoothScrollCoroutine;
		if (_SmoothScrollCoroutine == null)
		{
			throw new InvalidOperationException();
		}
		_SmoothScrollOnDone = onDone;
		double initialVrtInsetFromParent = -1.0;
		double targetVrtInsetFromParent = -1.0;
		bool needToCalculateInitialInset = true;
		bool needToCalculateTargetInset = true;
		bool notCanceledByCaller = true;
		double startTime = Time;
		WaitForEndOfFrame endOfFrame = new WaitForEndOfFrame();
		ContentSizeOrPositionChangeParams contentPosChangeParams = new ContentSizeOrPositionChangeParams
		{
			computeVisibilityParams = _ComputeVisibilityParams_Reusable_Empty,
			fireScrollPositionChangedEvent = true,
			allowOutsideBounds = true
		};
		bool looped = false;
		Action<double> setInsetAndUpdateLocalsFn = (double inset) =>
		{
			contentPosChangeParams.allowOutsideBounds = _Params.effects.LoopItems && _InternalState.VirtualScrollableArea > 0.0;
			SetContentVirtualInsetFromViewportStart(inset, ref contentPosChangeParams, out looped);
		};
		Func<double, double> lerpFn = OSAMath.GetLerpFunction(_Params.Animation.SmoothScrollType);
		double originalStartTime = startTime;
		double originalDuration = duration;
		bool atLeastOneSizeChangeDetected = false;
		int sizeChanges_LastKnown = _InternalState.totalNumberOfSizeChanges;
		bool atLeastOneTwinPassOrItemSizeChangeDetected = false;
		Action detectTwinPassOrItemSizeChanges = () =>
		{
			if (!atLeastOneSizeChangeDetected && sizeChanges_LastKnown != _InternalState.totalNumberOfSizeChanges)
			{
				sizeChanges_LastKnown = _InternalState.totalNumberOfSizeChanges;
				atLeastOneSizeChangeDetected = true;
			}
			atLeastOneTwinPassOrItemSizeChangeDetected = atLeastOneSizeChangeDetected;
		};
		while (true)
		{
			yield return null;
			detectTwinPassOrItemSizeChanges();
			yield return endOfFrame;
			detectTwinPassOrItemSizeChanges();
			double num = Time;
			double num2 = num - startTime;
			double num3;
			double num4;
			if (num2 >= duration)
			{
				num3 = (num4 = 1.0);
			}
			else
			{
				double arg = num2 / duration;
				double arg2 = (num - originalStartTime) / originalDuration;
				num4 = lerpFn(arg);
				num3 = lerpFn(arg2);
			}
			if (needToCalculateInitialInset)
			{
				initialVrtInsetFromParent = _InternalState.ctVirtualInsetFromVPS_Cached;
				startTime = num;
				duration -= num2;
			}
			if (needToCalculateTargetInset)
			{
				targetVrtInsetFromParent = getTargetVrtInset();
			}
			double num5 = initialVrtInsetFromParent * (1.0 - num4) + targetVrtInsetFromParent * num4;
			if (Math.Abs(targetVrtInsetFromParent - num5) < 0.01)
			{
				num5 = targetVrtInsetFromParent;
				num3 = 1.0;
			}
			if (num5 > 0.0 && !_Params.effects.LoopItems)
			{
				num3 = 1.0;
			}
			else
			{
				setInsetAndUpdateLocalsFn(num5);
				detectTwinPassOrItemSizeChanges();
				if (_Params.effects.LoopItems)
				{
					bool flag = true;
					needToCalculateTargetInset = true;
					needToCalculateInitialInset = flag;
				}
				else
				{
					bool flag;
					needToCalculateTargetInset = (flag = atLeastOneTwinPassOrItemSizeChangeDetected);
					needToCalculateInitialInset = flag;
				}
			}
			if (!(num3 < 1.0))
			{
				break;
			}
			if (onProgress != null)
			{
				bool flag;
				notCanceledByCaller = (flag = onProgress((float)num3));
				if (!flag)
				{
					break;
				}
			}
		}
		if (notCanceledByCaller)
		{
			detectTwinPassOrItemSizeChanges();
			setInsetAndUpdateLocalsFn(getTargetVrtInset());
			detectTwinPassOrItemSizeChanges();
			if (looped | atLeastOneTwinPassOrItemSizeChangeDetected)
			{
				setInsetAndUpdateLocalsFn(getTargetVrtInset());
			}
			if (_Params.effects.LoopItems)
			{
				ComputeVisibilityForCurrentPositionRawParams(forceFireScrollViewPositionChangedEvent: false, potentialTwinPassCTEndStationaryPrioritizeUserPreference: false, -0.1);
				ComputeVisibilityForCurrentPositionRawParams(forceFireScrollViewPositionChangedEvent: true, potentialTwinPassCTEndStationaryPrioritizeUserPreference: false, 0.1);
			}
			_SmoothScrollCoroutine = null;
			_SmoothScrollOnDone = null;
			onProgress?.Invoke(1f);
		}
		else
		{
			if (mySmoothScrollCoroutine == _SmoothScrollCoroutine)
			{
				_SmoothScrollCoroutine = null;
			}
			if (onDone == _SmoothScrollOnDone)
			{
				_SmoothScrollOnDone = null;
			}
		}
		_SkipComputeVisibilityInUpdateOrOnScroll = ignorOnScroll_lastValue;
		if (notCanceledByCaller)
		{
			onDone?.Invoke();
		}
	}

	private double ScrollToHelper_GetContentStartVirtualInsetFromViewportStart(double vsa, int itemIndex, double normalizedItemOffsetFromStart, double normalizedPositionOfItemPivotToUse, bool shortestPathWhenLooping)
	{
		int itemViewIndexFromRealIndexChecked = _ItemsDesc.GetItemViewIndexFromRealIndexChecked(itemIndex);
		double itemVirtualInsetFromParentStartUsingItemIndexInView = _InternalState.GetItemVirtualInsetFromParentStartUsingItemIndexInView(itemViewIndexFromRealIndexChecked);
		double num = _ItemsDesc[itemViewIndexFromRealIndexChecked];
		double num2 = _InternalState.vpSize * normalizedItemOffsetFromStart - num * normalizedPositionOfItemPivotToUse;
		double t = 0.0 - itemVirtualInsetFromParentStartUsingItemIndexInView + num2;
		if (shortestPathWhenLooping && _Params.effects.LoopItems)
		{
			double? num3 = _ScrollToHelper_GetContentStartVirtualInsetFromViewportStart_Looping_ShorterPathIfExists(itemViewIndexFromRealIndexChecked, itemVirtualInsetFromParentStartUsingItemIndexInView, normalizedItemOffsetFromStart, normalizedPositionOfItemPivotToUse, num2);
			if (num3.HasValue)
			{
				return num3.Value;
			}
		}
		double num4 = _InternalState.vpSize / 2.0;
		double num5 = ((_Params.effects.LoopItems && vsa > 0.0) ? num4 : 0.0);
		double min = 0.0 - vsa - num5;
		return ClampDouble(t, min, num5);
	}

	private double? _ScrollToHelper_GetContentStartVirtualInsetFromViewportStart_Looping_ShorterPathIfExists(int itemViewIndex, double itemVrtInsetFromStart, double normalizedItemOffsetFromStart, double normalizedPositionOfItemPivotToUse, double insetToAddFromFineTunedOffsets)
	{
		if (_VisibleItemsCount == 0)
		{
			return null;
		}
		double ctVirtualSize = _InternalState.ctVirtualSize;
		double vpSize = _InternalState.vpSize;
		double num = _ItemsDesc[itemViewIndex];
		double ctVirtualInsetFromVPS_Cached = _InternalState.ctVirtualInsetFromVPS_Cached;
		double num2 = itemVrtInsetFromStart + num;
		double num3 = 0.0 - ctVirtualInsetFromVPS_Cached;
		bool flag = num2 < num3;
		double num4 = itemVrtInsetFromStart + normalizedPositionOfItemPivotToUse * num;
		if (flag)
		{
			double num5 = num4;
			double num6 = num3 - num4;
			double num7 = vpSize * normalizedItemOffsetFromStart;
			double num8 = num6 + num7;
			double num9 = num4 + num8;
			double num10 = ctVirtualSize - num9 + num5;
			if (num8 < num10)
			{
				return null;
			}
			return ctVirtualInsetFromVPS_Cached - num10;
		}
		double num11 = num3 + vpSize;
		if (itemVrtInsetFromStart > num11)
		{
			double num12 = ctVirtualSize - num4;
			double num13 = ctVirtualSize - num3 - vpSize - num12;
			double num14 = vpSize * (1.0 - normalizedItemOffsetFromStart);
			double num15 = num13 + num14;
			double num16 = num4 - num15 + num12;
			if (num15 < num16)
			{
				return null;
			}
			return ctVirtualInsetFromVPS_Cached + num16;
		}
		return null;
	}

	internal double SetContentVirtualInsetFromViewportStart(double virtualInset, ref ContentSizeOrPositionChangeParams p, out bool looped)
	{
		_ReleaseFromPull.inProgress = false;
		double num = virtualInset - _InternalState.ctVirtualInsetFromVPS_Cached;
		if (!p.keepVelocity)
		{
			StopMovement();
		}
		Drag(num, (!_Params.effects.LoopItems || !(_InternalState.VirtualScrollableArea > 0.0)) ? AllowContentOutsideBoundsMode.ALLOW_IF_OUTSIDE_AMOUNT_SHRINKS : AllowContentOutsideBoundsMode.ALLOW, p.cancelSnappingIfAny, out var _, out looped);
		CorrectPositionsOfVisibleItems(alsoCorrectTransversalPositioning: false, p.fireScrollPositionChangedEvent);
		return num;
	}

	private void RecycleAllVisibleViewsHolders()
	{
		while (VisibleItemsCount > 0)
		{
			RecycleOrStealViewsHolder(0, steal: false);
		}
	}

	private void RecycleOrStealViewsHolder(int vhIndex, bool steal)
	{
		TItemViewsHolder val = _VisibleItems[vhIndex];
		if (!steal)
		{
			OnBeforeRecycleOrDisableViewsHolder(val, -1);
			SetViewsHolderDisabled(val);
		}
		_VisibleItems.RemoveAt(vhIndex);
		int visibleItemsCount = VisibleItemsCount - 1;
		VisibleItemsCount = visibleItemsCount;
		if (!steal)
		{
			_RecyclableItems.Add(val);
		}
	}

	private bool UpdateCTVrtInsetFromVPS(ref ContentSizeOrPositionChangeParams p)
	{
		double ctVirtualInsetFromVPS_Cached = _InternalState.ctVirtualInsetFromVPS_Cached;
		double num = _InternalState.paddingContentStart;
		double virtualInset = 0.0;
		if (p.contentInsetOverride.HasValue)
		{
			virtualInset = p.contentInsetOverride.Value;
		}
		else if (VisibleItemsCount > 0)
		{
			TItemViewsHolder val = _VisibleItems[0];
			int itemIndexInView = val.itemIndexInView;
			if (itemIndexInView > 0)
			{
				num += _ItemsDesc.GetItemSizeCumulative(itemIndexInView - 1, allowInferringFromNeighborAfter: false) + (double)itemIndexInView * _InternalState.spacing;
			}
			virtualInset = (double)val.root.GetInsetFromParentEdge(_Params.Content, _InternalState.startEdge) - num;
		}
		bool skipComputeVisibilityInUpdateOrOnScroll = _SkipComputeVisibilityInUpdateOrOnScroll;
		_SkipComputeVisibilityInUpdateOrOnScroll = true;
		if (p.cancelSnappingIfAny && (bool)_Params.Snapper)
		{
			_Params.Snapper.CancelSnappingIfInProgress();
		}
		if (!p.keepVelocity)
		{
			StopMovement();
		}
		_InternalState.UpdateCachedCTVirtInsetFromVPS(virtualInset, p.allowOutsideBounds);
		bool result = false;
		if (p.computeVisibilityParams != null)
		{
			result = ComputeVisibilityForCurrentPosition(p.computeVisibilityParams);
		}
		if (p.fireScrollPositionChangedEvent)
		{
			OnScrollPositionChangedInternal();
		}
		_SkipComputeVisibilityInUpdateOrOnScroll = skipComputeVisibilityInUpdateOrOnScroll;
		if (_Params.effects.HasContentVisual)
		{
			double num2 = _InternalState.ctVirtualInsetFromVPS_Cached - ctVirtualInsetFromVPS_Cached;
			num2 += (double)_Params.effects.ContentVisualParallaxEffect * num2;
			Rect uvRect = _Params.effects.ContentVisual.uvRect;
			Vector2 position = uvRect.position;
			float num3 = position[_InternalState.hor0_vert1];
			double num4 = num2 / _InternalState.vpSize;
			double num5 = (num4 - Math.Floor(num4)) * (double)(-_InternalState.hor1_vertMinus1);
			if (num5 < 0.0)
			{
				num5 = 1.0 + num5;
			}
			double num6 = (double)num3 + num5;
			num6 -= Math.Floor(num6);
			if (num6 < 0.0)
			{
				num6 = 1.0 + num6;
			}
			position[_InternalState.hor0_vert1] = (float)num6;
			uvRect.position = position;
			_Params.effects.ContentVisual.uvRect = uvRect;
		}
		return result;
	}

	private void ShiftViewsHolderItemIndexAndFireEvent(TItemViewsHolder vh, int shift, bool wasInsert, int insertOrRemoveIndex)
	{
		int itemIndex = vh.ItemIndex;
		vh.ShiftIndex(shift, _ItemsDesc.itemsCount);
		OnItemIndexChangedDueInsertOrRemove(vh, itemIndex, wasInsert, insertOrRemoveIndex);
	}

	private void ShiftViewsHolderItemIndexInView(TItemViewsHolder vh, int shift)
	{
		vh.ShiftIndexInView(shift, _ItemsDesc.itemsCount);
	}

	private void ChangeItemsCountInternal(ItemCountChangeMode changeMode, int count, int indexIfInsertingOrRemoving, bool contentPanelEndEdgeStationary, bool keepVelocity, bool stealInsteadOfRecycle)
	{
		if (!_Initialized && !_SkipInitializationChecks)
		{
			throw new OSAException("ChangeItemsCountInternal: OSA not initialized. Before using it, make sure the GameObject is active in hierarchy, the OSA component is enabled, and Start has been called. If you overrode OnInitialized, please call base.OnInitialized() on the first line of your function");
		}
		int itemsCount = _ItemsDesc.itemsCount;
		switch (changeMode)
		{
		case ItemCountChangeMode.INSERT:
		{
			if (indexIfInsertingOrRemoving < 0 || indexIfInsertingOrRemoving > itemsCount)
			{
				throw new ArgumentOutOfRangeException("indexIfInsertingOrRemoving", indexIfInsertingOrRemoving, "should be >=0 and <= than itemsCount(=" + itemsCount + ")");
			}
			long num = (long)itemsCount + (long)count;
			if (num > 2147483646)
			{
				throw new ArgumentOutOfRangeException("newCount", num, "should be <= MAX_COUNT(=" + 2147483646 + ")");
			}
			break;
		}
		case ItemCountChangeMode.REMOVE:
			if (indexIfInsertingOrRemoving < 0 || indexIfInsertingOrRemoving >= itemsCount)
			{
				throw new ArgumentOutOfRangeException("indexIfInsertingOrRemoving", indexIfInsertingOrRemoving, "should be >=0 and < than itemsCount(=" + itemsCount + ")");
			}
			if (count < 1)
			{
				throw new ArgumentOutOfRangeException("count", count, "should be > 0");
			}
			if (indexIfInsertingOrRemoving + count > itemsCount)
			{
				throw new ArgumentOutOfRangeException("indexIfInsertingOrRemoving + count", count, "indexIfInsertingOrRemoving+count = " + (indexIfInsertingOrRemoving + count) + " should be <= itemsCount(=" + _ItemsDesc.itemsCount + ")");
			}
			break;
		}
		if (_Params.effects.LoopItems && changeMode != ItemCountChangeMode.RESET)
		{
			throw new OSAException("ChangeItemsCountInternal: At the moment, only ItemCountChangeMode.RESET is supported when looping. Use ResetItems()");
		}
		AnimationCancelling cancel = _Params.Animation.Cancel;
		CancelAnimations(snapping: true, cancel.SmoothScroll.OnCountChanges, cancel.UserAnimations.OnCountChanges);
		if (_ReleaseFromPull.inProgress)
		{
			if (VisibleItemsCount > 0)
			{
				_ReleaseFromPull.FinishNowByDraggingItems(computeVisibility: false);
			}
			else
			{
				_ReleaseFromPull.FinishNowBySettingContentInset(computeVisibility: false);
			}
		}
		bool skipComputeVisibilityInUpdateOrOnScroll = _SkipComputeVisibilityInUpdateOrOnScroll;
		_SkipComputeVisibilityInUpdateOrOnScroll = true;
		int num2 = -1;
		if (itemsCount > 0 && changeMode != ItemCountChangeMode.RESET)
		{
			num2 = ((indexIfInsertingOrRemoving != itemsCount) ? _ItemsDesc.GetItemViewIndexFromRealIndexChecked(indexIfInsertingOrRemoving) : (_ItemsDesc.GetItemViewIndexFromRealIndexChecked(indexIfInsertingOrRemoving - 1) + 1));
		}
		Vector2 velocity = _Velocity;
		if (!keepVelocity)
		{
			StopMovement();
		}
		double num3 = _InternalState.CalculateContentVirtualSize();
		CollectItemsSizes(changeMode, count, indexIfInsertingOrRemoving, _ItemsDesc);
		int itemsCount2 = _ItemsDesc.itemsCount;
		double num4 = _InternalState.CalculateContentVirtualSize();
		double num5 = num4 - num3;
		double additionalCTDragAbstrDelta = 0.0;
		_InternalState.CorrectParametersOnCTSizeChange(contentPanelEndEdgeStationary, out var _, ref additionalCTDragAbstrDelta, num4, num5);
		double num6 = 0.0 - _InternalState.VirtualScrollableArea;
		bool flag = _InternalState.CTVirtualInsetFromVPE_Cached >= 0.0;
		if (GetNumExcessRecycleableItems() > 0)
		{
			throw new OSAException("ChangeItemsCountInternal: GetNumExcessObjects() > 0 when calling ChangeItemsCountInternal(); this may be due ComputeVisibility not being finished executing yet");
		}
		double? num7 = null;
		double? num8 = null;
		bool flag2 = false;
		bool flag3 = false;
		bool flag4 = false;
		int num9 = -1;
		if (VisibleItemsCount > 0 && changeMode != ItemCountChangeMode.RESET)
		{
			int itemIndexInView = _VisibleItems[0].itemIndexInView;
			num9 = num2 - itemIndexInView;
		}
		switch (changeMode)
		{
		case ItemCountChangeMode.INSERT:
			if (VisibleItemsCount > 0)
			{
				for (int k = 0; k < VisibleItemsCount; k++)
				{
					TItemViewsHolder vh = _VisibleItems[k];
					if (vh.itemIndexInView >= num2)
					{
						ShiftViewsHolderItemIndexInView(vh, count);
					}
					if (vh.ItemIndex >= indexIfInsertingOrRemoving)
					{
						ShiftViewsHolderItemIndexAndFireEvent(vh, count, wasInsert: true, indexIfInsertingOrRemoving);
					}
				}
			}
			if (contentPanelEndEdgeStationary)
			{
				if (num6 > 0.0)
				{
					num8 = _InternalState.ctVirtualInsetFromVPS_Cached - num5;
					flag2 = true;
				}
				if (VisibleItemsCount > 0)
				{
					int num17 = num9;
					int num18 = num17 - 1;
					num7 = -0.1;
					if (num18 < 0)
					{
						num7 = 0.1;
					}
					else if (num17 >= VisibleItemsCount)
					{
						DragVisibleItemsRangeUnchecked(0, VisibleItemsCount, 0.0 - num5, updateCachedCTVirtualInset: false, updateCachedCTVirtualInset_ComputeVisibility: false);
					}
					else
					{
						double firstVHInsetFromEdge = _VisibleItems[num18].root.GetInsetFromParentEdge(_Params.Content, _InternalState.endEdge);
						DragVisibleItemsRangeUnchecked(0, num17, 0.0 - num5, updateCachedCTVirtualInset: false, updateCachedCTVirtualInset_ComputeVisibility: false);
						int num19;
						for (num19 = num18; num19 >= 0; num19--)
						{
							TItemViewsHolder vh = _VisibleItems[num19];
							if ((double)vh.root.GetInsetFromParentEdge(_Params.Content, _InternalState.endEdge) > _InternalState.vpSize)
							{
								break;
							}
						}
						if (num19 >= 0)
						{
							num17 -= num19 + 1;
						}
						while (num19 >= 0)
						{
							RecycleOrStealViewsHolder(num19--, stealInsteadOfRecycle);
						}
						int startIndexInView = num2 - 1 + count;
						double num20 = AddViewsHoldersAndMakeVisible(firstVHInsetFromEdge, _InternalState.endEdge, num17, startIndexInView, count, 0, -1);
						num8 = (num8.HasValue ? (num8 - num20) : new double?(_InternalState.ctVirtualInsetFromVPS_Cached - num20));
						flag2 = true;
					}
				}
			}
			else
			{
				if (num6 > 0.0)
				{
					num8 = _InternalState.ctVirtualInsetFromVPS_Cached;
					flag2 = true;
				}
				if (VisibleItemsCount > 0)
				{
					int num21 = num9;
					if (num21 < VisibleItemsCount)
					{
						if (num21 < 0)
						{
							num7 = 0.1;
							DragVisibleItemsRangeUnchecked(0, VisibleItemsCount, num5, updateCachedCTVirtualInset: false, updateCachedCTVirtualInset_ComputeVisibility: false);
						}
						else
						{
							double firstVHInsetFromEdge2 = _VisibleItems[num21].root.GetInsetFromParentEdge(_Params.Content, _InternalState.startEdge);
							DragVisibleItemsRangeUnchecked(num21, VisibleItemsCount, num5, updateCachedCTVirtualInset: false, updateCachedCTVirtualInset_ComputeVisibility: false);
							int k;
							for (k = num21; k < VisibleItemsCount; k++)
							{
								TItemViewsHolder vh = _VisibleItems[k];
								if ((double)vh.root.GetInsetFromParentEdge(_Params.Content, _InternalState.startEdge) > _InternalState.vpSize)
								{
									break;
								}
							}
							while (k < VisibleItemsCount)
							{
								RecycleOrStealViewsHolder(k, stealInsteadOfRecycle);
							}
							AddViewsHoldersAndMakeVisible(firstVHInsetFromEdge2, _InternalState.startEdge, num21, num2, count, 1, 1);
						}
					}
					else
					{
						num7 = -0.1;
					}
				}
			}
			if (!flag2 && _Params.effects.ElasticMovement && IsDragging && (!_Params.ForwardDragToParents || !_NestingManager.CurrentDragCapturedByParent))
			{
				flag2 = true;
			}
			break;
		case ItemCountChangeMode.REMOVE:
		{
			if (VisibleItemsCount <= 0)
			{
				break;
			}
			int num10 = num9;
			int num11 = num10 + count;
			int num12 = num11 - 1;
			int num13 = 0;
			int num14 = 0;
			int visibleItemsCount;
			if (contentPanelEndEdgeStationary)
			{
				if (num6 > 0.0)
				{
					num8 = _InternalState.ctVirtualInsetFromVPS_Cached - num5 + additionalCTDragAbstrDelta;
					flag2 = true;
				}
				visibleItemsCount = VisibleItemsCount;
				int num15;
				if (num11 > VisibleItemsCount)
				{
					if (num10 < 0)
					{
						goto case ItemCountChangeMode.RESET;
					}
					num7 = 0.1;
					if (num10 >= VisibleItemsCount)
					{
						num15 = VisibleItemsCount;
						num13 = 0;
					}
					else
					{
						num15 = num10;
						num13 = VisibleItemsCount - num15;
						flag4 = true;
					}
				}
				else if (num10 < 0)
				{
					num15 = 0;
					if (num12 < 0)
					{
						num13 = 0;
					}
					else
					{
						num13 = num11;
						num7 = 0.1;
						flag4 = true;
					}
				}
				else
				{
					num15 = num10;
					num13 = num11 - num15;
					num7 = 0.1;
					flag4 = true;
				}
				while (num13-- > 0)
				{
					RecycleOrStealViewsHolder(num15, stealInsteadOfRecycle);
				}
				DragVisibleItemsRangeUnchecked(0, num15, 0.0 - num5 + additionalCTDragAbstrDelta, updateCachedCTVirtualInset: false, updateCachedCTVirtualInset_ComputeVisibility: false);
				if (num15 < VisibleItemsCount)
				{
					if (additionalCTDragAbstrDelta != 0.0)
					{
						DragVisibleItemsRangeUnchecked(num15, VisibleItemsCount, additionalCTDragAbstrDelta, updateCachedCTVirtualInset: false, updateCachedCTVirtualInset_ComputeVisibility: false);
					}
					for (int i = num15; i < VisibleItemsCount; i++)
					{
						TItemViewsHolder vh = _VisibleItems[i];
						ShiftViewsHolderItemIndexInView(vh, -count);
						ShiftViewsHolderItemIndexAndFireEvent(vh, -count, wasInsert: false, indexIfInsertingOrRemoving);
					}
				}
				break;
			}
			if (num6 > 0.0)
			{
				num8 = _InternalState.ctVirtualInsetFromVPS_Cached + additionalCTDragAbstrDelta;
				flag2 = true;
			}
			int vhStartIndex = 0;
			int num16;
			if (num10 < 0)
			{
				num16 = 0;
				if (num12 < 0)
				{
					num14 = count;
				}
				else
				{
					if (num12 >= VisibleItemsCount)
					{
						goto case ItemCountChangeMode.RESET;
					}
					num14 = -num10;
					flag4 = true;
				}
				num7 = -0.1;
			}
			else if (num10 < VisibleItemsCount)
			{
				num16 = num10;
				if (num11 > VisibleItemsCount)
				{
					num14 = num11 - VisibleItemsCount;
				}
				num7 = -0.1;
				flag4 = true;
			}
			else
			{
				num14 = count;
				num16 = VisibleItemsCount;
			}
			visibleItemsCount = num16;
			num13 = count - num14;
			while (num13-- > 0)
			{
				RecycleOrStealViewsHolder(num16, stealInsteadOfRecycle);
			}
			if (additionalCTDragAbstrDelta != 0.0)
			{
				DragVisibleItemsRangeUnchecked(vhStartIndex, visibleItemsCount, additionalCTDragAbstrDelta, updateCachedCTVirtualInset: false, updateCachedCTVirtualInset_ComputeVisibility: false);
			}
			if (num16 < VisibleItemsCount)
			{
				DragVisibleItemsRangeUnchecked(num16, VisibleItemsCount, num5 + additionalCTDragAbstrDelta, updateCachedCTVirtualInset: false, updateCachedCTVirtualInset_ComputeVisibility: false);
				for (int j = num16; j < VisibleItemsCount; j++)
				{
					TItemViewsHolder vh = _VisibleItems[j];
					ShiftViewsHolderItemIndexInView(vh, -count);
					ShiftViewsHolderItemIndexAndFireEvent(vh, -count, wasInsert: false, indexIfInsertingOrRemoving);
				}
			}
			break;
		}
		case ItemCountChangeMode.RESET:
			flag3 = true;
			num8 = ((!contentPanelEndEdgeStationary) ? new double?(_InternalState.ctVirtualInsetFromVPS_Cached + additionalCTDragAbstrDelta) : new double?(_InternalState.ctVirtualInsetFromVPS_Cached - num5 + additionalCTDragAbstrDelta));
			break;
		}
		ContentSizeOrPositionChangeParams p = new ContentSizeOrPositionChangeParams
		{
			keepVelocity = keepVelocity,
			contentEndEdgeStationary = contentPanelEndEdgeStationary,
			contentInsetOverride = num8,
			allowOutsideBounds = flag2
		};
		OnCumulatedSizesOfAllItemsChanged(ref p);
		if (itemsCount2 == 0)
		{
			flag3 = _Params.optimization.KeepItemsPoolOnEmptyList;
			if (!flag3)
			{
				ClearVisibleItems();
				ClearCachedRecyclableItems();
			}
		}
		if (flag3)
		{
			RecycleAllVisibleViewsHolders();
		}
		double num22;
		if (num7.HasValue)
		{
			num22 = num7.Value;
		}
		else if (itemsCount == 0)
		{
			num22 = 0.0;
		}
		else if (contentPanelEndEdgeStationary)
		{
			num22 = 0.1;
		}
		else
		{
			num22 = -0.1;
			if (flag)
			{
				num22 = 0.1;
			}
		}
		double num23 = 0.0 - _InternalState.VirtualScrollableArea;
		bool flag5 = flag4 && (additionalCTDragAbstrDelta != 0.0 || num23 >= 0.0);
		if (_InternalState.ConsumeFlag_computeVisibilityTwinPassScheduled())
		{
			bool contentEndEdgeStationary = _InternalState.ConsumeFlag_preferKeepingCTEndEdgeStationaryInNextComputeVisibilityTwinPass();
			ComputeVisibilityTwinPass(contentEndEdgeStationary);
		}
		if (flag4)
		{
			CorrectPositionsOfVisibleItems(alsoCorrectTransversalPositioning: true, fireScrollPositionChangedEvent: false);
		}
		ComputeVisibilityForCurrentPositionRawParams(forceFireScrollViewPositionChangedEvent: false, potentialTwinPassCTEndStationaryPrioritizeUserPreference: true, num22);
		if (flag5)
		{
			ComputeVisibilityForCurrentPositionRawParams(forceFireScrollViewPositionChangedEvent: false, potentialTwinPassCTEndStationaryPrioritizeUserPreference: true, 0.0 - num22);
		}
		CorrectPositionsOfVisibleItems(alsoCorrectTransversalPositioning: true, fireScrollPositionChangedEvent: true);
		if (keepVelocity)
		{
			_Velocity = velocity;
		}
		OnItemsRefreshed(itemsCount, itemsCount2);
		if (ItemsRefreshed != null)
		{
			ItemsRefreshed(itemsCount, itemsCount2);
		}
		_SkipComputeVisibilityInUpdateOrOnScroll = skipComputeVisibilityInUpdateOrOnScroll;
	}

	private void MyUpdate()
	{
		if (_InternalState.computeVisibilityTwinPassScheduled)
		{
			throw new OSAException("ScheduleComputeVisibilityTwinPass() can only be called during UpdateViewsHolder() or OnItemIndexChangedDueInsertOrRemove() !!!");
		}
		if (_ForceRebuildLayoutScheduled || _InternalState.HasScrollViewSizeChanged)
		{
			ForceRebuildLayout();
		}
		else
		{
			_NavigationManager.OnUpdate();
		}
	}

	private void MyLateUpdate()
	{
		bool inProgress = _ReleaseFromPull.inProgress;
		double virtualScrollableArea = _InternalState.VirtualScrollableArea;
		double num = 0.0 - virtualScrollableArea;
		bool flag = num > 0.0;
		double emptyAreaWhenCTSmallerThanVP = Math.Max(0.0, num);
		Snapper8 snapper = _Params.Snapper;
		bool flag2 = _InternalState.totalNumberOfSizeChangesLastFrame == _InternalState.totalNumberOfSizeChanges;
		bool num2 = ((!flag && !inProgress && !IsDragging && !_ReleaseFromPull.IsPulled() && !_SkipComputeVisibilityInUpdateOrOnScroll) & flag2) && (bool)snapper;
		bool flag3 = false;
		if (num2)
		{
			snapper.StartSnappingIfNeeded();
			flag3 = snapper.SnappingInProgress;
		}
		UpdateGalleryEffectIfNeeded(onlyIfEffectAmountChanged: true);
		float deltaTime = DeltaTime;
		bool flag4 = true;
		float currentVelocity = _Velocity[_InternalState.hor0_vert1];
		AllowContentOutsideBoundsMode allowOutsideBoundsMode = AllowContentOutsideBoundsMode.DO_NOT_ALLOW;
		bool flag5 = false;
		if (flag)
		{
			_ReleaseFromPull.targetCTInsetFromVPS = _InternalState.GetTargetCTVirtualInsetFromVPSWhenCTSmallerThanVP(emptyAreaWhenCTSmallerThanVP);
			if (_IsDragging)
			{
				_ReleaseFromPull.inProgress = false;
				_Velocity[_InternalState.hor0_vert1] = 0f;
			}
			else
			{
				flag5 = true;
				float num3;
				float num4;
				if (VisibleItemsCount > 0)
				{
					num3 = (float)_ReleaseFromPull.CalculateFirstItemInsetFromVPS();
					num4 = (float)_ReleaseFromPull.CalculateFirstItemTargetInsetFromVPS();
				}
				else
				{
					num3 = (float)_InternalState.ctVirtualInsetFromVPS_Cached;
					num4 = (float)_ReleaseFromPull.targetCTInsetFromVPS;
				}
				_ReleaseFromPull.inProgress = (double)Math.Abs(num3 - num4) >= 1.0;
				if (_Params.effects.ElasticMovement)
				{
					float currentVelocity2 = currentVelocity * (float)_InternalState.hor1_vertMinus1;
					Mathf.SmoothDamp(num3, num4, ref currentVelocity2, _Params.effects.ReleaseTime, float.PositiveInfinity, deltaTime);
					currentVelocity = ((!_ReleaseFromPull.inProgress) ? 0f : (currentVelocity2 * (float)_InternalState.hor1_vertMinus1));
				}
				else
				{
					if (_ReleaseFromPull.inProgress)
					{
						if (VisibleItemsCount > 0)
						{
							_ReleaseFromPull.FinishNowByDraggingItems(computeVisibility: true);
						}
						else
						{
							_ReleaseFromPull.FinishNowBySettingContentInset(computeVisibility: false);
						}
					}
					currentVelocity = 0f;
				}
				_Velocity[_InternalState.hor0_vert1] = currentVelocity;
			}
		}
		else if (_IsDragging | flag3)
		{
			_ReleaseFromPull.inProgress = false;
		}
		else
		{
			double ctVirtualInsetFromVPS_Cached = _InternalState.ctVirtualInsetFromVPS_Cached;
			bool flag6 = ctVirtualInsetFromVPS_Cached > 0.0;
			double num5;
			if (flag6)
			{
				num5 = ctVirtualInsetFromVPS_Cached;
				_ReleaseFromPull.targetCTInsetFromVPS = 0.0;
			}
			else
			{
				double cTVirtualInsetFromVPE_Cached = _InternalState.CTVirtualInsetFromVPE_Cached;
				if (cTVirtualInsetFromVPE_Cached > 0.0)
				{
					num5 = cTVirtualInsetFromVPE_Cached;
					_ReleaseFromPull.targetCTInsetFromVPS = 0.0 - virtualScrollableArea;
				}
				else
				{
					num5 = 0.0;
				}
			}
			bool flag7 = num5 > 0.0;
			bool flag8 = false;
			_ReleaseFromPull.inProgress = flag7;
			if (_Params.effects.ElasticMovement)
			{
				bool flag9 = false;
				if (_ReleaseFromPull.inProgress)
				{
					allowOutsideBoundsMode = AllowContentOutsideBoundsMode.ALLOW_IF_OUTSIDE_AMOUNT_SHRINKS;
					flag4 = false;
					double num6 = ((num5 > 3.4028234663852886E+38) ? 3.4028234663852886E+38 : num5);
					double num7 = ((!flag6) ? ((0.0 - num6) * (double)_InternalState.hor1_vertMinus1) : (num6 * (double)_InternalState.hor1_vertMinus1));
					float f = Mathf.SmoothDamp((float)num7, 0f, ref currentVelocity, _Params.effects.ReleaseTime, float.PositiveInfinity, deltaTime);
					_ReleaseFromPull.inProgress = Mathf.Abs(f) >= 1f;
					if (_ReleaseFromPull.inProgress)
					{
						_Velocity[_InternalState.hor0_vert1] = currentVelocity;
					}
					else
					{
						flag8 = (flag9 = true);
					}
				}
				else
				{
					flag9 = inProgress;
					flag8 = inProgress && num5 < 0.1;
					flag4 = !flag8;
					if (!flag8)
					{
						allowOutsideBoundsMode = AllowContentOutsideBoundsMode.ALLOW;
					}
				}
				if (flag9)
				{
					currentVelocity = (_Velocity[_InternalState.hor0_vert1] = 0f);
				}
			}
			else if (_Params.effects.LoopItems)
			{
				allowOutsideBoundsMode = AllowContentOutsideBoundsMode.ALLOW;
				if (flag7 && (VisibleItemsCount != _ItemsDesc.itemsCount || !(virtualScrollableArea > 0.0)))
				{
					flag8 = true;
				}
			}
			else if (flag7)
			{
				flag8 = true;
			}
			if (flag8)
			{
				_ReleaseFromPull.FinishNowBySettingContentInset(computeVisibility: true);
			}
		}
		if (_Params.effects.Inertia && !flag3)
		{
			float num9 = Mathf.Pow(1f - _Params.effects.InertiaDecelerationRate, deltaTime);
			if (_IsDragging)
			{
				_VelocityToAddOnDragEnd *= num9;
				float magnitude = _VelocityToAddOnDragEnd.magnitude;
				if (magnitude < 1f)
				{
					_VelocityToAddOnDragEnd = Vector2.zero;
				}
				else
				{
					float num10 = magnitude / _Params.effects.MaxSpeed;
					if (num10 > 1f)
					{
						_VelocityToAddOnDragEnd /= num10;
					}
				}
			}
			else if (flag4)
			{
				if (Mathf.Abs(currentVelocity) < 2f)
				{
					_Velocity[_InternalState.hor0_vert1] = 0f;
					int index = 1 - _InternalState.hor0_vert1;
					_Velocity[index] *= num9;
				}
				else
				{
					_Velocity *= num9;
				}
			}
		}
		Velocity = _Velocity;
		currentVelocity = _Velocity[_InternalState.hor0_vert1];
		if (!_IsDragging && !flag3 && currentVelocity != 0f)
		{
			float num11 = currentVelocity * (float)_InternalState.hor1_vertMinus1;
			double num12 = (double)num11 * (double)deltaTime;
			if ((double)Math.Abs(num11) > 0.001)
			{
				if (flag5)
				{
					DragVisibleItemsRangeUnchecked(0, VisibleItemsCount, num12, updateCachedCTVirtualInset: true, updateCachedCTVirtualInset_ComputeVisibility: true);
				}
				else
				{
					Drag(num12, allowOutsideBoundsMode, cancelSnappingIfAny: false, out var _, out var _);
				}
			}
		}
		_InternalState.totalNumberOfSizeChangesLastFrame = _InternalState.totalNumberOfSizeChanges;
	}

	private void MyOnDisable()
	{
		CancelAllAnimations();
		_SkipComputeVisibilityInUpdateOrOnScroll = false;
	}

	private void OnScrollPositionChangedInternal()
	{
		UpdateGalleryEffectIfNeeded(onlyIfEffectAmountChanged: false);
		double normalizedPosition = GetNormalizedPosition();
		OnScrollPositionChanged(normalizedPosition);
		if (ScrollPositionChanged != null)
		{
			ScrollPositionChanged(normalizedPosition);
		}
	}

	private double GetDeltaForComputeVisibility()
	{
		return _InternalState.ctVirtualInsetFromVPS_Cached - _InternalState.lastProcessedCTVirtualInsetFromVPS;
	}

	private bool ComputeVisibilityForCurrentPosition(ComputeVisibilityParams p)
	{
		if (p.overrideDelta.HasValue)
		{
			return ComputeVisibilityForCurrentPositionRawParams(p.forceFireScrollPositionChangedEvent, p.potentialTwinPassCTEndStationaryPrioritizeUserPreference, p.overrideDelta.Value);
		}
		return ComputeVisibilityForCurrentPosition(p.forceFireScrollPositionChangedEvent, p.potentialTwinPassCTEndStationaryPrioritizeUserPreference);
	}

	private bool ComputeVisibilityForCurrentPositionRawParams(bool forceFireScrollViewPositionChangedEvent, bool potentialTwinPassCTEndStationaryPrioritizeUserPreference, double overrideScrollingDelta)
	{
		double ctVirtualInsetFromVPS_Cached = _InternalState.ctVirtualInsetFromVPS_Cached;
		_InternalState.lastProcessedCTVirtualInsetFromVPS = ctVirtualInsetFromVPS_Cached - overrideScrollingDelta;
		return ComputeVisibilityForCurrentPosition(forceFireScrollViewPositionChangedEvent, potentialTwinPassCTEndStationaryPrioritizeUserPreference);
	}

	private bool ComputeVisibilityForCurrentPosition(bool forceFireScrollViewPositionChangedEvent, bool potentialTwinPassCTEndStationaryPrioritizeUserPreference)
	{
		if (_InternalState.computeVisibilityTwinPassScheduled)
		{
			throw new OSAException("ScheduleComputeVisibilityTwinPass() can only be called during UpdateViewsHolder() or OnItemIndexChangedDueInsertOrRemove() !!!");
		}
		double num = GetDeltaForComputeVisibility();
		Vector2 velocity = _Velocity;
		bool result = false;
		if (_Params.effects.LoopItems)
		{
			result = LoopIfNeeded(num);
		}
		_ComputeVisibilityManager.ComputeVisibility(num);
		if (_InternalState.ConsumeFlag_computeVisibilityTwinPassScheduled())
		{
			bool flag = _InternalState.ConsumeFlag_preferKeepingCTEndEdgeStationaryInNextComputeVisibilityTwinPass();
			bool contentEndEdgeStationary = ((potentialTwinPassCTEndStationaryPrioritizeUserPreference || num == 0.0) ? flag : (num > 0.0));
			if (num == 0.0)
			{
				num = -0.1;
			}
			int num2 = 20;
			int num3 = 0;
			bool flag2;
			do
			{
				ComputeVisibilityTwinPass(contentEndEdgeStationary);
				flag2 = false;
				double ctVirtualSize = _InternalState.ctVirtualSize;
				_ComputeVisibilityManager.ComputeVisibility(num);
				_ComputeVisibilityManager.ComputeVisibility(0.0 - num);
				if (_InternalState.ConsumeFlag_computeVisibilityTwinPassScheduled())
				{
					ComputeVisibilityTwinPass(contentEndEdgeStationary);
					_InternalState.ConsumeFlag_computeVisibilityTwinPassScheduled();
				}
				flag2 = ctVirtualSize != _InternalState.ctVirtualSize;
				num3++;
				if (num3 == num2)
				{
					throw new OSAException("Max iterations (" + num2 + ") reached for TwinPass. \nIf you're using ContentSizeFitter, make sure the DefaultItemSize is smaller than the size of any generated item.\nIf you're also using BaseParamsWithPrefab for the params, DefaultItemSize will be automatically set to the prefab's size, so in this case make the prefab as small as possible instead.");
				}
			}
			while (flag2);
		}
		_InternalState.UpdateLastProcessedCTVirtualInsetFromVPStart();
		if (!IsDragging)
		{
			_Velocity = velocity;
		}
		if (forceFireScrollViewPositionChangedEvent || num != 0.0)
		{
			OnScrollPositionChangedInternal();
		}
		return result;
	}

	private void ComputeVisibilityTwinPass(bool contentEndEdgeStationary)
	{
		if (VisibleItemsCount == 0)
		{
			throw new OSAException("computeVisibilityTwinPassScheduled, but there are no visible items.ScheduleComputeVisibilityTwinPass() can only be called during UpdateViewsHolder() or OnItemIndexChangedDueInsertOrRemove() !!!");
		}
		int itemsCount = GetItemsCount();
		if (_Params.effects.LoopItems && itemsCount > 800000000)
		{
			throw new OSAException("If looping is enabled, ComputeVisibilityTwinPass can only be used if item count is less than " + 800000000 + " (currently having " + itemsCount + "). This prevents UI overlaps due to rounding errors");
		}
		bool skipComputeVisibilityInUpdateOrOnScroll = _SkipComputeVisibilityInUpdateOrOnScroll;
		_SkipComputeVisibilityInUpdateOrOnScroll = true;
		double[] array = new double[VisibleItemsCount];
		Action<TItemViewsHolder> action = ((!_Params.IsHorizontal) ? new Action<TItemViewsHolder>(OnItemHeightChangedPreTwinPass) : new Action<TItemViewsHolder>(OnItemWidthChangedPreTwinPass));
		for (int i = 0; i < VisibleItemsCount; i++)
		{
			TItemViewsHolder val = _VisibleItems[i];
			array[i] = UpdateItemSizeOnTwinPass(val);
			action(val);
		}
		OnItemsSizesChangedExternally(_VisibleItems, array, contentEndEdgeStationary);
		_SkipComputeVisibilityInUpdateOrOnScroll = skipComputeVisibilityInUpdateOrOnScroll;
	}

	private bool LoopIfNeeded(double delta)
	{
		if (delta == 0.0)
		{
			return false;
		}
		if (_InternalState.VirtualScrollableArea <= 0.0)
		{
			return false;
		}
		if (VisibleItemsCount == 0)
		{
			_ = _ItemsDesc.itemsCount;
			return false;
		}
		ContentSizeOrPositionChangeParams p = new ContentSizeOrPositionChangeParams
		{
			allowOutsideBounds = true,
			keepVelocity = true
		};
		bool flag = delta <= 0.0;
		TItemViewsHolder val = _VisibleItems[0];
		TItemViewsHolder val2 = _VisibleItems[VisibleItemsCount - 1];
		int itemIndexInView = val.itemIndexInView;
		int itemIndexInView2 = val2.itemIndexInView;
		bool flag2 = itemIndexInView == 0;
		bool flag3 = itemIndexInView2 == _ItemsDesc.itemsCount - 1;
		int newValueOf_RealIndexOfFirstItemInView;
		if (flag)
		{
			if (!flag3)
			{
				return false;
			}
			if (flag2 && (double)(0f - val.root.GetInsetFromParentEdge(_Params.Content, _InternalState.startEdge)) <= 0.0)
			{
				return false;
			}
			if ((double)(0f - val2.root.GetInsetFromParentEdge(_Params.Content, _InternalState.endEdge)) > 0.0)
			{
				return false;
			}
			newValueOf_RealIndexOfFirstItemInView = val.ItemIndex;
			for (int i = 0; i < VisibleItemsCount; i++)
			{
				_VisibleItems[i].itemIndexInView = i;
			}
		}
		else
		{
			if (!flag2)
			{
				return false;
			}
			if (flag3 && (double)(0f - val2.root.GetInsetFromParentEdge(_Params.Content, _InternalState.endEdge)) <= 0.0)
			{
				return false;
			}
			if ((double)(0f - val.root.GetInsetFromParentEdge(_Params.Content, _InternalState.startEdge)) > 0.0)
			{
				return false;
			}
			newValueOf_RealIndexOfFirstItemInView = _ItemsDesc.GetItemRealIndexFromViewIndex(itemIndexInView2 + 1);
			for (int j = 0; j < VisibleItemsCount; j++)
			{
				_VisibleItems[j].itemIndexInView = _ItemsDesc.itemsCount - VisibleItemsCount + j;
			}
		}
		_ItemsDesc.RotateItemsSizesOnScrollViewLooped(newValueOf_RealIndexOfFirstItemInView);
		UpdateCTVrtInsetFromVPS(ref p);
		CorrectPositionsOfVisibleItems(alsoCorrectTransversalPositioning: true, fireScrollPositionChangedEvent: true);
		_InternalState.UpdateLastProcessedCTVirtualInsetFromVPStart();
		return true;
	}

	private void CorrectPositionsOfVisibleItems(bool alsoCorrectTransversalPositioning, bool fireScrollPositionChangedEvent)
	{
		if (VisibleItemsCount > 0)
		{
			_InternalState.CorrectPositions(_VisibleItems, alsoCorrectTransversalPositioning);
		}
		if (fireScrollPositionChangedEvent)
		{
			OnScrollPositionChangedInternal();
		}
	}

	internal TItemViewsHolder ExtractRecyclableViewsHolderOrCreateNew(int indexOfItemThatWillBecomeVisible, double sizeOfItem)
	{
		TItemViewsHolder val = TryExtractRecyclableViewsHolderFrom(_RecyclableItems, indexOfItemThatWillBecomeVisible, sizeOfItem);
		if (val == null)
		{
			val = TryExtractRecyclableViewsHolderFrom(_BufferredRecyclableItems, indexOfItemThatWillBecomeVisible, sizeOfItem);
		}
		if (val == null)
		{
			val = CreateViewsHolder(indexOfItemThatWillBecomeVisible);
		}
		return val;
	}

	private TItemViewsHolder TryExtractRecyclableViewsHolderFrom(IList<TItemViewsHolder> vhsToChooseFrom, int indexOfItemThatWillBecomeVisible, double sizeOfItem)
	{
		for (int i = 0; i < vhsToChooseFrom.Count; i++)
		{
			TItemViewsHolder val = vhsToChooseFrom[i];
			if (IsRecyclable(val, indexOfItemThatWillBecomeVisible, sizeOfItem))
			{
				OnBeforeRecycleOrDisableViewsHolder(val, indexOfItemThatWillBecomeVisible);
				vhsToChooseFrom.RemoveAt(i);
				return val;
			}
		}
		return null;
	}

	internal void AddViewsHolderAndMakeVisible(TItemViewsHolder vh, int vhIndex, int itemIndex, int itemIndexInView, double realInsetFromEdge, RectTransform.Edge insetEdge, double size)
	{
		_VisibleItems.Insert(vhIndex, vh);
		int visibleItemsCount = VisibleItemsCount + 1;
		VisibleItemsCount = visibleItemsCount;
		if (itemIndexInView < 0 || itemIndexInView >= _ItemsDesc.itemsCount)
		{
			throw new OSAException("OSA internal error: itemIndexInView " + itemIndexInView + ", while itemsCount is " + _ItemsDesc.itemsCount);
		}
		vh.ItemIndex = itemIndex;
		vh.itemIndexInView = itemIndexInView;
		RectTransform root = vh.root;
		root.SetParent(_Params.Content, worldPositionStays: false);
		SetViewsHolderEnabled(vh);
		UpdateViewsHolder(vh);
		if (!IsViewsHolderEnabled(vh))
		{
			string text = (_Params.optimization.ScaleToZeroInsteadOfDisable ? "have a zero scale" : "be disabled");
			throw new OSAException("AddViewsHolderAndMakeVisible: VH detected to " + text + " after UpdateViewsHolder() was called on it. This is not allowed. " + vh.root);
		}
		Vector2 anchorMin = (root.anchorMax = _InternalState.layoutInfo.constantAnchorPosForAllItems);
		root.anchorMin = anchorMin;
		if (_Params.optimization.KeepItemsSortedInHierarchy && vhIndex < _Params.Content.childCount)
		{
			root.SetSiblingIndex(vhIndex);
		}
		root.SetInsetAndSizeFromParentEdgeWithCurrentAnchors(insetEdge, (float)realInsetFromEdge, (float)size);
		_InternalState.GetTransversalInsetStartAndSizeToUse(vh, out var insetStart, out var size2);
		root.SetInsetAndSizeFromParentEdgeWithCurrentAnchors(_InternalState.transvStartEdge, insetStart, size2);
	}

	private double AddViewsHoldersAndMakeVisible(double firstVHInsetFromEdge, RectTransform.Edge insetEdge, int vhStartIndex, int startIndexInView, int maxCount, int vhIndexIncrement, int itemIndexInViewIncrementSign)
	{
		TItemViewsHolder val = null;
		double num = firstVHInsetFromEdge;
		int num2 = 0;
		int num3 = vhStartIndex;
		int num4 = startIndexInView;
		while (num <= _InternalState.vpSize && num2 < maxCount)
		{
			double num5 = _ItemsDesc[num4];
			int itemRealIndexFromViewIndex = _ItemsDesc.GetItemRealIndexFromViewIndex(num4);
			val = ExtractRecyclableViewsHolderOrCreateNew(itemRealIndexFromViewIndex, num5);
			AddViewsHolderAndMakeVisible(val, num3, itemRealIndexFromViewIndex, num4, num, insetEdge, num5);
			num += num5 + _InternalState.spacing;
			num2++;
			num3 += vhIndexIncrement;
			num4 += itemIndexInViewIncrementSign;
		}
		double num6 = 0.0;
		if (startIndexInView > 0)
		{
			num6 = _ItemsDesc.GetItemSizeCumulative(startIndexInView - 1, allowInferringFromNeighborAfter: false);
		}
		return _ItemsDesc.GetItemSizeCumulative(startIndexInView + maxCount - 1, allowInferringFromNeighborAfter: false) - num6 + _InternalState.spacing * (double)maxCount;
	}

	internal int GetNumExcessRecycleableItems()
	{
		if (_RecyclableItems.Count > 1)
		{
			int maxNumObjectsToKeepInMemory = GetMaxNumObjectsToKeepInMemory();
			int num = _RecyclableItems.Count + VisibleItemsCount - maxNumObjectsToKeepInMemory;
			if (num > 0)
			{
				return num;
			}
		}
		return 0;
	}

	private int GetMaxNumObjectsToKeepInMemory()
	{
		int recycleBinCapacity = _Params.optimization.RecycleBinCapacity;
		if (recycleBinCapacity > 0)
		{
			return recycleBinCapacity + VisibleItemsCount;
		}
		return _ItemsDesc.maxVisibleItemsSeenSinceLastScrollViewSizeChange + _ItemsDesc.destroyedItemsSinceLastScrollViewSizeChange + 1;
	}

	protected internal IList<TItemViewsHolder> CreateBufferredRecycleableItems(int count, int indexToPass = -1)
	{
		List<TItemViewsHolder> list = new List<TItemViewsHolder>(count);
		for (int i = 0; i < count; i++)
		{
			TItemViewsHolder val = CreateViewsHolder(indexToPass);
			val.root.SetParent(_Params.Content, worldPositionStays: false);
			SetViewsHolderDisabled(val);
			list.Add(val);
		}
		return list;
	}

	protected internal void AddBufferredRecycleableItems(IList<TItemViewsHolder> vhs)
	{
		foreach (TItemViewsHolder vh in vhs)
		{
			AddBufferredRecycleableItem(vh);
		}
	}

	protected internal void AddBufferredRecycleableItem(TItemViewsHolder vh)
	{
		_BufferredRecyclableItems.Add(vh);
	}

	private void UpdateGalleryEffectIfNeeded(bool onlyIfEffectAmountChanged)
	{
		bool flag = _PrevGalleryEffectAmount == _Params.effects.Gallery.OverallAmount;
		if (flag & onlyIfEffectAmountChanged)
		{
			return;
		}
		if (_Params.effects.Gallery.OverallAmount == 0f)
		{
			if (flag)
			{
				return;
			}
			RemoveGalleryEffectFromItems(_RecyclableItems, areEnabled: false);
			RemoveGalleryEffectFromItems(_BufferredRecyclableItems, areEnabled: false);
			RemoveGalleryEffectFromItems(_VisibleItems, areEnabled: true);
		}
		else
		{
			if (VisibleItemsCount == 0 || _ItemsDesc.itemsCount == 0)
			{
				return;
			}
			for (int i = 0; i < VisibleItemsCount; i++)
			{
				TItemViewsHolder val = _VisibleItems[i];
				double val2 = ((double)val.root.GetInsetFromParentEdge(_Params.Content, _InternalState.startEdge) + _ItemsDesc[val.itemIndexInView] / 2.0) / _InternalState.vpSize;
				val2 = Math.Min(1.0, Math.Max(0.0, val2));
				val.root.localScale = ComposeGalleryEffectFinalAmount(_Params.effects.Gallery.Scale, val2, out var vhDistFromVPPivot01Signed);
				val.root.localEulerAngles = ComposeGalleryEffectFinalAmount(_Params.effects.Gallery.Rotation, val2, out vhDistFromVPPivot01Signed);
				double itemCenterDistFromStart = val2;
				double itemCenterPosRelativeToPivot01Signed = vhDistFromVPPivot01Signed * 2.0;
				OnApplyCustomGalleryEffects(val, itemCenterDistFromStart, itemCenterPosRelativeToPivot01Signed);
			}
		}
		_PrevGalleryEffectAmount = _Params.effects.Gallery.OverallAmount;
	}

	private Vector3 ComposeGalleryEffectFinalAmount(GalleryAnimation effectParams, double vhCenterRealInsetFromStart01, out double vhDistFromVPPivot01Signed)
	{
		float viewportPivot = effectParams.ViewportPivot;
		double value = vhCenterRealInsetFromStart01 - (double)viewportPivot;
		int num = Math.Sign(value);
		double val = Math.Abs(value);
		val = Math.Min(2.0, val);
		vhDistFromVPPivot01Signed = (double)num * val;
		double num2 = Math.Abs((double)viewportPivot - 0.5) + 0.5;
		val /= num2;
		float f = 1f - (float)val;
		float p = Mathf.Clamp(effectParams.Exponent, 1f, 50f);
		f = Mathf.Pow(f, p);
		f = Mathf.Clamp01(f);
		float t = effectParams.Amount * _Params.effects.Gallery.OverallAmount;
		if (effectParams == _Params.effects.Gallery.Scale)
		{
			Vector3 one = Vector3.one;
			Vector3 vector = effectParams.TransformSpace.Transform(f);
			float minValue = _Params.effects.Gallery.Scale.MinValue;
			vector = new Vector3(Mathf.Max(minValue, vector.x), Mathf.Max(minValue, vector.y), Mathf.Max(minValue, vector.z));
			return Vector3.Lerp(one, vector, t);
		}
		Vector3 zero = Vector3.zero;
		Quaternion b = Quaternion.Lerp(Quaternion.Euler(effectParams.TransformSpace.From), Quaternion.Euler(effectParams.TransformSpace.To), f);
		_ = b.eulerAngles;
		return Quaternion.Lerp(Quaternion.Euler(zero), b, t).eulerAngles;
	}

	private void RemoveGalleryEffectFromItems(IList<TItemViewsHolder> vhs, bool areEnabled)
	{
		if (vhs == null)
		{
			return;
		}
		bool scaleToZeroInsteadOfDisable = _Params.optimization.ScaleToZeroInsteadOfDisable;
		Vector3 vector = (areEnabled ? Vector3.one : Vector3.zero);
		foreach (TItemViewsHolder vh in vhs)
		{
			if (vh == null || !vh.root)
			{
				continue;
			}
			if (scaleToZeroInsteadOfDisable)
			{
				if (vh.root.localScale != vector)
				{
					vh.root.localScale = vector;
				}
			}
			else
			{
				vh.root.localScale = Vector3.one;
			}
			vh.root.localEulerAngles = Vector3.zero;
			OnRemoveCustomGalleryEffects(vh);
		}
	}

	private void OnCumulatedSizesOfAllItemsChanged(ref ContentSizeOrPositionChangeParams p)
	{
		_InternalState.ctVirtualSize = _InternalState.CalculateContentVirtualSize();
		_ReleaseFromPull.inProgress = false;
		UpdateCTVrtInsetFromVPS(ref p);
		_InternalState.totalNumberOfSizeChanges++;
	}

	private double ChangeItemSizeAndUpdateContentSizeAccordingly(TItemViewsHolder viewsHolder, int itemIndexInView, double curSize, double requestedSize, bool itemEndEdgeStationary)
	{
		double num = requestedSize - curSize;
		double newCTSize = _InternalState.ctVirtualSize + num;
		double additionalCTDragAbstrDelta = 0.0;
		_InternalState.CorrectParametersOnCTSizeChange(itemEndEdgeStationary, out var _, ref additionalCTDragAbstrDelta, newCTSize, num);
		int num2;
		if (viewsHolder == null)
		{
			int itemIndexInView2 = _VisibleItems[0].itemIndexInView;
			if (itemIndexInView < itemIndexInView2)
			{
				num2 = -1;
			}
			else
			{
				int itemIndexInView3 = _VisibleItems[VisibleItemsCount - 1].itemIndexInView;
				if (itemIndexInView <= itemIndexInView3)
				{
					throw new OSAException("ChangeItemSizeAndUpdateContentSizeAccordingly: the item with itemIndexInView " + itemIndexInView + " is neither visible, nor before, nor after the visible items?");
				}
				num2 = VisibleItemsCount;
			}
		}
		else
		{
			if (viewsHolder.root == null)
			{
				throw new OSAException("ChangeItemSizeAndUpdateContentSizeAccordingly: Unexpected state: ViewsHolder not found among visible items. Shouldn't happen if implemented according to documentation/examples");
			}
			RectTransform.Edge edge;
			float newInset;
			if (itemEndEdgeStationary)
			{
				edge = _InternalState.endEdge;
				newInset = (float)((double)viewsHolder.root.GetInsetFromParentEdge(_Params.Content, edge) - additionalCTDragAbstrDelta);
			}
			else
			{
				edge = _InternalState.startEdge;
				newInset = (float)((double)viewsHolder.root.GetInsetFromParentEdge(_Params.Content, edge) + additionalCTDragAbstrDelta);
			}
			viewsHolder.root.SetInsetAndSizeFromParentEdgeWithCurrentAnchors(edge, newInset, (float)requestedSize);
			num2 = _VisibleItems.IndexOf(viewsHolder);
		}
		if (itemEndEdgeStationary)
		{
			DragVisibleItemsRangeUnchecked(0, num2, 0.0 - num + additionalCTDragAbstrDelta, updateCachedCTVirtualInset: false, updateCachedCTVirtualInset_ComputeVisibility: false);
			if (additionalCTDragAbstrDelta != 0.0)
			{
				DragVisibleItemsRangeUnchecked(num2 + 1, VisibleItemsCount, additionalCTDragAbstrDelta, updateCachedCTVirtualInset: false, updateCachedCTVirtualInset_ComputeVisibility: false);
			}
		}
		else
		{
			DragVisibleItemsRangeUnchecked(num2 + 1, VisibleItemsCount, num + additionalCTDragAbstrDelta, updateCachedCTVirtualInset: false, updateCachedCTVirtualInset_ComputeVisibility: false);
			if (additionalCTDragAbstrDelta != 0.0)
			{
				DragVisibleItemsRangeUnchecked(0, num2, additionalCTDragAbstrDelta, updateCachedCTVirtualInset: false, updateCachedCTVirtualInset_ComputeVisibility: false);
			}
		}
		_ItemsDesc.BeginChangingItemsSizes(itemIndexInView);
		_ItemsDesc[itemIndexInView] = requestedSize;
		_ItemsDesc.EndChangingItemsSizes();
		ContentSizeOrPositionChangeParams p = new ContentSizeOrPositionChangeParams
		{
			computeVisibilityParams = _ComputeVisibilityParams_Reusable_Empty,
			fireScrollPositionChangedEvent = true,
			keepVelocity = true,
			allowOutsideBounds = true,
			contentEndEdgeStationary = itemEndEdgeStationary
		};
		OnCumulatedSizesOfAllItemsChanged(ref p);
		return requestedSize;
	}

	private void OnItemsSizesChangedExternally(List<TItemViewsHolder> vhs, double[] sizes, bool itemEndEdgeStationary)
	{
		if (_ItemsDesc.itemsCount == 0)
		{
			throw new OSAException("Cannot change item sizes externally if the items count is 0!");
		}
		int count = vhs.Count;
		double num = _InternalState.CalculateContentVirtualSize();
		int itemIndexInView = vhs[0].itemIndexInView;
		_ItemsDesc.BeginChangingItemsSizes(itemIndexInView);
		for (int i = 0; i < count; i++)
		{
			int itemIndexInView2 = vhs[i].itemIndexInView;
			_ItemsDesc[itemIndexInView2] = sizes[i];
		}
		_ItemsDesc.EndChangingItemsSizes();
		double num2 = _InternalState.CalculateContentVirtualSize();
		double num3 = num2 - num;
		double additionalCTDragAbstrDelta = 0.0;
		_InternalState.CorrectParametersOnCTSizeChange(itemEndEdgeStationary, out var _, ref additionalCTDragAbstrDelta, num2, num3);
		double num4 = _InternalState.ctVirtualInsetFromVPS_Cached;
		if (itemEndEdgeStationary)
		{
			num4 -= num3;
		}
		num4 += additionalCTDragAbstrDelta;
		ContentSizeOrPositionChangeParams p = new ContentSizeOrPositionChangeParams
		{
			cancelSnappingIfAny = true,
			keepVelocity = true,
			allowOutsideBounds = true,
			contentEndEdgeStationary = itemEndEdgeStationary,
			contentInsetOverride = num4
		};
		OnCumulatedSizesOfAllItemsChanged(ref p);
		CorrectPositionsOfVisibleItems(alsoCorrectTransversalPositioning: true, fireScrollPositionChangedEvent: true);
	}

	private void OnScrollViewSizeChangedBase()
	{
		if (ScrollViewSizeChanged != null)
		{
			ScrollViewSizeChanged();
		}
		OnScrollViewSizeChanged();
	}

	private void RecomputeVisibility_Auto(out bool looped)
	{
		looped = false;
		if (_InternalState.VirtualScrollableArea <= 0.0 || GetItemsCount() == 0)
		{
			return;
		}
		bool flag = false;
		bool flag2 = false;
		if (VisibleItemsCount == 0)
		{
			flag = (flag2 = true);
		}
		else
		{
			TItemViewsHolder val = _VisibleItems[0];
			if ((double)GetItemRealInsetFromParentStart(val.root) > _InternalState.paddingContentStart + 1.0)
			{
				flag2 = true;
			}
			if (GetItemsCount() > 1)
			{
				TItemViewsHolder val2 = _VisibleItems[VisibleItemsCount - 1];
				if ((double)GetItemRealInsetFromParentEnd(val2.root) > _InternalState.paddingContentEnd + 1.0)
				{
					flag = true;
				}
			}
		}
		if (flag)
		{
			looped = ComputeVisibilityForCurrentPositionRawParams(forceFireScrollViewPositionChangedEvent: false, potentialTwinPassCTEndStationaryPrioritizeUserPreference: true, -0.10000000149011612);
		}
		if (flag2)
		{
			looped = ComputeVisibilityForCurrentPositionRawParams(forceFireScrollViewPositionChangedEvent: false, potentialTwinPassCTEndStationaryPrioritizeUserPreference: true, 0.10000000149011612) | looped;
		}
	}

	private void ForceRebuildLayout()
	{
		if (_InternalState.computeVisibilityTwinPassScheduled)
		{
			throw new OSAException("ScheduleComputeVisibilityTwinPass() can only be called during UpdateViewsHolder() or OnItemIndexChangedDueInsertOrRemove() !!!");
		}
		_ForceRebuildLayoutScheduled = false;
		_Rebuilding = true;
		OnScrollViewSizeChangedBase();
		RebuildLayoutDueToScrollViewSizeChange();
		Refresh(contentPanelEndEdgeStationary: false, keepVelocity: true);
		_Rebuilding = false;
		PostRebuildLayoutDueToScrollViewSizeChange();
	}

	private bool ForceUpdateViewsHolder(TItemViewsHolder vh)
	{
		if (_InternalState.computeVisibilityTwinPassScheduled)
		{
			throw new OSAException("You shouldn't call ForceUpdateViewsHolderIfVisible during a ComputeVisibilityForCurrentPosition, UpdateViewsHolder or CreateViewsHolder");
		}
		UpdateViewsHolder(vh);
		bool flag = _InternalState.ConsumeFlag_computeVisibilityTwinPassScheduled();
		if (flag)
		{
			bool itemEndEdgeStationary = _InternalState.ConsumeFlag_preferKeepingCTEndEdgeStationaryInNextComputeVisibilityTwinPass();
			ForceRebuildViewsHolderAndUpdateSize(vh, itemEndEdgeStationary);
		}
		return flag;
	}

	private double ClampDouble(double t, double min, double max)
	{
		if (t < min)
		{
			return min;
		}
		if (t > max)
		{
			return max;
		}
		return t;
	}
}
