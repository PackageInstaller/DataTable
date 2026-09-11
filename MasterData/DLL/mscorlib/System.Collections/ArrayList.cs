using System.Diagnostics;
using System.Threading;

namespace System.Collections;

[Serializable]
[DebuggerTypeProxy(typeof(ArrayListDebugView))]
[DebuggerDisplay("Count = {Count}")]
public class ArrayList : IList, ICollection, IEnumerable, ICloneable
{
	[Serializable]
	private class IListWrapper : ArrayList
	{
		[Serializable]
		private sealed class IListWrapperEnumWrapper : IEnumerator, ICloneable
		{
			private IEnumerator _en;

			private int _remaining;

			private int _initialStartIndex;

			private int _initialCount;

			private bool _firstCall;

			public object Current
			{
				get
				{
					if (_firstCall)
					{
						throw new InvalidOperationException("Enumeration has not started. Call MoveNext.");
					}
					if (_remaining < 0)
					{
						throw new InvalidOperationException("Enumeration already finished.");
					}
					return _en.Current;
				}
			}

			internal IListWrapperEnumWrapper(IListWrapper listWrapper, int startIndex, int count)
			{
				_en = listWrapper.GetEnumerator();
				_initialStartIndex = startIndex;
				_initialCount = count;
				while (startIndex-- > 0 && _en.MoveNext())
				{
				}
				_remaining = count;
				_firstCall = true;
			}

			private IListWrapperEnumWrapper()
			{
			}

			public object Clone()
			{
				return new IListWrapperEnumWrapper
				{
					_en = (IEnumerator)((ICloneable)_en).Clone(),
					_initialStartIndex = _initialStartIndex,
					_initialCount = _initialCount,
					_remaining = _remaining,
					_firstCall = _firstCall
				};
			}

			public bool MoveNext()
			{
				if (_firstCall)
				{
					_firstCall = false;
					if (_remaining-- > 0)
					{
						return _en.MoveNext();
					}
					return false;
				}
				if (_remaining < 0)
				{
					return false;
				}
				if (_en.MoveNext())
				{
					return _remaining-- > 0;
				}
				return false;
			}

			public void Reset()
			{
				_en.Reset();
				int initialStartIndex = _initialStartIndex;
				while (initialStartIndex-- > 0 && _en.MoveNext())
				{
				}
				_remaining = _initialCount;
				_firstCall = true;
			}
		}

		private IList _list;

		public override int Capacity
		{
			get
			{
				return _list.Count;
			}
			set
			{
				if (value < Count)
				{
					throw new ArgumentOutOfRangeException("value", "capacity was less than the current size.");
				}
			}
		}

		public override int Count => _list.Count;

		public override bool IsReadOnly => _list.IsReadOnly;

		public override bool IsFixedSize => _list.IsFixedSize;

		public override bool IsSynchronized => _list.IsSynchronized;

		public override object this[int index]
		{
			get
			{
				return _list[index];
			}
			set
			{
				_list[index] = value;
				_version++;
			}
		}

		public override object SyncRoot => _list.SyncRoot;

		internal IListWrapper(IList list)
		{
			_list = list;
			_version = 0;
		}

		public override int Add(object obj)
		{
			int result = _list.Add(obj);
			_version++;
			return result;
		}

		public override void AddRange(ICollection c)
		{
			InsertRange(Count, c);
		}

		public override int BinarySearch(int index, int count, object value, IComparer comparer)
		{
			if (index < 0 || count < 0)
			{
				throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
			}
			if (Count - index < count)
			{
				throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
			}
			if (comparer == null)
			{
				comparer = Comparer.Default;
			}
			int num = index;
			int num2 = index + count - 1;
			while (num <= num2)
			{
				int num3 = (num + num2) / 2;
				int num4 = comparer.Compare(value, _list[num3]);
				if (num4 == 0)
				{
					return num3;
				}
				if (num4 < 0)
				{
					num2 = num3 - 1;
				}
				else
				{
					num = num3 + 1;
				}
			}
			return ~num;
		}

		public override void Clear()
		{
			if (_list.IsFixedSize)
			{
				throw new NotSupportedException("Collection was of a fixed size.");
			}
			_list.Clear();
			_version++;
		}

		public override object Clone()
		{
			return new IListWrapper(_list);
		}

		public override bool Contains(object obj)
		{
			return _list.Contains(obj);
		}

		public override void CopyTo(Array array, int index)
		{
			_list.CopyTo(array, index);
		}

		public override void CopyTo(int index, Array array, int arrayIndex, int count)
		{
			if (array == null)
			{
				throw new ArgumentNullException("array");
			}
			if (index < 0 || arrayIndex < 0)
			{
				throw new ArgumentOutOfRangeException((index < 0) ? "index" : "arrayIndex", "Non-negative number required.");
			}
			if (count < 0)
			{
				throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
			}
			if (array.Length - arrayIndex < count)
			{
				throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
			}
			if (array.Rank != 1)
			{
				throw new ArgumentException("Only single dimensional arrays are supported for the requested action.", "array");
			}
			if (_list.Count - index < count)
			{
				throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
			}
			for (int i = index; i < index + count; i++)
			{
				array.SetValue(_list[i], arrayIndex++);
			}
		}

		public override IEnumerator GetEnumerator()
		{
			return _list.GetEnumerator();
		}

		public override IEnumerator GetEnumerator(int index, int count)
		{
			if (index < 0 || count < 0)
			{
				throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
			}
			if (_list.Count - index < count)
			{
				throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
			}
			return new IListWrapperEnumWrapper(this, index, count);
		}

		public override int IndexOf(object value)
		{
			return _list.IndexOf(value);
		}

		public override int IndexOf(object value, int startIndex)
		{
			return IndexOf(value, startIndex, _list.Count - startIndex);
		}

		public override int IndexOf(object value, int startIndex, int count)
		{
			if (startIndex < 0 || startIndex > Count)
			{
				throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
			}
			if (count < 0 || startIndex > Count - count)
			{
				throw new ArgumentOutOfRangeException("count", "Count must be positive and count must refer to a location within the string/array/collection.");
			}
			int num = startIndex + count;
			if (value == null)
			{
				for (int i = startIndex; i < num; i++)
				{
					if (_list[i] == null)
					{
						return i;
					}
				}
				return -1;
			}
			for (int j = startIndex; j < num; j++)
			{
				if (_list[j] != null && _list[j].Equals(value))
				{
					return j;
				}
			}
			return -1;
		}

		public override void Insert(int index, object obj)
		{
			_list.Insert(index, obj);
			_version++;
		}

