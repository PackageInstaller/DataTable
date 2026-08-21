using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.ConstrainedExecution;
using System.Runtime.Serialization;
using System.Threading;

namespace System.Collections;

[Serializable]
[DebuggerTypeProxy(typeof(HashtableDebugView))]
[DebuggerDisplay("Count = {Count}")]
public class Hashtable : IDictionary, ICollection, IEnumerable, ISerializable, IDeserializationCallback, ICloneable
{
	private struct bucket
	{
		public object key;

		public object val;

		public int hash_coll;
	}

	[Serializable]
	private class KeyCollection : ICollection, IEnumerable
	{
		private Hashtable _hashtable;

		public virtual bool IsSynchronized => _hashtable.IsSynchronized;

		public virtual object SyncRoot => _hashtable.SyncRoot;

		public virtual int Count => _hashtable._count;

		internal KeyCollection(Hashtable hashtable)
		{
			_hashtable = hashtable;
		}

		public virtual void CopyTo(Array array, int arrayIndex)
		{
			if (array == null)
			{
				throw new ArgumentNullException("array");
			}
			if (array.Rank != 1)
			{
				throw new ArgumentException("Only single dimensional arrays are supported for the requested action.", "array");
			}
			if (arrayIndex < 0)
			{
				throw new ArgumentOutOfRangeException("arrayIndex", "Non-negative number required.");
			}
			if (array.Length - arrayIndex < _hashtable._count)
			{
				throw new ArgumentException("Destination array is not long enough to copy all the items in the collection. Check array index and length.");
			}
			_hashtable.CopyKeys(array, arrayIndex);
		}

		public virtual IEnumerator GetEnumerator()
		{
			return new HashtableEnumerator(_hashtable, 1);
		}
	}

	[Serializable]
	private class ValueCollection : ICollection, IEnumerable
	{
		private Hashtable _hashtable;

		public virtual bool IsSynchronized => _hashtable.IsSynchronized;

		public virtual object SyncRoot => _hashtable.SyncRoot;

		public virtual int Count => _hashtable._count;

		internal ValueCollection(Hashtable hashtable)
		{
			_hashtable = hashtable;
		}

		public virtual void CopyTo(Array array, int arrayIndex)
		{
			if (array == null)
			{
				throw new ArgumentNullException("array");
			}
			if (array.Rank != 1)
			{
				throw new ArgumentException("Only single dimensional arrays are supported for the requested action.", "array");
			}
			if (arrayIndex < 0)
			{
				throw new ArgumentOutOfRangeException("arrayIndex", "Non-negative number required.");
			}
			if (array.Length - arrayIndex < _hashtable._count)
			{
				throw new ArgumentException("Destination array is not long enough to copy all the items in the collection. Check array index and length.");
			}
			_hashtable.CopyValues(array, arrayIndex);
		}

		public virtual IEnumerator GetEnumerator()
		{
			return new HashtableEnumerator(_hashtable, 2);
		}
	}

	[Serializable]
	private class SyncHashtable : Hashtable, IEnumerable
	{
		protected Hashtable _table;

		public override int Count => _table.Count;

		public override bool IsReadOnly => _table.IsReadOnly;

		public override bool IsFixedSize => _table.IsFixedSize;

		public override bool IsSynchronized => true;

		public override object this[object key]
		{
			get
			{
				return _table[key];
			}
			set
			{
				lock (_table.SyncRoot)
				{
					_table[key] = value;
				}
			}
		}

		public override object SyncRoot => _table.SyncRoot;

		public override ICollection Keys
		{
			get
			{
				lock (_table.SyncRoot)
				{
					return _table.Keys;
				}
			}
		}

		public override ICollection Values
		{
			get
			{
				lock (_table.SyncRoot)
				{
					return _table.Values;
				}
			}
		}

		internal SyncHashtable(Hashtable table)
			: base(trash: false)
		{
			_table = table;
		}

		internal SyncHashtable(SerializationInfo info, StreamingContext context)
			: base(info, context)
		{
			throw new PlatformNotSupportedException();
		}

		public override void GetObjectData(SerializationInfo info, StreamingContext context)
		{
			throw new PlatformNotSupportedException();
		}

		public override void Add(object key, object value)
		{
			lock (_table.SyncRoot)
			{
				_table.Add(key, value);
			}
		}

		public override void Clear()
		{
			lock (_table.SyncRoot)
			{
				_table.Clear();
			}
		}

