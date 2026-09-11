using System.Globalization;
using System.Reflection;
using System.Runtime.Serialization;
using System.Threading;
using Unity;

namespace System.Collections.Specialized;

[Serializable]
public abstract class NameObjectCollectionBase : ICollection, IEnumerable, ISerializable, IDeserializationCallback
{
	internal class NameObjectEntry
	{
		internal string Key;

		internal object Value;

		internal NameObjectEntry(string name, object value)
		{
			Key = name;
			Value = value;
		}
	}

	[Serializable]
	internal class NameObjectKeysEnumerator : IEnumerator
	{
		private int _pos;

		private NameObjectCollectionBase _coll;

		private int _version;

		public object Current
		{
			get
			{
				if (_pos >= 0 && _pos < _coll.Count)
				{
					return _coll.BaseGetKey(_pos);
				}
				throw new InvalidOperationException(global::SR.GetString("Enumeration has either not started or has already finished."));
			}
		}

		internal NameObjectKeysEnumerator(NameObjectCollectionBase coll)
		{
			_coll = coll;
			_version = _coll._version;
			_pos = -1;
		}

		public bool MoveNext()
		{
			if (_version != _coll._version)
			{
				throw new InvalidOperationException(global::SR.GetString("Collection was modified; enumeration operation may not execute."));
			}
			if (_pos < _coll.Count - 1)
			{
				_pos++;
				return true;
			}
			_pos = _coll.Count;
			return false;
		}

		public void Reset()
		{
			if (_version != _coll._version)
			{
				throw new InvalidOperationException(global::SR.GetString("Collection was modified; enumeration operation may not execute."));
			}
			_pos = -1;
		}
	}

	[Serializable]
	[DefaultMember("Item")]
	public class KeysCollection : ICollection, IEnumerable
	{
		private NameObjectCollectionBase _coll;

		public int Count => _coll.Count;

		object ICollection.SyncRoot => ((ICollection)_coll).SyncRoot;

		bool ICollection.IsSynchronized => false;

		public IEnumerator GetEnumerator()
		{
			return new NameObjectKeysEnumerator(_coll);
		}

		void ICollection.CopyTo(Array array, int index)
		{
			if (array == null)
			{
				throw new ArgumentNullException("array");
			}
			if (array.Rank != 1)
			{
				throw new ArgumentException(global::SR.GetString("Multi dimension array is not supported on this operation."));
			}
			if (index < 0)
			{
				throw new ArgumentOutOfRangeException("index", global::SR.GetString("Index {0} is out of range.", index.ToString(CultureInfo.CurrentCulture)));
			}
			if (array.Length - index < _coll.Count)
			{
				throw new ArgumentException(global::SR.GetString("Insufficient space in the target location to copy the information."));
			}
			IEnumerator enumerator = GetEnumerator();
			while (enumerator.MoveNext())
			{
				array.SetValue(enumerator.Current, index++);
			}
		}

		internal KeysCollection()
		{
			Unity.ThrowStub.ThrowNotSupportedException();
		}
	}

	private const string ReadOnlyName = "ReadOnly";

	private const string CountName = "Count";

	private const string ComparerName = "Comparer";

	private const string HashCodeProviderName = "HashProvider";

	private const string KeysName = "Keys";

	private const string ValuesName = "Values";

	private const string KeyComparerName = "KeyComparer";

	private const string VersionName = "Version";

	private bool _readOnly;

	private ArrayList _entriesArray;

	private IEqualityComparer _keyComparer;

	private volatile Hashtable _entriesTable;

	private volatile NameObjectEntry _nullKeyEntry;

	private KeysCollection _keys;

	private SerializationInfo _serializationInfo;

	private int _version;

	[NonSerialized]
	private object _syncRoot;

	private static StringComparer defaultComparer = StringComparer.InvariantCultureIgnoreCase;

	protected bool IsReadOnly => _readOnly;

	public virtual int Count => _entriesArray.Count;

	object ICollection.SyncRoot
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

	bool ICollection.IsSynchronized => false;

	protected NameObjectCollectionBase()
		: this(defaultComparer)
	{
	}