		public override void InsertRange(int index, ICollection c)
		{
			if (c == null)
			{
				throw new ArgumentNullException("c", "Collection cannot be null.");
			}
			if (index < 0 || index > Count)
			{
				throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
			}
			if (c.Count <= 0)
			{
				return;
			}
			if (_list is ArrayList arrayList)
			{
				arrayList.InsertRange(index, c);
			}
			else
			{
				IEnumerator enumerator = c.GetEnumerator();
				while (enumerator.MoveNext())
				{
					_list.Insert(index++, enumerator.Current);
				}
			}
			_version++;
		}

		public override int LastIndexOf(object value)
		{
			return LastIndexOf(value, _list.Count - 1, _list.Count);
		}

		public override int LastIndexOf(object value, int startIndex)
		{
			return LastIndexOf(value, startIndex, startIndex + 1);
		}

		public override int LastIndexOf(object value, int startIndex, int count)
		{
			if (_list.Count == 0)
			{
				return -1;
			}
			if (startIndex < 0 || startIndex >= _list.Count)
			{
				throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
			}
			if (count < 0 || count > startIndex + 1)
			{
				throw new ArgumentOutOfRangeException("count", "Count must be positive and count must refer to a location within the string/array/collection.");
			}
			int num = startIndex - count + 1;
			if (value == null)
			{
				for (int num2 = startIndex; num2 >= num; num2--)
				{
					if (_list[num2] == null)
					{
						return num2;
					}
				}
				return -1;
			}
			for (int num3 = startIndex; num3 >= num; num3--)
			{
				if (_list[num3] != null && _list[num3].Equals(value))
				{
					return num3;
				}
			}
			return -1;
		}

		public override void Remove(object value)
		{
			int num = IndexOf(value);
			if (num >= 0)
			{
				RemoveAt(num);
			}
		}

		public override void RemoveAt(int index)
		{
			_list.RemoveAt(index);
			_version++;
		}

		public override void RemoveRange(int index, int count)
		{
			if (index < 0 || count < 0)
			{
				throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
			}
			if (_list.Count - index < count)
			{
				throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
			}
			if (count > 0)
			{
				_version++;
			}
			while (count > 0)
			{
				_list.RemoveAt(index);
				count--;
			}
		}

		public override void Reverse(int index, int count)
		{
			if (index < 0 || count < 0)
			{
				throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
			}
			if (_list.Count - index < count)
			{
				throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
			}
			int num = index;
			int num2 = index + count - 1;
			while (num < num2)
			{
				object value = _list[num];
				_list[num++] = _list[num2];
				_list[num2--] = value;
			}
			_version++;
		}

		public override void SetRange(int index, ICollection c)
		{
			if (c == null)
			{
				throw new ArgumentNullException("c", "Collection cannot be null.");
			}
			if (index < 0 || index > _list.Count - c.Count)
			{
				throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
			}
			if (c.Count > 0)
			{
				IEnumerator enumerator = c.GetEnumerator();
				while (enumerator.MoveNext())
				{
					_list[index++] = enumerator.Current;
				}
				_version++;
			}
		}

		public override ArrayList GetRange(int index, int count)
		{
			if (index < 0 || count < 0)
			{
				throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
			}
			if (_list.Count - index < count)
			{
				throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
			}
			return new Range(this, index, count);
		}

		public override void Sort(int index, int count, IComparer comparer)
		{
			if (index < 0 || count < 0)
			{
				throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
			}
			if (_list.Count - index < count)
			{
				throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
			}
			object[] array = new object[count];
			CopyTo(index, array, 0, count);
			Array.Sort(array, 0, count, comparer);
			for (int i = 0; i < count; i++)
			{
				_list[i + index] = array[i];
			}
			_version++;
		}

		public override object[] ToArray()
		{
			if (Count == 0)
			{
				return Array.Empty<object>();
			}
			object[] array = new object[Count];
			_list.CopyTo(array, 0);
			return array;
		}

		public override Array ToArray(Type type)
		{
			if (type == null)
			{
				throw new ArgumentNullException("type");
			}
			Array array = Array.CreateInstance(type, _list.Count);
			_list.CopyTo(array, 0);
			return array;
		}

		public override void TrimToSize()
		{
		}
	}

	[Serializable]
	private class SyncArrayList : ArrayList
	{
		private ArrayList _list;

		private object _root;

		public override int Capacity
		{
			get
			{
				lock (_root)
				{
					return _list.Capacity;
				}
			}
			set
			{
				lock (_root)
				{
					_list.Capacity = value;
				}
			}
		}

		public override int Count
		{
			get
			{
				lock (_root)
				{
					return _list.Count;
				}
			}
		}

		public override bool IsReadOnly => _list.IsReadOnly;

		public override bool IsFixedSize => _list.IsFixedSize;

		public override bool IsSynchronized => true;

		public override object this[int index]
		{
			get
			{
				lock (_root)
				{
					return _list[index];
				}
			}
			set
			{
				lock (_root)
				{
					_list[index] = value;
				}
			}
		}

		public override object SyncRoot => _root;

		internal SyncArrayList(ArrayList list)
			: base(trash: false)
		{
			_list = list;
			_root = list.SyncRoot;
		}

		public override int Add(object value)
		{
			lock (_root)
			{
				return _list.Add(value);
			}
		}

		public override void AddRange(ICollection c)
		{
			lock (_root)
			{
				_list.AddRange(c);
			}
		}

		public override int BinarySearch(object value)
		{
			lock (_root)
			{
				return _list.BinarySearch(value);
			}
		}

		public override int BinarySearch(object value, IComparer comparer)
		{
			lock (_root)
			{
				return _list.BinarySearch(value, comparer);
			}
		}

		public override int BinarySearch(int index, int count, object value, IComparer comparer)
		{
			lock (_root)
			{
				return _list.BinarySearch(index, count, value, comparer);
			}
		}

		public override void Clear()
		{
			lock (_root)
			{
				_list.Clear();
			}
		}

		public override object Clone()
		{
			lock (_root)
			{
				return new SyncArrayList((ArrayList)_list.Clone());
			}
		}

		public override bool Contains(object item)
		{
			lock (_root)
			{
				return _list.Contains(item);
			}
		}

		public override void CopyTo(Array array)
		{
			lock (_root)
			{
				_list.CopyTo(array);
			}
		}

		public override void CopyTo(Array array, int index)
		{
			lock (_root)
			{
				_list.CopyTo(array, index);
			}
		}

		public override void CopyTo(int index, Array array, int arrayIndex, int count)
		{
			lock (_root)
			{
				_list.CopyTo(index, array, arrayIndex, count);
			}
		}

