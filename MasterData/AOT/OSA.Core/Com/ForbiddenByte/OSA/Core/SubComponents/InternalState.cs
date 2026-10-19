using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;
using frame8.Logic.Misc.Other;
using frame8.Logic.Misc.Other.Extensions;

namespace Com.ForbiddenByte.OSA.Core.SubComponents;

public class InternalState<TItemViewsHolder> where TItemViewsHolder : BaseItemViewsHolder
{
	public LayoutInfo layoutInfo = new LayoutInfo();

	public double lastProcessedCTVirtualInsetFromVPS;

	public double ctVirtualSize;

	public bool computeVisibilityTwinPassScheduled;

	public bool preferKeepingCTEndEdgeStationaryInNextComputeVisibilityTwinPass;

	public int totalNumberOfSizeChanges;

	public int totalNumberOfSizeChangesLastFrame;

	private ItemsDescriptor _ItemsDesc;

	private BaseParams _SourceParams;

	public double ProximityToLimitNeeded01ToResetPos
	{
		get
		{
			if (!_SourceParams.effects.ElasticMovement)
			{
				return 0.9999995;
			}
			return 1.0;
		}
	}

	public double vpSize => layoutInfo.vpSize;

	public double paddingContentStart => layoutInfo.paddingContentStart;

	public double transversalPaddingContentStart => layoutInfo.transversalPaddingContentStart;

	public double paddingContentEnd => layoutInfo.paddingContentEnd;

	public double paddingStartPlusEnd => layoutInfo.paddingStartPlusEnd;

	public double spacing => layoutInfo.spacing;

	public RectTransform.Edge startEdge => layoutInfo.startEdge;

	public RectTransform.Edge endEdge => layoutInfo.endEdge;

	public RectTransform.Edge transvStartEdge => layoutInfo.transvStartEdge;

	public int hor0_vert1 => layoutInfo.hor0_vert1;

	public int hor1_vertMinus1 => layoutInfo.hor1_vertMinus1;

	public double ctVirtualInsetFromVPS_Cached { get; private set; }

	public Vector2 scrollViewSize => layoutInfo.scrollViewSize;

	public bool HasScrollViewSizeChanged
	{
		get
		{
			Rect rect = _SourceParams.ScrollViewRT.rect;
			if (_SourceParams.ItemTransversalSize == -1f && transversalPaddingContentStart != -1.0)
			{
				if (scrollViewSize[hor0_vert1] != rect.size[hor0_vert1])
				{
					return true;
				}
				Rect rect2 = _SourceParams.Viewport.rect;
				if ((float)vpSize != rect2.size[hor0_vert1])
				{
					return true;
				}
				return false;
			}
			if (!(scrollViewSize != rect.size))
			{
				return (float)vpSize != _SourceParams.Viewport.rect.size[hor0_vert1];
			}
			return true;
		}
	}

	public double CTVirtualInsetFromVPE_Cached => 0.0 - ctVirtualSize + vpSize - ctVirtualInsetFromVPS_Cached;

	public double VirtualScrollableArea => ctVirtualSize - vpSize;

	public double AbstractPivot01 => (float)hor0_vert1 + (float)hor1_vertMinus1 * _SourceParams.Content.pivot[hor0_vert1];

	public static InternalState<TItemViewsHolder> CreateFromSourceParamsOrThrow(BaseParams sourceParams, ItemsDescriptor itemsDescriptor)
	{
		return new InternalState<TItemViewsHolder>(sourceParams, itemsDescriptor);
	}

	protected InternalState(BaseParams sourceParams, ItemsDescriptor itemsDescriptor)
	{
		_SourceParams = sourceParams;
		_ItemsDesc = itemsDescriptor;
		LayoutGroup component = sourceParams.Content.GetComponent<LayoutGroup>();
		if ((bool)component && component.enabled)
		{
			component.enabled = false;
			Debug.Log("LayoutGroup on GameObject " + component.name + " has beed disabled in order to use OSA");
		}
		ContentSizeFitter component2 = sourceParams.Content.GetComponent<ContentSizeFitter>();
		if ((bool)component2 && component2.enabled)
		{
			component2.enabled = false;
			Debug.Log("ContentSizeFitter on GameObject " + component2.name + " has beed disabled in order to use OSA");
		}
		LayoutElement component3 = sourceParams.Content.GetComponent<LayoutElement>();
		if ((bool)component3)
		{
			UnityEngine.Object.Destroy(component3);
			Debug.Log("LayoutElement on GameObject " + component2.name + " has beed DESTROYED in order to use OSA");
		}
	}

