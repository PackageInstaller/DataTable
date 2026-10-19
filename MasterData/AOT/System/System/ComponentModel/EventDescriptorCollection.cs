using System.Collections;
using System.Collections.Generic;

namespace System.ComponentModel;

public class EventDescriptorCollection : ICollection, IEnumerable, IList
{
	private class ArraySubsetEnumerator : IEnumerator
	{
		private readonly Array _array;

		private readonly int _total;

		private int _current;

		public object Current
		{
			get
			{
				if (_current == -1)
				{
					throw new InvalidOperationException();
				}
				return _array.GetValue(_current);
			}
		}

		public ArraySubsetEnumerator(Array array, int count)
		{
			_array = array;
			_total = count;
			_current = -1;
		}

		public bool MoveNext()
		{
			if (_current < _total - 1)
			{
				_current++;
				return true;
			}
			return false;
		}

		public void Reset()
		{
			_current = -1;
		}
	}

	private EventDescriptor[] _events;

	private string[] _namedSort;

	private readonly IComparer _comparer;

	private bool _eventsOwned;

	private bool _needSort;

	private readonly bool _readOnly;

	public static readonly EventDescriptorCollection Empty = new EventDescriptorCollection(null, readOnly: true);

	public int Count { get; private set; }

	public virtual EventDescriptor this[int index]
	{
		get
		{
			if (index >= Count)
			{
				throw new IndexOutOfRangeException();
			}
			EnsureEventsOwned();
			return _events[index];
		}
	}

	public virtual EventDescriptor this[string name] => Find(name, ignoreCase: false);

	bool ICollection.IsSynchronized => false;

	object ICollection.SyncRoot => null;

	int ICollection.Count => Count;

	object IList.this[int index]
	{
		get
		{
			return this[index];
		}
		set
		{
			if (_readOnly)
			{
				throw new NotSupportedException();
			}
			if (index >= Count)
			{
				throw new IndexOutOfRangeException();
			}
			EnsureEventsOwned();
			_events[index] = (EventDescriptor)value;
		}
	}

	bool IList.IsReadOnly => _readOnly;

	bool IList.IsFixedSize => _readOnly;

	public EventDescriptorCollection(EventDescriptor[] events)
	{
		if (events == null)
		{
			_events = Array.Empty<EventDescriptor>();
		}
		else
		{
			_events = events;
			Count = events.Length;
		}
		_eventsOwned = true;
	}

	public EventDescriptorCollection(EventDescriptor[] events, bool readOnly)
		: this(events)
	{
		_readOnly = readOnly;
	}

	public int Add(EventDescriptor value)
	{
		if (_readOnly)
		{
			throw new NotSupportedException();
		}
		EnsureSize(Count + 1);
		_events[Count++] = value;
		return Count - 1;
	}

	public void Clear()
	{
		if (_readOnly)
		{
			throw new NotSupportedException();
		}
		Count = 0;
	}

	public bool Contains(EventDescriptor value)
	{
		return IndexOf(value) >= 0;
	}

	void ICollection.CopyTo(Array array, int index)
	{
		EnsureEventsOwned();
		Array.Copy(_events, 0, array, index, Count);
	}

	private void EnsureEventsOwned()
	{
		if (!_eventsOwned)
		{
			_eventsOwned = true;
			if (_events != null)
			{
				EventDescriptor[] array = new EventDescriptor[Count];
				Array.Copy(_events, 0, array, 0, Count);
				_events = array;
			}
		}
		if (_needSort)
		{
			_needSort = false;
			InternalSort(_namedSort);
		}
	}

	private void EnsureSize(int sizeNeeded)
	{
		if (sizeNeeded > _events.Length)
		{
			if (_events.Length == 0)
			{
				Count = 0;
				_events = new EventDescriptor[sizeNeeded];
				return;
			}
			EnsureEventsOwned();
			EventDescriptor[] array = new EventDescriptor[Math.Max(sizeNeeded, _events.Length * 2)];
			Array.Copy(_events, 0, array, 0, Count);
			_events = array;
		}
	}

	public virtual EventDescriptor Find(string name, bool ignoreCase)
	{
		EventDescriptor result = null;
		if (ignoreCase)
		{
			for (int i = 0; i < Count; i++)
			{
				if (string.Equals(_events[i].Name, name, StringComparison.OrdinalIgnoreCase))
				{
					result = _events[i];
					break;
				}
			}
		}
		else
		{
			for (int j = 0; j < Count; j++)
			{
				if (string.Equals(_events[j].Name, name, StringComparison.Ordinal))
				{
					result = _events[j];
					break;
				}
			}
		}
		return result;
	}

	public int IndexOf(EventDescriptor value)
	{
		return Array.IndexOf(_events, value, 0, Count);
	}

	public void Insert(int index, EventDescriptor value)
	{
		if (_readOnly)
		{
			throw new NotSupportedException();
		}
		EnsureSize(Count + 1);
		if (index < Count)
		{
			Array.Copy(_events, index, _events, index + 1, Count - index);
		}
		_events[index] = value;
		Count++;
	}

	public void Remove(EventDescriptor value)
	{
		if (_readOnly)
		{
			throw new NotSupportedException();
		}
		int num = IndexOf(value);
		if (num != -1)
		{
			RemoveAt(num);
		}
	}

	public void RemoveAt(int index)
	{
		if (_readOnly)
		{
			throw new NotSupportedException();
		}
		if (index < Count - 1)
		{
			Array.Copy(_events, index + 1, _events, index, Count - index - 1);
		}
		_events[Count - 1] = null;
		Count--;
	}

	public IEnumerator GetEnumerator()
	{
		if (_events.Length == Count)
		{
			return _events.GetEnumerator();
		}
		return new ArraySubsetEnumerator(_events, Count);
	}

	protected void InternalSort(string[] names)
	{
		if (_events.Length == 0)
		{
			return;
		}
		InternalSort(_comparer);
		if (names == null || names.Length == 0)
		{
			return;
		}
		List<EventDescriptor> list = new List<EventDescriptor>(_events);
		int num = 0;
		int num2 = _events.Length;
		for (int i = 0; i < names.Length; i++)
		{
			for (int j = 0; j < num2; j++)
			{
				EventDescriptor eventDescriptor = list[j];
				if (eventDescriptor != null && eventDescriptor.Name.Equals(names[i]))
				{
					_events[num++] = eventDescriptor;
					list[j] = null;
					break;
				}
			}
		}
		for (int k = 0; k < num2; k++)
		{
			if (list[k] != null)
			{
				_events[num++] = list[k];
			}
		}
	}

	protected void InternalSort(IComparer sorter)
	{
		if (sorter == null)
		{
			TypeDescriptor.SortDescriptorArray(this);
		}
		else
		{
			Array.Sort(_events, sorter);
		}
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	int IList.Add(object value)
	{
		return Add((EventDescriptor)value);
	}

	bool IList.Contains(object value)
	{
		return Contains((EventDescriptor)value);
	}

	void IList.Clear()
	{
		Clear();
	}

	int IList.IndexOf(object value)
	{
		return IndexOf((EventDescriptor)value);
	}

	void IList.Insert(int index, object value)
	{
		Insert(index, (EventDescriptor)value);
	}

	void IList.Remove(object value)
	{
		Remove((EventDescriptor)value);
	}

	void IList.RemoveAt(int index)
	{
		RemoveAt(index);
	}
}
