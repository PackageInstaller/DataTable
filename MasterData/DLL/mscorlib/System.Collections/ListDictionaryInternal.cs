using System.Threading;

namespace System.Collections;

[Serializable]
internal class ListDictionaryInternal : IDictionary, ICollection, IEnumerable
{
	private class NodeEnumerator : IDictionaryEnumerator, IEnumerator
	{
		private ListDictionaryInternal list;

		private DictionaryNode current;

		private int version;

		private bool start;

		public object Current => Entry;

		public DictionaryEntry Entry
		{
			get
			{
				if (current == null)
				{
					throw new InvalidOperationException("Enumeration has either not started or has already finished.");
				}
				return new DictionaryEntry(current.key, current.value);
			}
		}

		public object Key
		{
			get
			{
				if (current == null)
				{
					throw new InvalidOperationException("Enumeration has either not started or has already finished.");
				}
				return current.key;
			}
		}

		public object Value
		{
			get
			{
				if (current == null)
				{
					throw new InvalidOperationException("Enumeration has either not started or has already finished.");
				}
				return current.value;
			}
		}

		public NodeEnumerator(ListDictionaryInternal list)
		{
			this.list = list;
			version = list.version;
			start = true;
			current = null;
		}

		public bool MoveNext()
		{
			if (version != list.version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			if (start)
			{
				current = list.head;
				start = false;
			}
			else if (current != null)
			{
				current = current.next;
			}
			return current != null;
		}

		public void Reset()
		{
			if (version != list.version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			start = true;
			current = null;
		}
	}

	private class NodeKeyValueCollection : ICollection, IEnumerable
	{
		private class NodeKeyValueEnumerator : IEnumerator
		{
			private ListDictionaryInternal list;

			private DictionaryNode current;

			private int version;

			private bool isKeys;

			private bool start;

			public object Current
			{
				get
				{
					if (current == null)
					{
						throw new InvalidOperationException("Enumeration has either not started or has already finished.");
					}
					if (!isKeys)
					{
						return current.value;
					}
					return current.key;
				}
			}

			public NodeKeyValueEnumerator(ListDictionaryInternal list, bool isKeys)
			{
				this.list = list;
				this.isKeys = isKeys;
				version = list.version;
				start = true;
				current = null;
			}

			public bool MoveNext()
			{
				if (version != list.version)
				{
					throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
				}
				if (start)
				{
					current = list.head;
					start = false;
				}
				else if (current != null)
				{
					current = current.next;
				}
				return current != null;
			}

			public void Reset()
			{
				if (version != list.version)
				{
					throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
				}
				start = true;
				current = null;
			}
		}

		private ListDictionaryInternal list;

		private bool isKeys;

		int ICollection.Count
		{
			get
			{
				int num = 0;
				for (DictionaryNode dictionaryNode = list.head; dictionaryNode != null; dictionaryNode = dictionaryNode.next)
				{
					num++;
				}
				return num;
			}
		}

		bool ICollection.IsSynchronized => false;

		object ICollection.SyncRoot => list.SyncRoot;

		public NodeKeyValueCollection(ListDictionaryInternal list, bool isKeys)
		{
			this.list = list;
			this.isKeys = isKeys;
		}

		void ICollection.CopyTo(Array array, int index)
		{
			if (array == null)
			{
				throw new ArgumentNullException("array");
			}
			if (array.Rank != 1)
			{
				throw new ArgumentException("Only single dimensional arrays are supported for the requested action.");
			}
			if (index < 0)
			{
				throw new ArgumentOutOfRangeException("index", "Non-negative number required.");
			}
			if (array.Length - index < list.Count)
			{
				throw new ArgumentException("Index was out of range. Must be non-negative and less than the size of the collection.", "index");
			}
			for (DictionaryNode dictionaryNode = list.head; dictionaryNode != null; dictionaryNode = dictionaryNode.next)
			{
				array.SetValue(isKeys ? dictionaryNode.key : dictionaryNode.value, index);
				index++;
			}
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return new NodeKeyValueEnumerator(list, isKeys);
		}
	}

	[Serializable]
	private class DictionaryNode
	{
		public object key;

		public object value;

		public DictionaryNode next;
	}

	private DictionaryNode head;

	private int version;

	private int count;

	[NonSerialized]
	private object _syncRoot;

	public object this[object key]
	{
		get
		{
			if (key == null)
			{
				throw new ArgumentNullException("key", "Key cannot be null.");
			}
			for (DictionaryNode next = head; next != null; next = next.next)
			{
				if (next.key.Equals(key))
				{
					return next.value;
				}
			}
			return null;
		}
		set
		{
			if (key == null)
			{
				throw new ArgumentNullException("key", "Key cannot be null.");
			}
			version++;
			DictionaryNode dictionaryNode = null;
			DictionaryNode next = head;
			while (next != null && !next.key.Equals(key))
			{
				dictionaryNode = next;
				next = next.next;
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
				Interlocked.CompareExchange<object>(ref _syncRoot, new object(), (object)null);
			}
			return _syncRoot;
		}
	}

	public ICollection Values => new NodeKeyValueCollection(this, isKeys: false);

	public void Add(object key, object value)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key", "Key cannot be null.");
		}
		version++;
		DictionaryNode dictionaryNode = null;
		DictionaryNode next;
		for (next = head; next != null; next = next.next)
		{
			if (next.key.Equals(key))
			{
				throw new ArgumentException(SR.Format("Item has already been added. Key in dictionary: '{0}'  Key being added: '{1}'", next.key, key));
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
			throw new ArgumentNullException("key", "Key cannot be null.");
		}
		for (DictionaryNode next = head; next != null; next = next.next)
		{
			if (next.key.Equals(key))
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
		if (array.Rank != 1)
		{
			throw new ArgumentException("Only single dimensional arrays are supported for the requested action.");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", "Non-negative number required.");
		}
		if (array.Length - index < Count)
		{
			throw new ArgumentException("Index was out of range. Must be non-negative and less than the size of the collection.", "index");
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
			throw new ArgumentNullException("key", "Key cannot be null.");
		}
		version++;
		DictionaryNode dictionaryNode = null;
		DictionaryNode next = head;
		while (next != null && !next.key.Equals(key))
		{
			dictionaryNode = next;
			next = next.next;
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