	public void CacheScrollViewInfo()
	{
		layoutInfo.CacheScrollViewInfo(_SourceParams);
	}

	public Vector2 GetPointerPositionInCTSpace(PointerEventData currentPointerEventData)
	{
		return UIUtils8.Instance.ScreenPointToLocalPointInRectangle(_SourceParams.Content, currentPointerEventData);
	}

	public double GetCTAbstractSpaceVectorLongitudinalComponentFromCTSpaceVector(Vector2 vectorCTSpace)
	{
		return (double)vectorCTSpace[hor0_vert1] * (double)hor1_vertMinus1;
	}

	public double CalculateContentVirtualSize()
	{
		return _ItemsDesc.CumulatedSizeOfAllItems + spacing * (double)Math.Max(0, _ItemsDesc.itemsCount - 1) + paddingStartPlusEnd;
	}

	public void CorrectPositions(List<TItemViewsHolder> vhs, bool alsoCorrectTransversalPositioning)
	{
		int count = vhs.Count;
		double num = GetItemInferredRealInsetFromParentStart(vhs[0].itemIndexInView);
		for (int i = 0; i < count; i++)
		{
			TItemViewsHolder val = vhs[i];
			double num2 = _ItemsDesc[val.itemIndexInView];
			val.root.SetInsetAndSizeFromParentEdgeWithCurrentAnchors(startEdge, (float)num, (float)num2);
			num += num2 + spacing;
			if (alsoCorrectTransversalPositioning)
			{
				GetTransversalInsetStartAndSizeToUse(val, out var insetStart, out var size);
				val.root.SetInsetAndSizeFromParentEdgeWithCurrentAnchors(transvStartEdge, insetStart, size);
			}
		}
	}

	public void UpdateLastProcessedCTVirtualInsetFromVPStart()
	{
		lastProcessedCTVirtualInsetFromVPS = ctVirtualInsetFromVPS_Cached;
	}

	public double GetVirtualAbstractNormalizedScrollPosition()
	{
		double virtualScrollableArea = VirtualScrollableArea;
		if (virtualScrollableArea <= 0.0)
		{
			return 1.0;
		}
		double num = Math.Min(0.0, ctVirtualInsetFromVPS_Cached);
		return 1.0 + num / virtualScrollableArea;
	}

	public void UpdateCachedCTVirtInsetFromVPS(double virtualInset, bool allowOutsideBounds)
	{
		if (!allowOutsideBounds)
		{
			double num = 0.0 - VirtualScrollableArea;
			double num2;
			double num3;
			if (num > 0.0)
			{
				num2 = (num3 = GetTargetCTVirtualInsetFromVPSWhenCTSmallerThanVP(num));
			}
			else
			{
				double virtualScrollableArea = VirtualScrollableArea;
				num3 = 0.0;
				num2 = 0.0 - virtualScrollableArea;
			}
			if (num2 > num3)
			{
				throw new OSAException($"[Internal] Clamping content offset failed: minInsetStart(={num2}) > maxInsetStart(-{num3})");
			}
			virtualInset = Math.Max(num2, Math.Min(num3, virtualInset));
		}
		ctVirtualInsetFromVPS_Cached = virtualInset;
		if (_SourceParams.optimization.ForceLayoutRebuildOnDrag)
		{
			RebuildLayoutImmediateCompat(_SourceParams.ScrollViewRT);
		}
	}

	public double GetItemVirtualInsetFromParentStartUsingItemIndexInView(int itemIndexInView)
	{
		double num = 0.0;
		if (itemIndexInView > 0)
		{
			num = _ItemsDesc.GetItemSizeCumulative(itemIndexInView - 1) + (double)itemIndexInView * spacing;
		}
		return paddingContentStart + num;
	}

	public double GetItemVirtualInsetFromParentEndUsingItemIndexInView(int itemIndexInView)
	{
		return ctVirtualSize - GetItemVirtualInsetFromParentStartUsingItemIndexInView(itemIndexInView) - _ItemsDesc[itemIndexInView];
	}

	public double GetItemInferredRealInsetFromParentStart(int itemIndexInView)
	{
		return ConvertItemInsetFromParentStart_FromVirtualToInferredReal(GetItemVirtualInsetFromParentStartUsingItemIndexInView(itemIndexInView));
	}

	public double GetItemInferredRealInsetFromParentEnd(int itemIndexInView)
	{
		return vpSize - GetItemInferredRealInsetFromParentStart(itemIndexInView) - _ItemsDesc[itemIndexInView];
	}

