using System.Collections.Generic;
using System.Diagnostics;

namespace System.Collections.ObjectModel;

[Serializable]
[DebuggerDisplay("Count = {Count}")]
[DebuggerTypeProxy(typeof(ICollectionDebugView<>))]
public class Collection<T> : IList<T>, ICollection<T>, IEnumerable<T>, IEnumerable, IList, ICollection, IReadOnlyList<T>, IReadOnlyCollection<T>
{
	private IList<T> items;

	public int Count => items.Count;

	protected IList<T> Items => items;

	public T this[int index]
	{
		get
		{
			return items[index];
		}
		set
		{
			if (items.IsReadOnly)
			{
				ThrowHelper.ThrowNotSupportedException(ExceptionResource.NotSupported_ReadOnlyCollection);
			}
			if ((uint)index >= (uint)items.Count)
			{
				ThrowHelper.ThrowArgumentOutOfRange_IndexException();
			}
			SetItem(index, value);
		}
	}

	bool ICollection<T>.IsReadOnly => items.IsReadOnly;

	bool ICollection.IsSynchronized => false;

	object ICollection.SyncRoot
	{
		get
		{
			if (!(items is ICollection collection))
			{
				return this;
			}
			return collection.SyncRoot;
		}
	}

	object IList.this[int index]
	{
		get
		{
			return items[index];
		}
		set
		{
			ThrowHelper.IfNullAndNullsAreIllegalThenThrow<T>(value, ExceptionArgument.value);
			try
			{
				this[index] = (T)value;
			}
			catch (InvalidCastException)
			{
				ThrowHelper.ThrowWrongValueTypeArgumentException(value, typeof(T));
			}
		}
	}

	bool IList.IsReadOnly => items.IsReadOnly;

	bool IList.IsFixedSize
	{
		get
		{
			if (items is IList list)
			{
				return list.IsFixedSize;
			}
			return items.IsReadOnly;
		}
	}

	public Collection()
	{
		items = new List<T>();
	}

