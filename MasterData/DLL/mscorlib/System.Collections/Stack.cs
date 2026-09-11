using System.Diagnostics;
using System.Threading;

namespace System.Collections;

[Serializable]
[DebuggerTypeProxy(typeof(StackDebugView))]
[DebuggerDisplay("Count = {Count}")]
public class Stack : ICollection, IEnumerable, ICloneable
{
	[Serializable]
	private class SyncStack : Stack
	{
		private Stack _s;

		private object _root;

		public override bool IsSynchronized => true;

		public override object SyncRoot => _root;

		public override int Count
		{
			get
			{
				lock (_root)
				{
					return _s.Count;
				}
			}
		}

		internal SyncStack(Stack stack)
		{
			_s = stack;
			_root = stack.SyncRoot;
		}

		public override bool Contains(object obj)
		{
			lock (_root)
			{
				return _s.Contains(obj);
			}
		}

		public override object Clone()
		{
			lock (_root)
			{
				return new SyncStack((Stack)_s.Clone());
			}
		}

		public override void Clear()
		{
			lock (_root)
			{
				_s.Clear();
			}
		}

		public override void CopyTo(Array array, int arrayIndex)
		{
			lock (_root)
			{
				_s.CopyTo(array, arrayIndex);
			}
		}

		public override void Push(object value)
		{
			lock (_root)
			{
				_s.Push(value);
			}
		}

		public override object Pop()
		{
			lock (_root)
			{
				return _s.Pop();
			}
		}

		public override IEnumerator GetEnumerator()
		{
			lock (_root)
			{
				return _s.GetEnumerator();
			}
		}

		public override object Peek()
		{
			lock (_root)
			{
				return _s.Peek();
			}
		}

		public override object[] ToArray()
		{
			lock (_root)
			{
				return _s.ToArray();
			}
		}
	}

	[Serializable]
	private class StackEnumerator : IEnumerator, ICloneable
	{
		private Stack _stack;

		private int _index;

		private int _version;

		private object _currentElement;

		public virtual object Current
		{
			get
			{
				if (_index == -2)
				{
					throw new InvalidOperationException("Enumeration has not started. Call MoveNext.");
				}
				if (_index == -1)
				{
					throw new InvalidOperationException("Enumeration already finished.");
				}
				return _currentElement;
			}
		}

		internal StackEnumerator(Stack stack)
		{
			_stack = stack;
			_version = _stack._version;
			_index = -2;
			_currentElement = null;
		}

		public object Clone()
		{
			return MemberwiseClone();
		}

		public virtual bool MoveNext()
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
			_currentElement = null;
			return num2;
		}

		public virtual void Reset()
		{
			if (_version != _stack._version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			_index = -2;
			_currentElement = null;
		}
	}

	internal class StackDebugView
	{
	}

	private object[] _array;

	private int _size;

	private int _version;

	[NonSerialized]
	private object _syncRoot;

	private const int _defaultCapacity = 10;

	public virtual int Count => _size;

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

	public Stack()
	{
		_array = new object[10];
		_size = 0;
		_version = 0;
	}

	public Stack(int initialCapacity)
	{
		if (initialCapacity < 0)
		{
			throw new ArgumentOutOfRangeException("initialCapacity", "Non-negative number required.");
		}
		if (initialCapacity < 10)
		{
			initialCapacity = 10;
		}
		_array = new object[initialCapacity];
		_size = 0;
		_version = 0;
	}

	public Stack(ICollection col)
		: this(col?.Count ?? 32)
	{
		if (col == null)
		{
			throw new ArgumentNullException("col");
		}
		IEnumerator enumerator = col.GetEnumerator();
		while (enumerator.MoveNext())
		{
			Push(enumerator.Current);
		}
	}

	public virtual void Clear()
	{
		Array.Clear(_array, 0, _size);
		_size = 0;
		_version++;
	}

	public virtual object Clone()
	{
		Stack stack = new Stack(_size);
		stack._size = _size;
		Array.Copy(_array, 0, stack._array, 0, _size);
		stack._version = _version;
		return stack;
	}

	public virtual bool Contains(object obj)
	{
		int size = _size;
		while (size-- > 0)
		{
			if (obj == null)
			{
				if (_array[size] == null)
				{
					return true;
				}
			}
			else if (_array[size] != null && _array[size].Equals(obj))
			{
				return true;
			}
		}
		return false;
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
			throw new ArgumentOutOfRangeException("index", "Non-negative number required.");
		}
		if (array.Length - index < _size)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		int i = 0;
		if (array is object[] array2)
		{
			for (; i < _size; i++)
			{
				array2[i + index] = _array[_size - i - 1];
			}
		}
		else
		{
			for (; i < _size; i++)
			{
				array.SetValue(_array[_size - i - 1], i + index);
			}
		}
	}

	public virtual IEnumerator GetEnumerator()
	{
		return new StackEnumerator(this);
	}

	public virtual object Peek()
	{
		if (_size == 0)
		{
			throw new InvalidOperationException("Stack empty.");
		}
		return _array[_size - 1];
	}

	public virtual object Pop()
	{
		if (_size == 0)
		{
			throw new InvalidOperationException("Stack empty.");
		}
		_version++;
		object result = _array[--_size];
		_array[_size] = null;
		return result;
	}

	public virtual void Push(object obj)
	{
		if (_size == _array.Length)
		{
			object[] array = new object[2 * _array.Length];
			Array.Copy(_array, 0, array, 0, _size);
			_array = array;
		}
		_array[_size++] = obj;
		_version++;
	}

	public static Stack Synchronized(Stack stack)
	{
		if (stack == null)
		{
			throw new ArgumentNullException("stack");
		}
		return new SyncStack(stack);
	}

	public virtual object[] ToArray()
	{
		if (_size == 0)
		{
			return Array.Empty<object>();
		}
		object[] array = new object[_size];
		for (int i = 0; i < _size; i++)
		{
			array[i] = _array[_size - i - 1];
		}
		return array;
	}
}