		public override IEnumerator GetEnumerator()
		{
			lock (_root)
			{
				return _list.GetEnumerator();
			}
		}

		public override IEnumerator GetEnumerator(int index, int count)
		{
			lock (_root)
			{
				return _list.GetEnumerator(index, count);
			}
		}

		public override int IndexOf(object value)
		{
			lock (_root)
			{
				return _list.IndexOf(value);
			}
		}

		public override int IndexOf(object value, int startIndex)
		{
			lock (_root)
			{
				return _list.IndexOf(value, startIndex);
			}
		}

		public override int IndexOf(object value, int startIndex, int count)
		{
			lock (_root)
			{
				return _list.IndexOf(value, startIndex, count);
			}
		}

		public override void Insert(int index, object value)
		{
			lock (_root)
			{
				_list.Insert(index, value);
			}
		}

		public override void InsertRange(int index, ICollection c)
		{
			lock (_root)
			{
				_list.InsertRange(index, c);
			}
		}

		public override int LastIndexOf(object value)
		{
			lock (_root)
			{
				return _list.LastIndexOf(value);
			}
		}

		public override int LastIndexOf(object value, int startIndex)
		{
			lock (_root)
			{
				return _list.LastIndexOf(value, startIndex);
			}
		}

		public override int LastIndexOf(object value, int startIndex, int count)
		{
			lock (_root)
			{
				return _list.LastIndexOf(value, startIndex, count);
			}
		}

		public override void Remove(object value)
		{
			lock (_root)
			{
				_list.Remove(value);
			}
		}

		public override void RemoveAt(int index)
		{
			lock (_root)
			{
				_list.RemoveAt(index);
			}
		}

		public override void RemoveRange(int index, int count)
		{
			lock (_root)
			{
				_list.RemoveRange(index, count);
			}
		}

		public override void Reverse(int index, int count)
		{
			lock (_root)
			{
				_list.Reverse(index, count);
			}
		}

		public override void SetRange(int index, ICollection c)
		{
			lock (_root)
			{
				_list.SetRange(index, c);
			}
		}

		public override ArrayList GetRange(int index, int count)
		{
			lock (_root)
			{
				return _list.GetRange(index, count);
			}
		}

		public override void Sort()
		{
			lock (_root)
			{
				_list.Sort();
			}
		}

		public override void Sort(IComparer comparer)
		{
			lock (_root)
			{
				_list.Sort(comparer);
			}
		}

		public override void Sort(int index, int count, IComparer comparer)
		{
			lock (_root)
			{
				_list.Sort(index, count, comparer);
			}
		}

		public override object[] ToArray()
		{
			lock (_root)
			{
				return _list.ToArray();
			}
		}

		public override Array ToArray(Type type)
		{
			lock (_root)
			{
				return _list.ToArray(type);
			}
		}

		public override void TrimToSize()
		{
			lock (_root)
			{
				_list.TrimToSize();
			}
		}
	}

	[Serializable]
	private class SyncIList : IList, ICollection, IEnumerable
	{
		private IList _list;

		private object _root;

		public virtual int Count
		{
			get
			{
				lock (_root)
				{
					return _list.Count;
				}
			}
		}

		public virtual bool IsReadOnly => _list.IsReadOnly;

		public virtual bool IsFixedSize => _list.IsFixedSize;

		public virtual bool IsSynchronized => true;

		public virtual object this[int index]
		{
			get
			{
				lock (_root)
				{
					return _list[index];
				}
			}
			set
			{
				lock (_root)
				{
					_list[index] = value;
				}
			}
		}

		public virtual object SyncRoot => _root;

		internal SyncIList(IList list)
		{
			_list = list;
			_root = list.SyncRoot;
		}

		public virtual int Add(object value)
		{
			lock (_root)
			{
				return _list.Add(value);
			}
		}

		public virtual void Clear()
		{
			lock (_root)
			{
				_list.Clear();
			}
		}

		public virtual bool Contains(object item)
		{
			lock (_root)
			{
				return _list.Contains(item);
			}
		}

		public virtual void CopyTo(Array array, int index)
		{
			lock (_root)
			{
				_list.CopyTo(array, index);
			}
		}

		public virtual IEnumerator GetEnumerator()
		{
			lock (_root)
			{
				return _list.GetEnumerator();
			}
		}

		public virtual int IndexOf(object value)
		{
			lock (_root)
			{
				return _list.IndexOf(value);
			}
		}

		public virtual void Insert(int index, object value)
		{
			lock (_root)
			{
				_list.Insert(index, value);
			}
		}

		public virtual void Remove(object value)
		{
			lock (_root)
			{
				_list.Remove(value);
			}
		}

		public virtual void RemoveAt(int index)
		{
			lock (_root)
			{
				_list.RemoveAt(index);
			}
		}
	}

	[Serializable]
	private class FixedSizeList : IList, ICollection, IEnumerable
	{
		private IList _list;

		public virtual int Count => _list.Count;

		public virtual bool IsReadOnly => _list.IsReadOnly;

		public virtual bool IsFixedSize => true;

		public virtual bool IsSynchronized => _list.IsSynchronized;

		public virtual object this[int index]
		{
			get
			{
				return _list[index];
			}
			set
			{
				_list[index] = value;
			}
		}

		public virtual object SyncRoot => _list.SyncRoot;

		internal FixedSizeList(IList l)
		{
			_list = l;
		}

		public virtual int Add(object obj)
		{
			throw new NotSupportedException("Collection was of a fixed size.");
		}

		public virtual void Clear()
		{
			throw new NotSupportedException("Collection was of a fixed size.");
		}

		public virtual bool Contains(object obj)
		{
			return _list.Contains(obj);
		}

		public virtual void CopyTo(Array array, int index)
		{
			_list.CopyTo(array, index);
		}

		public virtual IEnumerator GetEnumerator()
		{
			return _list.GetEnumerator();
		}

		public virtual int IndexOf(object value)
		{
			return _list.IndexOf(value);
		}

		public virtual void Insert(int index, object obj)
		{
			throw new NotSupportedException("Collection was of a fixed size.");
		}

		public virtual void Remove(object value)
		{
			throw new NotSupportedException("Collection was of a fixed size.");
		}

		public virtual void RemoveAt(int index)
		{
			throw new NotSupportedException("Collection was of a fixed size.");
		}
	}

	[Serializable]
	private class FixedSizeArrayList : ArrayList
	{
		private ArrayList _list;

		public override int Count => _list.Count;

		public override bool IsReadOnly => _list.IsReadOnly;

		public override bool IsFixedSize => true;

		public override bool IsSynchronized => _list.IsSynchronized;

