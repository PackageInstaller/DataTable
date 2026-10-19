using System;
using System.Collections;
using System.Collections.Generic;
using Com.ForbiddenByte.OSA.Core;
using UnityEngine;

namespace Com.ForbiddenByte.OSA.DataHelpers;

public class FilterableDataHelper<T> : IEnumerable<T>, IEnumerable
{
	private List<T> _FilteredList;

	private List<T> _DataList;

	private List<int> _FilteredItemIndex;

	private bool _UseFilteredData = true;

	private IOSA _Adapter;

	private bool _KeepVelocityOnCountChange;

	private Predicate<T> _FilteringCriteria;

	public bool UseFilteredData
	{
		get
		{
			return _UseFilteredData;
		}
		set
		{
			_UseFilteredData = value;
		}
	}

	public T this[int index] => CurrentList[index];

	public int Count => CurrentList.Count;

	public Predicate<T> FilteringCriteria
	{
		set
		{
			if (value == null)
			{
				throw new ArgumentNullException("Please make sure your predicate is valid");
			}
			_FilteringCriteria = value;
			RemakeFilteredItems();
			_Adapter.ResetItems(CurrentList.Count);
		}
	}

	private List<T> CurrentList
	{
		get
		{
			if (!_UseFilteredData)
			{
				return _DataList;
			}
			return _FilteredList;
		}
	}

	public FilterableDataHelper(IOSA iAdapter, bool keepVelocityOnCountChange = true)
	{
		_DataList = new List<T>();
		_Adapter = iAdapter;
		_FilteredList = new List<T>();
		_FilteredItemIndex = new List<int>();
		_FilteringCriteria = (T T) => true;
		_KeepVelocityOnCountChange = keepVelocityOnCountChange;
	}

	IEnumerator<T> IEnumerable<T>.GetEnumerator()
	{
		return CurrentList.GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return CurrentList.GetEnumerator();
	}

	public void InsertItems(int index, IList<T> models, bool freezeEndEdge = false)
	{
		_DataList.InsertRange(index, models);
		int num = _FilteredItemIndex.BinarySearch(index);
		bool flag = num >= 0;
		if (!flag)
		{
			num = ~num;
		}
		List<T> list = new List<T>();
		List<int> list2 = new List<int>();
		for (int i = 0; i < models.Count; i++)
		{
			T val = models[i];
			if (_FilteringCriteria(val))
			{
				list.Add(val);
				list2.Add(index + i);
			}
		}
		for (int j = num; j < _FilteredItemIndex.Count; j++)
		{
			_FilteredItemIndex[j] += models.Count;
		}
		_FilteredList.InsertRange(Mathf.Max(num + ((!flag) ? (-1) : 0), 0), list);
		_FilteredItemIndex.InsertRange(Mathf.Max(num + ((!flag) ? (-1) : 0), 0), list2);
		if (_Adapter.InsertAtIndexSupported)
		{
			if (_UseFilteredData)
			{
				_Adapter.InsertItems(num, list.Count, freezeEndEdge, _KeepVelocityOnCountChange);
			}
			else
			{
				_Adapter.InsertItems(index, models.Count, freezeEndEdge, _KeepVelocityOnCountChange);
			}
		}
		else
		{
			_Adapter.ResetItems(CurrentList.Count, freezeEndEdge, _KeepVelocityOnCountChange);
		}
	}

	public void InsertItemsAtStart(IList<T> models, bool freezeEndEdge = false)
	{
		InsertItems(0, models, freezeEndEdge);
	}

	public void InsertItemsAtEnd(IList<T> models, bool freezeEndEdge = false)
	{
		InsertItems(_DataList.Count, models, freezeEndEdge);
	}

	public void InsertOne(int unfilteredIndex, T model, bool freezeEndEdge = false)
	{
		_DataList.Insert(unfilteredIndex, model);
		int num = _FilteredItemIndex.BinarySearch(unfilteredIndex);
		if (num < 0)
		{
			num = Mathf.Max(~num - 1, 0);
		}
		for (int i = num; i < _FilteredItemIndex.Count; i++)
		{
			_FilteredItemIndex[i]++;
		}
		bool flag = _FilteringCriteria(model);
		if (flag)
		{
			_FilteredList.Insert(num, model);
			_FilteredItemIndex.Insert(num, unfilteredIndex);
		}
		if (_Adapter.InsertAtIndexSupported)
		{
			int itemsCount = 1;
			if (UseFilteredData && !flag)
			{
				itemsCount = 0;
			}
			_Adapter.InsertItems(_UseFilteredData ? num : unfilteredIndex, itemsCount, freezeEndEdge, _KeepVelocityOnCountChange);
		}
		else
		{
			_Adapter.ResetItems(CurrentList.Count, freezeEndEdge, _KeepVelocityOnCountChange);
		}
	}