		public override bool Contains(object key)
		{
			return _table.Contains(key);
		}

		public override bool ContainsKey(object key)
		{
			if (key == null)
			{
				throw new ArgumentNullException("key", "Key cannot be null.");
			}
			return _table.ContainsKey(key);
		}

		public override void CopyTo(Array array, int arrayIndex)
		{
			lock (_table.SyncRoot)
			{
				_table.CopyTo(array, arrayIndex);
			}
		}

		public override object Clone()
		{
			lock (_table.SyncRoot)
			{
				return Synchronized((Hashtable)_table.Clone());
			}
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return _table.GetEnumerator();
		}

		public override IDictionaryEnumerator GetEnumerator()
		{
			return _table.GetEnumerator();
		}

		public override void Remove(object key)
		{
			lock (_table.SyncRoot)
			{
				_table.Remove(key);
			}
		}

		public override void OnDeserialization(object sender)
		{
		}
	}

	[Serializable]
	private class HashtableEnumerator : IDictionaryEnumerator, IEnumerator, ICloneable
	{
		private Hashtable _hashtable;

		private int _bucket;

		private int _version;

		private bool _current;

		private int _getObjectRetType;

		private object _currentKey;

		private object _currentValue;

		public virtual object Key
		{
			get
			{
				if (!_current)
				{
					throw new InvalidOperationException("Enumeration has not started. Call MoveNext.");
				}
				return _currentKey;
			}
		}

		public virtual DictionaryEntry Entry
		{
			get
			{
				if (!_current)
				{
					throw new InvalidOperationException("Enumeration has either not started or has already finished.");
				}
				return new DictionaryEntry(_currentKey, _currentValue);
			}
		}

		public virtual object Current
		{
			get
			{
				if (!_current)
				{
					throw new InvalidOperationException("Enumeration has either not started or has already finished.");
				}
				if (_getObjectRetType == 1)
				{
					return _currentKey;
				}
				if (_getObjectRetType == 2)
				{
					return _currentValue;
				}
				return new DictionaryEntry(_currentKey, _currentValue);
			}
		}

		public virtual object Value
		{
			get
			{
				if (!_current)
				{
					throw new InvalidOperationException("Enumeration has either not started or has already finished.");
				}
				return _currentValue;
			}
		}

		internal HashtableEnumerator(Hashtable hashtable, int getObjRetType)
		{
			_hashtable = hashtable;
			_bucket = hashtable._buckets.Length;
			_version = hashtable._version;
			_current = false;
			_getObjectRetType = getObjRetType;
		}

		public object Clone()
		{
			return MemberwiseClone();
		}

