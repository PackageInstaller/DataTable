using System;
using System.Collections.Generic;
using UnityEngine;

namespace Com.ForbiddenByte.OSA.Core.SubComponents;

internal class ComputeVisibilityManager<TParams, TItemViewsHolder> where TParams : BaseParams where TItemViewsHolder : BaseItemViewsHolder
{
	private OSA<TParams, TItemViewsHolder> _Adapter;

	private TParams _Params;

	private InternalState<TItemViewsHolder> _InternalState;

	private ItemsDescriptor _ItemsDesc;

	private string debugString;

	private bool negativeScroll;

	private double vpSize;

	private RectTransform.Edge negStartEdge_posEndEdge;

	private TItemViewsHolder nlvHolder;

	private int endItemIndexInView;

	private int neg1_posMinus1;

	private int neg1_pos0;

	private int neg0_pos1;

	private double ctVrtInsetFromVPS;

	private int itemsCount;

	private bool thereWereVisibletems;

	private double currentItemRealInset_negStart_posEnd;

	private bool negNLVCandidateIsBeforeVP_posNLVCandidateIsAfterVP;

	private TItemViewsHolder startingLVHolder;

	private double negCTVrtInsetFromVPS_posCTVrtInsetFromVPE;

	private int nlvIndexInView;

	private double nlvSize;

	private double nlvSizePlusSpacing;

	private double currentRealInsetToUseForNLV_negFromCTS_posFromCTE;

	public ComputeVisibilityManager(OSA<TParams, TItemViewsHolder> adapter)
	{
		_Adapter = adapter;
		_Params = _Adapter.Parameters;
		_InternalState = _Adapter._InternalState;
		_ItemsDesc = _Adapter._ItemsDesc;
	}

	public void ComputeVisibility(double abstractDelta)
	{
		debugString = null;
		negativeScroll = abstractDelta <= 0.0;
		vpSize = _InternalState.vpSize;
		if (negativeScroll)
		{
			neg1_posMinus1 = 1;
			negStartEdge_posEndEdge = _InternalState.startEdge;
		}
		else
		{
			neg1_posMinus1 = -1;
			negStartEdge_posEndEdge = _InternalState.endEdge;
		}
		neg1_pos0 = (neg1_posMinus1 + 1) / 2;
		neg0_pos1 = 1 - neg1_pos0;
		thereWereVisibletems = _Adapter.VisibleItemsCount > 0;
		itemsCount = _ItemsDesc.itemsCount;
		endItemIndexInView = neg1_pos0 * (itemsCount - 1);
		ctVrtInsetFromVPS = _InternalState.ctVirtualInsetFromVPS_Cached;
		negCTVrtInsetFromVPS_posCTVrtInsetFromVPE = (negativeScroll ? ctVrtInsetFromVPS : (0.0 - _InternalState.ctVirtualSize + _InternalState.vpSize - ctVrtInsetFromVPS));
		int startingVHIndexInView;
		if (thereWereVisibletems)
		{
			PrepareOutsideItemsForPotentialRecycleAndGetNextFirstVisibleIndexInView(out startingVHIndexInView);
		}
		else
		{
			startingVHIndexInView = neg0_pos1 * (itemsCount - 1);
		}
		if (itemsCount > 0)
		{
			bool flag = false;
			double num = -1.0;
			if ((!thereWereVisibletems || Math.Abs(abstractDelta) > _InternalState.vpSize * 2.0) && (num = Math.Min(_InternalState.vpSize / ((double)_Params.DefaultItemSize + _InternalState.spacing), _Adapter._AVGVisibleItemsCount)) < (double)itemsCount)
			{
				flag = InferFirstVisibleVHIndexInViewAndInset(ref startingVHIndexInView, num);
			}
			if ((negativeScroll && startingVHIndexInView <= endItemIndexInView) || (!negativeScroll && startingVHIndexInView >= endItemIndexInView))
			{
				if (!flag)
				{
					if (negativeScroll)
					{
						currentItemRealInset_negStart_posEnd = _InternalState.GetItemInferredRealInsetFromParentStart(startingVHIndexInView);
					}
					else
					{
						currentItemRealInset_negStart_posEnd = _InternalState.GetItemInferredRealInsetFromParentEnd(startingVHIndexInView);
					}
				}
				while (FindCorrectNLVFromCurrent(startingVHIndexInView))
				{
					int itemRealIndexFromViewIndex = _ItemsDesc.GetItemRealIndexFromViewIndex(nlvIndexInView);
					nlvHolder = _Adapter.ExtractRecyclableViewsHolderOrCreateNew(itemRealIndexFromViewIndex, nlvSize);
					int vhIndex = neg1_pos0 * _Adapter.VisibleItemsCount;
					_Adapter.AddViewsHolderAndMakeVisible(nlvHolder, vhIndex, itemRealIndexFromViewIndex, nlvIndexInView, currentItemRealInset_negStart_posEnd, negStartEdge_posEndEdge, nlvSize);
					startingVHIndexInView = nlvIndexInView + neg1_posMinus1;
					currentItemRealInset_negStart_posEnd += nlvSizePlusSpacing;
					if ((!negativeScroll || startingVHIndexInView > endItemIndexInView) && (negativeScroll || startingVHIndexInView < endItemIndexInView))
					{
						break;
					}
				}
			}
			if (debugString != null)
			{
				Debug.Log("OSA.ComputeVisibility(" + abstractDelta + "): " + debugString);
			}
		}
		if (_Adapter.VisibleItemsCount > _ItemsDesc.maxVisibleItemsSeenSinceLastScrollViewSizeChange)
		{
			_ItemsDesc.maxVisibleItemsSeenSinceLastScrollViewSizeChange = _Adapter.VisibleItemsCount;
		}
		PostComputeVisibilityCleanRecyclableItems();
		_Adapter._AVGVisibleItemsCount = _Adapter._AVGVisibleItemsCount * 0.9 + (double)_Adapter.VisibleItemsCount * 0.1;
	}

