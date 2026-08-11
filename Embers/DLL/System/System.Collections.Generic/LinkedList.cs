using System.Diagnostics;
using System.Runtime.Serialization;
using System.Threading;

namespace System.Collections.Generic;

[Serializable]
[DebuggerTypeProxy(typeof(System.Collections.Generic.ICollectionDebugView<>))]
[DebuggerDisplay("Count = {Count}")]
public class LinkedList<T> : ICollection<T>, IEnumerable<T>, IEnumerable, ICollection, IReadOnlyCollection<T>, ISerializable, IDeserializationCallback
{
	[Serializable]
	public struct Enumerator : IEnumerator<T>, IDisposable, IEnumerator, ISerializable, IDeserializationCallback
	{
		private LinkedList<T> _list;

		private LinkedListNode<T> _node;

		private int _version;

		private T _current;

		private int _index;

		private const string LinkedListName = "LinkedList";

		private const string CurrentValueName = "Current";

		private const string VersionName = "Version";

		private const string IndexName = "Index";

		public T Current => _current;

		object IEnumerator.Current
		{
			get
			{
				if (_index == 0 || _index == _list.Count + 1)
				{
					throw new InvalidOperationException("Enumeration has either not started or has already finished.");
				}
				return _current;
			}
		}

		internal Enumerator(LinkedList<T> list)
		{
			_list = list;
			_version = list.version;
			_node = list.head;
			_current = default(T);
			_index = 0;
		}

		private Enumerator(SerializationInfo info, StreamingContext context)
		{
			throw new PlatformNotSupportedException();
		}