	protected NameObjectCollectionBase(IEqualityComparer equalityComparer)
	{
		IEqualityComparer keyComparer;
		if (equalityComparer != null)
		{
			keyComparer = equalityComparer;
		}
		else
		{
			IEqualityComparer equalityComparer2 = defaultComparer;
			keyComparer = equalityComparer2;
		}
		_keyComparer = keyComparer;
		Reset();
	}

	protected NameObjectCollectionBase(int capacity, IEqualityComparer equalityComparer)
		: this(equalityComparer)
	{
		Reset(capacity);
	}

	internal NameObjectCollectionBase(DBNull dummy)
	{
	}

	protected NameObjectCollectionBase(SerializationInfo info, StreamingContext context)
	{
		_serializationInfo = info;
	}

	public virtual void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		info.AddValue("ReadOnly", _readOnly);
		if (_keyComparer == defaultComparer)
		{
			info.AddValue("HashProvider", CompatibleComparer.DefaultHashCodeProvider, typeof(IHashCodeProvider));
			info.AddValue("Comparer", CompatibleComparer.DefaultComparer, typeof(IComparer));
		}
		else if (_keyComparer == null)
		{
			info.AddValue("HashProvider", null, typeof(IHashCodeProvider));
			info.AddValue("Comparer", null, typeof(IComparer));
		}
		else if (_keyComparer is CompatibleComparer)
		{
			CompatibleComparer compatibleComparer = (CompatibleComparer)_keyComparer;
			info.AddValue("HashProvider", compatibleComparer.HashCodeProvider, typeof(IHashCodeProvider));
			info.AddValue("Comparer", compatibleComparer.Comparer, typeof(IComparer));
		}
		else
		{
			info.AddValue("KeyComparer", _keyComparer, typeof(IEqualityComparer));
		}
		int count = _entriesArray.Count;
		info.AddValue("Count", count);
		string[] array = new string[count];
		object[] array2 = new object[count];
		for (int i = 0; i < count; i++)
		{
			NameObjectEntry nameObjectEntry = (NameObjectEntry)_entriesArray[i];
			array[i] = nameObjectEntry.Key;
			array2[i] = nameObjectEntry.Value;
		}
		info.AddValue("Keys", array, typeof(string[]));
		info.AddValue("Values", array2, typeof(object[]));
		info.AddValue("Version", _version);
	}

	public virtual void OnDeserialization(object sender)
	{
		if (_keyComparer != null)
		{
			return;
		}
		if (_serializationInfo == null)
		{
			throw new SerializationException();
		}
		SerializationInfo serializationInfo = _serializationInfo;
		_serializationInfo = null;
		bool readOnly = false;
		int num = 0;
		string[] array = null;
		object[] array2 = null;
		IHashCodeProvider hashCodeProvider = null;
		IComparer comparer = null;
		bool flag = false;
		int version = 0;
		foreach (string item in serializationInfo)
		{
			switch (item)
			{
			case "ReadOnly":
				readOnly = serializationInfo.GetBoolean("ReadOnly");
				break;
			case "HashProvider":
				hashCodeProvider = (IHashCodeProvider)serializationInfo.GetValue("HashProvider", typeof(IHashCodeProvider));
				break;
			case "Comparer":
				comparer = (IComparer)serializationInfo.GetValue("Comparer", typeof(IComparer));
				break;
			case "KeyComparer":
				_keyComparer = (IEqualityComparer)serializationInfo.GetValue("KeyComparer", typeof(IEqualityComparer));
				break;
			case "Count":
				num = serializationInfo.GetInt32("Count");
				break;
			case "Keys":
				array = (string[])serializationInfo.GetValue("Keys", typeof(string[]));
				break;
			case "Values":
				array2 = (object[])serializationInfo.GetValue("Values", typeof(object[]));
				break;
			case "Version":
				flag = true;
				version = serializationInfo.GetInt32("Version");
				break;
			}
		}
		if (_keyComparer == null)
		{
			if (comparer == null || hashCodeProvider == null)
			{
				throw new SerializationException();
			}
			_keyComparer = new CompatibleComparer(comparer, hashCodeProvider);
		}
		if (array == null || array2 == null)
		{
			throw new SerializationException();
		}
		Reset(num);
		for (int i = 0; i < num; i++)
		{
			BaseAdd(array[i], array2[i]);
		}
		_readOnly = readOnly;
		if (flag)
		{
			_version = version;
		}
	}

	private void Reset()
	{
		_entriesArray = new ArrayList();
		_entriesTable = new Hashtable(_keyComparer);
		_nullKeyEntry = null;
		_version++;
	}

	private void Reset(int capacity)
	{
		_entriesArray = new ArrayList(capacity);
		_entriesTable = new Hashtable(capacity, _keyComparer);
		_nullKeyEntry = null;
		_version++;
	}

	private NameObjectEntry FindEntry(string key)
	{
		if (key != null)
		{
			return (NameObjectEntry)_entriesTable[key];
		}
		return _nullKeyEntry;
	}

	protected void BaseAdd(string name, object value)
	{
		if (_readOnly)
		{
			throw new NotSupportedException(global::SR.GetString("Collection is read-only."));
		}
		NameObjectEntry nameObjectEntry = new NameObjectEntry(name, value);
		if (name != null)
		{
			if (_entriesTable[name] == null)
			{
				_entriesTable.Add(name, nameObjectEntry);
			}
		}
		else if (_nullKeyEntry == null)
		{
			_nullKeyEntry = nameObjectEntry;
		}
		_entriesArray.Add(nameObjectEntry);
		_version++;
	}

	protected void BaseRemove(string name)
	{
		if (_readOnly)
		{
			throw new NotSupportedException(global::SR.GetString("Collection is read-only."));
		}
		if (name != null)
		{
			_entriesTable.Remove(name);
			for (int num = _entriesArray.Count - 1; num >= 0; num--)
			{
				if (_keyComparer.Equals(name, BaseGetKey(num)))
				{
					_entriesArray.RemoveAt(num);
				}
			}
		}
		else
		{
			_nullKeyEntry = null;
			for (int num2 = _entriesArray.Count - 1; num2 >= 0; num2--)
			{
				if (BaseGetKey(num2) == null)
				{
					_entriesArray.RemoveAt(num2);
				}
			}
		}
		_version++;
	}

	protected object BaseGet(string name)
	{
		return FindEntry(name)?.Value;
	}

	protected void BaseSet(string name, object value)
	{
		if (_readOnly)
		{
			throw new NotSupportedException(global::SR.GetString("Collection is read-only."));
		}
		NameObjectEntry nameObjectEntry = FindEntry(name);
		if (nameObjectEntry != null)
		{
			nameObjectEntry.Value = value;
			_version++;
		}
		else
		{
			BaseAdd(name, value);
		}
	}

	protected object BaseGet(int index)
	{
		return ((NameObjectEntry)_entriesArray[index]).Value;
	}

	protected string BaseGetKey(int index)
	{
		return ((NameObjectEntry)_entriesArray[index]).Key;
	}

	public virtual IEnumerator GetEnumerator()
	{
		return new NameObjectKeysEnumerator(this);
	}

	void ICollection.CopyTo(Array array, int index)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (array.Rank != 1)
		{
			throw new ArgumentException(global::SR.GetString("Multi dimension array is not supported on this operation."));
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", global::SR.GetString("Index {0} is out of range.", index.ToString(CultureInfo.CurrentCulture)));
		}
		if (array.Length - index < _entriesArray.Count)
		{
			throw new ArgumentException(global::SR.GetString("Insufficient space in the target location to copy the information."));
		}
		IEnumerator enumerator = GetEnumerator();
		while (enumerator.MoveNext())
		{
			array.SetValue(enumerator.Current, index++);
		}
	}

	protected string[] BaseGetAllKeys()
	{
		int count = _entriesArray.Count;
		string[] array = new string[count];
		for (int i = 0; i < count; i++)
		{
			array[i] = BaseGetKey(i);
		}
		return array;
	}
}