	private bool FindCorrectNLVFromCurrent(int currentLVItemIndexInView)
	{
		nlvIndexInView = currentLVItemIndexInView;
		while (true)
		{
			nlvSize = _ItemsDesc[nlvIndexInView];
			nlvSizePlusSpacing = nlvSize + _InternalState.spacing;
			currentRealInsetToUseForNLV_negFromCTS_posFromCTE = currentItemRealInset_negStart_posEnd;
			negNLVCandidateIsBeforeVP_posNLVCandidateIsAfterVP = currentRealInsetToUseForNLV_negFromCTS_posFromCTE <= 0.0 - nlvSize;
			if (!negNLVCandidateIsBeforeVP_posNLVCandidateIsAfterVP)
			{
				break;
			}
			if (nlvIndexInView == endItemIndexInView)
			{
				return false;
			}
			currentItemRealInset_negStart_posEnd += nlvSizePlusSpacing;
			nlvIndexInView += neg1_posMinus1;
		}
		if (currentRealInsetToUseForNLV_negFromCTS_posFromCTE > vpSize)
		{
			return false;
		}
		return true;
	}

	private void PrepareOutsideItemsForPotentialRecycleAndGetNextFirstVisibleIndexInView(out int startingVHIndexInView)
	{
		int index = neg1_pos0 * (_Adapter.VisibleItemsCount - 1);
		startingLVHolder = _Adapter._VisibleItems[index];
		startingVHIndexInView = startingLVHolder.itemIndexInView + neg1_posMinus1;
		int num = neg0_pos1 * (_Adapter.VisibleItemsCount - 1);
		TItemViewsHolder val = _Adapter._VisibleItems[num];
		double num2 = (negativeScroll ? _InternalState.GetItemVirtualInsetFromParentStartUsingItemIndexInView(val.itemIndexInView) : _InternalState.GetItemVirtualInsetFromParentEndUsingItemIndexInView(val.itemIndexInView));
		while (true)
		{
			double num3 = _ItemsDesc[val.itemIndexInView] + _InternalState.spacing;
			if (negCTVrtInsetFromVPS_posCTVrtInsetFromVPE <= 0.0 - (num2 + num3))
			{
				_Adapter._RecyclableItems.Add(val);
				_Adapter._VisibleItems.RemoveAt(num);
				OSA<TParams, TItemViewsHolder> adapter = _Adapter;
				int visibleItemsCount = adapter.VisibleItemsCount - 1;
				adapter.VisibleItemsCount = visibleItemsCount;
				if (_Adapter.VisibleItemsCount != 0)
				{
					num -= neg0_pos1;
					num2 += num3;
					val = _Adapter._VisibleItems[num];
					continue;
				}
				break;
			}
			break;
		}
	}