		public override object this[int index]
		{
			get
			{
				return _list[index];
			}
			set
			{
				_list[index] = value;
				_version = _list._version;
			}
		}

		public override object SyncRoot => _list.SyncRoot;

		public override int Capacity
		{
			get
			{
				return _list.Capacity;
			}
			set
			{
				throw new NotSupportedException("Collection was of a fixed size.");
			}
		}

		internal FixedSizeArrayList(ArrayList l)
		{
			_list = l;
			_version = _list._version;
		}

		public override int Add(object obj)
		{
			throw new NotSupportedException("Collection was of a fixed size.");
		}

		public override void AddRange(ICollection c)
		{
			throw new NotSupportedException("Collection was of a fixed size.");
		}

		public override int BinarySearch(int index, int count, object value, IComparer comparer)
		{
			return _list.BinarySearch(index, count, value, comparer);
		}

		public override void Clear()
		{
			throw new NotSupportedException("Collection was of a fixed size.");
		}

		public override object Clone()
		{
			return new FixedSizeArrayList(_list)
			{
				_list = (ArrayList)_list.Clone()
			};
		}

		public override bool Contains(object obj)
		{
			return _list.Contains(obj);
		}

		public override void CopyTo(Array array, int index)
		{
			_list.CopyTo(array, index);
		}

		public override void CopyTo(int index, Array array, int arrayIndex, int count)
		{
			_list.CopyTo(index, array, arrayIndex, count);
		}

		public override IEnumerator GetEnumerator()
		{
			return _list.GetEnumerator();
		}

		public override IEnumerator GetEnumerator(int index, int count)
		{
			return _list.GetEnumerator(index, count);
		}

		public override int IndexOf(object value)
		{
			return _list.IndexOf(value);
		}

		public override int IndexOf(object value, int startIndex)
		{
			return _list.IndexOf(value, startIndex);
		}

		public override int IndexOf(object value, int startIndex, int count)
		{
			return _list.IndexOf(value, startIndex, count);
		}

		public override void Insert(int index, object obj)
		{
			throw new NotSupportedException("Collection was of a fixed size.");
		}

		public override void InsertRange(int index, ICollection c)
		{
			throw new NotSupportedException("Collection was of a fixed size.");
		}

		public override int LastIndexOf(object value)
		{
			return _list.LastIndexOf(value);
		}

		public override int LastIndexOf(object value, int startIndex)
		{
			return _list.LastIndexOf(value, startIndex);
		}

		public override int LastIndexOf(object value, int startIndex, int count)
		{
			return _list.LastIndexOf(value, startIndex, count);
		}

		public override void Remove(object value)
		{
			throw new NotSupportedException("Collection was of a fixed size.");
		}

		public override void RemoveAt(int index)
		{
			throw new NotSupportedException("Collection was of a fixed size.");
		}

		public override void RemoveRange(int index, int count)
		{
			throw new NotSupportedException("Collection was of a fixed size.");
		}

		public override void SetRange(int index, ICollection c)
		{
			_list.SetRange(index, c);
			_version = _list._version;
		}

		public override ArrayList GetRange(int index, int count)
		{
			if (index < 0 || count < 0)
			{
				throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
			}
			if (Count - index < count)
			{
				throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
			}
			return new Range(this, index, count);
		}

		public override void Reverse(int index, int count)
		{
			_list.Reverse(index, count);
			_version = _list._version;
		}

		public override void Sort(int index, int count, IComparer comparer)
		{
			_list.Sort(index, count, comparer);
			_version = _list._version;
		}

		public override object[] ToArray()
		{
			return _list.ToArray();
		}

		public override Array ToArray(Type type)
		{
			return _list.ToArray(type);
		}

		public override void TrimToSize()
		{
			throw new NotSupportedException("Collection was of a fixed size.");
		}
	}

	[Serializable]
	private class ReadOnlyList : IList, ICollection, IEnumerable
	{
		private IList _list;

		public virtual int Count => _list.Count;

		public virtual bool IsReadOnly => true;

		public virtual bool IsFixedSize => true;

		public virtual bool IsSynchronized => _list.IsSynchronized;

		public virtual object this[int index]
		{
			get
			{
				return _list[index];
			}
			set
			{
				throw new NotSupportedException("Collection is read-only.");
			}
		}

		public virtual object SyncRoot => _list.SyncRoot;

		internal ReadOnlyList(IList l)
		{
			_list = l;
		}

		public virtual int Add(object obj)
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		public virtual void Clear()
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		public virtual bool Contains(object obj)
		{
			return _list.Contains(obj);
		}

		public virtual void CopyTo(Array array, int index)
		{
			_list.CopyTo(array, index);
		}

		public virtual IEnumerator GetEnumerator()
		{
			return _list.GetEnumerator();
		}

		public virtual int IndexOf(object value)
		{
			return _list.IndexOf(value);
		}

		public virtual void Insert(int index, object obj)
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		public virtual void Remove(object value)
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		public virtual void RemoveAt(int index)
		{
			throw new NotSupportedException("Collection is read-only.");
		}
	}

	[Serializable]
	private class ReadOnlyArrayList : ArrayList
	{
		private ArrayList _list;

		public override int Count => _list.Count;

		public override bool IsReadOnly => true;

		public override bool IsFixedSize => true;

		public override bool IsSynchronized => _list.IsSynchronized;

		public override object this[int index]
		{
			get
			{
				return _list[index];
			}
			set
			{
				throw new NotSupportedException("Collection is read-only.");
			}
		}

		public override object SyncRoot => _list.SyncRoot;

		public override int Capacity
		{
			get
			{
				return _list.Capacity;
			}
			set
			{
				throw new NotSupportedException("Collection is read-only.");
			}
		}

		internal ReadOnlyArrayList(ArrayList l)
		{
			_list = l;
		}

		public override int Add(object obj)
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		public override void AddRange(ICollection c)
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		public override int BinarySearch(int index, int count, object value, IComparer comparer)
		{
			return _list.BinarySearch(index, count, value, comparer);
		}

		public override void Clear()
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		public override object Clone()
		{
			return new ReadOnlyArrayList(_list)
			{
				_list = (ArrayList)_list.Clone()
			};
		}

		public override bool Contains(object obj)
		{
			return _list.Contains(obj);
		}

		public override void CopyTo(Array array, int index)
		{
			_list.CopyTo(array, index);
		}

		public override void CopyTo(int index, Array array, int arrayIndex, int count)
		{
			_list.CopyTo(index, array, arrayIndex, count);
		}

		public override IEnumerator GetEnumerator()
		{
			return _list.GetEnumerator();
		}

		public override IEnumerator GetEnumerator(int index, int count)
		{
			return _list.GetEnumerator(index, count);
		}

