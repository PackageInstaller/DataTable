using System.Collections;
using System.Collections.Generic;
using System.Numerics.Hashing;
using System.Reflection;

namespace System;

[Serializable]
[DefaultMember("Item")]
public readonly struct ArraySegment<T> : IList<T>, ICollection<T>, IEnumerable<T>, IEnumerable, IReadOnlyList<T>, IReadOnlyCollection<T>
{
	public struct Enumerator : IEnumerator<T>, IDisposable, IEnumerator
	{
		private readonly T[] _array;

		private readonly int _start;

		private readonly int _end;

		private int _current;

		public T Current
		{
			get
			{
				if (_current < _start)
				{
					ThrowHelper.ThrowInvalidOperationException_InvalidOperation_EnumNotStarted();
				}
				if (_current >= _end)
				{
					ThrowHelper.ThrowInvalidOperationException_InvalidOperation_EnumEnded();
				}
				return _array[_current];
			}
		}

		object IEnumerator.Current => Current;

		internal Enumerator(ArraySegment<T> arraySegment)
		{
			_array = arraySegment.Array;
			_start = arraySegment.Offset;
			_end = arraySegment.Offset + arraySegment.Count;
			_current = arraySegment.Offset - 1;
		}

		public bool MoveNext()
		{
			if (_current < _end)
			{
				_current++;
				return _current < _end;
			}
			return false;
		}

		void IEnumerator.Reset()
		{
			_current = _start - 1;
		}

		public void Dispose()
		{
		}
	}

	private readonly T[] _array;

	private readonly int _offset;

	private readonly int _count;

	public static ArraySegment<T> Empty { get; } = new ArraySegment<T>(new T[0]);

	public T[] Array => _array;

	public int Offset => _offset;

	public int Count => _count;

	T IList<T>.this[int index]
	{
		get
		{
			ThrowInvalidOperationIfDefault();
			if (index < 0 || index >= _count)
			{
				ThrowHelper.ThrowArgumentOutOfRange_IndexException();
			}
			return _array[_offset + index];
		}
		set
		{
			ThrowInvalidOperationIfDefault();
			if (index < 0 || index >= _count)
			{
				ThrowHelper.ThrowArgumentOutOfRange_IndexException();
			}
			_array[_offset + index] = value;
		}
	}

	T IReadOnlyList<T>.this[int index]
	{
		get
		{
			ThrowInvalidOperationIfDefault();
			if (index < 0 || index >= _count)
			{
				ThrowHelper.ThrowArgumentOutOfRange_IndexException();
			}
			return _array[_offset + index];
		}
	}

	bool ICollection<T>.IsReadOnly => true;

	public ArraySegment(T[] array)
	{
		if (array == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.array);
		}
		_array = array;
		_offset = 0;
		_count = array.Length;
	}

	public ArraySegment(T[] array, int offset, int count)
	{
		if (array == null || (uint)offset > (uint)array.Length || (uint)count > (uint)(array.Length - offset))
		{
			ThrowHelper.ThrowArraySegmentCtorValidationFailedExceptions(array, offset, count);
		}
		_array = array;
		_offset = offset;
		_count = count;
	}

	public Enumerator GetEnumerator()
	{
		ThrowInvalidOperationIfDefault();
		return new Enumerator(this);
	}

	public override int GetHashCode()
	{
		if (_array == null)
		{
			return 0;
		}
		return System.Numerics.Hashing.HashHelpers.Combine(System.Numerics.Hashing.HashHelpers.Combine(5381, _offset), _count) ^ _array.GetHashCode();
	}

	public void CopyTo(T[] destination, int destinationIndex)
	{
		ThrowInvalidOperationIfDefault();
		System.Array.Copy(_array, _offset, destination, destinationIndex, _count);
	}

	public override bool Equals(object obj)
	{
		if (obj is ArraySegment<T>)
		{
			return Equals((ArraySegment<T>)obj);
		}
		return false;
	}

	public bool Equals(ArraySegment<T> obj)
	{
		if (obj._array == _array && obj._offset == _offset)
		{
			return obj._count == _count;
		}
		return false;
	}

	int IList<T>.IndexOf(T item)
	{
		ThrowInvalidOperationIfDefault();
		int num = System.Array.IndexOf(_array, item, _offset, _count);
		if (num < 0)
		{
			return -1;
		}
		return num - _offset;
	}

	void IList<T>.Insert(int index, T item)
	{
		ThrowHelper.ThrowNotSupportedException();
	}

	void IList<T>.RemoveAt(int index)
	{
		ThrowHelper.ThrowNotSupportedException();
	}

	void ICollection<T>.Add(T item)
	{
		ThrowHelper.ThrowNotSupportedException();
	}

	void ICollection<T>.Clear()
	{
		ThrowHelper.ThrowNotSupportedException();
	}

	bool ICollection<T>.Contains(T item)
	{
		ThrowInvalidOperationIfDefault();
		return System.Array.IndexOf(_array, item, _offset, _count) >= 0;
	}

	bool ICollection<T>.Remove(T item)
	{
		ThrowHelper.ThrowNotSupportedException();
		return false;
	}

	IEnumerator<T> IEnumerable<T>.GetEnumerator()
	{
		return GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	private void ThrowInvalidOperationIfDefault()
	{
		if (_array == null)
		{
			ThrowHelper.ThrowInvalidOperationException(ExceptionResource.InvalidOperation_NullArray);
		}
	}
}
