using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Threading;

namespace System.Collections.Generic;

[Serializable]
[DebuggerTypeProxy(typeof(StackDebugView<>))]
[DebuggerDisplay("Count = {Count}")]
[TypeForwardedFrom("System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")]
public class Stack<T> : IEnumerable<T>, IEnumerable, ICollection, IReadOnlyCollection<T>
{
	[Serializable]
	public struct Enumerator : IEnumerator<T>, IDisposable, IEnumerator
	{
		private readonly Stack<T> _stack;

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

		internal Enumerator(Stack<T> stack)
		{
			_stack = stack;
			_version = stack._version;
			_index = -2;
			_currentElement = default(T);
		}

		public void Dispose()
		{
			_index = -1;
		}

		public bool MoveNext()
		{
			if (_version != _stack._version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			if (_index == -2)
			{
				_index = _stack._size - 1;
				bool num = _index >= 0;
				if (num)
				{
					_currentElement = _stack._array[_index];
				}
				return num;
			}
			if (_index == -1)
			{
				return false;
			}
			bool num2 = --_index >= 0;
			if (num2)
			{
				_currentElement = _stack._array[_index];
				return num2;
			}
			_currentElement = default(T);
			return num2;
		}

		private void ThrowEnumerationNotStartedOrEnded()
		{
			throw new InvalidOperationException((_index == -2) ? "Enumeration has not started. Call MoveNext." : "Enumeration already finished.");
		}

		void IEnumerator.Reset()
		{
			if (_version != _stack._version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			_index = -2;
			_currentElement = default(T);
		}
	}

	private T[] _array;

	private int _size;

	private int _version;

	[NonSerialized]
	private object _syncRoot;

	private const int DefaultCapacity = 4;

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

	public Stack()
	{
		_array = Array.Empty<T>();
	}

	public Stack(int capacity)
	{
		if (capacity < 0)
		{
			throw new ArgumentOutOfRangeException("capacity", capacity, "Non-negative number required.");
		}
		_array = new T[capacity];
	}

	public Stack(IEnumerable<T> collection)
	{
		if (collection == null)
		{
			throw new ArgumentNullException("collection");
		}
		_array = EnumerableHelpers.ToArray(collection, out _size);
	}

	public void Clear()
	{
		if (RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			Array.Clear(_array, 0, _size);
		}
		_size = 0;
		_version++;
	}

	public bool Contains(T item)
	{
		if (_size != 0)
		{
			return Array.LastIndexOf(_array, item, _size - 1) != -1;
		}
		return false;
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
		int num = 0;
		int num2 = arrayIndex + _size;
		while (num < _size)
		{
			array[--num2] = _array[num++];
		}
	}

	void ICollection.CopyTo(Array array, int arrayIndex)
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
		if (arrayIndex < 0 || arrayIndex > array.Length)
		{
			throw new ArgumentOutOfRangeException("arrayIndex", arrayIndex, "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (array.Length - arrayIndex < _size)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		try
		{
			Array.Copy(_array, 0, array, arrayIndex, _size);
			Array.Reverse(array, arrayIndex, _size);
		}
		catch (ArrayTypeMismatchException)
		{
			throw new ArgumentException("Target array type is not compatible with the type of items in the collection.", "array");
		}
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

	public void TrimExcess()
	{
		int num = (int)((double)_array.Length * 0.9);
		if (_size < num)
		{
			Array.Resize(ref _array, _size);
			_version++;
		}
	}

	public T Peek()
	{
		int num = _size - 1;
		T[] array = _array;
		if ((uint)num >= (uint)array.Length)
		{
			ThrowForEmptyStack();
		}
		return array[num];
	}

	public bool TryPeek(out T result)
	{
		int num = _size - 1;
		T[] array = _array;
		if ((uint)num >= (uint)array.Length)
		{
			result = default(T);
			return false;
		}
		result = array[num];
		return true;
	}

	public T Pop()
	{
		int num = _size - 1;
		T[] array = _array;
		if ((uint)num >= (uint)array.Length)
		{
			ThrowForEmptyStack();
		}
		_version++;
		_size = num;
		T result = array[num];
		if (RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			array[num] = default(T);
		}
		return result;
	}

	public bool TryPop(out T result)
	{
		int num = _size - 1;
		T[] array = _array;
		if ((uint)num >= (uint)array.Length)
		{
			result = default(T);
			return false;
		}
		_version++;
		_size = num;
		result = array[num];
		if (RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			array[num] = default(T);
		}
		return true;
	}

	public void Push(T item)
	{
		int size = _size;
		T[] array = _array;
		if ((uint)size < (uint)array.Length)
		{
			array[size] = item;
			_version++;
			_size = size + 1;
		}
		else
		{
			PushWithResize(item);
		}
	}

	[MethodImpl((MethodImplOptions)8)]
	private void PushWithResize(T item)
	{
		Array.Resize(ref _array, (_array.Length == 0) ? 4 : (2 * _array.Length));
		_array[_size] = item;
		_version++;
		_size++;
	}

	public T[] ToArray()
	{
		if (_size == 0)
		{
			return Array.Empty<T>();
		}
		T[] array = new T[_size];
		for (int i = 0; i < _size; i++)
		{
			array[i] = _array[_size - i - 1];
		}
		return array;
	}

	private void ThrowForEmptyStack()
	{
		throw new InvalidOperationException("Stack empty.");
	}
}