		public override int IndexOf(object value)
		{
			return _list.IndexOf(value);
		}

		public override int IndexOf(object value, int startIndex)
		{
			return _list.IndexOf(value, startIndex);
		}

		public override int IndexOf(object value, int startIndex, int count)
		{
			return _list.IndexOf(value, startIndex, count);
		}

		public override void Insert(int index, object obj)
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		public override void InsertRange(int index, ICollection c)
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		public override int LastIndexOf(object value)
		{
			return _list.LastIndexOf(value);
		}

		public override int LastIndexOf(object value, int startIndex)
		{
			return _list.LastIndexOf(value, startIndex);
		}

		public override int LastIndexOf(object value, int startIndex, int count)
		{
			return _list.LastIndexOf(value, startIndex, count);
		}

		public override void Remove(object value)
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		public override void RemoveAt(int index)
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		public override void RemoveRange(int index, int count)
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		public override void SetRange(int index, ICollection c)
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		public override ArrayList GetRange(int index, int count)
		{
			if (index < 0 || count < 0)
			{
				throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
			}
			if (Count - index < count)
			{
				throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
			}
			return new Range(this, index, count);
		}

		public override void Reverse(int index, int count)
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		public override void Sort(int index, int count, IComparer comparer)
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		public override object[] ToArray()
		{
			return _list.ToArray();
		}

		public override Array ToArray(Type type)
		{
			return _list.ToArray(type);
		}

		public override void TrimToSize()
		{
			throw new NotSupportedException("Collection is read-only.");
		}
	}

	[Serializable]
	private sealed class ArrayListEnumerator : IEnumerator, ICloneable
	{
		private ArrayList _list;

		private int _index;

		private int _endIndex;

		private int _version;

		private object _currentElement;

		private int _startIndex;

		public object Current
		{
			get
			{
				if (_index < _startIndex)
				{
					throw new InvalidOperationException("Enumeration has not started. Call MoveNext.");
				}
				if (_index > _endIndex)
				{
					throw new InvalidOperationException("Enumeration already finished.");
				}
				return _currentElement;
			}
		}

		internal ArrayListEnumerator(ArrayList list, int index, int count)
		{
			_list = list;
			_startIndex = index;
			_index = index - 1;
			_endIndex = _index + count;
			_version = list._version;
			_currentElement = null;
		}

		public object Clone()
		{
			return MemberwiseClone();
		}