	public void InsertOneAtStart(T model, bool freezeEndEdge = false)
	{
		InsertOne(0, model, freezeEndEdge);
	}

	public void InsertOneAtEnd(T model, bool freezeEndEdge = false)
	{
		InsertOne(_DataList.Count, model, freezeEndEdge);
	}

	public void RemoveItems(int index, int count, bool freezeEndEdge = false)
	{
		_DataList.RemoveRange(index, count);
		int num = _FilteredItemIndex.BinarySearch(index + count);
		int num2 = _FilteredItemIndex.BinarySearch(index);
		bool flag = num2 >= 0;
		bool flag2 = num >= 0;
		if (!flag)
		{
			num2 = ~num2;
		}
		if (!flag2)
		{
			num = ~num;
		}
		int num3 = num - num2;
		for (int i = num; i < _FilteredItemIndex.Count; i++)
		{
			_FilteredItemIndex[i] -= count;
		}
		_FilteredItemIndex.RemoveRange(num2, num3);
		_FilteredList.RemoveRange(num2, num3);
		if (_Adapter.RemoveFromIndexSupported)
		{
			if (_UseFilteredData)
			{
				if (num3 > 0)
				{
					_Adapter.RemoveItems(num2, num3, freezeEndEdge, _KeepVelocityOnCountChange);
				}
			}
			else
			{
				_Adapter.RemoveItems(index, count, _KeepVelocityOnCountChange);
			}
		}
		else
		{
			_Adapter.ResetItems(CurrentList.Count, freezeEndEdge, _KeepVelocityOnCountChange);
		}
	}

	public void RemoveItemsFromStart(int count, bool freezeEndEdge = false)
	{
		RemoveItems(0, count, freezeEndEdge);
	}

	public void RemoveItemsFromEnd(int count, bool freezeEndEdge = false)
	{
		RemoveItems(_DataList.Count - count, count, freezeEndEdge);
	}

	public void RemoveOne(int unfilteredIndex, bool freezeEndEdge = false)
	{
		RemoveItems(unfilteredIndex, 1, freezeEndEdge);
	}

	public void RemoveOneFromStart(bool freezeEndEdge = false)
	{
		RemoveOne(0, freezeEndEdge);
	}

	public void RemoveOneFromEnd(bool freezeEndEdge = false)
	{
		RemoveOne(_DataList.Count - 1, freezeEndEdge);
	}

	public void ResetItems(IList<T> models, bool freezeEndEdge = false)
	{
		_DataList.Clear();
		_DataList.AddRange(models);
		RemakeFilteredItems();
		_Adapter.ResetItems(CurrentList.Count, freezeEndEdge, _KeepVelocityOnCountChange);
	}

	public void ResetItemsByReplacingListInstance(List<T> newListInstance, bool freezeEndEdge = false)
	{
		_DataList.Clear();
		_DataList = newListInstance;
		RemakeFilteredItems();
		_Adapter.ResetItems(CurrentList.Count, freezeEndEdge, _KeepVelocityOnCountChange);
	}

	public void NotifyListChangedExternally(bool freezeEndEdge = false)
	{
		RemakeFilteredItems();
		_Adapter.ResetItems(CurrentList.Count, freezeEndEdge, _KeepVelocityOnCountChange);
	}

	public int GetUnfilteredIdex(int filteredIndex)
	{
		if (!_UseFilteredData)
		{
			return filteredIndex;
		}
		return _FilteredItemIndex[filteredIndex];
	}

	private void RemakeFilteredItems()
	{
		_FilteredList.Clear();
		_FilteredItemIndex.Clear();
		for (int i = 0; i < _DataList.Count; i++)
		{
			T val = _DataList[i];
			if (_FilteringCriteria(val))
			{
				_FilteredList.Add(val);
				_FilteredItemIndex.Add(i);
			}
		}
	}
}
