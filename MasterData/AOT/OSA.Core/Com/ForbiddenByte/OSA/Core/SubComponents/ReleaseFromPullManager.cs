using frame8.Logic.Misc.Other.Extensions;

namespace Com.ForbiddenByte.OSA.Core.SubComponents;

internal class ReleaseFromPullManager<TParams, TItemViewsHolder> where TParams : BaseParams where TItemViewsHolder : BaseItemViewsHolder
{
	public bool inProgress;

	public double targetCTInsetFromVPS;

	private OSA<TParams, TItemViewsHolder> _Adapter;

	private ComputeVisibilityParams _ComputeVisibilityParams_Reusable = new ComputeVisibilityParams();

	public ReleaseFromPullManager(OSA<TParams, TItemViewsHolder> adapter)
	{
		_Adapter = adapter;
	}

	public double CalculateFirstItemTargetInsetFromVPS()
	{
		return targetCTInsetFromVPS + _Adapter._InternalState.paddingContentStart;
	}

	public double CalculateFirstItemInsetFromVPS()
	{
		TItemViewsHolder itemViewsHolder = _Adapter.GetItemViewsHolder(0);
		double num = itemViewsHolder.root.GetInsetFromParentEdge(_Adapter.Parameters.Content, _Adapter._InternalState.startEdge);
		if (itemViewsHolder.itemIndexInView > 0)
		{
			num -= _Adapter._InternalState.GetItemVirtualInsetFromParentStartUsingItemIndexInView(itemViewsHolder.itemIndexInView) - _Adapter._InternalState.paddingContentStart;
		}
		return num;
	}

	public void FinishNowByDraggingItems(bool computeVisibility)
	{
		if (inProgress)
		{
			double num = CalculateFirstItemTargetInsetFromVPS() - CalculateFirstItemInsetFromVPS();
			if (num != 0.0)
			{
				_Adapter.DragVisibleItemsRangeUnchecked(0, _Adapter.VisibleItemsCount, num, updateCachedCTVirtualInset: true, computeVisibility);
			}
			inProgress = false;
		}
	}

	public void FinishNowBySettingContentInset(bool computeVisibility)
	{
		_ComputeVisibilityParams_Reusable.overrideDelta = targetCTInsetFromVPS - _Adapter._InternalState.ctVirtualInsetFromVPS_Cached;
		ContentSizeOrPositionChangeParams p = new ContentSizeOrPositionChangeParams
		{
			cancelSnappingIfAny = true,
			computeVisibilityParams = (computeVisibility ? _ComputeVisibilityParams_Reusable : null),
			fireScrollPositionChangedEvent = true,
			keepVelocity = true
		};
		_Adapter.SetContentVirtualInsetFromViewportStart(targetCTInsetFromVPS, ref p, out var _);
		inProgress = false;
	}

	public bool IsPulled()
	{
		if (!(_Adapter._InternalState.ctVirtualInsetFromVPS_Cached > 1E-05))
		{
			return _Adapter._InternalState.CTVirtualInsetFromVPE_Cached > 1E-05;
		}
		return true;
	}
}
