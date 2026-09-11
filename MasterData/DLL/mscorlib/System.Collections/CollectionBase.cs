namespace System.Collections;

[Serializable]
public abstract class CollectionBase : IList, ICollection, IEnumerable
{
	private ArrayList _list;

	protected ArrayList InnerList => _list;

	protected IList List => this;

	public int Count => _list.Count;

	bool IList.IsReadOnly => InnerList.IsReadOnly;

	bool IList.IsFixedSize => InnerList.IsFixedSize;

	bool ICollection.IsSynchronized => InnerList.IsSynchronized;

	object ICollection.SyncRoot => InnerList.SyncRoot;

	object IList.this[int index]
	{
		get
		{
			if (index < 0 || index >= Count)
			{
				throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
			}
			return InnerList[index];
		}
		set
		{
			if (index < 0 || index >= Count)
			{
				throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
			}
			OnValidate(value);
			object obj = InnerList[index];
			OnSet(index, obj, value);
			InnerList[index] = value;
			try
			{
				OnSetComplete(index, obj, value);
			}
			catch
			{
				InnerList[index] = obj;
				throw;
			}
		}
	}

	protected CollectionBase()
	{
		_list = new ArrayList();
	}

	public void Clear()
	{
		OnClear();
		InnerList.Clear();
		OnClearComplete();
	}

	public void RemoveAt(int index)
	{
		if (index < 0 || index >= Count)
		{
			throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		object value = InnerList[index];
		OnValidate(value);
		OnRemove(index, value);
		InnerList.RemoveAt(index);
		try
		{
			OnRemoveComplete(index, value);
		}
		catch
		{
			InnerList.Insert(index, value);
			throw;
		}
	}

	void ICollection.CopyTo(Array array, int index)
	{
		InnerList.CopyTo(array, index);
	}

	bool IList.Contains(object value)
	{
		return InnerList.Contains(value);
	}

	int IList.Add(object value)
	{
		OnValidate(value);
		OnInsert(InnerList.Count, value);
		int num = InnerList.Add(value);
		try
		{
			OnInsertComplete(num, value);
			return num;
		}
		catch
		{
			InnerList.RemoveAt(num);
			throw;
		}
	}

	void IList.Remove(object value)
	{
		OnValidate(value);
		int num = InnerList.IndexOf(value);
		if (num < 0)
		{
			throw new ArgumentException("Cannot remove the specified item because it was not found in the specified Collection.");
		}
		OnRemove(num, value);
		InnerList.RemoveAt(num);
		try
		{
			OnRemoveComplete(num, value);
		}
		catch
		{
			InnerList.Insert(num, value);
			throw;
		}
	}

	int IList.IndexOf(object value)
	{
		return InnerList.IndexOf(value);
	}

	void IList.Insert(int index, object value)
	{
		if (index < 0 || index > Count)
		{
			throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		OnValidate(value);
		OnInsert(index, value);
		InnerList.Insert(index, value);
		try
		{
			OnInsertComplete(index, value);
		}
		catch
		{
			InnerList.RemoveAt(index);
			throw;
		}
	}

	public IEnumerator GetEnumerator()
	{
		return InnerList.GetEnumerator();
	}

	protected virtual void OnSet(int index, object oldValue, object newValue)
	{
	}

	protected virtual void OnInsert(int index, object value)
	{
	}

	protected virtual void OnClear()
	{
	}

	protected virtual void OnRemove(int index, object value)
	{
	}

	protected virtual void OnValidate(object value)
	{
		if (value == null)
		{
			throw new ArgumentNullException("value");
		}
	}

	protected virtual void OnSetComplete(int index, object oldValue, object newValue)
	{
	}

	protected virtual void OnInsertComplete(int index, object value)
	{
	}

	protected virtual void OnClearComplete()
	{
	}

	protected virtual void OnRemoveComplete(int index, object value)
	{
	}
}