		public bool MoveNext()
		{
			if (_version != _list._version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			if (_index < _endIndex)
			{
				_currentElement = _list[++_index];
				return true;
			}
			_index = _endIndex + 1;
			return false;
		}

		public void Reset()
		{
			if (_version != _list._version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			_index = _startIndex - 1;
		}
	}

	[Serializable]
	private class Range : ArrayList
	{
		private ArrayList _baseList;

		private int _baseIndex;

		private int _baseSize;

		private int _baseVersion;

		public override int Capacity
		{
			get
			{
				return _baseList.Capacity;
			}
			set
			{
				if (value < Count)
				{
					throw new ArgumentOutOfRangeException("value", "capacity was less than the current size.");
				}
			}
		}

		public override int Count
		{
			get
			{
				InternalUpdateRange();
				return _baseSize;
			}
		}

		public override bool IsReadOnly => _baseList.IsReadOnly;

		public override bool IsFixedSize => _baseList.IsFixedSize;

		public override bool IsSynchronized => _baseList.IsSynchronized;

		public override object SyncRoot => _baseList.SyncRoot;

		public override object this[int index]
		{
			get
			{
				InternalUpdateRange();
				if (index < 0 || index >= _baseSize)
				{
					throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
				}
				return _baseList[_baseIndex + index];
			}
			set
			{
				InternalUpdateRange();
				if (index < 0 || index >= _baseSize)
				{
					throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
				}
				_baseList[_baseIndex + index] = value;
				InternalUpdateVersion();
			}
		}

		internal Range(ArrayList list, int index, int count)
			: base(trash: false)
		{
			_baseList = list;
			_baseIndex = index;
			_baseSize = count;
			_baseVersion = list._version;
			_version = list._version;
		}

		private void InternalUpdateRange()
		{
			if (_baseVersion != _baseList._version)
			{
				throw new InvalidOperationException("This range in the underlying list is invalid. A possible cause is that elements were removed.");
			}
		}

		private void InternalUpdateVersion()
		{
			_baseVersion++;
			_version++;
		}

		public override int Add(object value)
		{
			InternalUpdateRange();
			_baseList.Insert(_baseIndex + _baseSize, value);
			InternalUpdateVersion();
			return _baseSize++;
		}

		public override void AddRange(ICollection c)
		{
			if (c == null)
			{
				throw new ArgumentNullException("c");
			}
			InternalUpdateRange();
			int count = c.Count;
			if (count > 0)
			{
				_baseList.InsertRange(_baseIndex + _baseSize, c);
				InternalUpdateVersion();
				_baseSize += count;
			}
		}

		public override int BinarySearch(int index, int count, object value, IComparer comparer)
		{
			if (index < 0 || count < 0)
			{
				throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
			}
			if (_baseSize - index < count)
			{
				throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
			}
			InternalUpdateRange();
			int num = _baseList.BinarySearch(_baseIndex + index, count, value, comparer);
			if (num >= 0)
			{
				return num - _baseIndex;
			}
			return num + _baseIndex;
		}

		public override void Clear()
		{
			InternalUpdateRange();
			if (_baseSize != 0)
			{
				_baseList.RemoveRange(_baseIndex, _baseSize);
				InternalUpdateVersion();
				_baseSize = 0;
			}
		}

		public override object Clone()
		{
			InternalUpdateRange();
			return new Range(_baseList, _baseIndex, _baseSize)
			{
				_baseList = (ArrayList)_baseList.Clone()
			};
		}

		public override bool Contains(object item)
		{
			InternalUpdateRange();
			if (item == null)
			{
				for (int i = 0; i < _baseSize; i++)
				{
					if (_baseList[_baseIndex + i] == null)
					{
						return true;
					}
				}
				return false;
			}
			for (int j = 0; j < _baseSize; j++)
			{
				if (_baseList[_baseIndex + j] != null && _baseList[_baseIndex + j].Equals(item))
				{
					return true;
				}
			}
			return false;
		}

		public override void CopyTo(Array array, int index)
		{
			if (array == null)
			{
				throw new ArgumentNullException("array");
			}
			if (array.Rank != 1)
			{
				throw new ArgumentException("Only single dimensional arrays are supported for the requested action.", "array");
			}
			if (index < 0)
			{
				throw new ArgumentOutOfRangeException("index", "Non-negative number required.");
			}
			if (array.Length - index < _baseSize)
			{
				throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
			}
			InternalUpdateRange();
			_baseList.CopyTo(_baseIndex, array, index, _baseSize);
		}

		public override void CopyTo(int index, Array array, int arrayIndex, int count)
		{
			if (array == null)
			{
				throw new ArgumentNullException("array");
			}
			if (array.Rank != 1)
			{
				throw new ArgumentException("Only single dimensional arrays are supported for the requested action.", "array");
			}
			if (index < 0 || count < 0)
			{
				throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
			}
			if (array.Length - arrayIndex < count)
			{
				throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
			}
			if (_baseSize - index < count)
			{
				throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
			}
			InternalUpdateRange();
			_baseList.CopyTo(_baseIndex + index, array, arrayIndex, count);
		}

		public override IEnumerator GetEnumerator()
		{
			return GetEnumerator(0, _baseSize);
		}

		public override IEnumerator GetEnumerator(int index, int count)
		{
			if (index < 0 || count < 0)
			{
				throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
			}
			if (_baseSize - index < count)
			{
				throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
			}
			InternalUpdateRange();
			return _baseList.GetEnumerator(_baseIndex + index, count);
		}

		public override ArrayList GetRange(int index, int count)
		{
			if (index < 0 || count < 0)
			{
				throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
			}
			if (_baseSize - index < count)
			{
				throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
			}
			InternalUpdateRange();
			return new Range(this, index, count);
		}

		public override int IndexOf(object value)
		{
			InternalUpdateRange();
			int num = _baseList.IndexOf(value, _baseIndex, _baseSize);
			if (num >= 0)
			{
				return num - _baseIndex;
			}
			return -1;
		}

		public override int IndexOf(object value, int startIndex)
		{
			if (startIndex < 0)
			{
				throw new ArgumentOutOfRangeException("startIndex", "Non-negative number required.");
			}
			if (startIndex > _baseSize)
			{
				throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
			}
			InternalUpdateRange();
			int num = _baseList.IndexOf(value, _baseIndex + startIndex, _baseSize - startIndex);
			if (num >= 0)
			{
				return num - _baseIndex;
			}
			return -1;
		}

		public override int IndexOf(object value, int startIndex, int count)
		{
			if (startIndex < 0 || startIndex > _baseSize)
			{
				throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
			}
			if (count < 0 || startIndex > _baseSize - count)
			{
				throw new ArgumentOutOfRangeException("count", "Count must be positive and count must refer to a location within the string/array/collection.");
			}
			InternalUpdateRange();
			int num = _baseList.IndexOf(value, _baseIndex + startIndex, count);
			if (num >= 0)
			{
				return num - _baseIndex;
			}
			return -1;
		}

		public override void Insert(int index, object value)
		{
			if (index < 0 || index > _baseSize)
			{
				throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
			}
			InternalUpdateRange();
			_baseList.Insert(_baseIndex + index, value);
			InternalUpdateVersion();
			_baseSize++;
		}

		public override void InsertRange(int index, ICollection c)
		{
			if (index < 0 || index > _baseSize)
			{
				throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
			}
			if (c == null)
			{
				throw new ArgumentNullException("c");
			}
			InternalUpdateRange();
			int count = c.Count;
			if (count > 0)
			{
				_baseList.InsertRange(_baseIndex + index, c);
				_baseSize += count;
				InternalUpdateVersion();
			}
		}

		public override int LastIndexOf(object value)
		{
			InternalUpdateRange();
			int num = _baseList.LastIndexOf(value, _baseIndex + _baseSize - 1, _baseSize);
			if (num >= 0)
			{
				return num - _baseIndex;
			}
			return -1;
		}

		public override int LastIndexOf(object value, int startIndex)
		{
			return LastIndexOf(value, startIndex, startIndex + 1);
		}

		public override int LastIndexOf(object value, int startIndex, int count)
		{
			InternalUpdateRange();
			if (_baseSize == 0)
			{
				return -1;
			}
			if (startIndex >= _baseSize)
			{
				throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
			}
			if (startIndex < 0)
			{
				throw new ArgumentOutOfRangeException("startIndex", "Non-negative number required.");
			}
			int num = _baseList.LastIndexOf(value, _baseIndex + startIndex, count);
			if (num >= 0)
			{
				return num - _baseIndex;
			}
			return -1;
		}

		public override void RemoveAt(int index)
		{
			if (index < 0 || index >= _baseSize)
			{
				throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
			}
			InternalUpdateRange();
			_baseList.RemoveAt(_baseIndex + index);
			InternalUpdateVersion();
			_baseSize--;
		}

		public override void RemoveRange(int index, int count)
		{
			if (index < 0 || count < 0)
			{
				throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
			}
			if (_baseSize - index < count)
			{
				throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
			}
			InternalUpdateRange();
			if (count > 0)
			{
				_baseList.RemoveRange(_baseIndex + index, count);
				InternalUpdateVersion();
				_baseSize -= count;
			}
		}

		public override void Reverse(int index, int count)
		{
			if (index < 0 || count < 0)
			{
				throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
			}
			if (_baseSize - index < count)
			{
				throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
			}
			InternalUpdateRange();
			_baseList.Reverse(_baseIndex + index, count);
			InternalUpdateVersion();
		}

		public override void SetRange(int index, ICollection c)
		{
			InternalUpdateRange();
			if (index < 0 || index >= _baseSize)
			{
				throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
			}
			_baseList.SetRange(_baseIndex + index, c);
			if (c.Count > 0)
			{
				InternalUpdateVersion();
			}
		}

		public override void Sort(int index, int count, IComparer comparer)
		{
			if (index < 0 || count < 0)
			{
				throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
			}
			if (_baseSize - index < count)
			{
				throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
			}
			InternalUpdateRange();
			_baseList.Sort(_baseIndex + index, count, comparer);
			InternalUpdateVersion();
		}

		public override object[] ToArray()
		{
			InternalUpdateRange();
			if (_baseSize == 0)
			{
				return Array.Empty<object>();
			}
			object[] array = new object[_baseSize];
			Array.Copy(_baseList._items, _baseIndex, array, 0, _baseSize);
			return array;
		}

		public override Array ToArray(Type type)
		{
			if (type == null)
			{
				throw new ArgumentNullException("type");
			}
			InternalUpdateRange();
			Array array = Array.CreateInstance(type, _baseSize);
			_baseList.CopyTo(_baseIndex, array, 0, _baseSize);
			return array;
		}

		public override void TrimToSize()
		{
			throw new NotSupportedException("The specified operation is not supported on Ranges.");
		}
	}

	[Serializable]
	private sealed class ArrayListEnumeratorSimple : IEnumerator, ICloneable
	{
		private ArrayList _list;

		private int _index;

		private int _version;

		private object _currentElement;

		private bool _isArrayList;

		private static object s_dummyObject = new object();

		public object Current
		{
			get
			{
				object currentElement = _currentElement;
				if (s_dummyObject == currentElement)
				{
					if (_index == -1)
					{
						throw new InvalidOperationException("Enumeration has not started. Call MoveNext.");
					}
					throw new InvalidOperationException("Enumeration already finished.");
				}
				return currentElement;
			}
		}

		internal ArrayListEnumeratorSimple(ArrayList list)
		{
			_list = list;
			_index = -1;
			_version = list._version;
			_isArrayList = list.GetType() == typeof(ArrayList);
			_currentElement = s_dummyObject;
		}

		public object Clone()
		{
			return MemberwiseClone();
		}

		public bool MoveNext()
		{
			if (_version != _list._version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			if (_isArrayList)
			{
				if (_index < _list._size - 1)
				{
					_currentElement = _list._items[++_index];
					return true;
				}
				_currentElement = s_dummyObject;
				_index = _list._size;
				return false;
			}
			if (_index < _list.Count - 1)
			{
				_currentElement = _list[++_index];
				return true;
			}
			_index = _list.Count;
			_currentElement = s_dummyObject;
			return false;
		}

		public void Reset()
		{
			if (_version != _list._version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			_currentElement = s_dummyObject;
			_index = -1;
		}
	}

	internal class ArrayListDebugView
	{
	}

	private object[] _items;

	private int _size;

	private int _version;

	[NonSerialized]
	private object _syncRoot;

	private const int _defaultCapacity = 4;

	internal const int MaxArrayLength = 2146435071;

	public virtual int Capacity
	{
		get
		{
			return _items.Length;
		}
		set
		{
			if (value < _size)
			{
				throw new ArgumentOutOfRangeException("value", "capacity was less than the current size.");
			}
			if (value == _items.Length)
			{
				return;
			}
			if (value > 0)
			{
				object[] array = new object[value];
				if (_size > 0)
				{
					Array.Copy(_items, 0, array, 0, _size);
				}
				_items = array;
			}
			else
			{
				_items = new object[4];
			}
		}
	}

	public virtual int Count => _size;

	public virtual bool IsFixedSize => false;

	public virtual bool IsReadOnly => false;

	public virtual bool IsSynchronized => false;

	public virtual object SyncRoot
	{
		get
		{
			if (_syncRoot == null)
			{
				Interlocked.CompareExchange<object>(ref _syncRoot, new object(), (object)null);
			}
			return _syncRoot;
		}
	}

	public virtual object this[int index]
	{
		get
		{
			if (index < 0 || index >= _size)
			{
				throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
			}
			return _items[index];
		}
		set
		{
			if (index < 0 || index >= _size)
			{
				throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
			}
			_items[index] = value;
			_version++;
		}
	}

	internal ArrayList(bool trash)
	{
	}

	public ArrayList()
	{
		_items = Array.Empty<object>();
	}

	public ArrayList(int capacity)
	{
		if (capacity < 0)
		{
			throw new ArgumentOutOfRangeException("capacity", SR.Format("'{0}' must be non-negative.", "capacity"));
		}
		if (capacity == 0)
		{
			_items = Array.Empty<object>();
		}
		else
		{
			_items = new object[capacity];
		}
	}

	public ArrayList(ICollection c)
	{
		if (c == null)
		{
			throw new ArgumentNullException("c", "Collection cannot be null.");
		}
		int count = c.Count;
		if (count == 0)
		{
			_items = Array.Empty<object>();
			return;
		}
		_items = new object[count];
		AddRange(c);
	}

	public static ArrayList Adapter(IList list)
	{
		if (list == null)
		{
			throw new ArgumentNullException("list");
		}
		return new IListWrapper(list);
	}

	public virtual int Add(object value)
	{
		if (_size == _items.Length)
		{
			EnsureCapacity(_size + 1);
		}
		_items[_size] = value;
		_version++;
		return _size++;
	}

	public virtual void AddRange(ICollection c)
	{
		InsertRange(_size, c);
	}

	public virtual int BinarySearch(int index, int count, object value, IComparer comparer)
	{
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", "Non-negative number required.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		if (_size - index < count)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		return Array.BinarySearch(_items, index, count, value, comparer);
	}

	public virtual int BinarySearch(object value)
	{
		return BinarySearch(0, Count, value, null);
	}

	public virtual int BinarySearch(object value, IComparer comparer)
	{
		return BinarySearch(0, Count, value, comparer);
	}

	public virtual void Clear()
	{
		if (_size > 0)
		{
			Array.Clear(_items, 0, _size);
			_size = 0;
		}
		_version++;
	}

	public virtual object Clone()
	{
		ArrayList arrayList = new ArrayList(_size);
		arrayList._size = _size;
		arrayList._version = _version;
		Array.Copy(_items, 0, arrayList._items, 0, _size);
		return arrayList;
	}

	public virtual bool Contains(object item)
	{
		if (item == null)
		{
			for (int i = 0; i < _size; i++)
			{
				if (_items[i] == null)
				{
					return true;
				}
			}
			return false;
		}
		for (int j = 0; j < _size; j++)
		{
			if (_items[j] != null && _items[j].Equals(item))
			{
				return true;
			}
		}
		return false;
	}

	public virtual void CopyTo(Array array)
	{
		CopyTo(array, 0);
	}

	public virtual void CopyTo(Array array, int arrayIndex)
	{
		if (array != null && array.Rank != 1)
		{
			throw new ArgumentException("Only single dimensional arrays are supported for the requested action.", "array");
		}
		Array.Copy(_items, 0, array, arrayIndex, _size);
	}

	public virtual void CopyTo(int index, Array array, int arrayIndex, int count)
	{
		if (_size - index < count)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		if (array != null && array.Rank != 1)
		{
			throw new ArgumentException("Only single dimensional arrays are supported for the requested action.", "array");
		}
		Array.Copy(_items, index, array, arrayIndex, count);
	}

	private void EnsureCapacity(int min)
	{
		if (_items.Length < min)
		{
			int num = ((_items.Length == 0) ? 4 : (_items.Length * 2));
			if ((uint)num > 2146435071u)
			{
				num = 2146435071;
			}
			if (num < min)
			{
				num = min;
			}
			Capacity = num;
		}
	}

	public static IList FixedSize(IList list)
	{
		if (list == null)
		{
			throw new ArgumentNullException("list");
		}
		return new FixedSizeList(list);
	}

	public static ArrayList FixedSize(ArrayList list)
	{
		if (list == null)
		{
			throw new ArgumentNullException("list");
		}
		return new FixedSizeArrayList(list);
	}

	public virtual IEnumerator GetEnumerator()
	{
		return new ArrayListEnumeratorSimple(this);
	}

	public virtual IEnumerator GetEnumerator(int index, int count)
	{
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", "Non-negative number required.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		if (_size - index < count)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		return new ArrayListEnumerator(this, index, count);
	}

	public virtual int IndexOf(object value)
	{
		return Array.IndexOf((Array)_items, value, 0, _size);
	}

	public virtual int IndexOf(object value, int startIndex)
	{
		if (startIndex > _size)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		return Array.IndexOf((Array)_items, value, startIndex, _size - startIndex);
	}

	public virtual int IndexOf(object value, int startIndex, int count)
	{
		if (startIndex > _size)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (count < 0 || startIndex > _size - count)
		{
			throw new ArgumentOutOfRangeException("count", "Count must be positive and count must refer to a location within the string/array/collection.");
		}
		return Array.IndexOf((Array)_items, value, startIndex, count);
	}

	public virtual void Insert(int index, object value)
	{
		if (index < 0 || index > _size)
		{
			throw new ArgumentOutOfRangeException("index", "Insertion index was out of range. Must be non-negative and less than or equal to size.");
		}
		if (_size == _items.Length)
		{
			EnsureCapacity(_size + 1);
		}
		if (index < _size)
		{
			Array.Copy(_items, index, _items, index + 1, _size - index);
		}
		_items[index] = value;
		_size++;
		_version++;
	}

	public virtual void InsertRange(int index, ICollection c)
	{
		if (c == null)
		{
			throw new ArgumentNullException("c", "Collection cannot be null.");
		}
		if (index < 0 || index > _size)
		{
			throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		int count = c.Count;
		if (count > 0)
		{
			EnsureCapacity(_size + count);
			if (index < _size)
			{
				Array.Copy(_items, index, _items, index + count, _size - index);
			}
			object[] array = new object[count];
			c.CopyTo(array, 0);
			array.CopyTo(_items, index);
			_size += count;
			_version++;
		}
	}

	public virtual int LastIndexOf(object value)
	{
		return LastIndexOf(value, _size - 1, _size);
	}

	public virtual int LastIndexOf(object value, int startIndex)
	{
		if (startIndex >= _size)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		return LastIndexOf(value, startIndex, startIndex + 1);
	}

	public virtual int LastIndexOf(object value, int startIndex, int count)
	{
		if (Count != 0 && (startIndex < 0 || count < 0))
		{
			throw new ArgumentOutOfRangeException((startIndex < 0) ? "startIndex" : "count", "Non-negative number required.");
		}
		if (_size == 0)
		{
			return -1;
		}
		if (startIndex >= _size || count > startIndex + 1)
		{
			throw new ArgumentOutOfRangeException((startIndex >= _size) ? "startIndex" : "count", "Must be less than or equal to the size of the collection.");
		}
		return Array.LastIndexOf((Array)_items, value, startIndex, count);
	}

	public static IList ReadOnly(IList list)
	{
		if (list == null)
		{
			throw new ArgumentNullException("list");
		}
		return new ReadOnlyList(list);
	}

	public static ArrayList ReadOnly(ArrayList list)
	{
		if (list == null)
		{
			throw new ArgumentNullException("list");
		}
		return new ReadOnlyArrayList(list);
	}

	public virtual void Remove(object obj)
	{
		int num = IndexOf(obj);
		if (num >= 0)
		{
			RemoveAt(num);
		}
	}

	public virtual void RemoveAt(int index)
	{
		if (index < 0 || index >= _size)
		{
			throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		_size--;
		if (index < _size)
		{
			Array.Copy(_items, index + 1, _items, index, _size - index);
		}
		_items[_size] = null;
		_version++;
	}

	public virtual void RemoveRange(int index, int count)
	{
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", "Non-negative number required.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		if (_size - index < count)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		if (count > 0)
		{
			int num = _size;
			_size -= count;
			if (index < _size)
			{
				Array.Copy(_items, index + count, _items, index, _size - index);
			}
			while (num > _size)
			{
				_items[--num] = null;
			}
			_version++;
		}
	}

	public static ArrayList Repeat(object value, int count)
	{
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		ArrayList arrayList = new ArrayList((count > 4) ? count : 4);
		for (int i = 0; i < count; i++)
		{
			arrayList.Add(value);
		}
		return arrayList;
	}

	public virtual void Reverse()
	{
		Reverse(0, Count);
	}

	public virtual void Reverse(int index, int count)
	{
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", "Non-negative number required.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		if (_size - index < count)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		Array.Reverse(_items, index, count);
		_version++;
	}

	public virtual void SetRange(int index, ICollection c)
	{
		if (c == null)
		{
			throw new ArgumentNullException("c", "Collection cannot be null.");
		}
		int count = c.Count;
		if (index < 0 || index > _size - count)
		{
			throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (count > 0)
		{
			c.CopyTo(_items, index);
			_version++;
		}
	}

	public virtual ArrayList GetRange(int index, int count)
	{
		if (index < 0 || count < 0)
		{
			throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
		}
		if (_size - index < count)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		return new Range(this, index, count);
	}

	public virtual void Sort()
	{
		Sort(0, Count, Comparer.Default);
	}

	public virtual void Sort(IComparer comparer)
	{
		Sort(0, Count, comparer);
	}

	public virtual void Sort(int index, int count, IComparer comparer)
	{
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", "Non-negative number required.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		if (_size - index < count)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		Array.Sort(_items, index, count, comparer);
		_version++;
	}

	public static IList Synchronized(IList list)
	{
		if (list == null)
		{
			throw new ArgumentNullException("list");
		}
		return new SyncIList(list);
	}

	public static ArrayList Synchronized(ArrayList list)
	{
		if (list == null)
		{
			throw new ArgumentNullException("list");
		}
		return new SyncArrayList(list);
	}

	public virtual object[] ToArray()
	{
		if (_size == 0)
		{
			return Array.Empty<object>();
		}
		object[] array = new object[_size];
		Array.Copy(_items, 0, array, 0, _size);
		return array;
	}

	public virtual Array ToArray(Type type)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		Array array = Array.CreateInstance(type, _size);
		Array.Copy(_items, 0, array, 0, _size);
		return array;
	}

	public virtual void TrimToSize()
	{
		Capacity = _size;
	}
}
