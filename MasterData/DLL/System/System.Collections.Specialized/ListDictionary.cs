using System.Threading;

namespace System.Collections.Specialized;

[Serializable]
public class ListDictionary : IDictionary, ICollection, IEnumerable
{
	private class NodeEnumerator : IDictionaryEnumerator, IEnumerator
	{
		private ListDictionary _list;

		private DictionaryNode _current;

		private int _version;

		private bool _start;

		public object Current => Entry;

		public DictionaryEntry Entry
		{
			get
			{
				if (_current == null)
				{
					throw new InvalidOperationException("Enumeration has either not started or has already finished.");
				}
				return new DictionaryEntry(_current.key, _current.value);
			}
		}

		public object Key
		{
			get
			{
				if (_current == null)
				{
					throw new InvalidOperationException("Enumeration has either not started or has already finished.");
				}
				return _current.key;
			}
		}

		public object Value
		{
			get
			{
				if (_current == null)
				{
					throw new InvalidOperationException("Enumeration has either not started or has already finished.");
				}
				return _current.value;
			}
		}

		public NodeEnumerator(ListDictionary list)
		{
			_list = list;
			_version = list.version;
			_start = true;
			_current = null;
		}

		public bool MoveNext()
		{
			if (_version != _list.version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			if (_start)
			{
				_current = _list.head;
				_start = false;
			}
			else if (_current != null)
			{
				_current = _current.next;
			}
			return _current != null;
		}

		public void Reset()
		{
			if (_version != _list.version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			_start = true;
			_current = null;
		}
	}

	private class NodeKeyValueCollection : ICollection, IEnumerable
	{
		private class NodeKeyValueEnumerator : IEnumerator
		{
			private ListDictionary _list;

			private DictionaryNode _current;

			private int _version;

			private bool _isKeys;

			private bool _start;

			public object Current
			{
				get
				{
					if (_current == null)
					{
						throw new InvalidOperationException("Enumeration has either not started or has already finished.");
					}
					if (!_isKeys)
					{
						return _current.value;
					}
					return _current.key;
				}
			}

			public NodeKeyValueEnumerator(ListDictionary list, bool isKeys)
			{
				_list = list;
				_isKeys = isKeys;
				_version = list.version;
				_start = true;
				_current = null;
			}

			public bool MoveNext()
			{
				if (_version != _list.version)
				{
					throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
				}
				if (_start)
				{
					_current = _list.head;
					_start = false;
				}
				else if (_current != null)
				{
					_current = _current.next;
				}
				return _current != null;
			}

			public void Reset()
			{
				if (_version != _list.version)
				{
					throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
				}
				_start = true;
				_current = null;
			}
		}

		private ListDictionary _list;

		private bool _isKeys;

		int ICollection.Count
		{
			get
			{
				int num = 0;
				for (DictionaryNode dictionaryNode = _list.head; dictionaryNode != null; dictionaryNode = dictionaryNode.next)
				{
					num++;
				}
				return num;
			}
		}

		bool ICollection.IsSynchronized => false;

		object ICollection.SyncRoot => _list.SyncRoot;

		public NodeKeyValueCollection(ListDictionary list, bool isKeys)
		{
			_list = list;
			_isKeys = isKeys;
		}

		void ICollection.CopyTo(Array array, int index)
		{
			if (array == null)
			{
				throw new ArgumentNullException("array");
			}
			if (index < 0)
			{
				throw new ArgumentOutOfRangeException("index", index, "Non-negative number required.");
			}
			for (DictionaryNode dictionaryNode = _list.head; dictionaryNode != null; dictionaryNode = dictionaryNode.next)
			{
				array.SetValue(_isKeys ? dictionaryNode.key : dictionaryNode.value, index);
				index++;
			}
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return new NodeKeyValueEnumerator(_list, _isKeys);
		}
	}

	[Serializable]
	public class DictionaryNode
	{
		public object key;

		public object value;

		public DictionaryNode next;
	}

	private DictionaryNode head;

	private int version;

	private int count;

	private readonly IComparer comparer;

	[NonSerialized]
	private object _syncRoot;

	public object this[object key]
	{
		get
		{
			if (key == null)
			{
				throw new ArgumentNullException("key");
			}
			DictionaryNode next = head;
			if (comparer == null)
			{
				while (next != null)
				{
					if (next.key.Equals(key))
					{
						return next.value;
					}
					next = next.next;
				}
			}
			else
			{
				while (next != null)
				{
					object key2 = next.key;
					if (comparer.Compare(key2, key) == 0)
					{
						return next.value;
					}
					next = next.next;
				}
			}
			return null;
		}
		set
		{
			if (key == null)
			{
				throw new ArgumentNullException("key");
			}
			version++;
			DictionaryNode dictionaryNode = null;
			DictionaryNode next;
			for (next = head; next != null; next = next.next)
			{
				object key2 = next.key;
				if ((comparer == null) ? key2.Equals(key) : (comparer.Compare(key2, key) == 0))
				{
					break;
				}
				dictionaryNode = next;
			}
			if (next != null)
			{
				next.value = value;
				return;
			}
			DictionaryNode dictionaryNode2 = new DictionaryNode();
			dictionaryNode2.key = key;
			dictionaryNode2.value = value;
			if (dictionaryNode != null)
			{
				dictionaryNode.next = dictionaryNode2;
			}
			else
			{
				head = dictionaryNode2;
			}
			count++;
		}
	}

	public int Count => count;

	public ICollection Keys => new NodeKeyValueCollection(this, isKeys: true);

	public bool IsReadOnly => false;

	public bool IsFixedSize => false;

	public bool IsSynchronized => false;

	public object SyncRoot
	{
		get
		{
			if (_syncRoot == null)
			{
				Interlocked.CompareExchange(ref _syncRoot, new object(), null);
			}
			return _syncRoot;
		}
	}

	public ICollection Values => new NodeKeyValueCollection(this, isKeys: false);

	public ListDictionary()
	{
	}

	public ListDictionary(IComparer comparer)
	{
		this.comparer = comparer;
	}

	public void Add(object key, object value)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key");
		}
		version++;
		DictionaryNode dictionaryNode = null;
		for (DictionaryNode next = head; next != null; next = next.next)
		{
			object key2 = next.key;
			if ((comparer == null) ? key2.Equals(key) : (comparer.Compare(key2, key) == 0))
			{
				throw new ArgumentException(global::SR.Format("An item with the same key has already been added. Key: {0}", key));
			}
			dictionaryNode = next;
		}
		DictionaryNode dictionaryNode2 = new DictionaryNode();
		dictionaryNode2.key = key;
		dictionaryNode2.value = value;
		if (dictionaryNode != null)
		{
			dictionaryNode.next = dictionaryNode2;
		}
		else
		{
			head = dictionaryNode2;
		}
		count++;
	}

