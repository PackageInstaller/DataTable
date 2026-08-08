using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using Unity;

namespace System.Text.RegularExpressions;

[DebuggerTypeProxy(typeof(CollectionDebuggerProxy<Capture>))]
[DebuggerDisplay("Count = {Count}")]
public class CaptureCollection : IList<Capture>, ICollection<Capture>, IEnumerable<Capture>, IEnumerable, IReadOnlyList<Capture>, IReadOnlyCollection<Capture>, IList, ICollection
{
	[Serializable]
	private sealed class Enumerator : IEnumerator<Capture>, IDisposable, IEnumerator
	{
		private readonly CaptureCollection _collection;

		private int _index;

		public Capture Current
		{
			get
			{
				if (_index < 0 || _index >= _collection.Count)
				{
					throw new InvalidOperationException("Enumeration has either not started or has already finished.");
				}
				return _collection[_index];
			}
		}

		object IEnumerator.Current => Current;

		internal Enumerator(CaptureCollection collection)
		{
			_collection = collection;
			_index = -1;
		}

		public bool MoveNext()
		{
			int count = _collection.Count;
			if (_index >= count)
			{
				return false;
			}
			_index++;
			return _index < count;
		}

		void IEnumerator.Reset()
		{
			_index = -1;
		}

		void IDisposable.Dispose()
		{
		}
	}

	private readonly Group _group;

	private readonly int _capcount;

	private Capture[] _captures;

	public bool IsReadOnly => true;

	public int Count => _capcount;

	public Capture this[int i] => GetCapture(i);

	public bool IsSynchronized => false;

	public object SyncRoot => _group;

	Capture IList<Capture>.this[int index]
	{
		get
		{
			return this[index];
		}
		set
		{
			throw new NotSupportedException("Collection is read-only.");
		}
	}

	bool IList.IsFixedSize => true;

	object IList.this[int index]
	{
		get
		{
			return this[index];
		}
		set
		{
			throw new NotSupportedException("Collection is read-only.");
		}
	}

	internal CaptureCollection(Group group)
	{
		_group = group;
		_capcount = _group._capcount;
	}

	public IEnumerator GetEnumerator()
	{
		return new Enumerator(this);
	}

	IEnumerator<Capture> IEnumerable<Capture>.GetEnumerator()
	{
		return new Enumerator(this);
	}

	private Capture GetCapture(int i)
	{
		if (i == _capcount - 1 && i >= 0)
		{
			return _group;
		}
		if (i >= _capcount || i < 0)
		{
			throw new ArgumentOutOfRangeException("i");
		}
		if (_captures == null)
		{
			ForceInitialized();
		}
		return _captures[i];
	}

	internal void ForceInitialized()
	{
		_captures = new Capture[_capcount];
		for (int i = 0; i < _capcount - 1; i++)
		{
			_captures[i] = new Capture(_group.Text, _group._caps[i * 2], _group._caps[i * 2 + 1]);
		}
	}

	public void CopyTo(Array array, int arrayIndex)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		int num = arrayIndex;
		for (int i = 0; i < Count; i++)
		{
			array.SetValue(this[i], num);
			num++;
		}
	}

	public void CopyTo(Capture[] array, int arrayIndex)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (arrayIndex < 0 || arrayIndex > array.Length)
		{
			throw new ArgumentOutOfRangeException("arrayIndex");
		}
		if (array.Length - arrayIndex < Count)
		{
			throw new ArgumentException("Destination array is not long enough to copy all the items in the collection. Check array index and length.");
		}
		int num = arrayIndex;
		for (int i = 0; i < Count; i++)
		{
			array[num] = this[i];
			num++;
		}
	}

	int IList<Capture>.IndexOf(Capture item)
	{
		for (int i = 0; i < Count; i++)
		{
			if (EqualityComparer<Capture>.Default.Equals(this[i], item))
			{
				return i;
			}
		}
		return -1;
	}

	void IList<Capture>.Insert(int index, Capture item)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	void IList<Capture>.RemoveAt(int index)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	void ICollection<Capture>.Add(Capture item)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	void ICollection<Capture>.Clear()
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	bool ICollection<Capture>.Contains(Capture item)
	{
		return ((IList<Capture>)this).IndexOf(item) >= 0;
	}

	bool ICollection<Capture>.Remove(Capture item)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	int IList.Add(object value)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	void IList.Clear()
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	bool IList.Contains(object value)
	{
		if (value is Capture)
		{
			return ((ICollection<Capture>)this).Contains((Capture)value);
		}
		return false;
	}

	int IList.IndexOf(object value)
	{
		if (!(value is Capture))
		{
			return -1;
		}
		return ((IList<Capture>)this).IndexOf((Capture)value);
	}

	void IList.Insert(int index, object value)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	void IList.Remove(object value)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	void IList.RemoveAt(int index)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	internal CaptureCollection()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
