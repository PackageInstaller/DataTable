using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Threading;

namespace System.Collections.Generic;

[Serializable]
[DebuggerDisplay("Count = {Count}")]
[DebuggerTypeProxy(typeof(QueueDebugView<>))]
[TypeForwardedFrom("System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")]
public class Queue<T> : IEnumerable<T>, IEnumerable, ICollection, IReadOnlyCollection<T>
{
	[Serializable]
	public struct Enumerator : IEnumerator<T>, IDisposable, IEnumerator
	{
		private readonly Queue<T> _q;

		private readonly int _version;

		private int _index;

		private T _currentElement;

		public T Current
		{
			get
			{
				if (_index < 0)
				{
					ThrowEnumerationNotStartedOrEnded();
				}
				return _currentElement;
			}
		}

		object IEnumerator.Current => Current;

		internal Enumerator(Queue<T> q)
		{
			_q = q;
			_version = q._version;
			_index = -1;
			_currentElement = default(T);
		}

		public void Dispose()
		{
			_index = -2;
			_currentElement = default(T);
		}

		public bool MoveNext()
		{
			if (_version != _q._version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			if (_index == -2)
			{
				return false;
			}
			_index++;
			if (_index == _q._size)
			{
				_index = -2;
				_currentElement = default(T);
				return false;
			}
			T[] array = _q._array;
			int num = array.Length;
			int num2 = _q._head + _index;
			if (num2 >= num)
			{
				num2 -= num;
			}
			_currentElement = array[num2];
			return true;
		}

		private void ThrowEnumerationNotStartedOrEnded()
		{
			throw new InvalidOperationException((_index == -1) ? "Enumeration has not started. Call MoveNext." : "Enumeration already finished.");
		}

		void IEnumerator.Reset()
		{
			if (_version != _q._version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			_index = -1;
			_currentElement = default(T);
		}
	}

	private T[] _array;

	private int _head;

	private int _tail;

	private int _size;

	private int _version;

	[NonSerialized]
	private object _syncRoot;

	private const int MinimumGrow = 4;

	private const int GrowFactor = 200;

	public int Count => _size;

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

	public Queue()
	{
		_array = Array.Empty<T>();
	}

	public Queue(int capacity)
	{
		if (capacity < 0)
		{
			throw new ArgumentOutOfRangeException("capacity", capacity, "Non-negative number required.");
		}
		_array = new T[capacity];
	}

	public Queue(IEnumerable<T> collection)
	{
		if (collection == null)
		{
			throw new ArgumentNullException("collection");
		}
		_array = EnumerableHelpers.ToArray(collection, out _size);
		if (_size != _array.Length)
		{
			_tail = _size;
		}
	}

	public void Clear()
	{
		if (_size != 0)
		{
			if (RuntimeHelpers.IsReferenceOrContainsReferences<T>())
			{
				if (_head < _tail)
				{
					Array.Clear(_array, _head, _size);
				}
				else
				{
					Array.Clear(_array, _head, _array.Length - _head);
					Array.Clear(_array, 0, _tail);
				}
			}
			_size = 0;
		}
		_head = 0;
		_tail = 0;
		_version++;
	}

	public void CopyTo(T[] array, int arrayIndex)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (arrayIndex < 0 || arrayIndex > array.Length)
		{
			throw new ArgumentOutOfRangeException("arrayIndex", arrayIndex, "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (array.Length - arrayIndex < _size)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		int size = _size;
		if (size != 0)
		{
			int num = Math.Min(_array.Length - _head, size);
			Array.Copy(_array, _head, array, arrayIndex, num);
			size -= num;
			if (size > 0)
			{
				Array.Copy(_array, 0, array, arrayIndex + _array.Length - _head, size);
			}
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
		int length = array.Length;
		if (index < 0 || index > length)
		{
			throw new ArgumentOutOfRangeException("index", index, "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (length - index < _size)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		int size = _size;
		if (size == 0)
		{
			return;
		}
		try
		{
			int num = ((_array.Length - _head < size) ? (_array.Length - _head) : size);
			Array.Copy(_array, _head, array, index, num);
			size -= num;
			if (size > 0)
			{
				Array.Copy(_array, 0, array, index + _array.Length - _head, size);
			}
		}
		catch (ArrayTypeMismatchException)
		{
			throw new ArgumentException("Target array type is not compatible with the type of items in the collection.", "array");
		}
	}

	public void Enqueue(T item)
	{
		if (_size == _array.Length)
		{
			int num = (int)((long)_array.Length * 200L / 100);
			if (num < _array.Length + 4)
			{
				num = _array.Length + 4;
			}
			SetCapacity(num);
		}
		_array[_tail] = item;
		MoveNext(ref _tail);
		_size++;
		_version++;
	}

	public Enumerator GetEnumerator()
	{
		return new Enumerator(this);
	}

	IEnumerator<T> IEnumerable<T>.GetEnumerator()
	{
		return new Enumerator(this);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return new Enumerator(this);
	}

	public T Dequeue()
	{
		int head = _head;
		T[] array = _array;
		if (_size == 0)
		{
			ThrowForEmptyQueue();
		}
		T result = array[head];
		if (RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			array[head] = default(T);
		}
		MoveNext(ref _head);
		_size--;
		_version++;
		return result;
	}

	public bool TryDequeue(out T result)
	{
		int head = _head;
		T[] array = _array;
		if (_size == 0)
		{
			result = default(T);
			return false;
		}
		result = array[head];
		if (RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			array[head] = default(T);
		}
		MoveNext(ref _head);
		_size--;
		_version++;
		return true;
	}

	public T Peek()
	{
		if (_size == 0)
		{
			ThrowForEmptyQueue();
		}
		return _array[_head];
	}

	public bool TryPeek(out T result)
	{
		if (_size == 0)
		{
			result = default(T);
			return false;
		}
		result = _array[_head];
		return true;
	}

	public bool Contains(T item)
	{
		if (_size == 0)
		{
			return false;
		}
		if (_head < _tail)
		{
			return Array.IndexOf(_array, item, _head, _size) >= 0;
		}
		if (Array.IndexOf(_array, item, _head, _array.Length - _head) < 0)
		{
			return Array.IndexOf(_array, item, 0, _tail) >= 0;
		}
		return true;
	}

	public T[] ToArray()
	{
		if (_size == 0)
		{
			return Array.Empty<T>();
		}
		T[] array = new T[_size];
		if (_head < _tail)
		{
			Array.Copy(_array, _head, array, 0, _size);
		}
		else
		{
			Array.Copy(_array, _head, array, 0, _array.Length - _head);
			Array.Copy(_array, 0, array, _array.Length - _head, _tail);
		}
		return array;
	}

	private void SetCapacity(int capacity)
	{
		T[] array = new T[capacity];
		if (_size > 0)
		{
			if (_head < _tail)
			{
				Array.Copy(_array, _head, array, 0, _size);
			}
			else
			{
				Array.Copy(_array, _head, array, 0, _array.Length - _head);
				Array.Copy(_array, 0, array, _array.Length - _head, _tail);
			}
		}
		_array = array;
		_head = 0;
		_tail = ((_size != capacity) ? _size : 0);
		_version++;
	}

	private void MoveNext(ref int index)
	{
		int num = index + 1;
		if (num == _array.Length)
		{
			num = 0;
		}
		index = num;
	}

	private void ThrowForEmptyQueue()
	{
		throw new InvalidOperationException("Queue empty.");
	}

	public void TrimExcess()
	{
		int num = (int)((double)_array.Length * 0.9);
		if (_size < num)
		{
			SetCapacity(_size);
		}
	}
}
