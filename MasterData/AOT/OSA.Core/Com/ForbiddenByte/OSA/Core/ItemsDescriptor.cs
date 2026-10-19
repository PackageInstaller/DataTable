using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace Com.ForbiddenByte.OSA.Core;

public class ItemsDescriptor
{
	public class SizeInfo
	{
		public double size;

		public double cumulativeSize;
	}

	public int itemsCount;

	public int realIndexOfFirstItemInView;

	public int maxVisibleItemsSeenSinceLastScrollViewSizeChange;

	public int destroyedItemsSinceLastScrollViewSizeChange;

	private List<int> _Keys = new List<int>();

	private Dictionary<int, SizeInfo> _SizeInfos = new Dictionary<int, SizeInfo>();

	private double _DefaultSize;

	private bool _ChangingItemsSizesInProgress;

	private int _IndexInViewOfFirstItemThatChangesSizeDuringSizesChange;

	private int _IndexInViewOfLastItemThatChangedSizeDuringSizesChange = -1;

	private double _CumulatedSizesUntilNowDuringSizesChange;

	public double CumulatedSizeOfAllItems
	{
		get
		{
			if (itemsCount != 0)
			{
				return GetItemSizeCumulative(itemsCount - 1, allowInferringFromNeighborAfter: false);
			}
			return 0.0;
		}
	}

	public double this[int itemIndexInView]
	{
		get
		{
			if (_SizeInfos.TryGetValue(itemIndexInView, out var value))
			{
				return value.size;
			}
			return _DefaultSize;
		}
		set
		{
			if (_ChangingItemsSizesInProgress)
			{
				if (itemIndexInView != _IndexInViewOfLastItemThatChangedSizeDuringSizesChange + 1)
				{
					throw new OSAException("itemIndexInView=" + itemIndexInView + ", while the expected one is " + (_IndexInViewOfLastItemThatChangedSizeDuringSizesChange + 1) + ". Sizes can only be changed for items one by one, one after another(e.g. 3,4,5,6,7..), starting with the one passed to BeginChangingItemsSizes(int)!");
				}
				BinaryAddKeyToSortedListIfDoesntExist(itemIndexInView);
				_CumulatedSizesUntilNowDuringSizesChange += value;
				if (!_SizeInfos.TryGetValue(itemIndexInView, out var value2))
				{
					_SizeInfos.Add(itemIndexInView, value2 = new SizeInfo());
				}
				value2.size = value;
				value2.cumulativeSize = _CumulatedSizesUntilNowDuringSizesChange;
				_IndexInViewOfLastItemThatChangedSizeDuringSizesChange = itemIndexInView;
				return;
			}
			throw new OSAException("Call BeginChangingItemsSizes() before");
		}
	}

	public ItemsDescriptor(double defaultSize)
	{
		if (defaultSize <= 0.0)
		{
			throw new OSAException("ItemsDescriptor can't be initialized with a 0 or negative itemDefaultSize: " + defaultSize);
		}
		ReinitializeSizes(ItemCountChangeMode.RESET, 0, -1, defaultSize);
		ReinitializeRealIndexOfFirstItemInView(0, ItemCountChangeMode.RESET, 0, -1, -1, canLoop: false);
	}

	public void ReinitializeRealIndexOfFirstItemInView(int oldCount, ItemCountChangeMode changeMode, int count, int indexIfInsertingOrRemoving, int itemIndexOfFirstVHIfInsertingOrRemoving, bool canLoop)
	{
		if (itemsCount == 0)
		{
			realIndexOfFirstItemInView = -1;
			return;
		}
		if (changeMode == ItemCountChangeMode.RESET)
		{
			realIndexOfFirstItemInView = 0;
			return;
		}
		if (canLoop)
		{
			throw new OSAException("At the moment, only ItemCountChangeMode.RESET is supported when looping");
		}
		realIndexOfFirstItemInView = 0;
	}

