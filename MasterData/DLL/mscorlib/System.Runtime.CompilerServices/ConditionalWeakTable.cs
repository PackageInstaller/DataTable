using System.Collections;
using System.Collections.Generic;
using System.Threading;

namespace System.Runtime.CompilerServices;

public sealed class ConditionalWeakTable<TKey, TValue> : IEnumerable<KeyValuePair<TKey, TValue>>, IEnumerable where TKey : class where TValue : class
{
	public delegate TValue CreateValueCallback(TKey key);

	private sealed class Enumerator : IEnumerator<KeyValuePair<TKey, TValue>>, IDisposable, IEnumerator
	{
		private ConditionalWeakTable<TKey, TValue> _table;

		private int _currentIndex = -1;

		private KeyValuePair<TKey, TValue> _current;

		public KeyValuePair<TKey, TValue> Current
		{
			get
			{
				if (_currentIndex < 0)
				{
					ThrowHelper.ThrowInvalidOperationException_InvalidOperation_EnumOpCantHappen();
				}
				return _current;
			}
		}

		object IEnumerator.Current => Current;

		public Enumerator(ConditionalWeakTable<TKey, TValue> table)
		{
			_table = table;
			_currentIndex = -1;
		}

		~Enumerator()
		{
			Dispose();
		}

		public void Dispose()
		{
			if (Interlocked.Exchange(ref _table, null) != null)
			{
				_current = default(KeyValuePair<TKey, TValue>);
				GC.SuppressFinalize(this);
			}
		}

		public bool MoveNext()
		{
			ConditionalWeakTable<TKey, TValue> table = _table;
			if (table != null)
			{
				lock (table._lock)
				{
					object ePHEMERON_TOMBSTONE = GC.EPHEMERON_TOMBSTONE;
					while (_currentIndex < table.data.Length - 1)
					{
						_currentIndex++;
						Ephemeron ephemeron = table.data[_currentIndex];
						if (ephemeron.key != null && ephemeron.key != ePHEMERON_TOMBSTONE)
						{
							_current = new KeyValuePair<TKey, TValue>((TKey)ephemeron.key, (TValue)ephemeron.value);
							return true;
						}
					}
				}
			}
			return false;
		}

		public void Reset()
		{
		}
	}

	private const int INITIAL_SIZE = 13;

	private const float LOAD_FACTOR = 0.7f;

	private const float COMPACT_FACTOR = 0.5f;

	private const float EXPAND_FACTOR = 1.1f;

	private Ephemeron[] data;

	private object _lock = new object();

	private int size;

	public ConditionalWeakTable()
	{
		data = new Ephemeron[13];
		GC.register_ephemeron_array(data);
	}

	~ConditionalWeakTable()
	{
	}

	private void RehashWithoutResize()
	{
		int num = data.Length;
		for (int i = 0; i < num; i++)
		{
			if (data[i].key == GC.EPHEMERON_TOMBSTONE)
			{
				data[i].key = null;
			}
		}
		for (int j = 0; j < num; j++)
		{
			object key = data[j].key;
			if (key == null)
			{
				continue;
			}
			int num2 = (RuntimeHelpers.GetHashCode(key) & 0x7FFFFFFF) % num;
			while (true)
			{
				if (data[num2].key == null)
				{
					data[num2].key = key;
					data[num2].value = data[j].value;
					data[j].key = null;
					data[j].value = null;
					break;
				}
				if (data[num2].key == key)
				{
					break;
				}
				if (++num2 == num)
				{
					num2 = 0;
				}
			}
		}
	}

	private void RecomputeSize()
	{
		size = 0;
		for (int i = 0; i < data.Length; i++)
		{
			if (data[i].key != null)
			{
				size++;
			}
		}
	}

