using System.Diagnostics;
using System.Threading;

namespace System.Collections;

[Serializable]
[DebuggerDisplay("Count = {Count}")]
[DebuggerTypeProxy(typeof(ArrayListDebugView))]
public class ArrayList : IList, ICollection, IEnumerable, ICloneable
{
	[Serializable]
	private class IListWrapper : ArrayList
	{
		private IList _list;

		public override int Capacity
		{
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

		public override int IndexOf(object value)
		{
			return _list.IndexOf(value);
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
	}

	[Serializable]
	private class SyncArrayList : ArrayList
	{
		private ArrayList _list;

		private object _root;

		public override int Capacity
		{
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

		public override int IndexOf(object value)
		{
			lock (_root)
			{
				return _list.IndexOf(value);
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

		public override int IndexOf(object value)
		{
			return _list.IndexOf(value);
		}

		public override void Insert(int index, object obj)
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		public override void InsertRange(int index, ICollection c)
		{
			throw new NotSupportedException("Collection is read-only.");
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

	public virtual int Capacity
	{
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

	public virtual IEnumerator GetEnumerator()
	{
		return new ArrayListEnumeratorSimple(this);
	}

	public virtual int IndexOf(object value)
	{
		return Array.IndexOf((Array)_items, value, 0, _size);
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
}