	public void ReinitializeSizes(ItemCountChangeMode changeMode, int count, int indexIfInsertingOrRemoving, double? newDefaultSize = null)
	{
		if (newDefaultSize.HasValue)
		{
			if (newDefaultSize != _DefaultSize)
			{
				if (changeMode != ItemCountChangeMode.RESET)
				{
					throw new OSAException("Cannot preserve old sizes if the newDefaultItemSize is different!");
				}
				_DefaultSize = newDefaultSize.Value;
			}
			AssureValidDefaultItemSizeOrThrow();
		}
		int num;
		if (changeMode == ItemCountChangeMode.RESET)
		{
			num = count;
			if (num < 0)
			{
				throw new ArgumentOutOfRangeException("OSA.ItemsDescriptor.ReinitializeSizes: Can't have negative count: " + num);
			}
			ClearAllKeysAndSizes();
		}
		else
		{
			if (indexIfInsertingOrRemoving < 0)
			{
				throw new ArgumentOutOfRangeException("indexIfInsertingOrRemoving", indexIfInsertingOrRemoving, "Should be positive or 0");
			}
			if (count < 0)
			{
				throw new ArgumentOutOfRangeException("count", count, "Cannot be negative!");
			}
			if (changeMode == ItemCountChangeMode.REMOVE)
			{
				if (indexIfInsertingOrRemoving + count > itemsCount)
				{
					throw new ArgumentOutOfRangeException("RemoveItems: index + count", indexIfInsertingOrRemoving + count, "Should be positive and less than- or or equal to itemsCount=" + itemsCount);
				}
			}
			else if (indexIfInsertingOrRemoving > itemsCount)
			{
				throw new ArgumentOutOfRangeException("InsertItems: indexIfInsertingOrRemoving", indexIfInsertingOrRemoving, "Should be positive and less than- or equal to itemsCount=" + itemsCount);
			}
			int num2 = (int)changeMode * count;
			num = itemsCount + num2;
			if (num < 0)
			{
				throw new ArgumentOutOfRangeException("newCount", "OSA.ItemsDescriptor.ReinitializeSizes: Can't have negative count " + num);
			}
			if (num == 0)
			{
				ClearAllKeysAndSizes();
			}
			else if (itemsCount > 0 && indexIfInsertingOrRemoving < itemsCount)
			{
				ShiftSizesKeysAfterInsertOrRemove(GetItemViewIndexFromRealIndexChecked(indexIfInsertingOrRemoving), num2);
			}
		}
		itemsCount = num;
	}

	public ReadOnlyCollection<int> GetIndicesInViewOfNonDefaultItems()
	{
		return _Keys.AsReadOnly();
	}

	public Dictionary<int, SizeInfo> GetSizeInfosOfNonDefaultItems()
	{
		return _SizeInfos;
	}

	private void AssureValidDefaultItemSizeOrThrow()
	{
		if (_DefaultSize <= 0.0)
		{
			throw new OSAException("ItemsDescriptor.AssureValidDefaultItemSizeOrThrow: Item prefab's size is zero or negative(" + _DefaultSize + "). This is not allowed. Is your prefab badly resized at initialization?");
		}
	}

	private void ClearAllKeysAndSizes()
	{
		_SizeInfos = new Dictionary<int, SizeInfo>();
		_Keys = new List<int>();
	}

	private void BinaryAddKeyToSortedListIfDoesntExist(int key)
	{
		int num = _Keys.BinarySearch(key);
		if (num < 0)
		{
			_Keys.Insert(~num, key);
		}
	}

	private void BinaryRemoveKeyFromSortedList(int key)
	{
		_Keys.RemoveAt(_Keys.BinarySearch(key));
	}