	private bool InferFirstVisibleVHIndexInViewAndInset(ref int currentInferredFirstVisibleVHIndexInView, double estimatedAVGVisibleItems)
	{
		int val = (int)Math.Round((1.0 - _InternalState.GetVirtualAbstractNormalizedScrollPosition()) * ((double)(itemsCount - 1) - (double)neg1_pos0 * estimatedAVGVisibleItems));
		val = Math.Max(0, Math.Min(itemsCount - 1, val));
		int num = val;
		double itemSizeOrDefault = _ItemsDesc.GetItemSizeOrDefault(num);
		double num2 = (negativeScroll ? _InternalState.GetItemInferredRealInsetFromParentStart(num) : _InternalState.GetItemInferredRealInsetFromParentEnd(num));
		int num3 = itemsCount * neg0_pos1 - neg1_pos0;
		for (; num2 <= 0.0 - itemSizeOrDefault; num2 += itemSizeOrDefault + _InternalState.spacing)
		{
			int num4 = num + neg1_posMinus1;
			if (num4 == num3)
			{
				break;
			}
			num = num4;
			itemSizeOrDefault = _ItemsDesc.GetItemSizeOrDefault(num);
		}
		if (num == val)
		{
			while (true)
			{
				int num5 = num - neg1_posMinus1;
				if (num5 == num3)
				{
					break;
				}
				double itemSizeOrDefault2 = _ItemsDesc.GetItemSizeOrDefault(num5);
				double num6 = num2 - (itemSizeOrDefault2 + _InternalState.spacing);
				if (num6 <= 0.0 - itemSizeOrDefault2)
				{
					break;
				}
				num = num5;
				itemSizeOrDefault = itemSizeOrDefault2;
				num2 = num6;
			}
			if (num < 0)
			{
				throw new OSAException("index " + num + ", currentInferredFirstVisibleVHIndexInView " + currentInferredFirstVisibleVHIndexInView);
			}
			if (num >= itemsCount)
			{
				throw new OSAException("index " + num + " >= itemsCount " + itemsCount + ", currentInferredFirstVisibleVHIndexInView " + currentInferredFirstVisibleVHIndexInView);
			}
		}
		if (!thereWereVisibletems || (negativeScroll && num >= currentInferredFirstVisibleVHIndexInView) || (!negativeScroll && num <= currentInferredFirstVisibleVHIndexInView))
		{
			currentInferredFirstVisibleVHIndexInView = num;
			currentItemRealInset_negStart_posEnd = num2;
			return true;
		}
		return false;
	}

	private void PostComputeVisibilityCleanRecyclableItems()
	{
		List<TItemViewsHolder> recyclableItems = _Adapter._RecyclableItems;
		int count = recyclableItems.Count;
		while (count-- > 0)
		{
			TItemViewsHolder val = recyclableItems[count];
			if (_Adapter.IsViewsHolderEnabled(val))
			{
				_Adapter.InternalOnBeforeRecycleOrDisableViewsHolder(val, -1);
				_Adapter.SetViewsHolderDisabled(val);
			}
			recyclableItems.RemoveAt(count);
			int numExcessRecycleableItems = _Adapter.GetNumExcessRecycleableItems();
			if (_Adapter.InternalShouldDestroyRecyclableItem(val, numExcessRecycleableItems > 0))
			{
				_Adapter.InternalDestroyRecyclableItem(val, isVisible: false);
				_ItemsDesc.destroyedItemsSinceLastScrollViewSizeChange++;
			}
			else
			{
				_Adapter.AddBufferredRecycleableItem(val);
			}
		}
	}
}