	private void Rehash()
	{
		RecomputeSize();
		uint prime = (uint)HashHelpers.GetPrime(((int)((float)size / 0.7f) << 1) | 1);
		if ((float)prime > (float)data.Length * 0.5f && (float)prime < (float)data.Length * 1.1f)
		{
			RehashWithoutResize();
			return;
		}
		Ephemeron[] array = new Ephemeron[prime];
		GC.register_ephemeron_array(array);
		size = 0;
		for (int i = 0; i < data.Length; i++)
		{
			object key = data[i].key;
			object value = data[i].value;
			if (key == null || key == GC.EPHEMERON_TOMBSTONE)
			{
				continue;
			}
			int num = array.Length;
			int num2 = -1;
			int num4;
			int num3 = (num4 = (RuntimeHelpers.GetHashCode(key) & 0x7FFFFFFF) % num);
			do
			{
				object key2 = array[num3].key;
				if (key2 == null || key2 == GC.EPHEMERON_TOMBSTONE)
				{
					num2 = num3;
					break;
				}
				if (++num3 == num)
				{
					num3 = 0;
				}
			}
			while (num3 != num4);
			array[num2].key = key;
			array[num2].value = value;
			size++;
		}
		data = array;
	}

	public void Add(TKey key, TValue value)
	{
		if (key == null)
		{
			throw new ArgumentNullException("Null key", "key");
		}
		lock (_lock)
		{
			if ((float)size >= (float)data.Length * 0.7f)
			{
				Rehash();
			}
			int num = data.Length;
			int num2 = -1;
			int num4;
			int num3 = (num4 = (RuntimeHelpers.GetHashCode(key) & 0x7FFFFFFF) % num);
			do
			{
				object key2 = data[num3].key;
				if (key2 == null)
				{
					if (num2 == -1)
					{
						num2 = num3;
					}
					break;
				}
				if (key2 == GC.EPHEMERON_TOMBSTONE && num2 == -1)
				{
					num2 = num3;
				}
				else if (key2 == key)
				{
					throw new ArgumentException("Key already in the list", "key");
				}
				if (++num3 == num)
				{
					num3 = 0;
				}
			}
			while (num3 != num4);
			data[num2].key = key;
			data[num2].value = value;
			size++;
		}
	}

	public bool Remove(TKey key)
	{
		if (key == null)
		{
			throw new ArgumentNullException("Null key", "key");
		}
		lock (_lock)
		{
			int num = data.Length;
			int num3;
			int num2 = (num3 = (RuntimeHelpers.GetHashCode(key) & 0x7FFFFFFF) % num);
			do
			{
				object key2 = data[num2].key;
				if (key2 == key)
				{
					data[num2].key = GC.EPHEMERON_TOMBSTONE;
					data[num2].value = null;
					return true;
				}
				if (key2 == null)
				{
					break;
				}
				if (++num2 == num)
				{
					num2 = 0;
				}
			}
			while (num2 != num3);
		}
		return false;
	}

	public bool TryGetValue(TKey key, out TValue value)
	{
		if (key == null)
		{
			throw new ArgumentNullException("Null key", "key");
		}
		value = null;
		lock (_lock)
		{
			int num = data.Length;
			int num3;
			int num2 = (num3 = (RuntimeHelpers.GetHashCode(key) & 0x7FFFFFFF) % num);
			do
			{
				object key2 = data[num2].key;
				if (key2 == key)
				{
					value = (TValue)data[num2].value;
					return true;
				}
				if (key2 == null)
				{
					break;
				}
				if (++num2 == num)
				{
					num2 = 0;
				}
			}
			while (num2 != num3);
		}
		return false;
	}

	public TValue GetValue(TKey key, CreateValueCallback createValueCallback)
	{
		if (createValueCallback == null)
		{
			throw new ArgumentNullException("Null create delegate", "createValueCallback");
		}
		lock (_lock)
		{
			if (TryGetValue(key, out var value))
			{
				return value;
			}
			value = createValueCallback(key);
			Add(key, value);
			return value;
		}
	}

	IEnumerator<KeyValuePair<TKey, TValue>> IEnumerable<KeyValuePair<TKey, TValue>>.GetEnumerator()
	{
		lock (_lock)
		{
			IEnumerator<KeyValuePair<TKey, TValue>> result;
			if (size != 0)
			{
				IEnumerator<KeyValuePair<TKey, TValue>> enumerator = new Enumerator(this);
				result = enumerator;
			}
			else
			{
				result = ((IEnumerable<KeyValuePair<TKey, TValue>>)Array.Empty<KeyValuePair<TKey, TValue>>()).GetEnumerator();
			}
			return result;
		}
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return ((IEnumerable<KeyValuePair<TKey, TValue>>)this).GetEnumerator();
	}
}