	private void ShiftSizesKeysAfterInsertOrRemove(int startingKey, int amount)
	{
		if (_SizeInfos.Count != _Keys.Count)
		{
			throw new OSAException("The sizes state was corrupted");
		}
		int num = _Keys.BinarySearch(startingKey);
		if (num < 0)
		{
			num = ~num;
		}
		long num2 = amount;
		int i = num;
		double num3 = 0.0;
		SizeInfo value;
		if (amount < 0)
		{
			long num4 = _Keys.Count;
			long num5 = -num2;
			long num6 = startingKey + num5;
			int key;
			while (i < _Keys.Count && (key = _Keys[i]) < num6)
			{
				SizeInfo sizeInfo = _SizeInfos[key];
				num3 -= sizeInfo.size;
				_SizeInfos.Remove(key);
				_Keys.RemoveAt(i);
			}
			long num7 = num4 - _Keys.Count;
			num3 -= (double)(num5 - num7) * _DefaultSize;
			for (; i < _Keys.Count; i++)
			{
				key = _Keys[i];
				SizeInfo sizeInfo = _SizeInfos[key];
				_SizeInfos.Remove(key);
				int num8 = key + amount;
				if (num8 < 0)
				{
					_Keys.RemoveAt(i);
					continue;
				}
				_Keys[i] = num8;
				if (!_SizeInfos.TryGetValue(num8, out value))
				{
					_SizeInfos.Add(num8, value = new SizeInfo());
				}
				value.size = sizeInfo.size;
				value.cumulativeSize = sizeInfo.cumulativeSize + num3;
			}
			return;
		}
		num3 = (double)amount * _DefaultSize;
		int num9 = i;
		for (i = _Keys.Count - 1; i >= num9; i--)
		{
			int key = _Keys[i];
			SizeInfo sizeInfo = _SizeInfos[key];
			_SizeInfos.Remove(key);
			int num10 = key + amount;
			_Keys[i] = num10;
			if (!_SizeInfos.TryGetValue(num10, out value))
			{
				_SizeInfos.Add(num10, value = new SizeInfo());
			}
			value.size = sizeInfo.size;
			value.cumulativeSize = sizeInfo.cumulativeSize + num3;
		}
	}

	public void BeginChangingItemsSizes(int indexInViewOfFirstItemThatWillChangeSize)
	{
		if (_ChangingItemsSizesInProgress)
		{
			throw new OSAException("Call EndChangingItemsSizes() when done doing it");
		}
		_ChangingItemsSizesInProgress = true;
		_IndexInViewOfFirstItemThatChangesSizeDuringSizesChange = indexInViewOfFirstItemThatWillChangeSize;
		_IndexInViewOfLastItemThatChangedSizeDuringSizesChange = _IndexInViewOfFirstItemThatChangesSizeDuringSizesChange - 1;
		_CumulatedSizesUntilNowDuringSizesChange = ((_IndexInViewOfFirstItemThatChangesSizeDuringSizesChange == 0) ? 0.0 : GetItemSizeCumulative(_IndexInViewOfFirstItemThatChangesSizeDuringSizesChange - 1, allowInferringFromNeighborAfter: false));
	}

	public void EndChangingItemsSizes()
	{
		_ChangingItemsSizesInProgress = false;
		if (_IndexInViewOfLastItemThatChangedSizeDuringSizesChange != _IndexInViewOfFirstItemThatChangesSizeDuringSizesChange - 1)
		{
			int num = _Keys.BinarySearch(_IndexInViewOfLastItemThatChangedSizeDuringSizesChange);
			if (num < 0)
			{
				throw new OSAException("The sizes state was corrupted");
			}
			double num2 = _CumulatedSizesUntilNowDuringSizesChange;
			int num3 = _IndexInViewOfLastItemThatChangedSizeDuringSizesChange;
			for (int i = num + 1; i < _Keys.Count; i++)
			{
				int num4 = _Keys[i];
				SizeInfo sizeInfo = _SizeInfos[num4];
				num2 = (sizeInfo.cumulativeSize = num2 + ((double)(num4 - num3 - 1) * _DefaultSize + sizeInfo.size));
				num3 = num4;
			}
		}
	}

	public int GetItemRealIndexFromViewIndex(int indexInView)
	{
		return (int)(((long)realIndexOfFirstItemInView + (long)indexInView) % itemsCount);
	}