		public virtual bool MoveNext()
		{
			if (_version != _hashtable._version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			while (_bucket > 0)
			{
				_bucket--;
				object key = _hashtable._buckets[_bucket].key;
				if (key != null && key != _hashtable._buckets)
				{
					_currentKey = key;
					_currentValue = _hashtable._buckets[_bucket].val;
					_current = true;
					return true;
				}
			}
			_current = false;
			return false;
		}

		public virtual void Reset()
		{
			if (_version != _hashtable._version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			_current = false;
			_bucket = _hashtable._buckets.Length;
			_currentKey = null;
			_currentValue = null;
		}
	}

	internal class HashtableDebugView
	{
	}

	internal const int HashPrime = 101;

	private const int InitialSize = 3;

	private const string LoadFactorName = "LoadFactor";

	private const string VersionName = "Version";

	private const string ComparerName = "Comparer";

	private const string HashCodeProviderName = "HashCodeProvider";

	private const string HashSizeName = "HashSize";

	private const string KeysName = "Keys";

	private const string ValuesName = "Values";

	private const string KeyComparerName = "KeyComparer";

	private bucket[] _buckets;

	private int _count;

	private int _occupancy;

	private int _loadsize;

	private float _loadFactor;

	private volatile int _version;

	private volatile bool _isWriterInProgress;

	private ICollection _keys;

	private ICollection _values;

	private IEqualityComparer _keycomparer;

	private object _syncRoot;

	private static ConditionalWeakTable<object, SerializationInfo> s_serializationInfoTable;

	private static ConditionalWeakTable<object, SerializationInfo> SerializationInfoTable => LazyInitializer.EnsureInitialized(ref s_serializationInfoTable);

	public virtual object this[object key]
	{
		get
		{
			if (key == null)
			{
				throw new ArgumentNullException("key", "Key cannot be null.");
			}
			bucket[] buckets = _buckets;
			uint num = InitHash(key, buckets.Length, out var seed, out var incr);
			int num2 = 0;
			int num3 = (int)(seed % (uint)buckets.Length);
			bucket bucket2;
			do
			{
				SpinWait spinWait = default(SpinWait);
				while (true)
				{
					int version = _version;
					bucket2 = buckets[num3];
					if (!_isWriterInProgress && version == _version)
					{
						break;
					}
					spinWait.SpinOnce();
				}
				if (bucket2.key == null)
				{
					return null;
				}
				if ((bucket2.hash_coll & 0x7FFFFFFF) == num && KeyEquals(bucket2.key, key))
				{
					return bucket2.val;
				}
				num3 = (int)((num3 + incr) % (uint)buckets.Length);
			}
			while (bucket2.hash_coll < 0 && ++num2 < buckets.Length);
			return null;
		}
		set
		{
			Insert(key, value, add: false);
		}
	}

	public virtual bool IsReadOnly => false;

	public virtual bool IsFixedSize => false;

	public virtual bool IsSynchronized => false;

	public virtual ICollection Keys
	{
		get
		{
			if (_keys == null)
			{
				_keys = new KeyCollection(this);
			}
			return _keys;
		}
	}

	public virtual ICollection Values
	{
		get
		{
			if (_values == null)
			{
				_values = new ValueCollection(this);
			}
			return _values;
		}
	}

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

	public virtual int Count => _count;

	internal Hashtable(bool trash)
	{
	}

	public Hashtable()
		: this(0, 1f)
	{
	}

	public Hashtable(int capacity)
		: this(capacity, 1f)
	{
	}

	public Hashtable(int capacity, float loadFactor)
	{
		if (capacity < 0)
		{
			throw new ArgumentOutOfRangeException("capacity", "Non-negative number required.");
		}
		if (!(loadFactor >= 0.1f) || !(loadFactor <= 1f))
		{
			throw new ArgumentOutOfRangeException("loadFactor", SR.Format("Load factor needs to be between 0.1 and 1.0.", 0.1, 1.0));
		}
		_loadFactor = 0.72f * loadFactor;
		double num = (float)capacity / _loadFactor;
		if (num > 2147483647.0)
		{
			throw new ArgumentException("Hashtable's capacity overflowed and went negative. Check load factor, capacity and the current size of the table.", "capacity");
		}
		int num2 = ((num > 3.0) ? HashHelpers.GetPrime((int)num) : 3);
		_buckets = new bucket[num2];
		_loadsize = (int)(_loadFactor * (float)num2);
		_isWriterInProgress = false;
	}

	public Hashtable(int capacity, float loadFactor, IEqualityComparer equalityComparer)
		: this(capacity, loadFactor)
	{
		_keycomparer = equalityComparer;
	}

	[Obsolete("Please use Hashtable(IEqualityComparer) instead.")]
	public Hashtable(IHashCodeProvider hcp, IComparer comparer)
		: this(0, 1f, hcp, comparer)
	{
	}

	public Hashtable(IEqualityComparer equalityComparer)
		: this(0, 1f, equalityComparer)
	{
	}

	public Hashtable(int capacity, IEqualityComparer equalityComparer)
		: this(capacity, 1f, equalityComparer)
	{
	}

	public Hashtable(IDictionary d)
		: this(d, 1f)
	{
	}

	public Hashtable(IDictionary d, float loadFactor)
		: this(d, loadFactor, null)
	{
	}

	[Obsolete("Please use Hashtable(int, float, IEqualityComparer) instead.")]
	public Hashtable(int capacity, float loadFactor, IHashCodeProvider hcp, IComparer comparer)
		: this(capacity, loadFactor)
	{
		if (hcp != null || comparer != null)
		{
			_keycomparer = new CompatibleComparer(hcp, comparer);
		}
	}

	public Hashtable(IDictionary d, float loadFactor, IEqualityComparer equalityComparer)
		: this(d?.Count ?? 0, loadFactor, equalityComparer)
	{
		if (d == null)
		{
			throw new ArgumentNullException("d", "Dictionary cannot be null.");
		}
		IDictionaryEnumerator enumerator = d.GetEnumerator();
		while (enumerator.MoveNext())
		{
			Add(enumerator.Key, enumerator.Value);
		}
	}

	protected Hashtable(SerializationInfo info, StreamingContext context)
	{
		SerializationInfoTable.Add(this, info);
	}

	private uint InitHash(object key, int hashsize, out uint seed, out uint incr)
	{
		uint result = (seed = (uint)(GetHash(key) & 0x7FFFFFFF));
		incr = 1 + seed * 101 % (uint)(hashsize - 1);
		return result;
	}

	public virtual void Add(object key, object value)
	{
		Insert(key, value, add: true);
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public virtual void Clear()
	{
		if (_count != 0 || _occupancy != 0)
		{
			_isWriterInProgress = true;
			for (int i = 0; i < _buckets.Length; i++)
			{
				_buckets[i].hash_coll = 0;
				_buckets[i].key = null;
				_buckets[i].val = null;
			}
			_count = 0;
			_occupancy = 0;
			UpdateVersion();
			_isWriterInProgress = false;
		}
	}

	public virtual object Clone()
	{
		bucket[] buckets = _buckets;
		Hashtable hashtable = new Hashtable(_count, _keycomparer);
		hashtable._version = _version;
		hashtable._loadFactor = _loadFactor;
		hashtable._count = 0;
		int num = buckets.Length;
		while (num > 0)
		{
			num--;
			object key = buckets[num].key;
			if (key != null && key != buckets)
			{
				hashtable[key] = buckets[num].val;
			}
		}
		return hashtable;
	}

	public virtual bool Contains(object key)
	{
		return ContainsKey(key);
	}

	public virtual bool ContainsKey(object key)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key", "Key cannot be null.");
		}
		bucket[] buckets = _buckets;
		uint num = InitHash(key, buckets.Length, out var seed, out var incr);
		int num2 = 0;
		int num3 = (int)(seed % (uint)buckets.Length);
		bucket bucket2;
		do
		{
			bucket2 = buckets[num3];
			if (bucket2.key == null)
			{
				return false;
			}
			if ((bucket2.hash_coll & 0x7FFFFFFF) == num && KeyEquals(bucket2.key, key))
			{
				return true;
			}
			num3 = (int)((num3 + incr) % (uint)buckets.Length);
		}
		while (bucket2.hash_coll < 0 && ++num2 < buckets.Length);
		return false;
	}