		public bool MoveNext()
		{
			if (_version != _list.version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			if (_node == null)
			{
				_index = _list.Count + 1;
				return false;
			}
			_index++;
			_current = _node.item;
			_node = _node.next;
			if (_node == _list.head)
			{
				_node = null;
			}
			return true;
		}

		void IEnumerator.Reset()
		{
			if (_version != _list.version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			_current = default(T);
			_node = _list.head;
			_index = 0;
		}

		public void Dispose()
		{
		}

		void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
		{
			throw new PlatformNotSupportedException();
		}

		void IDeserializationCallback.OnDeserialization(object sender)
		{
			throw new PlatformNotSupportedException();
		}
	}

	internal LinkedListNode<T> head;

	internal int count;

	internal int version;

	private object _syncRoot;

	private SerializationInfo _siInfo;

	private const string VersionName = "Version";

	private const string CountName = "Count";

	private const string ValuesName = "Data";

	public int Count => count;

	public LinkedListNode<T> First => head;

	public LinkedListNode<T> Last
	{
		get
		{
			if (head != null)
			{
				return head.prev;
			}
			return null;
		}
	}

	bool ICollection<T>.IsReadOnly => false;

	bool ICollection.IsSynchronized => false;

	object ICollection.SyncRoot
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

	public LinkedList()
	{
	}

	public LinkedList(IEnumerable<T> collection)
	{
		if (collection == null)
		{
			throw new ArgumentNullException("collection");
		}
		foreach (T item in collection)
		{
			AddLast(item);
		}
	}

	protected LinkedList(SerializationInfo info, StreamingContext context)
	{
		_siInfo = info;
	}

	void ICollection<T>.Add(T value)
	{
		AddLast(value);
	}

	public LinkedListNode<T> AddAfter(LinkedListNode<T> node, T value)
	{
		ValidateNode(node);
		LinkedListNode<T> linkedListNode = new LinkedListNode<T>(node.list, value);
		InternalInsertNodeBefore(node.next, linkedListNode);
		return linkedListNode;
	}

	public void AddAfter(LinkedListNode<T> node, LinkedListNode<T> newNode)
	{
		ValidateNode(node);
		ValidateNewNode(newNode);
		InternalInsertNodeBefore(node.next, newNode);
		newNode.list = this;
	}

	public LinkedListNode<T> AddBefore(LinkedListNode<T> node, T value)
	{
		ValidateNode(node);
		LinkedListNode<T> linkedListNode = new LinkedListNode<T>(node.list, value);
		InternalInsertNodeBefore(node, linkedListNode);
		if (node == head)
		{
			head = linkedListNode;
		}
		return linkedListNode;
	}

	public void AddBefore(LinkedListNode<T> node, LinkedListNode<T> newNode)
	{
		ValidateNode(node);
		ValidateNewNode(newNode);
		InternalInsertNodeBefore(node, newNode);
		newNode.list = this;
		if (node == head)
		{
			head = newNode;
		}
	}

	public LinkedListNode<T> AddFirst(T value)
	{
		LinkedListNode<T> linkedListNode = new LinkedListNode<T>(this, value);
		if (head == null)
		{
			InternalInsertNodeToEmptyList(linkedListNode);
		}
		else
		{
			InternalInsertNodeBefore(head, linkedListNode);
			head = linkedListNode;
		}
		return linkedListNode;
	}

	public void AddFirst(LinkedListNode<T> node)
	{
		ValidateNewNode(node);
		if (head == null)
		{
			InternalInsertNodeToEmptyList(node);
		}
		else
		{
			InternalInsertNodeBefore(head, node);
			head = node;
		}
		node.list = this;
	}

	public LinkedListNode<T> AddLast(T value)
	{
		LinkedListNode<T> linkedListNode = new LinkedListNode<T>(this, value);
		if (head == null)
		{
			InternalInsertNodeToEmptyList(linkedListNode);
		}
		else
		{
			InternalInsertNodeBefore(head, linkedListNode);
		}
		return linkedListNode;
	}

	public void AddLast(LinkedListNode<T> node)
	{
		ValidateNewNode(node);
		if (head == null)
		{
			InternalInsertNodeToEmptyList(node);
		}
		else
		{
			InternalInsertNodeBefore(head, node);
		}
		node.list = this;
	}

	public void Clear()
	{
		LinkedListNode<T> next = head;
		while (next != null)
		{
			LinkedListNode<T> linkedListNode = next;
			next = next.Next;
			linkedListNode.Invalidate();
		}
		head = null;
		count = 0;
		version++;
	}

	public bool Contains(T value)
	{
		return Find(value) != null;
	}

	public void CopyTo(T[] array, int index)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", index, "Non-negative number required.");
		}
		if (index > array.Length)
		{
			throw new ArgumentOutOfRangeException("index", index, "Must be less than or equal to the size of the collection.");
		}
		if (array.Length - index < Count)
		{
			throw new ArgumentException("Insufficient space in the target location to copy the information.");
		}
		LinkedListNode<T> next = head;
		if (next != null)
		{
			do
			{
				array[index++] = next.item;
				next = next.next;
			}
			while (next != head);
		}
	}

	public LinkedListNode<T> Find(T value)
	{
		LinkedListNode<T> next = head;
		EqualityComparer<T> equalityComparer = EqualityComparer<T>.Default;
		if (next != null)
		{
			if (value != null)
			{
				do
				{
					if (equalityComparer.Equals(next.item, value))
					{
						return next;
					}
					next = next.next;
				}
				while (next != head);
			}
			else
			{
				do
				{
					if (next.item == null)
					{
						return next;
					}
					next = next.next;
				}
				while (next != head);
			}
		}
		return null;
	}

	public LinkedListNode<T> FindLast(T value)
	{
		if (head == null)
		{
			return null;
		}
		LinkedListNode<T> prev = head.prev;
		LinkedListNode<T> linkedListNode = prev;
		EqualityComparer<T> equalityComparer = EqualityComparer<T>.Default;
		if (linkedListNode != null)
		{
			if (value != null)
			{
				do
				{
					if (equalityComparer.Equals(linkedListNode.item, value))
					{
						return linkedListNode;
					}
					linkedListNode = linkedListNode.prev;
				}
				while (linkedListNode != prev);
			}
			else
			{
				do
				{
					if (linkedListNode.item == null)
					{
						return linkedListNode;
					}
					linkedListNode = linkedListNode.prev;
				}
				while (linkedListNode != prev);
			}
		}
		return null;
	}

	public Enumerator GetEnumerator()
	{
		return new Enumerator(this);
	}

