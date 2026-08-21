using System.Diagnostics;
using System.Threading;

namespace System.Collections;

[Serializable]
[DebuggerTypeProxy(typeof(QueueDebugView))]
[DebuggerDisplay("Count = {Count}")]
public class Queue : ICollection, IEnumerable, ICloneable
{
	[Serializable]
	private class QueueEnumerator : IEnumerator, ICloneable
	{
		private Queue _q;

		private int _index;

		private int _version;

		private object _currentElement;

		public virtual object Current
		{
			get
			{
				if (_currentElement == _q._array)
				{
					if (_index == 0)
					{
						throw new InvalidOperationException("Enumeration has not started. Call MoveNext.");
					}
					throw new InvalidOperationException("Enumeration already finished.");
				}
				return _currentElement;
			}
		}

		internal QueueEnumerator(Queue q)
		{
			_q = q;
			_version = _q._version;
			_index = 0;
			_currentElement = _q._array;
			if (_q._size == 0)
			{
				_index = -1;
			}
		}

		public object Clone()
		{
			return MemberwiseClone();
		}

		public virtual bool MoveNext()
		{
			if (_version != _q._version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			if (_index < 0)
			{
				_currentElement = _q._array;
				return false;
			}
			_currentElement = _q.GetElement(_index);
			_index++;
			if (_index == _q._size)
			{
				_index = -1;
			}
			return true;
		}

		public virtual void Reset()
		{
			if (_version != _q._version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			if (_q._size == 0)
			{
				_index = -1;
			}
			else
			{
				_index = 0;
			}
			_currentElement = _q._array;
		}
	}

	internal class QueueDebugView
	{
	}

	private object[] _array;

	private int _head;

	private int _tail;

	private int _size;

	private int _growFactor;

	private int _version;

	[NonSerialized]
	private object _syncRoot;

	public virtual int Count => _size;

	public virtual bool IsSynchronized => false;

	public virtual object SyncRoot
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

	public Queue()
		: this(32, 2f)
	{
	}

	public Queue(int capacity)
		: this(capacity, 2f)
	{
	}

	public Queue(int capacity, float growFactor)
	{
		if (capacity < 0)
		{
			throw new ArgumentOutOfRangeException("capacity", "Non-negative number required.");
		}
		if (!((double)growFactor >= 1.0) || !((double)growFactor <= 10.0))
		{
			throw new ArgumentOutOfRangeException("growFactor", SR.Format("Queue grow factor must be between {0} and {1}.", 1, 10));
		}
		_array = new object[capacity];
		_head = 0;
		_tail = 0;
		_size = 0;
		_growFactor = (int)(growFactor * 100f);
	}

	public Queue(ICollection col)
		: this(col?.Count ?? 32)
	{
		if (col == null)
		{
			throw new ArgumentNullException("col");
		}
		IEnumerator enumerator = col.GetEnumerator();
		while (enumerator.MoveNext())
		{
			Enqueue(enumerator.Current);
		}
	}

	public virtual object Clone()
	{
		Queue queue = new Queue(_size);
		queue._size = _size;
		int size = _size;
		int num = ((_array.Length - _head < size) ? (_array.Length - _head) : size);
		Array.Copy(_array, _head, queue._array, 0, num);
		size -= num;
		if (size > 0)
		{
			Array.Copy(_array, 0, queue._array, _array.Length - _head, size);
		}
		queue._version = _version;
		return queue;
	}

	public virtual void CopyTo(Array array, int index)
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
			throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (array.Length - index < _size)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		int size = _size;
		if (size != 0)
		{
			int num = ((_array.Length - _head < size) ? (_array.Length - _head) : size);
			Array.Copy(_array, _head, array, index, num);
			size -= num;
			if (size > 0)
			{
				Array.Copy(_array, 0, array, index + _array.Length - _head, size);
			}
		}
	}

	public virtual void Enqueue(object obj)
	{
		if (_size == _array.Length)
		{
			int num = (int)((long)_array.Length * (long)_growFactor / 100);
			if (num < _array.Length + 4)
			{
				num = _array.Length + 4;
			}
			SetCapacity(num);
		}
		_array[_tail] = obj;
		_tail = (_tail + 1) % _array.Length;
		_size++;
		_version++;
	}

	public virtual IEnumerator GetEnumerator()
	{
		return new QueueEnumerator(this);
	}

	public virtual object Dequeue()
	{
		if (Count == 0)
		{
			throw new InvalidOperationException("Queue empty.");
		}
		object result = _array[_head];
		_array[_head] = null;
		_head = (_head + 1) % _array.Length;
		_size--;
		_version++;
		return result;
	}

	public virtual object Peek()
	{
		if (Count == 0)
		{
			throw new InvalidOperationException("Queue empty.");
		}
		return _array[_head];
	}

	internal object GetElement(int i)
	{
		return _array[(_head + i) % _array.Length];
	}

	private void SetCapacity(int capacity)
	{
		object[] array = new object[capacity];
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
}
