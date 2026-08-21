using System;
using System.Collections.Generic;
using System.Reflection;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

[DisallowMultipleComponent]
[RequireComponent(typeof(LoopListView2))]
public sealed class LoopListView2FastCenterSnapScale : MonoBehaviour
{
	private sealed class CacheData
	{
		public Transform scaleTarget;

		public RectTransform measureRect;

		public Vector3 baseScale;
	}

	[Header("Reference")]
	[SerializeField]
	private LoopListView2 loopListView;

	[Tooltip("留空=缩放整个Item根节点；填写子节点路径=只缩放该子节点，例如 VisualRoot")]
	[SerializeField]
	private string scaleTargetPath = string.Empty;

	[Header("Init Focus")]
	[SerializeField]
	private bool focusDefaultItemOnInitialize = true;

	[SerializeField]
	private int defaultFocusItemIndex;

	[Header("Spacer Item")]
	[SerializeField]
	private bool useSpacerItems = true;

	[SerializeField]
	private int headSpacerItemCount = 2;

	[SerializeField]
	private int tailSpacerItemCount = 2;

	[Header("Auto Padding")]
	[SerializeField]
	private bool autoHeadTailPadding = true;

	[SerializeField]
	private bool recalculatePaddingOnEnable = true;

	[SerializeField]
	private float extraHeadPadding;

	[SerializeField]
	private float extraTailPadding;

	[Header("Scale")]
	[SerializeField]
	private float minScale = 0.85f;

	[SerializeField]
	private float maxScale = 1.15f;

	[SerializeField]
	private float effectRange = -1f;

	[SerializeField]
	private AnimationCurve scaleCurve = AnimationCurve.EaseInOut(0f, 0f, 1f, 1f);

	[SerializeField]
	private float scaleSmoothSpeed = 20f;

	[Header("Fast Snap")]
	[SerializeField]
	private bool snapOnEndDrag = true;

	[SerializeField]
	private bool snapOnStart = true;

	[SerializeField]
	private float snapDuration = 0.12f;

