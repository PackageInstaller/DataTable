using System.Collections;
using System.Collections.Generic;
using Com.ForbiddenByte.OSA.Core;

namespace Com.ForbiddenByte.OSA.DataHelpers;

public class SimpleDataHelper<T> : IEnumerable<T>, IEnumerable
{
	protected IOSA _Adapter;

	protected List<T> _DataList;

	private bool _KeepVelocityOnCountChange;

	public int Count => _DataList.Count;

	public T this[int index] => _DataList[index];

	public List<T> List => _DataList;

	public SimpleDataHelper(IOSA iAdapter, bool keepVelocityOnCountChange = true)
	{
		_Adapter = iAdapter;
		_DataList = new List<T>();
		_KeepVelocityOnCountChange = keepVelocityOnCountChange;
	}

	IEnumerator<T> IEnumerable<T>.GetEnumerator()
	{
		return _DataList.GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return _DataList.GetEnumerator();
	}

	public void InsertItems(int index, IList<T> models, bool freezeEndEdge = false)
	{
		_DataList.InsertRange(index, models);
		if (_Adapter.InsertAtIndexSupported)
		{
			_Adapter.InsertItems(index, models.Count, freezeEndEdge, _KeepVelocityOnCountChange);
		}
		else
		{
			_Adapter.ResetItems(_DataList.Count, freezeEndEdge, _KeepVelocityOnCountChange);
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

	public void InsertOne(int index, T model, bool freezeEndEdge = false)
	{
		_DataList.Insert(index, model);
		if (_Adapter.InsertAtIndexSupported)
		{
			_Adapter.InsertItems(index, 1, freezeEndEdge, _KeepVelocityOnCountChange);
		}
		else
		{
			_Adapter.ResetItems(_DataList.Count, freezeEndEdge, _KeepVelocityOnCountChange);
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
		if (_Adapter.RemoveFromIndexSupported)
		{
			_Adapter.RemoveItems(index, count, freezeEndEdge, _KeepVelocityOnCountChange);
		}
		else
		{
			_Adapter.ResetItems(_DataList.Count, freezeEndEdge, _KeepVelocityOnCountChange);
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

	public void RemoveOne(int index, bool freezeEndEdge = false)
	{
		_DataList.RemoveAt(index);
		if (_Adapter.RemoveFromIndexSupported)
		{
			_Adapter.RemoveItems(index, 1, freezeEndEdge, _KeepVelocityOnCountChange);
		}
		else
		{
			_Adapter.ResetItems(_DataList.Count, freezeEndEdge, _KeepVelocityOnCountChange);
		}
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
		_Adapter.ResetItems(_DataList.Count, freezeEndEdge, _KeepVelocityOnCountChange);
	}

	public void ResetItemsByReplacingListInstance(List<T> newListInstance, bool freezeEndEdge = false)
	{
		_DataList.Clear();
		_DataList = newListInstance;
		_Adapter.ResetItems(_DataList.Count, freezeEndEdge, _KeepVelocityOnCountChange);
	}

	public void NotifyListChangedExternally(bool freezeEndEdge = false)
	{
		_Adapter.ResetItems(_DataList.Count, freezeEndEdge, _KeepVelocityOnCountChange);
	}
}