	private int GetItemViewIndexFromRealIndexWithoutChecks(int realIndex)
	{
		return (int)(((long)realIndex - (long)realIndexOfFirstItemInView + itemsCount) % itemsCount);
	}

	public int GetItemViewIndexFromRealIndexChecked(int realIndex)
	{
		if (realIndex < 0)
		{
			throw new ArgumentOutOfRangeException("realIndex", realIndex, "OSA.GetItemViewIndexFromRealIndexNotAllowingTotalCount: argument should be >=0");
		}
		if (realIndex >= itemsCount)
		{
			throw new ArgumentOutOfRangeException("realIndex", realIndex, "OSA.GetItemViewIndexFromRealIndexNotAllowingTotalCount: argument should be < totalCount(=" + itemsCount + ")");
		}
		return GetItemViewIndexFromRealIndexWithoutChecks(realIndex);
	}

	public double GetItemSizeOrDefault(int itemIndexInView)
	{
		if (_SizeInfos.TryGetValue(itemIndexInView, out var value))
		{
			return value.size;
		}
		return _DefaultSize;
	}

	public double GetItemSizeCumulative(int itemIndexInView, bool allowInferringFromNeighborAfter = true)
	{
		if (_Keys.Count > 0)
		{
			if (_SizeInfos.TryGetValue(itemIndexInView, out var value))
			{
				return value.cumulativeSize;
			}
			int num = _Keys.BinarySearch(itemIndexInView);
			if (num >= 0)
			{
				throw new OSAException("The sizes state was corrupted. key not in _SizesCumulative, but present in _Keys");
			}
			num = ~num;
			int num2 = num - 1;
			if ((num < _Keys.Count) & allowInferringFromNeighborAfter)
			{
				int num3 = _Keys[num];
				int num4 = num3 - itemIndexInView;
				if (num2 < 0 || num4 < itemIndexInView - _Keys[num2])
				{
					value = _SizeInfos[num3];
					return value.cumulativeSize - (this[num3] + (double)(num4 - 1) * _DefaultSize);
				}
			}
			if (num2 >= 0)
			{
				int num5 = _Keys[num2];
				value = _SizeInfos[num5];
				return value.cumulativeSize + (double)(itemIndexInView - num5) * _DefaultSize;
			}
		}
		return (double)(itemIndexInView + 1) * _DefaultSize;
	}

	public void RotateItemsSizesOnScrollViewLooped(int newValueOf_RealIndexOfFirstItemInView)
	{
		int num = realIndexOfFirstItemInView;
		realIndexOfFirstItemInView = newValueOf_RealIndexOfFirstItemInView;
		int num2 = num - realIndexOfFirstItemInView;
		int count = _Keys.Count;
		if (num2 == 0 && count == 0)
		{
			return;
		}
		if (num2 < 0)
		{
			num2 += itemsCount;
		}
		List<int> keys = _Keys;
		Dictionary<int, SizeInfo> sizeInfos = _SizeInfos;
		_Keys = new List<int>(count);
		_SizeInfos = new Dictionary<int, SizeInfo>(count);
		for (int i = 0; i < count; i++)
		{
			int num3 = keys[i];
			int key = (num3 + num2) % itemsCount;
			BinaryAddKeyToSortedListIfDoesntExist(key);
			SizeInfo sizeInfo = sizeInfos[num3];
			if (!_SizeInfos.TryGetValue(key, out var value))
			{
				_SizeInfos.Add(key, value = new SizeInfo());
			}
			value.size = sizeInfo.size;
		}
		double num4 = 0.0;
		int num5 = -1;
		for (int j = 0; j < count; j++)
		{
			int key = _Keys[j];
			SizeInfo sizeInfo = _SizeInfos[key];
			int num6 = key - num5 - 1;
			num4 += (double)num6 * _DefaultSize;
			num4 = (sizeInfo.cumulativeSize = num4 + sizeInfo.size);
			num5 = key;
		}
	}
}