	IEnumerator<T> IEnumerable<T>.GetEnumerator()
	{
		return GetEnumerator();
	}

	public bool Remove(T value)
	{
		LinkedListNode<T> linkedListNode = Find(value);
		if (linkedListNode != null)
		{
			InternalRemoveNode(linkedListNode);
			return true;
		}
		return false;
	}

	public void Remove(LinkedListNode<T> node)
	{
		ValidateNode(node);
		InternalRemoveNode(node);
	}

	public void RemoveFirst()
	{
		if (head == null)
		{
			throw new InvalidOperationException("The LinkedList is empty.");
		}
		InternalRemoveNode(head);
	}

	public void RemoveLast()
	{
		if (head == null)
		{
			throw new InvalidOperationException("The LinkedList is empty.");
		}
		InternalRemoveNode(head.prev);
	}

	public virtual void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		info.AddValue("Version", version);
		info.AddValue("Count", count);
		if (count != 0)
		{
			T[] array = new T[count];
			CopyTo(array, 0);
			info.AddValue("Data", array, typeof(T[]));
		}
	}

	public virtual void OnDeserialization(object sender)
	{
		if (_siInfo == null)
		{
			return;
		}
		int @int = _siInfo.GetInt32("Version");
		if (_siInfo.GetInt32("Count") != 0)
		{
			T[] array = (T[])_siInfo.GetValue("Data", typeof(T[]));
			if (array == null)
			{
				throw new SerializationException("The values for this dictionary are missing.");
			}
			for (int i = 0; i < array.Length; i++)
			{
				AddLast(array[i]);
			}
		}
		else
		{
			head = null;
		}
		version = @int;
		_siInfo = null;
	}

	private void InternalInsertNodeBefore(LinkedListNode<T> node, LinkedListNode<T> newNode)
	{
		newNode.next = node;
		newNode.prev = node.prev;
		node.prev.next = newNode;
		node.prev = newNode;
		version++;
		count++;
	}

	private void InternalInsertNodeToEmptyList(LinkedListNode<T> newNode)
	{
		newNode.next = newNode;
		newNode.prev = newNode;
		head = newNode;
		version++;
		count++;
	}

	internal void InternalRemoveNode(LinkedListNode<T> node)
	{
		if (node.next == node)
		{
			head = null;
		}
		else
		{
			node.next.prev = node.prev;
			node.prev.next = node.next;
			if (head == node)
			{
				head = node.next;
			}
		}
		node.Invalidate();
		count--;
		version++;
	}

	internal void ValidateNewNode(LinkedListNode<T> node)
	{
		if (node == null)
		{
			throw new ArgumentNullException("node");
		}
		if (node.list != null)
		{
			throw new InvalidOperationException("The LinkedList node already belongs to a LinkedList.");
		}
	}

	internal void ValidateNode(LinkedListNode<T> node)
	{
		if (node == null)
		{
			throw new ArgumentNullException("node");
		}
		if (node.list != this)
		{
			throw new InvalidOperationException("The LinkedList node does not belong to current LinkedList.");
		}
	}

	void ICollection.CopyTo(Array array, int index)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (array.Rank != 1)
		{
			throw new ArgumentException("Only single dimensional arrays are supported for the requested action.", "array");
		}
		if (array.GetLowerBound(0) != 0)
		{
			throw new ArgumentException("The lower bound of target array must be zero.", "array");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", index, "Non-negative number required.");
		}
		if (array.Length - index < Count)
		{
			throw new ArgumentException("Insufficient space in the target location to copy the information.");
		}
		if (array is T[] array2)
		{
			CopyTo(array2, index);
			return;
		}
		if (!(array is object[] array3))
		{
			throw new ArgumentException("Target array type is not compatible with the type of items in the collection.", "array");
		}
		LinkedListNode<T> next = head;
		try
		{
			if (next != null)
			{
				do
				{
					array3[index++] = next.item;
					next = next.next;
				}
				while (next != head);
			}
		}
		catch (ArrayTypeMismatchException)
		{
			throw new ArgumentException("Target array type is not compatible with the type of items in the collection.", "array");
		}
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}
}
