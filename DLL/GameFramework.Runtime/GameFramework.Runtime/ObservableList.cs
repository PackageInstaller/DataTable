using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Threading;

namespace GameFramework.Runtime;

[Serializable]
public class ObservableList<T> : IList<T>, ICollection<T>, IEnumerable<T>, IEnumerable, IList, ICollection, INotifyCollectionChanged, INotifyPropertyChanged
{
	[Serializable]
	private class SimpleMonitor : IDisposable
	{
		private int _busyCount;

		public bool Busy => _busyCount > 0;

		public void Enter()
		{
			_busyCount++;
		}

		public void Dispose()
		{
			_busyCount--;
		}
	}

	private static readonly PropertyChangedEventArgs CountEventArgs = new PropertyChangedEventArgs("Count");

	private static readonly PropertyChangedEventArgs IndexerEventArgs = new PropertyChangedEventArgs("Item[]");

	private readonly object propertyChangedLock = new object();

	private readonly object collectionChangedLock = new object();

	private PropertyChangedEventHandler propertyChanged;

	private NotifyCollectionChangedEventHandler collectionChanged;

	private SimpleMonitor monitor = new SimpleMonitor();

	private IList<T> items;

	[NonSerialized]
	private object syncRoot;

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
				throw new NotSupportedException("ReadOnlyCollection");
			}
			if (index < 0 || index >= items.Count)
			{
				throw new ArgumentOutOfRangeException($"ArgumentOutOfRangeException:{index}");
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
			if (syncRoot == null)
			{
				if (items is ICollection collection)
				{
					syncRoot = collection.SyncRoot;
				}
				else
				{
					Interlocked.CompareExchange<object>(ref syncRoot, new object(), (object)null);
				}
			}
			return syncRoot;
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
			if (value == null && default(T) != null)
			{
				throw new ArgumentNullException("value");
			}
			try
			{
				this[index] = (T)value;
			}
			catch (InvalidCastException innerException)
			{
				throw new ArgumentException("", innerException);
			}
		}
	}

	bool IList.IsReadOnly => items.IsReadOnly;

	bool IList.IsFixedSize
	{
		get
		{
			if (!(items is IList { IsFixedSize: var isFixedSize }))
			{
				return items.IsReadOnly;
			}
			return isFixedSize;
		}
	}

	public event PropertyChangedEventHandler PropertyChanged
	{
		add
		{
			lock (propertyChangedLock)
			{
				propertyChanged = (PropertyChangedEventHandler)Delegate.Combine(propertyChanged, value);
			}
		}
		remove
		{
			lock (propertyChangedLock)
			{
				propertyChanged = (PropertyChangedEventHandler)Delegate.Remove(propertyChanged, value);
			}
		}
	}

	public event NotifyCollectionChangedEventHandler CollectionChanged
	{
		add
		{
			lock (collectionChangedLock)
			{
				collectionChanged = (NotifyCollectionChangedEventHandler)Delegate.Combine(collectionChanged, value);
			}
		}
		remove
		{
			lock (collectionChangedLock)
			{
				collectionChanged = (NotifyCollectionChangedEventHandler)Delegate.Remove(collectionChanged, value);
			}
		}
	}

	public ObservableList()
	{
		items = new List<T>();
	}

	public ObservableList(List<T> list)
	{
		if (list == null)
		{
			throw new ArgumentNullException("list");
		}
		items = new List<T>();
		using IEnumerator<T> enumerator = (object)list.GetEnumerator();
		while (enumerator.MoveNext())
		{
			items.Add(enumerator.Current);
		}
	}

	public void Add(T item)
	{
		if (items.IsReadOnly)
		{
			throw new NotSupportedException("ReadOnlyCollection");
		}
		int count = items.Count;
		InsertItem(count, item);
	}

	public void Clear()
	{
		if (items.IsReadOnly)
		{
			throw new NotSupportedException("ReadOnlyCollection");
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
			throw new NotSupportedException("ReadOnlyCollection");
		}
		if (index < 0 || index > items.Count)
		{
			throw new ArgumentOutOfRangeException($"ArgumentOutOfRangeException:{index}");
		}
		InsertItem(index, item);
	}

	public bool Remove(T item)
	{
		if (items.IsReadOnly)
		{
			throw new NotSupportedException("ReadOnlyCollection");
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
			throw new NotSupportedException("ReadOnlyCollection");
		}
		if (index < 0 || index >= items.Count)
		{
			throw new ArgumentOutOfRangeException($"ArgumentOutOfRangeException:{index}");
		}
		RemoveItem(index);
	}

	public void Move(int oldIndex, int newIndex)
	{
		MoveItem(oldIndex, newIndex);
	}

	public void AddRange(IEnumerable<T> collection)
	{
		if (items.IsReadOnly)
		{
			throw new NotSupportedException("ReadOnlyCollection");
		}
		int count = items.Count;
		InsertItem(count, collection);
	}

	public void InsertRange(int index, IEnumerable<T> collection)
	{
		if (items.IsReadOnly)
		{
			throw new NotSupportedException("ReadOnlyCollection");
		}
		if (index < 0 || index > items.Count)
		{
			throw new ArgumentOutOfRangeException($"ArgumentOutOfRangeException:{index}");
		}
		InsertItem(index, collection);
	}

	public void RemoveRange(int index, int count)
	{
		if (items.IsReadOnly)
		{
			throw new NotSupportedException("ReadOnlyCollection");
		}
		if (index < 0 || index >= items.Count)
		{
			throw new ArgumentOutOfRangeException($"ArgumentOutOfRangeException:{index}");
		}
		RemoveItem(index, count);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return ((IEnumerable)items).GetEnumerator();
	}

	void ICollection.CopyTo(Array array, int index)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (array.Rank != 1)
		{
			throw new ArgumentException("RankMultiDimNotSupported");
		}
		if (array.GetLowerBound(0) != 0)
		{
			throw new ArgumentException("NonZeroLowerBound");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException($"ArgumentOutOfRangeException:{index}");
		}
		if (array.Length - index < Count)
		{
			throw new ArgumentException("ArrayPlusOffTooSmall");
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
			throw new ArgumentException("InvalidArrayType");
		}
		if (!(array is object[] array3))
		{
			throw new ArgumentException("InvalidArrayType");
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
			throw new ArgumentException("InvalidArrayType");
		}
	}

	int IList.Add(object value)
	{
		if (items.IsReadOnly)
		{
			throw new NotSupportedException("ReadOnlyCollection");
		}
		if (value == null && default(T) != null)
		{
			throw new ArgumentNullException("value");
		}
		try
		{
			Add((T)value);
		}
		catch (InvalidCastException innerException)
		{
			throw new ArgumentException("", innerException);
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
			throw new NotSupportedException("ReadOnlyCollection");
		}
		if (value == null && default(T) != null)
		{
			throw new ArgumentNullException("value");
		}
		try
		{
			Insert(index, (T)value);
		}
		catch (InvalidCastException innerException)
		{
			throw new ArgumentException("", innerException);
		}
	}

	void IList.Remove(object value)
	{
		if (items.IsReadOnly)
		{
			throw new NotSupportedException("ReadOnlyCollection");
		}
		if (IsCompatibleObject(value))
		{
			Remove((T)value);
		}
	}

	protected virtual void ClearItems()
	{
		CheckReentrancy();
		items.Clear();
		OnPropertyChanged(CountEventArgs);
		OnPropertyChanged(IndexerEventArgs);
		OnCollectionReset();
	}

	protected virtual void RemoveItem(int index)
	{
		CheckReentrancy();
		T val = this[index];
		items.RemoveAt(index);
		OnPropertyChanged(CountEventArgs);
		OnPropertyChanged(IndexerEventArgs);
		OnCollectionChanged(NotifyCollectionChangedAction.Remove, val, index);
	}

	protected virtual void RemoveItem(int index, int count)
	{
		CheckReentrancy();
		List<T> list = items as List<T>;
		List<T> range = list.GetRange(index, count);
		list.RemoveRange(index, count);
		OnPropertyChanged(CountEventArgs);
		OnPropertyChanged(IndexerEventArgs);
		OnCollectionChanged(NotifyCollectionChangedAction.Remove, range, index);
	}

	protected virtual void InsertItem(int index, T item)
	{
		CheckReentrancy();
		items.Insert(index, item);
		OnPropertyChanged(CountEventArgs);
		OnPropertyChanged(IndexerEventArgs);
		OnCollectionChanged(NotifyCollectionChangedAction.Add, item, index);
	}

	protected virtual void InsertItem(int index, IEnumerable<T> collection)
	{
		CheckReentrancy();
		(items as List<T>).InsertRange(index, collection);
		OnPropertyChanged(CountEventArgs);
		OnPropertyChanged(IndexerEventArgs);
		OnCollectionChanged(NotifyCollectionChangedAction.Add, ToList(collection), index);
	}

	protected virtual void SetItem(int index, T item)
	{
		CheckReentrancy();
		T val = this[index];
		items[index] = item;
		OnPropertyChanged(IndexerEventArgs);
		OnCollectionChanged(NotifyCollectionChangedAction.Replace, val, item, index);
	}

	protected virtual void MoveItem(int oldIndex, int newIndex)
	{
		CheckReentrancy();
		T val = this[oldIndex];
		items.RemoveAt(oldIndex);
		items.Insert(newIndex, val);
		OnPropertyChanged(IndexerEventArgs);
		OnCollectionChanged(NotifyCollectionChangedAction.Move, val, newIndex, oldIndex);
	}

	protected virtual void OnPropertyChanged(PropertyChangedEventArgs e)
	{
		if (propertyChanged != null)
		{
			propertyChanged(this, e);
		}
	}

	protected virtual void OnCollectionChanged(NotifyCollectionChangedEventArgs e)
	{
		if (collectionChanged != null)
		{
			using (BlockReentrancy())
			{
				collectionChanged(this, e);
			}
		}
	}

	protected IDisposable BlockReentrancy()
	{
		monitor.Enter();
		return monitor;
	}

	protected void CheckReentrancy()
	{
		if (monitor.Busy && collectionChanged != null && collectionChanged.GetInvocationList().Length > 1)
		{
			throw new InvalidOperationException();
		}
	}

	private IList ToList(IEnumerable<T> collection)
	{
		if (collection is IList)
		{
			return (IList)collection;
		}
		List<T> list = new List<T>();
		list.AddRange(collection);
		return list;
	}

	private static bool IsCompatibleObject(object value)
	{
		return value is T || (value == null && default(T) == null);
	}

	private void OnCollectionChanged(NotifyCollectionChangedAction action, object item, int index)
	{
		if (collectionChanged != null)
		{
			OnCollectionChanged(new NotifyCollectionChangedEventArgs(action, item, index));
		}
	}

	private void OnCollectionChanged(NotifyCollectionChangedAction action, IList changedItems, int index)
	{
		if (collectionChanged != null)
		{
			OnCollectionChanged(new NotifyCollectionChangedEventArgs(action, changedItems, index));
		}
	}

	private void OnCollectionChanged(NotifyCollectionChangedAction action, object item, int index, int oldIndex)
	{
		if (collectionChanged != null)
		{
			OnCollectionChanged(new NotifyCollectionChangedEventArgs(action, item, index, oldIndex));
		}
	}

	private void OnCollectionChanged(NotifyCollectionChangedAction action, object oldItem, object newItem, int index)
	{
		if (collectionChanged != null)
		{
			OnCollectionChanged(new NotifyCollectionChangedEventArgs(action, newItem, oldItem, index));
		}
	}

	private void OnCollectionReset()
	{
		if (collectionChanged != null)
		{
			OnCollectionChanged(new NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction.Reset));
		}
	}
}