	public void Clear()
	{
		count = 0;
		head = null;
		version++;
	}

	public bool Contains(object key)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key");
		}
		for (DictionaryNode next = head; next != null; next = next.next)
		{
			object key2 = next.key;
			if ((comparer == null) ? key2.Equals(key) : (comparer.Compare(key2, key) == 0))
			{
				return true;
			}
		}
		return false;
	}

	public void CopyTo(Array array, int index)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", index, "Non-negative number required.");
		}
		if (array.Length - index < count)
		{
			throw new ArgumentException("Insufficient space in the target location to copy the information.");
		}
		for (DictionaryNode next = head; next != null; next = next.next)
		{
			array.SetValue(new DictionaryEntry(next.key, next.value), index);
			index++;
		}
	}

	public IDictionaryEnumerator GetEnumerator()
	{
		return new NodeEnumerator(this);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return new NodeEnumerator(this);
	}

	public void Remove(object key)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key");
		}
		version++;
		DictionaryNode dictionaryNode = null;
		DictionaryNode next;
		for (next = head; next != null; next = next.next)
		{
			object key2 = next.key;
			if ((comparer == null) ? key2.Equals(key) : (comparer.Compare(key2, key) == 0))
			{
				break;
			}
			dictionaryNode = next;
		}
		if (next != null)
		{
			if (next == head)
			{
				head = next.next;
			}
			else
			{
				dictionaryNode.next = next.next;
			}
			count--;
		}
	}
}
