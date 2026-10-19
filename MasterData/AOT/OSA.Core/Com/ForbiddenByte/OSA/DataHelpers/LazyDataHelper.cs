using System;
using Com.ForbiddenByte.OSA.Core;

namespace Com.ForbiddenByte.OSA.DataHelpers;

public class LazyDataHelper<T>
{
	protected IOSA _Adapter;

	protected LazyList<T> _DataList;

	private bool _KeepVelocityOnCountChange;

	public int Count => _DataList.Count;

	public LazyList<T> List => _DataList;

	public T this[int key] => _DataList[key];

	public bool SkipNotifyingAdapterForNextEvent { get; set; }

	public LazyDataHelper(IOSA iAdapter, Func<int, T> newModelCreator, bool keepVelocityOnCountChange = true)
	{
		_Adapter = iAdapter;
		_DataList = new LazyList<T>(newModelCreator, 0);
		_KeepVelocityOnCountChange = keepVelocityOnCountChange;
	}

	public T GetOrCreate(int index)
	{
		return _DataList[index];
	}

	public LazyList<T>.EnumerableLazyList GetEnumerableForExistingItems()
	{
		return _DataList.AsEnumerableForExistingItems;
	}

	public void InsertItems(int index, int count, bool freezeEndEdge = false)
	{
		_DataList.Insert(index, count);
		if (SkipNotifyingAdapterForNextEvent)
		{
			SkipNotifyingAdapterForNextEvent = false;
		}
		else
		{
			InsertItemsInternal(index, count, freezeEndEdge);
		}
	}

	public void InsertItemsAtStart(int count, bool freezeEndEdge = false)
	{
		InsertItems(0, count, freezeEndEdge);
	}

	public void InsertItemsAtEnd(int count, bool freezeEndEdge = false)
	{
		InsertItems(_DataList.Count, count, freezeEndEdge);
	}

	public void InsertOneManuallyCreated(int index, T model, bool freezeEndEdge = false)
	{
		_DataList.Insert(index, 1);
		_DataList.SetOrUpdateManuallyCreatedValue(index, model);
		if (SkipNotifyingAdapterForNextEvent)
		{
			SkipNotifyingAdapterForNextEvent = false;
		}
		else
		{
			InsertItemsInternal(index, 1, freezeEndEdge);
		}
	}

	public void RemoveItems(int index, int count, bool freezeEndEdge = false)
	{
		_DataList.Remove(index, count);
		if (SkipNotifyingAdapterForNextEvent)
		{
			SkipNotifyingAdapterForNextEvent = false;
		}
		else
		{
			RemoveItemsInternal(index, count, freezeEndEdge);
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

	public void RemoveOne(T model, bool freezeEndEdge = false)
	{
		int num = _DataList.Remove(model);
		if (num == -1)
		{
			T val = model;
			throw new OSAException("Not found: " + val);
		}
		if (SkipNotifyingAdapterForNextEvent)
		{
			SkipNotifyingAdapterForNextEvent = false;
		}
		else
		{
			RemoveItemsInternal(num, 1, freezeEndEdge);
		}
	}

	public void ResetItems(int count, bool freezeEndEdge = false)
	{
		_DataList.InitWithNewCount(count);
		if (SkipNotifyingAdapterForNextEvent)
		{
			SkipNotifyingAdapterForNextEvent = false;
		}
		else
		{
			_Adapter.ResetItems(_DataList.Count, freezeEndEdge, _KeepVelocityOnCountChange);
		}
	}

	public void NotifyListChangedExternally(bool freezeEndEdge = false)
	{
		if (SkipNotifyingAdapterForNextEvent)
		{
			throw new OSAException("Don't set SkipNotifyingAdapterForNextEvent=true before calling NotifyListChangedExternally");
		}
		_Adapter.ResetItems(_DataList.Count, freezeEndEdge, _KeepVelocityOnCountChange);
	}

	private void InsertItemsInternal(int index, int count, bool freezeEndEdge)
	{
		if (_Adapter.InsertAtIndexSupported)
		{
			_Adapter.InsertItems(index, count, freezeEndEdge, _KeepVelocityOnCountChange);
		}
		else
		{
			_Adapter.ResetItems(_DataList.Count, freezeEndEdge, _KeepVelocityOnCountChange);
		}
	}

	private void RemoveItemsInternal(int index, int count, bool freezeEndEdge)
	{
		if (_Adapter.RemoveFromIndexSupported)
		{
			_Adapter.RemoveItems(index, count, freezeEndEdge, _KeepVelocityOnCountChange);
		}
		else
		{
			_Adapter.ResetItems(_DataList.Count, freezeEndEdge, _KeepVelocityOnCountChange);
		}
	}
}