	[SerializeField]
	private AnimationCurve snapCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.75f, 0.96f), new Keyframe(1f, 1f));

	[Header("Focus Optimize")]
	[SerializeField]
	private bool forceClampedWhileFocus = true;

	[SerializeField]
	private float focusSnapMinDistance = 0.5f;

	[SerializeField]
	private float fallbackItemSize;

	[Header("Measure")]
	[Tooltip("用于计算中心距离的节点路径。留空=使用Item根节点")]
	[SerializeField]
	private string measureTargetPath = string.Empty;

	[Header("Time")]
	[SerializeField]
	private bool useUnscaledTime = true;

	public Action<int> FocusItemStarted;

	public Action<int> FocusItemFinished;

	public Action<int> CenterItemChanged;

	public Action<int, LoopListViewItem2> CenterItemChangedEx;

	public Action<int> FinalCenterItemSettled;

	public Action<int, LoopListViewItem2> FinalCenterItemSettledEx;

	public Func<int, float> ItemSizeProvider;

	private RectTransform viewport;

	private ScrollRect scrollRect;

	private bool subscribed;

	private bool paddingInitialized;

	private bool pendingSnapAfterEndDrag;

	private bool pendingSnapOnStart;

	private bool hasPerformedInitialFocus;

	private bool isSnapping;

	private float snapElapsed;

	private Vector2 snapStartPos;

	private Vector2 snapTargetPos;

	private bool hasPendingFocusRequest;

	private int pendingFocusItemIndex = -1;

	private bool pendingFocusImmediate;

	private int currentFocusItemIndex = -1;

	private int lastCenteredItemIndex = -1;

	private int configuredDataItemCount = -1;

	private ScrollRect.MovementType cachedMovementType;

	private bool movementTypeOverridden;

	private readonly Dictionary<LoopListViewItem2, CacheData> cacheDict = new Dictionary<LoopListViewItem2, CacheData>();

	private readonly HashSet<LoopListViewItem2> visibleItems = new HashSet<LoopListViewItem2>();

	private static readonly BindingFlags PrivateInstance = BindingFlags.Instance | BindingFlags.NonPublic;

	private static readonly FieldInfo PaddingTopField = typeof(LoopListView2).GetField("mPaddingTop", PrivateInstance);

	private static readonly FieldInfo PaddingBottomField = typeof(LoopListView2).GetField("mPaddingBottom", PrivateInstance);

	private static readonly FieldInfo PaddingLeftField = typeof(LoopListView2).GetField("mPaddingLeft", PrivateInstance);

	private static readonly FieldInfo PaddingRightField = typeof(LoopListView2).GetField("mPaddingRight", PrivateInstance);

	public bool IsSnapping => isSnapping;

	public int HeadSpacerItemCount
	{
		get
		{
			if (!useSpacerItems)
			{
				return 0;
			}
			return Mathf.Max(0, headSpacerItemCount);
		}
	}

	public int TailSpacerItemCount
	{
		get
		{
			if (!useSpacerItems)
			{
				return 0;
			}
			return Mathf.Max(0, tailSpacerItemCount);
		}
	}

	private void Reset()
	{
		loopListView = GetComponent<LoopListView2>();
	}

	private void Awake()
	{
		EnsureRefs();
		pendingSnapOnStart = snapOnStart;
	}

	private void OnEnable()
	{
		EnsureRefs();
		SubscribeEvents();
		if (recalculatePaddingOnEnable)
		{
			paddingInitialized = false;
		}
		pendingSnapOnStart = snapOnStart;
		pendingSnapAfterEndDrag = false;
		hasPerformedInitialFocus = false;
		StopSnapTween();
	}

	private void OnDisable()
	{
		UnsubscribeEvents();
		StopSnapTween();
		EndProgrammaticFocus();
		ResetAllScale();
	}

	private void OnDestroy()
	{
		UnsubscribeEvents();
		StopSnapTween();
		EndProgrammaticFocus();
		ResetAllScale();
		cacheDict.Clear();
		visibleItems.Clear();
	}

	public void SetDataItemCountForInit(int dataItemCount)
	{
		configuredDataItemCount = Mathf.Max(0, dataItemCount);
	}

	public void SetSpacerItemCount(int headCount, int tailCount)
	{
		headSpacerItemCount = Mathf.Max(0, headCount);
		tailSpacerItemCount = Mathf.Max(0, tailCount);
	}

	public int GetLoopItemCount(int dataItemCount)
	{
		dataItemCount = Mathf.Max(0, dataItemCount);
		configuredDataItemCount = dataItemCount;
		if (dataItemCount == 0)
		{
			return 0;
		}
		return dataItemCount + HeadSpacerItemCount + TailSpacerItemCount;
	}

	public int GetConfiguredDataItemCount()
	{
		return Mathf.Max(0, configuredDataItemCount);
	}

	public int GetDataItemCount()
	{
		if (loopListView != null && loopListView.IsInited)
		{
			int num = Mathf.Max(0, loopListView.ItemTotalCount);
			if (!useSpacerItems)
			{
				return num;
			}
			if (num == 0)
			{
				return 0;
			}
			return Mathf.Max(0, num - HeadSpacerItemCount - TailSpacerItemCount);
		}
		return Mathf.Max(0, configuredDataItemCount);
	}

	public int DataIndexToLoopIndex(int dataIndex)
	{
		if (!useSpacerItems)
		{
			return dataIndex;
		}
		return dataIndex + HeadSpacerItemCount;
	}

	public int LoopIndexToDataIndex(int loopIndex)
	{
		if (!useSpacerItems)
		{
			return loopIndex;
		}
		return loopIndex - HeadSpacerItemCount;
	}

	public bool TryLoopIndexToDataIndex(int loopIndex, out int dataIndex)
	{
		dataIndex = LoopIndexToDataIndex(loopIndex);
		int dataItemCount = GetDataItemCount();
		if (dataIndex >= 0)
		{
			return dataIndex < dataItemCount;
		}
		return false;
	}

	public bool IsSpacerLoopIndex(int loopIndex)
	{
		if (!useSpacerItems)
		{
			return false;
		}
		int dataIndex;
		return !TryLoopIndexToDataIndex(loopIndex, out dataIndex);
	}

	public bool IsSpacerItem(LoopListViewItem2 item)
	{
		if (item != null)
		{
			return IsSpacerLoopIndex(item.ItemIndex);
		}
		return false;
	}

	private int GetFirstRealLoopIndex()
	{
		if (GetDataItemCount() <= 0)
		{
			return -1;
		}
		return HeadSpacerItemCount;
	}

	private int GetLastRealLoopIndex()
	{
		int dataItemCount = GetDataItemCount();
		if (dataItemCount <= 0)
		{
			return -1;
		}
		return HeadSpacerItemCount + dataItemCount - 1;
	}

	public void SetInitFocusItem(bool enable, int itemIndex = 0)
	{
		focusDefaultItemOnInitialize = enable;
		if (enable)
		{
			defaultFocusItemIndex = itemIndex;
		}
	}

	private void LateUpdate()
	{
		EnsureRefs();
		if (loopListView == null || scrollRect == null)
		{
			return;
		}
		if (!useSpacerItems && autoHeadTailPadding && !paddingInitialized)
		{
			TryInitializeAutoPadding();
		}
		if (hasPendingFocusRequest && IsReady())
		{
			int dataItemCount = GetDataItemCount();
			if (dataItemCount > 0)
			{
				if (!hasPerformedInitialFocus)
				{
					hasPerformedInitialFocus = true;
				}
				int dataIndex = Mathf.Clamp(pendingFocusItemIndex, 0, dataItemCount - 1);
				bool immediate = pendingFocusImmediate;
				hasPendingFocusRequest = false;
				pendingFocusItemIndex = -1;
				pendingFocusImmediate = false;
				ExecuteFocusLoopItem(DataIndexToLoopIndex(dataIndex), immediate);
			}
		}
		else if (!hasPerformedInitialFocus && focusDefaultItemOnInitialize && IsReady())
		{
			int dataItemCount2 = GetDataItemCount();
			if (dataItemCount2 > 0)
			{
				hasPerformedInitialFocus = true;
				pendingSnapOnStart = false;
				pendingSnapAfterEndDrag = false;
				hasPendingFocusRequest = false;
				FocusItem(Mathf.Clamp(defaultFocusItemIndex, 0, dataItemCount2 - 1), immediate: true);
			}
		}
		else if (pendingSnapOnStart && IsReady())
		{
			pendingSnapOnStart = false;
			SnapToNearest(immediate: true);
		}
		if (pendingSnapAfterEndDrag && IsReady() && !loopListView.IsDraging)
		{
			pendingSnapAfterEndDrag = false;
			SnapToNearest(immediate: false);
		}
		UpdateSnapTween();
		ApplyScale(immediate: false);
	}

	public void RefreshNow()
	{
		EnsureRefs();
		if (!useSpacerItems && autoHeadTailPadding && !paddingInitialized)
		{
			TryInitializeAutoPadding();
		}
		ApplyScale(immediate: true);
	}

	public void MarkPaddingDirty()
	{
		if (!useSpacerItems)
		{
			paddingInitialized = false;
		}
	}

	public void RecalculatePaddingAndCenter()
	{
		if (useSpacerItems)
		{
			SnapToNearest(immediate: true);
			return;
		}
		paddingInitialized = false;
		TryInitializeAutoPadding();
		SnapToNearest(immediate: true);
	}

	public void FocusItem(int dataIndex, bool immediate = false)
	{
		EnsureRefs();
		int dataItemCount = GetDataItemCount();
		if (!(loopListView == null) && dataItemCount > 0)
		{
			dataIndex = Mathf.Clamp(dataIndex, 0, dataItemCount - 1);
			pendingSnapAfterEndDrag = false;
			pendingSnapOnStart = false;
			if (!IsReady())
			{
				hasPendingFocusRequest = true;
				pendingFocusItemIndex = dataIndex;
				pendingFocusImmediate = immediate;
			}
			else
			{
				ExecuteFocusLoopItem(DataIndexToLoopIndex(dataIndex), immediate);
			}
		}
	}

	public void FocusItem(LoopListViewItem2 item, bool immediate = false)
	{
		if (!(item == null) && TryLoopIndexToDataIndex(item.ItemIndex, out var dataIndex))
		{
			FocusItem(dataIndex, immediate);
		}
	}

	public int GetCurrentCenterItemIndex()
	{
		LoopListViewItem2 nearestShownItem = GetNearestShownItem();
		if (nearestShownItem == null)
		{
			return -1;
		}
		if (!TryLoopIndexToDataIndex(nearestShownItem.ItemIndex, out var dataIndex))
		{
			return -1;
		}
		return dataIndex;
	}

	public void CancelFocusTween()
	{
		StopSnapTween();
		StopAllMotion();
		EndProgrammaticFocus();
		currentFocusItemIndex = -1;
	}

	public void SnapToNearest(bool immediate)
	{
		EnsureRefs();
		if (!IsReady())
		{
			return;
		}
		BeginProgrammaticFocus();
		LoopListViewItem2 nearestShownItem = GetNearestShownItem();
		if (nearestShownItem == null)
		{
			EndProgrammaticFocus();
			return;
		}
		currentFocusItemIndex = nearestShownItem.ItemIndex;
		if (TryLoopIndexToDataIndex(currentFocusItemIndex, out var dataIndex))
		{
			FocusItemStarted?.Invoke(dataIndex);
		}
		Vector2 pos = CalculateCenteredContentPos(nearestShownItem);
		pos = ClampContentPosition(pos);
		Vector2 anchoredPosition = scrollRect.content.anchoredPosition;
		float num = (loopListView.IsVertList ? Mathf.Abs(pos.y - anchoredPosition.y) : Mathf.Abs(pos.x - anchoredPosition.x));
		if (immediate || num <= focusSnapMinDistance || snapDuration <= 0f)
		{
			SetContentPosition(pos);
			ApplyScale(immediate: true);
			isSnapping = false;
			FinishFocus();
		}
		else
		{
			StartSnapTween(pos);
		}
	}

	private int GetInitOrRestoreLoopIndex()
	{
		int dataItemCount = GetDataItemCount();
		if (dataItemCount <= 0)
		{
			return -1;
		}
		int dataIndex = Mathf.Clamp(defaultFocusItemIndex, 0, dataItemCount - 1);
		if (!hasPerformedInitialFocus && focusDefaultItemOnInitialize)
		{
			return DataIndexToLoopIndex(dataIndex);
		}
		LoopListViewItem2 nearestShownItem = GetNearestShownItem();
		if (nearestShownItem != null)
		{
			return nearestShownItem.ItemIndex;
		}
		return DataIndexToLoopIndex(dataIndex);
	}

	private void ExecuteFocusLoopItem(int loopItemIndex, bool immediate)
	{
		if (!IsReady() || loopItemIndex < 0)
		{
			return;
		}
		BeginProgrammaticFocus();
		LoopListViewItem2 loopListViewItem = loopListView.GetShownItemByItemIndex(loopItemIndex);
		if (loopListViewItem == null)
		{
			float estimatedItemAxisSize = GetEstimatedItemAxisSize(loopItemIndex);
			float offset = Mathf.Max(0f, (GetViewportAxisSize() - estimatedItemAxisSize) * 0.5f);
			loopListView.MovePanelToItemIndex(loopItemIndex, offset);
			Canvas.ForceUpdateCanvases();
			loopListViewItem = loopListView.GetShownItemByItemIndex(loopItemIndex);
			if (loopListViewItem == null)
			{
				loopListViewItem = loopListView.GetShownItemNearestItemIndex(loopItemIndex);
			}
		}
		if (loopListViewItem == null || IsSpacerLoopIndex(loopListViewItem.ItemIndex))
		{
			EndProgrammaticFocus();
			return;
		}
		currentFocusItemIndex = loopListViewItem.ItemIndex;
		if (TryLoopIndexToDataIndex(currentFocusItemIndex, out var dataIndex))
		{
			FocusItemStarted?.Invoke(dataIndex);
		}
		Vector2 pos = CalculateCenteredContentPos(loopListViewItem);
		pos = ClampContentPosition(pos);
		Vector2 anchoredPosition = scrollRect.content.anchoredPosition;
		float num = (loopListView.IsVertList ? Mathf.Abs(pos.y - anchoredPosition.y) : Mathf.Abs(pos.x - anchoredPosition.x));
		if (immediate || num <= focusSnapMinDistance || snapDuration <= 0f)
		{
			SetContentPosition(pos);
			ApplyScale(immediate: true);
			isSnapping = false;
			FinishFocus();
		}
		else
		{
			StartSnapTween(pos);
		}
	}

	private void StartSnapTween(Vector2 targetPos)
	{
		snapStartPos = scrollRect.content.anchoredPosition;
		snapTargetPos = targetPos;
		snapElapsed = 0f;
		isSnapping = true;
	}

	private void NotifyCenterItemChanged(int loopItemIndex)
	{
		if (!TryLoopIndexToDataIndex(loopItemIndex, out var dataIndex) || dataIndex == lastCenteredItemIndex)
		{
			return;
		}
		lastCenteredItemIndex = dataIndex;
		LoopListViewItem2 loopListViewItem = null;
		if (loopListView != null)
		{
			loopListViewItem = loopListView.GetShownItemByItemIndex(loopItemIndex);
			if (loopListViewItem == null)
			{
				loopListViewItem = loopListView.GetShownItemNearestItemIndex(loopItemIndex);
			}
		}
		CenterItemChanged?.Invoke(dataIndex);
		CenterItemChangedEx?.Invoke(dataIndex, loopListViewItem);
	}

	private void NotifyFinalCenterItemSettled(int loopItemIndex)
	{
		if (TryLoopIndexToDataIndex(loopItemIndex, out var dataIndex))
		{
			LoopListViewItem2 arg = ResolveCenteredItem(loopItemIndex);
			FinalCenterItemSettled?.Invoke(dataIndex);
			FinalCenterItemSettledEx?.Invoke(dataIndex, arg);
		}
	}

	private void FinishFocus()
	{
		EndProgrammaticFocus();
		int num = currentFocusItemIndex;
		currentFocusItemIndex = -1;
		NotifyFinalCenterItemSettled(num);
		NotifyCenterItemChanged(num);
		if (TryLoopIndexToDataIndex(num, out var dataIndex))
		{
			FocusItemFinished?.Invoke(dataIndex);
		}
	}

	private void HandleBeginDrag()
	{
		pendingSnapAfterEndDrag = false;
		StopSnapTween();
		EndProgrammaticFocus();
		currentFocusItemIndex = -1;
	}

	private void HandleEndDrag()
	{
		if (snapOnEndDrag)
		{
			StopAllMotion();
			pendingSnapAfterEndDrag = true;
		}
	}

	private void TryInitializeAutoPadding()
	{
		if (useSpacerItems)
		{
			paddingInitialized = true;
		}
		else
		{
			if (!IsInitContextReady())
			{
				return;
			}
			int itemTotalCount = loopListView.ItemTotalCount;
			if (itemTotalCount <= 0)
			{
				return;
			}
			StopAllMotion();
			float num = MeasureItemAxisSize(0);
			float num2 = ((itemTotalCount == 1) ? num : MeasureItemAxisSize(itemTotalCount - 1));
			if (num <= 0f || num2 <= 0f)
			{
				return;
			}
			float viewportAxisSize = GetViewportAxisSize();
			float headPadding = Mathf.Max(0f, (viewportAxisSize - num) * 0.5f + extraHeadPadding);
			float tailPadding = Mathf.Max(0f, (viewportAxisSize - num2) * 0.5f + extraTailPadding);
			ApplyHeadTailPadding(headPadding, tailPadding);
			paddingInitialized = true;
			int initOrRestoreLoopIndex = GetInitOrRestoreLoopIndex();
			if (initOrRestoreLoopIndex >= 0)
			{
				pendingSnapOnStart = false;
				pendingSnapAfterEndDrag = false;
				hasPendingFocusRequest = false;
				if (!hasPerformedInitialFocus && focusDefaultItemOnInitialize)
				{
					hasPerformedInitialFocus = true;
				}
				ExecuteFocusLoopItem(initOrRestoreLoopIndex, immediate: true);
				Canvas.ForceUpdateCanvases();
				ApplyScale(immediate: true);
			}
		}
	}

	private float MeasureItemAxisSize(int itemIndex)
	{
		itemIndex = Mathf.Clamp(itemIndex, 0, loopListView.ItemTotalCount - 1);
		loopListView.MovePanelToItemIndex(itemIndex, 0f);
		Canvas.ForceUpdateCanvases();
		LoopListViewItem2 loopListViewItem = loopListView.GetShownItemByItemIndex(itemIndex);
		if (loopListViewItem == null)
		{
			loopListViewItem = loopListView.GetShownItemNearestItemIndex(itemIndex);
		}
		if (loopListViewItem == null)
		{
			return 0f;
		}
		return GetAxisSize(loopListViewItem.CachedRectTransform);
	}

	private float GetEstimatedItemAxisSize(int itemIndex)
	{
		int arg = itemIndex;
		if (useSpacerItems)
		{
			if (TryLoopIndexToDataIndex(itemIndex, out var dataIndex))
			{
				arg = dataIndex;
			}
			else
			{
				int dataItemCount = GetDataItemCount();
				if (dataItemCount > 0)
				{
					arg = ((itemIndex >= HeadSpacerItemCount) ? (dataItemCount - 1) : 0);
				}
			}
		}
		if (ItemSizeProvider != null)
		{
			float num = ItemSizeProvider(arg);
			if (num > 0f)
			{
				return num;
			}
		}
		LoopListViewItem2 shownItemByItemIndex = loopListView.GetShownItemByItemIndex(itemIndex);
		if (shownItemByItemIndex != null)
		{
			return GetAxisSize(shownItemByItemIndex.CachedRectTransform);
		}
		LoopListViewItem2 shownItemNearestItemIndex = loopListView.GetShownItemNearestItemIndex(itemIndex);
		if (shownItemNearestItemIndex != null)
		{
			return GetAxisSize(shownItemNearestItemIndex.CachedRectTransform);
		}
		if (fallbackItemSize > 0f)
		{
			return fallbackItemSize;
		}
		if (loopListView.ShownItemCount > 0)
		{
			LoopListViewItem2 shownItemByIndex = loopListView.GetShownItemByIndex(0);
			if (shownItemByIndex != null)
			{
				return GetAxisSize(shownItemByIndex.CachedRectTransform);
			}
		}
		return GetViewportAxisSize();
	}

	private void ApplyHeadTailPadding(float headPadding, float tailPadding)
	{
		if (PaddingTopField == null || PaddingBottomField == null || PaddingLeftField == null || PaddingRightField == null)
		{
			Debug.LogError("LoopListView2FastCenterSnapScale: 找不到 LoopListView2 的 padding 私有字段。");
			return;
		}
		switch (loopListView.ArrangeType)
		{
		case ListItemArrangeType.TopToBottom:
			PaddingTopField.SetValue(loopListView, headPadding);
			PaddingBottomField.SetValue(loopListView, tailPadding);
			break;
		case ListItemArrangeType.BottomToTop:
			PaddingBottomField.SetValue(loopListView, headPadding);
			PaddingTopField.SetValue(loopListView, tailPadding);
			break;
		case ListItemArrangeType.LeftToRight:
		case ListItemArrangeType.LeftToRight_Center:
			PaddingLeftField.SetValue(loopListView, headPadding);
			PaddingRightField.SetValue(loopListView, tailPadding);
			break;
		case ListItemArrangeType.RightToLeft:
			PaddingRightField.SetValue(loopListView, headPadding);
			PaddingLeftField.SetValue(loopListView, tailPadding);
			break;
		}
	}

	private void UpdateSnapTween()
	{
		if (isSnapping && !(scrollRect == null) && !(scrollRect.content == null))
		{
			StopAllMotion();
			float num = (useUnscaledTime ? Time.unscaledDeltaTime : Time.deltaTime);
			snapElapsed += num;
			float num2 = ((snapDuration <= 0f) ? 1f : Mathf.Clamp01(snapElapsed / snapDuration));
			float t = EvaluateSnapCurve(num2);
			Vector2 contentPosition = Vector2.LerpUnclamped(snapStartPos, snapTargetPos, t);
			SetContentPosition(contentPosition);
			if (num2 >= 1f)
			{
				SetContentPosition(snapTargetPos);
				isSnapping = false;
				ApplyScale(immediate: true);
				FinishFocus();
			}
		}
	}

	private float EvaluateSnapCurve(float t)
	{
		if (snapCurve != null && snapCurve.length > 0)
		{
			return snapCurve.Evaluate(t);
		}
		t = Mathf.Clamp01(t);
		float num = 1f - t;
		return 1f - num * num * num;
	}

	private void ApplyScale(bool immediate)
	{
		if (!IsReady() || loopListView.ShownItemCount <= 0)
		{
			return;
		}
		EnsureViewport();
		if (viewport == null)
		{
			return;
		}
		float num = GetViewportAxisSize() * 0.5f;
		float num2 = ((effectRange > 0f) ? effectRange : num);
		if (num2 <= 0f)
		{
			return;
		}
		float num3 = (loopListView.IsVertList ? viewport.rect.center.y : viewport.rect.center.x);
		float num4 = (useUnscaledTime ? Time.unscaledDeltaTime : Time.deltaTime);
		float t = ((immediate || scaleSmoothSpeed <= 0f) ? 1f : (1f - Mathf.Exp((0f - scaleSmoothSpeed) * num4)));
		visibleItems.Clear();
		int shownItemCount = loopListView.ShownItemCount;
		List<LoopListViewItem2> list = new List<LoopListViewItem2>(shownItemCount);
		List<CacheData> list2 = new List<CacheData>(shownItemCount);
		List<Vector3> list3 = new List<Vector3>(shownItemCount);
		for (int i = 0; i < shownItemCount; i++)
		{
			LoopListViewItem2 shownItemByIndex = loopListView.GetShownItemByIndex(i);
			if (shownItemByIndex == null)
			{
				continue;
			}
			CacheData orCreateCache = GetOrCreateCache(shownItemByIndex);
			if (orCreateCache != null && !(orCreateCache.scaleTarget == null))
			{
				if (IsSpacerLoopIndex(shownItemByIndex.ItemIndex))
				{
					orCreateCache.scaleTarget.localScale = orCreateCache.baseScale;
					continue;
				}
				visibleItems.Add(shownItemByIndex);
				list.Add(shownItemByIndex);
				list2.Add(orCreateCache);
				list3.Add(orCreateCache.scaleTarget.localScale);
				orCreateCache.scaleTarget.localScale = orCreateCache.baseScale;
			}
		}
		for (int j = 0; j < list.Count; j++)
		{
			LoopListViewItem2 loopListViewItem = list[j];
			CacheData cacheData = list2[j];
			RectTransform rectTransform = ((cacheData.measureRect != null) ? cacheData.measureRect : loopListViewItem.CachedRectTransform);
			Vector3 vector = viewport.InverseTransformPoint(rectTransform.TransformPoint(rectTransform.rect.center));
			float num5 = Mathf.Clamp01((loopListView.IsVertList ? Mathf.Abs(vector.y - num3) : Mathf.Abs(vector.x - num3)) / num2);
			float t2 = scaleCurve.Evaluate(1f - num5);
			float num6 = Mathf.LerpUnclamped(minScale, maxScale, t2);
			Vector3 vector2 = cacheData.baseScale * num6;
			Vector3 a = list3[j];
			cacheData.scaleTarget.localScale = (immediate ? vector2 : Vector3.Lerp(a, vector2, t));
		}
		foreach (KeyValuePair<LoopListViewItem2, CacheData> item in cacheDict)
		{
			if (!visibleItems.Contains(item.Key))
			{
				CacheData value = item.Value;
				if (value != null && value.scaleTarget != null)
				{
					value.scaleTarget.localScale = value.baseScale;
				}
			}
		}
	}

	private CacheData GetOrCreateCache(LoopListViewItem2 item)
	{
		if (cacheDict.TryGetValue(item, out var value) && value != null && value.scaleTarget != null)
		{
			if (value.measureRect == null)
			{
				value.measureRect = ResolveMeasureRect(item);
			}
			return value;
		}
		Transform transform = ResolveScaleTarget(item);
		if (transform == null)
		{
			return null;
		}
		value = new CacheData
		{
			scaleTarget = transform,
			measureRect = ResolveMeasureRect(item),
			baseScale = transform.localScale
		};
		cacheDict[item] = value;
		return value;
	}

	private Transform ResolveScaleTarget(LoopListViewItem2 item)
	{
		if (string.IsNullOrEmpty(scaleTargetPath))
		{
			return item.CachedRectTransform;
		}
		Transform transform = item.transform.Find(scaleTargetPath);
		if (!(transform != null))
		{
			return item.CachedRectTransform;
		}
		return transform;
	}

	private LoopListViewItem2 GetNearestShownItem()
	{
		int shownItemCount = loopListView.ShownItemCount;
		if (shownItemCount <= 0)
		{
			return null;
		}
		EnsureViewport();
		if (viewport == null)
		{
			return null;
		}
		float num = float.MaxValue;
		LoopListViewItem2 loopListViewItem = null;
		for (int i = 0; i < shownItemCount; i++)
		{
			LoopListViewItem2 shownItemByIndex = loopListView.GetShownItemByIndex(i);
			if (!(shownItemByIndex == null) && !IsSpacerLoopIndex(shownItemByIndex.ItemIndex))
			{
				float distanceToViewportCenter = GetDistanceToViewportCenter(shownItemByIndex);
				if (distanceToViewportCenter < num)
				{
					num = distanceToViewportCenter;
					loopListViewItem = shownItemByIndex;
				}
			}
		}
		if (loopListViewItem != null)
		{
			return loopListViewItem;
		}
		int firstRealLoopIndex = GetFirstRealLoopIndex();
		int lastRealLoopIndex = GetLastRealLoopIndex();
		if (firstRealLoopIndex < 0 || lastRealLoopIndex < 0)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem2 = loopListView.GetShownItemNearestItemIndex(firstRealLoopIndex);
		LoopListViewItem2 loopListViewItem3 = loopListView.GetShownItemNearestItemIndex(lastRealLoopIndex);
		if (loopListViewItem2 != null && IsSpacerLoopIndex(loopListViewItem2.ItemIndex))
		{
			loopListViewItem2 = null;
		}
		if (loopListViewItem3 != null && IsSpacerLoopIndex(loopListViewItem3.ItemIndex))
		{
			loopListViewItem3 = null;
		}
		if (loopListViewItem2 == null)
		{
			return loopListViewItem3;
		}
		if (loopListViewItem3 == null)
		{
			return loopListViewItem2;
		}
		if (!(GetDistanceToViewportCenter(loopListViewItem2) <= GetDistanceToViewportCenter(loopListViewItem3)))
		{
			return loopListViewItem3;
		}
		return loopListViewItem2;
	}

	private LoopListViewItem2 ResolveCenteredItem(int itemIndex)
	{
		if (itemIndex < 0 || loopListView == null)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = loopListView.GetShownItemByItemIndex(itemIndex);
		if (loopListViewItem == null)
		{
			loopListViewItem = loopListView.GetShownItemNearestItemIndex(itemIndex);
		}
		if (loopListViewItem != null && IsSpacerLoopIndex(loopListViewItem.ItemIndex))
		{
			return null;
		}
		return loopListViewItem;
	}

	private float GetDistanceToViewportCenter(LoopListViewItem2 item)
	{
		EnsureViewport();
		if (item == null || viewport == null || loopListView == null)
		{
			return float.MaxValue;
		}
		CacheData orCreateCache = GetOrCreateCache(item);
		RectTransform rectTransform = ((orCreateCache != null && orCreateCache.measureRect != null) ? orCreateCache.measureRect : item.CachedRectTransform);
		Vector3 vector = viewport.InverseTransformPoint(rectTransform.TransformPoint(rectTransform.rect.center));
		float num = (loopListView.IsVertList ? viewport.rect.center.y : viewport.rect.center.x);
		if (!loopListView.IsVertList)
		{
			return Mathf.Abs(vector.x - num);
		}
		return Mathf.Abs(vector.y - num);
	}

	private Vector2 CalculateCenteredContentPos(LoopListViewItem2 item)
	{
		EnsureViewport();
		if (item == null || viewport == null || scrollRect == null || scrollRect.content == null)
		{
			if (!(scrollRect != null) || !(scrollRect.content != null))
			{
				return Vector2.zero;
			}
			return scrollRect.content.anchoredPosition;
		}
		CacheData orCreateCache = GetOrCreateCache(item);
		RectTransform rectTransform = ((orCreateCache != null && orCreateCache.measureRect != null) ? orCreateCache.measureRect : item.CachedRectTransform);
		Vector2 anchoredPosition = scrollRect.content.anchoredPosition;
		Vector3 vector = viewport.InverseTransformPoint(rectTransform.TransformPoint(rectTransform.rect.center));
		if (loopListView.IsVertList)
		{
			float num = viewport.rect.center.y - vector.y;
			anchoredPosition.y += num;
		}
		else
		{
			float num2 = viewport.rect.center.x - vector.x;
			anchoredPosition.x += num2;
		}
		return anchoredPosition;
	}

	private Vector2 ClampContentPosition(Vector2 pos)
	{
		RectTransform content = scrollRect.content;
		if (content == null || viewport == null)
		{
			return pos;
		}
		if (loopListView.IsVertList)
		{
			float height = content.rect.height;
			float height2 = viewport.rect.height;
			float num = Mathf.Max(0f, height - height2);
			if (loopListView.ArrangeType == ListItemArrangeType.TopToBottom)
			{
				pos.y = Mathf.Clamp(pos.y, 0f, num);
			}
			else if (loopListView.ArrangeType == ListItemArrangeType.BottomToTop)
			{
				pos.y = Mathf.Clamp(pos.y, 0f - num, 0f);
			}
		}
		else
		{
			float width = content.rect.width;
			float width2 = viewport.rect.width;
			float num2 = Mathf.Max(0f, width - width2);
			if (loopListView.ArrangeType == ListItemArrangeType.LeftToRight || loopListView.ArrangeType == ListItemArrangeType.LeftToRight_Center)
			{
				pos.x = Mathf.Clamp(pos.x, 0f - num2, 0f);
			}
			else if (loopListView.ArrangeType == ListItemArrangeType.RightToLeft)
			{
				pos.x = Mathf.Clamp(pos.x, 0f, num2);
			}
		}
		return pos;
	}

	private void SetContentPosition(Vector2 pos)
	{
		if (!(scrollRect == null) && !(scrollRect.content == null))
		{
			scrollRect.content.anchoredPosition = ClampContentPosition(pos);
		}
	}

	private void StopAllMotion()
	{
		if (!(scrollRect == null))
		{
			scrollRect.StopMovement();
			scrollRect.velocity = Vector2.zero;
		}
	}

	private void StopSnapTween()
	{
		isSnapping = false;
		snapElapsed = 0f;
	}

	private void BeginProgrammaticFocus()
	{
		StopSnapTween();
		StopAllMotion();
		pendingSnapAfterEndDrag = false;
		pendingSnapOnStart = false;
		if (forceClampedWhileFocus && scrollRect != null && !movementTypeOverridden)
		{
			cachedMovementType = scrollRect.movementType;
			scrollRect.movementType = ScrollRect.MovementType.Clamped;
			movementTypeOverridden = true;
		}
	}

	private void EndProgrammaticFocus()
	{
		if (forceClampedWhileFocus && scrollRect != null && movementTypeOverridden)
		{
			scrollRect.movementType = cachedMovementType;
			movementTypeOverridden = false;
		}
	}

	private RectTransform ResolveMeasureRect(LoopListViewItem2 item)
	{
		if (item == null)
		{
			return null;
		}
		if (!string.IsNullOrEmpty(measureTargetPath) && item.transform.Find(measureTargetPath) is RectTransform result)
		{
			return result;
		}
		return item.CachedRectTransform;
	}

	private float GetViewportAxisSize()
	{
		EnsureViewport();
		if (viewport == null)
		{
			return 0f;
		}
		if (!loopListView.IsVertList)
		{
			return viewport.rect.width;
		}
		return viewport.rect.height;
	}

	private float GetAxisSize(RectTransform rect)
	{
		if (!loopListView.IsVertList)
		{
			return rect.rect.width;
		}
		return rect.rect.height;
	}

	private bool IsInitContextReady()
	{
		if (loopListView != null && scrollRect != null && scrollRect.content != null && loopListView.IsInited)
		{
			return loopListView.ItemTotalCount > 0;
		}
		return false;
	}

	private bool IsReady()
	{
		if (IsInitContextReady())
		{
			if (!useSpacerItems && autoHeadTailPadding)
			{
				return paddingInitialized;
			}
			return true;
		}
		return false;
	}

	private void EnsureRefs()
	{
		if (loopListView == null)
		{
			loopListView = GetComponent<LoopListView2>();
		}
		scrollRect = ((loopListView != null) ? loopListView.ScrollRect : null);
		EnsureViewport();
	}

	private void EnsureViewport()
	{
		if (loopListView == null || loopListView.ScrollRect == null)
		{
			viewport = null;
			return;
		}
		viewport = loopListView.ScrollRect.viewport;
		if (viewport == null)
		{
			viewport = loopListView.ScrollRect.GetComponent<RectTransform>();
		}
	}

	private void SubscribeEvents()
	{
		if (!subscribed && !(this.loopListView == null))
		{
			LoopListView2 loopListView = this.loopListView;
			loopListView.mOnBeginDragAction = (Action)Delegate.Combine(loopListView.mOnBeginDragAction, new Action(HandleBeginDrag));
			LoopListView2 loopListView2 = this.loopListView;
			loopListView2.mOnEndDragAction = (Action)Delegate.Combine(loopListView2.mOnEndDragAction, new Action(HandleEndDrag));
			subscribed = true;
		}
	}

	private void UnsubscribeEvents()
	{
		if (subscribed && !(this.loopListView == null))
		{
			LoopListView2 loopListView = this.loopListView;
			loopListView.mOnBeginDragAction = (Action)Delegate.Remove(loopListView.mOnBeginDragAction, new Action(HandleBeginDrag));
			LoopListView2 loopListView2 = this.loopListView;
			loopListView2.mOnEndDragAction = (Action)Delegate.Remove(loopListView2.mOnEndDragAction, new Action(HandleEndDrag));
			subscribed = false;
		}
	}

	private void ResetAllScale()
	{
		foreach (KeyValuePair<LoopListViewItem2, CacheData> item in cacheDict)
		{
			CacheData value = item.Value;
			if (value != null && value.scaleTarget != null)
			{
				value.scaleTarget.localScale = value.baseScale;
			}
		}
	}
}