	public Collection(IList<T> list)
	{
		if (list == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.list);
		}
		items = list;
	}

	public void Add(T item)
	{
		if (items.IsReadOnly)
		{
			ThrowHelper.ThrowNotSupportedException(ExceptionResource.NotSupported_ReadOnlyCollection);
		}
		int count = items.Count;
		InsertItem(count, item);
	}

	public void Clear()
	{
		if (items.IsReadOnly)
		{
			ThrowHelper.ThrowNotSupportedException(ExceptionResource.NotSupported_ReadOnlyCollection);
		}
		ClearItems();
	}

	public void CopyTo(T[] array, int index)
	{
		items.CopyTo(array, index);
	}

	public bool Contains(T item)
	{
		return items.Contains(item);
	}

	public IEnumerator<T> GetEnumerator()
	{
		return items.GetEnumerator();
	}

	public int IndexOf(T item)
	{
		return items.IndexOf(item);
	}

	public void Insert(int index, T item)
	{
		if (items.IsReadOnly)
		{
			ThrowHelper.ThrowNotSupportedException(ExceptionResource.NotSupported_ReadOnlyCollection);
		}
		if ((uint)index > (uint)items.Count)
		{
			ThrowHelper.ThrowArgumentOutOfRange_IndexException();
		}
		InsertItem(index, item);
	}

	public bool Remove(T item)
	{
		if (items.IsReadOnly)
		{
			ThrowHelper.ThrowNotSupportedException(ExceptionResource.NotSupported_ReadOnlyCollection);
		}
		int num = items.IndexOf(item);
		if (num < 0)
		{
			return false;
		}
		RemoveItem(num);
		return true;
	}

	public void RemoveAt(int index)
	{
		if (items.IsReadOnly)
		{
			ThrowHelper.ThrowNotSupportedException(ExceptionResource.NotSupported_ReadOnlyCollection);
		}
		if ((uint)index >= (uint)items.Count)
		{
			ThrowHelper.ThrowArgumentOutOfRange_IndexException();
		}
		RemoveItem(index);
	}

	protected virtual void ClearItems()
	{
		items.Clear();
	}

	protected virtual void InsertItem(int index, T item)
	{
		items.Insert(index, item);
	}

	protected virtual void RemoveItem(int index)
	{
		items.RemoveAt(index);
	}

	protected virtual void SetItem(int index, T item)
	{
		items[index] = item;
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return ((IEnumerable)items).GetEnumerator();
	}

	void ICollection.CopyTo(Array array, int index)
	{
		if (array == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.array);
		}
		if (array.Rank != 1)
		{
			ThrowHelper.ThrowArgumentException(ExceptionResource.Arg_RankMultiDimNotSupported);
		}
		if (array.GetLowerBound(0) != 0)
		{
			ThrowHelper.ThrowArgumentException(ExceptionResource.Arg_NonZeroLowerBound);
		}
		if (index < 0)
		{
			ThrowHelper.ThrowIndexArgumentOutOfRange_NeedNonNegNumException();
		}
		if (array.Length - index < Count)
		{
			ThrowHelper.ThrowArgumentException(ExceptionResource.Arg_ArrayPlusOffTooSmall);
		}
		if (array is T[] array2)
		{
			items.CopyTo(array2, index);
			return;
		}
		Type elementType = array.GetType().GetElementType();
		Type typeFromHandle = typeof(T);
		if (!elementType.IsAssignableFrom(typeFromHandle) && !typeFromHandle.IsAssignableFrom(elementType))
		{
			ThrowHelper.ThrowArgumentException_Argument_InvalidArrayType();
		}
		object[] array3 = array as object[];
		if (array3 == null)
		{
			ThrowHelper.ThrowArgumentException_Argument_InvalidArrayType();
		}
		int count = items.Count;
		try
		{
			for (int i = 0; i < count; i++)
			{
				array3[index++] = items[i];
			}
		}
		catch (ArrayTypeMismatchException)
		{
			ThrowHelper.ThrowArgumentException_Argument_InvalidArrayType();
		}
	}

	int IList.Add(object value)
	{
		if (items.IsReadOnly)
		{
			ThrowHelper.ThrowNotSupportedException(ExceptionResource.NotSupported_ReadOnlyCollection);
		}
		ThrowHelper.IfNullAndNullsAreIllegalThenThrow<T>(value, ExceptionArgument.value);
		try
		{
			Add((T)value);
		}
		catch (InvalidCastException)
		{
			ThrowHelper.ThrowWrongValueTypeArgumentException(value, typeof(T));
		}
		return Count - 1;
	}

	bool IList.Contains(object value)
	{
		if (IsCompatibleObject(value))
		{
			return Contains((T)value);
		}
		return false;
	}

	int IList.IndexOf(object value)
	{
		if (IsCompatibleObject(value))
		{
			return IndexOf((T)value);
		}
		return -1;
	}

	void IList.Insert(int index, object value)
	{
		if (items.IsReadOnly)
		{
			ThrowHelper.ThrowNotSupportedException(ExceptionResource.NotSupported_ReadOnlyCollection);
		}
		ThrowHelper.IfNullAndNullsAreIllegalThenThrow<T>(value, ExceptionArgument.value);
		try
		{
			Insert(index, (T)value);
		}
		catch (InvalidCastException)
		{
			ThrowHelper.ThrowWrongValueTypeArgumentException(value, typeof(T));
		}
	}

	void IList.Remove(object value)
	{
		if (items.IsReadOnly)
		{
			ThrowHelper.ThrowNotSupportedException(ExceptionResource.NotSupported_ReadOnlyCollection);
		}
		if (IsCompatibleObject(value))
		{
			Remove((T)value);
		}
	}

	private static bool IsCompatibleObject(object value)
	{
		if (!(value is T))
		{
			if (value == null)
			{
				return default(T) == null;
			}
			return false;
		}
		return true;
	}
}