	private void CopyKeys(Array array, int arrayIndex)
	{
		bucket[] buckets = _buckets;
		int num = buckets.Length;
		while (--num >= 0)
		{
			object key = buckets[num].key;
			if (key != null && key != _buckets)
			{
				array.SetValue(key, arrayIndex++);
			}
		}
	}

	private void CopyEntries(Array array, int arrayIndex)
	{
		bucket[] buckets = _buckets;
		int num = buckets.Length;
		while (--num >= 0)
		{
			object key = buckets[num].key;
			if (key != null && key != _buckets)
			{
				DictionaryEntry dictionaryEntry = new DictionaryEntry(key, buckets[num].val);
				array.SetValue(dictionaryEntry, arrayIndex++);
			}
		}
	}

	public virtual void CopyTo(Array array, int arrayIndex)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array", "Array cannot be null.");
		}
		if (array.Rank != 1)
		{
			throw new ArgumentException("Only single dimensional arrays are supported for the requested action.", "array");
		}
		if (arrayIndex < 0)
		{
			throw new ArgumentOutOfRangeException("arrayIndex", "Non-negative number required.");
		}
		if (array.Length - arrayIndex < Count)
		{
			throw new ArgumentException("Destination array is not long enough to copy all the items in the collection. Check array index and length.");
		}
		CopyEntries(array, arrayIndex);
	}

	private void CopyValues(Array array, int arrayIndex)
	{
		bucket[] buckets = _buckets;
		int num = buckets.Length;
		while (--num >= 0)
		{
			object key = buckets[num].key;
			if (key != null && key != _buckets)
			{
				array.SetValue(buckets[num].val, arrayIndex++);
			}
		}
	}

	private void expand()
	{
		int newsize = HashHelpers.ExpandPrime(_buckets.Length);
		rehash(newsize);
	}

	private void rehash()
	{
		rehash(_buckets.Length);
	}

	private void UpdateVersion()
	{
		_version++;
	}

	private void rehash(int newsize)
	{
		_occupancy = 0;
		bucket[] array = new bucket[newsize];
		for (int i = 0; i < _buckets.Length; i++)
		{
			bucket bucket2 = _buckets[i];
			if (bucket2.key != null && bucket2.key != _buckets)
			{
				int hashcode = bucket2.hash_coll & 0x7FFFFFFF;
				putEntry(array, bucket2.key, bucket2.val, hashcode);
			}
		}
		_isWriterInProgress = true;
		_buckets = array;
		_loadsize = (int)(_loadFactor * (float)newsize);
		UpdateVersion();
		_isWriterInProgress = false;
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return new HashtableEnumerator(this, 3);
	}

	public virtual IDictionaryEnumerator GetEnumerator()
	{
		return new HashtableEnumerator(this, 3);
	}

	protected virtual int GetHash(object key)
	{
		if (_keycomparer != null)
		{
			return _keycomparer.GetHashCode(key);
		}
		return key.GetHashCode();
	}

	protected virtual bool KeyEquals(object item, object key)
	{
		if (_buckets == item)
		{
			return false;
		}
		if (item == key)
		{
			return true;
		}
		if (_keycomparer != null)
		{
			return _keycomparer.Equals(item, key);
		}
		return item?.Equals(key) ?? false;
	}

	private void Insert(object key, object nvalue, bool add)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key", "Key cannot be null.");
		}
		if (_count >= _loadsize)
		{
			expand();
		}
		else if (_occupancy > _loadsize && _count > 100)
		{
			rehash();
		}
		uint num = InitHash(key, _buckets.Length, out var seed, out var incr);
		int num2 = 0;
		int num3 = -1;
		int num4 = (int)(seed % (uint)_buckets.Length);
		do
		{
			if (num3 == -1 && _buckets[num4].key == _buckets && _buckets[num4].hash_coll < 0)
			{
				num3 = num4;
			}
			if (_buckets[num4].key == null || (_buckets[num4].key == _buckets && (_buckets[num4].hash_coll & 0x80000000u) == 0L))
			{
				if (num3 != -1)
				{
					num4 = num3;
				}
				_isWriterInProgress = true;
				_buckets[num4].val = nvalue;
				_buckets[num4].key = key;
				_buckets[num4].hash_coll |= (int)num;
				_count++;
				UpdateVersion();
				_isWriterInProgress = false;
				return;
			}
			if ((_buckets[num4].hash_coll & 0x7FFFFFFF) == num && KeyEquals(_buckets[num4].key, key))
			{
				if (add)
				{
					throw new ArgumentException(SR.Format("Item has already been added. Key in dictionary: '{0}'  Key being added: '{1}'", _buckets[num4].key, key));
				}
				_isWriterInProgress = true;
				_buckets[num4].val = nvalue;
				UpdateVersion();
				_isWriterInProgress = false;
				return;
			}
			if (num3 == -1 && _buckets[num4].hash_coll >= 0)
			{
				_buckets[num4].hash_coll |= int.MinValue;
				_occupancy++;
			}
			num4 = (int)((num4 + incr) % (uint)_buckets.Length);
		}
		while (++num2 < _buckets.Length);
		if (num3 != -1)
		{
			_isWriterInProgress = true;
			_buckets[num3].val = nvalue;
			_buckets[num3].key = key;
			_buckets[num3].hash_coll |= (int)num;
			_count++;
			UpdateVersion();
			_isWriterInProgress = false;
			return;
		}
		throw new InvalidOperationException("Hashtable insert failed. Load factor too high. The most common cause is multiple threads writing to the Hashtable simultaneously.");
	}

	private void putEntry(bucket[] newBuckets, object key, object nvalue, int hashcode)
	{
		uint num = 1 + (uint)(hashcode * 101) % (uint)(newBuckets.Length - 1);
		int num2 = (int)((uint)hashcode % (uint)newBuckets.Length);
		while (newBuckets[num2].key != null && newBuckets[num2].key != _buckets)
		{
			if (newBuckets[num2].hash_coll >= 0)
			{
				newBuckets[num2].hash_coll |= int.MinValue;
				_occupancy++;
			}
			num2 = (int)((num2 + num) % (uint)newBuckets.Length);
		}
		newBuckets[num2].val = nvalue;
		newBuckets[num2].key = key;
		newBuckets[num2].hash_coll |= hashcode;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	public virtual void Remove(object key)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key", "Key cannot be null.");
		}
		uint num = InitHash(key, _buckets.Length, out var seed, out var incr);
		int num2 = 0;
		int num3 = (int)(seed % (uint)_buckets.Length);
		bucket bucket2;
		do
		{
			bucket2 = _buckets[num3];
			if ((bucket2.hash_coll & 0x7FFFFFFF) == num && KeyEquals(bucket2.key, key))
			{
				_isWriterInProgress = true;
				_buckets[num3].hash_coll &= int.MinValue;
				if (_buckets[num3].hash_coll != 0)
				{
					_buckets[num3].key = _buckets;
				}
				else
				{
					_buckets[num3].key = null;
				}
				_buckets[num3].val = null;
				_count--;
				UpdateVersion();
				_isWriterInProgress = false;
				break;
			}
			num3 = (int)((num3 + incr) % (uint)_buckets.Length);
		}
		while (bucket2.hash_coll < 0 && ++num2 < _buckets.Length);
	}

	public static Hashtable Synchronized(Hashtable table)
	{
		if (table == null)
		{
			throw new ArgumentNullException("table");
		}
		return new SyncHashtable(table);
	}

	public virtual void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		lock (SyncRoot)
		{
			int version = _version;
			info.AddValue("LoadFactor", _loadFactor);
			info.AddValue("Version", _version);
			IEqualityComparer keycomparer = _keycomparer;
			if (keycomparer == null)
			{
				info.AddValue("Comparer", null, typeof(IComparer));
				info.AddValue("HashCodeProvider", null, typeof(IHashCodeProvider));
			}
			else if (keycomparer is CompatibleComparer)
			{
				CompatibleComparer compatibleComparer = keycomparer as CompatibleComparer;
				info.AddValue("Comparer", compatibleComparer.Comparer, typeof(IComparer));
				info.AddValue("HashCodeProvider", compatibleComparer.HashCodeProvider, typeof(IHashCodeProvider));
			}
			else
			{
				info.AddValue("KeyComparer", keycomparer, typeof(IEqualityComparer));
			}
			info.AddValue("HashSize", _buckets.Length);
			object[] array = new object[_count];
			object[] array2 = new object[_count];
			CopyKeys(array, 0);
			CopyValues(array2, 0);
			info.AddValue("Keys", array, typeof(object[]));
			info.AddValue("Values", array2, typeof(object[]));
			if (_version != version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
		}
	}

	public virtual void OnDeserialization(object sender)
	{
		if (_buckets != null)
		{
			return;
		}
		SerializationInfoTable.TryGetValue(this, out var value);
		if (value == null)
		{
			throw new SerializationException("OnDeserialization method was called while the object was not being deserialized.");
		}
		int num = 0;
		IComparer comparer = null;
		IHashCodeProvider hashCodeProvider = null;
		object[] array = null;
		object[] array2 = null;
		foreach (string item in value)
		{
			switch (item)
			{
			case "LoadFactor":
				_loadFactor = value.GetSingle("LoadFactor");
				break;
			case "HashSize":
				num = value.GetInt32("HashSize");
				break;
			case "KeyComparer":
				_keycomparer = (IEqualityComparer)value.GetValue("KeyComparer", typeof(IEqualityComparer));
				break;
			case "Comparer":
				comparer = (IComparer)value.GetValue("Comparer", typeof(IComparer));
				break;
			case "HashCodeProvider":
				hashCodeProvider = (IHashCodeProvider)value.GetValue("HashCodeProvider", typeof(IHashCodeProvider));
				break;
			case "Keys":
				array = (object[])value.GetValue("Keys", typeof(object[]));
				break;
			case "Values":
				array2 = (object[])value.GetValue("Values", typeof(object[]));
				break;
			}
		}
		_loadsize = (int)(_loadFactor * (float)num);
		if (_keycomparer == null && (comparer != null || hashCodeProvider != null))
		{
			_keycomparer = new CompatibleComparer(hashCodeProvider, comparer);
		}
		_buckets = new bucket[num];
		if (array == null)
		{
			throw new SerializationException("The keys for this dictionary are missing.");
		}
		if (array2 == null)
		{
			throw new SerializationException("The values for this dictionary are missing.");
		}
		if (array.Length != array2.Length)
		{
			throw new SerializationException("The keys and values arrays have different sizes.");
		}
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i] == null)
			{
				throw new SerializationException("One of the serialized keys is null.");
			}
			Insert(array[i], array2[i], add: true);
		}
		_version = value.GetInt32("Version");
		SerializationInfoTable.Remove(this);
	}
}
