using System;
using Com.ForbiddenByte.OSA.Core.SubComponents;
using UnityEngine;
using UnityEngine.EventSystems;
using frame8.Logic.Misc.Visual.UI;

namespace Com.ForbiddenByte.OSA.Core;

public interface IOSA : IScrollRectProxy, IInitializePotentialDragHandler, IEventSystemHandler, IBeginDragHandler, IDragHandler, IEndDragHandler, IScrollHandler
{
	BaseParams BaseParameters { get; }

	MonoBehaviour AsMonoBehaviour { get; }

	double ContentVirtualInsetFromViewportStart { get; }

	double ContentVirtualInsetFromViewportEnd { get; }

	int VisibleItemsCount { get; }

	int RecyclableItemsCount { get; }

	int BufferedRecyclableItemsCount { get; }

	bool IsDragging { get; }

	bool InsertAtIndexSupported { get; }

	bool RemoveFromIndexSupported { get; }

	float Time { get; }

	float DeltaTime { get; }

	event Action Initialized;

	event Action<int, int> ItemsRefreshed;

	event Action ScrollViewSizeChanged;

	void Init();

	void ChangeItemsCount(ItemCountChangeMode changeMode, int itemsCount, int indexIfAppendingOrRemoving = -1, bool contentPanelEndEdgeStationary = false, bool keepVelocity = false);

	void Refresh(bool contentPanelEndEdgeStationary = false, bool keepVelocity = false);

	void ResetItems(int itemsCount, bool contentPanelEndEdgeStationary = false, bool keepVelocity = false);

	void InsertItems(int index, int itemsCount, bool contentPanelEndEdgeStationary = false, bool keepVelocity = false);

	void RemoveItems(int index, int itemsCount, bool contentPanelEndEdgeStationary = false, bool keepVelocity = false);

	double SetVirtualAbstractNormalizedScrollPosition(double pos, bool computeVisibilityNow, out bool looped, bool keepVelocity = false);

	int GetItemsCount();

	void ScrollTo(int itemIndex, float normalizedOffsetFromViewportStart = 0f, float normalizedPositionOfItemPivotToUse = 0f);

	bool SmoothScrollTo(int itemIndex, float duration, float normalizedOffsetFromViewportStart = 0f, float normalizedPositionOfItemPivotToUse = 0f, Func<float, bool> onProgress = null, Action onDone = null, bool overrideCurrentScrollingAnimation = false);

	void BringToView(int itemIndex, float? spacingFromViewportEdge = null);

	bool SmoothBringToView(int itemIndex, float duration, float? spacingFromViewportEdge = null, Func<float, bool> onProgress = null, Action onDone = null, bool overrideCurrentScrollingAnimation = false);

	AbstractViewsHolder GetViewsHolderClosestToViewportLongitudinalNormalizedAbstractPoint(Canvas canvas, RectTransform canvasRectTransform, float viewportPoint01, float itemPoint01, out float distance);

	LayoutInfo GetLayoutInfoReadonly();

	float GetItemRealInsetFromParentStart(RectTransform withRoot);

	float GetItemRealInsetFromParentEnd(RectTransform withRoot);

	BaseItemViewsHolder GetBaseItemViewsHolder(int vhIndex);

	BaseItemViewsHolder GetBaseItemViewsHolderIfVisible(int withItemIndex);

	BaseItemViewsHolder GetBaseItemViewsHolderIfVisible(RectTransform withRoot);

	Type GetViewsHolderType();

	void ScheduleForceRebuildLayout();

	void ForceRebuildLayoutNow();

	BaseNavigationManager GetBaseNavigationManager();
}