	public double GetContentInferredRealInsetFromVPS(TItemViewsHolder firstVH)
	{
		return (double)firstVH.root.GetInsetFromParentEdge(_SourceParams.Content, startEdge) - paddingContentStart;
	}

	public double GetContentInferredRealInsetFromVPE(TItemViewsHolder lastVH)
	{
		return (double)lastVH.root.GetInsetFromParentEdge(_SourceParams.Content, endEdge) - paddingContentEnd;
	}

	public double ConvertItemInsetFromParentStart_FromVirtualToInferredReal(double virtualInsetFromParrentStart)
	{
		return ctVirtualInsetFromVPS_Cached + virtualInsetFromParrentStart;
	}

	public double GetTargetCTVirtualInsetFromVPSWhenCTSmallerThanVP()
	{
		double emptyAreaWhenCTSmallerThanVP = 0.0 - VirtualScrollableArea;
		return GetTargetCTVirtualInsetFromVPSWhenCTSmallerThanVP(emptyAreaWhenCTSmallerThanVP);
	}

	public double GetTargetCTVirtualInsetFromVPSWhenCTSmallerThanVP(double emptyAreaWhenCTSmallerThanVP)
	{
		return AbstractPivot01 * emptyAreaWhenCTSmallerThanVP;
	}

	public void GetTransversalInsetStartAndSizeToUse(TItemViewsHolder vh, out float insetStart, out float size)
	{
		float itemTransversalSize = _SourceParams.ItemTransversalSize;
		if (itemTransversalSize == 0f)
		{
			size = (float)layoutInfo.itemsConstantTransversalSize;
		}
		else
		{
			if (itemTransversalSize == -1f)
			{
				size = vh.root.rect.size[1 - hor0_vert1];
			}
			else
			{
				size = itemTransversalSize;
			}
			if (layoutInfo.transversalPaddingStartPlusEnd == -1.0)
			{
				insetStart = (float)((layoutInfo.transversalContentSize - (double)size) / 2.0);
				return;
			}
		}
		insetStart = (float)transversalPaddingContentStart;
	}

	public void CorrectParametersOnCTSizeChange(bool contentPanelEndEdgeStationary, out double? ctInsetFromVPSOverride, ref double additionalCTDragAbstrDelta, double newCTSize, double deltaSize)
	{
		if (deltaSize < 0.0)
		{
			double num = 0.0 - (newCTSize - vpSize);
			if (num > 0.0)
			{
				ctInsetFromVPSOverride = GetTargetCTVirtualInsetFromVPSWhenCTSmallerThanVP(num);
				return;
			}
			double num2 = 0.0 - deltaSize;
			if (contentPanelEndEdgeStationary)
			{
				double num3 = 0.0 - ctVirtualInsetFromVPS_Cached;
				if (num3 < 0.0)
				{
					ctInsetFromVPSOverride = 0.0;
					additionalCTDragAbstrDelta = num3 - num2;
					return;
				}
				double num4 = num2 - num3;
				if (num4 >= 0.0)
				{
					ctInsetFromVPSOverride = 0.0;
					additionalCTDragAbstrDelta = 0.0 - num4;
				}
				else
				{
					ctInsetFromVPSOverride = null;
				}
				return;
			}
			double num5 = 0.0 - CTVirtualInsetFromVPE_Cached;
			if (num5 < 0.0)
			{
				ctInsetFromVPSOverride = vpSize - newCTSize;
				additionalCTDragAbstrDelta = 0.0 - num5 + num2;
				return;
			}
			double num6 = num2 - num5;
			if (num6 >= 0.0)
			{
				ctInsetFromVPSOverride = vpSize - newCTSize;
				additionalCTDragAbstrDelta = num6;
			}
			else
			{
				ctInsetFromVPSOverride = null;
			}
		}
		else
		{
			ctInsetFromVPSOverride = null;
		}
	}

	public void RebuildLayoutImmediateCompat(RectTransform rectTransform)
	{
		LayoutRebuilder.ForceRebuildLayoutImmediate(rectTransform);
	}

	public bool ConsumeFlag_computeVisibilityTwinPassScheduled()
	{
		bool result = computeVisibilityTwinPassScheduled;
		computeVisibilityTwinPassScheduled = false;
		return result;
	}

	public bool ConsumeFlag_preferKeepingCTEndEdgeStationaryInNextComputeVisibilityTwinPass()
	{
		bool result = preferKeepingCTEndEdgeStationaryInNextComputeVisibilityTwinPass;
		preferKeepingCTEndEdgeStationaryInNextComputeVisibilityTwinPass = false;
		return result;
	}
}
