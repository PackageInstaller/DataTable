using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.Serialization;

namespace System.Collections.Generic;

[Serializable]
[DebuggerTypeProxy(typeof(System.Collections.Generic.ICollectionDebugView<>))]
[DebuggerDisplay("Count = {Count}")]
public class HashSet<T> : ICollection<T>, IEnumerable<T>, IEnumerable, ISet<T>, IReadOnlyCollection<T>, ISerializable, IDeserializationCallback
{
	internal struct ElementCount
	{
		internal int uniqueCount;

		internal int unfoundCount;
	}

	internal struct Slot
	{
		internal int hashCode;

		internal int next;

		internal T value;
	}

	[Serializable]
	public struct Enumerator : IEnumerator<T>, IDisposable, IEnumerator
	{
		private HashSet<T> _set;

		private int _index;

		private int _version;

		private T _current;

		public T Current => _current;

		object IEnumerator.Current
		{
			get
			{
				if (_index == 0 || _index == _set._lastIndex + 1)
				{
					throw new InvalidOperationException("Enumeration has either not started or has already finished.");
				}
				return Current;
			}
		}

		internal Enumerator(HashSet<T> set)
		{
			_set = set;
			_index = 0;
			_version = set._version;
			_current = default(T);
		}

		public void Dispose()
		{
		}

		public bool MoveNext()
		{
			if (_version != _set._version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			while (_index < _set._lastIndex)
			{
				if (_set._slots[_index].hashCode >= 0)
				{
					_current = _set._slots[_index].value;
					_index++;
					return true;
				}
				_index++;
			}
			_index = _set._lastIndex + 1;
			_current = default(T);
			return false;
		}

		void IEnumerator.Reset()
		{
			if (_version != _set._version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			_index = 0;
			_current = default(T);
		}
	}

	private const int Lower31BitMask = int.MaxValue;

	private const int StackAllocThreshold = 100;

	private const int ShrinkThreshold = 3;

	private const string CapacityName = "Capacity";

	private const string ElementsName = "Elements";

	private const string ComparerName = "Comparer";

	private const string VersionName = "Version";

	private int[] _buckets;

	private Slot[] _slots;

	private int _count;

	private int _lastIndex;

	private int _freeList;

	private IEqualityComparer<T> _comparer;

	private int _version;

	private SerializationInfo _siInfo;

	public int Count => _count;

	bool ICollection<T>.IsReadOnly => false;

	public IEqualityComparer<T> Comparer => _comparer;

	public HashSet()
		: this((IEqualityComparer<T>)EqualityComparer<T>.Default)
	{
	}

	public HashSet(IEqualityComparer<T> comparer)
	{
		if (comparer == null)
		{
			comparer = EqualityComparer<T>.Default;
		}
		_comparer = comparer;
		_lastIndex = 0;
		_count = 0;
		_freeList = -1;
		_version = 0;
	}

	public HashSet(int capacity)
		: this(capacity, (IEqualityComparer<T>)EqualityComparer<T>.Default)
	{
	}

	public HashSet(IEnumerable<T> collection)
		: this(collection, (IEqualityComparer<T>)EqualityComparer<T>.Default)
	{
	}

	public HashSet(IEnumerable<T> collection, IEqualityComparer<T> comparer)
		: this(comparer)
	{
		if (collection == null)
		{
			throw new ArgumentNullException("collection");
		}
		if (collection is HashSet<T> hashSet && AreEqualityComparersEqual(this, hashSet))
		{
			CopyFrom(hashSet);
			return;
		}
		Initialize((collection is ICollection<T> collection2) ? collection2.Count : 0);
		UnionWith(collection);
		if (_count > 0 && _slots.Length / _count > 3)
		{
			TrimExcess();
		}
	}

	protected HashSet(SerializationInfo info, StreamingContext context)
	{
		_siInfo = info;
	}

	private void CopyFrom(HashSet<T> source)
	{
		int count = source._count;
		if (count == 0)
		{
			return;
		}
		int num = source._buckets.Length;
		if (HashHelpers.ExpandPrime(count + 1) >= num)
		{
			_buckets = (int[])source._buckets.Clone();
			_slots = (Slot[])source._slots.Clone();
			_lastIndex = source._lastIndex;
			_freeList = source._freeList;
		}
		else
		{
			int lastIndex = source._lastIndex;
			Slot[] slots = source._slots;
			Initialize(count);
			int num2 = 0;
			for (int i = 0; i < lastIndex; i++)
			{
				int hashCode = slots[i].hashCode;
				if (hashCode >= 0)
				{
					AddValue(num2, hashCode, slots[i].value);
					num2++;
				}
			}
			_lastIndex = num2;
		}
		_count = count;
	}

	public HashSet(int capacity, IEqualityComparer<T> comparer)
		: this(comparer)
	{
		if (capacity < 0)
		{
			throw new ArgumentOutOfRangeException("capacity");
		}
		if (capacity > 0)
		{
			Initialize(capacity);
		}
	}

	void ICollection<T>.Add(T item)
	{
		AddIfNotPresent(item);
	}

	public void Clear()
	{
		if (_lastIndex > 0)
		{
			Array.Clear(_slots, 0, _lastIndex);
			Array.Clear(_buckets, 0, _buckets.Length);
			_lastIndex = 0;
			_count = 0;
			_freeList = -1;
		}
		_version++;
	}

	public bool Contains(T item)
	{
		if (_buckets != null)
		{
			int num = 0;
			int num2 = InternalGetHashCode(item);
			Slot[] slots = _slots;
			for (int num3 = _buckets[num2 % _buckets.Length] - 1; num3 >= 0; num3 = slots[num3].next)
			{
				if (slots[num3].hashCode == num2 && _comparer.Equals(slots[num3].value, item))
				{
					return true;
				}
				if (num >= slots.Length)
				{
					throw new InvalidOperationException("Operations that change non-concurrent collections must have exclusive access. A concurrent update was performed on this collection and corrupted its state. The collection's state is no longer correct.");
				}
				num++;
			}
		}
		return false;
	}

	public void CopyTo(T[] array, int arrayIndex)
	{
		CopyTo(array, arrayIndex, _count);
	}

	public bool Remove(T item)
	{
		if (_buckets != null)
		{
			int num = InternalGetHashCode(item);
			int num2 = num % _buckets.Length;
			int num3 = -1;
			int num4 = 0;
			Slot[] slots = _slots;
			for (int num5 = _buckets[num2] - 1; num5 >= 0; num5 = slots[num5].next)
			{
				if (slots[num5].hashCode == num && _comparer.Equals(slots[num5].value, item))
				{
					if (num3 < 0)
					{
						_buckets[num2] = slots[num5].next + 1;
					}
					else
					{
						slots[num3].next = slots[num5].next;
					}
					slots[num5].hashCode = -1;
					if (RuntimeHelpers.IsReferenceOrContainsReferences<T>())
					{
						slots[num5].value = default(T);
					}
					slots[num5].next = _freeList;
					_count--;
					_version++;
					if (_count == 0)
					{
						_lastIndex = 0;
						_freeList = -1;
					}
					else
					{
						_freeList = num5;
					}
					return true;
				}
				if (num4 >= slots.Length)
				{
					throw new InvalidOperationException("Operations that change non-concurrent collections must have exclusive access. A concurrent update was performed on this collection and corrupted its state. The collection's state is no longer correct.");
				}
				num4++;
				num3 = num5;
			}
		}
		return false;
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

	public virtual void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		info.AddValue("Version", _version);
		info.AddValue("Comparer", _comparer, typeof(IComparer<T>));
		info.AddValue("Capacity", (_buckets != null) ? _buckets.Length : 0);
		if (_buckets != null)
		{
			T[] array = new T[_count];
			CopyTo(array);
			info.AddValue("Elements", array, typeof(T[]));
		}
	}

	public virtual void OnDeserialization(object sender)
	{
		if (_siInfo == null)
		{
			return;
		}
		int @int = _siInfo.GetInt32("Capacity");
		_comparer = (IEqualityComparer<T>)_siInfo.GetValue("Comparer", typeof(IEqualityComparer<T>));
		_freeList = -1;
		if (@int != 0)
		{
			_buckets = new int[@int];
			_slots = new Slot[@int];
			T[] array = (T[])_siInfo.GetValue("Elements", typeof(T[]));
			if (array == null)
			{
				throw new SerializationException("The keys for this dictionary are missing.");
			}
			for (int i = 0; i < array.Length; i++)
			{
				AddIfNotPresent(array[i]);
			}
		}
		else
		{
			_buckets = null;
		}
		_version = _siInfo.GetInt32("Version");
		_siInfo = null;
	}

	public bool Add(T item)
	{
		return AddIfNotPresent(item);
	}

	public bool TryGetValue(T equalValue, out T actualValue)
	{
		if (_buckets != null)
		{
			int num = InternalIndexOf(equalValue);
			if (num >= 0)
			{
				actualValue = _slots[num].value;
				return true;
			}
		}
		actualValue = default(T);
		return false;
	}

	public void UnionWith(IEnumerable<T> other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		foreach (T item in other)
		{
			AddIfNotPresent(item);
		}
	}

	public void IntersectWith(IEnumerable<T> other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		if (_count == 0 || other == this)
		{
			return;
		}
		if (other is ICollection<T> collection)
		{
			if (collection.Count == 0)
			{
				Clear();
				return;
			}
			if (other is HashSet<T> hashSet && AreEqualityComparersEqual(this, hashSet))
			{
				IntersectWithHashSetWithSameEC(hashSet);
				return;
			}
		}
		IntersectWithEnumerable(other);
	}

	public void ExceptWith(IEnumerable<T> other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		if (_count == 0)
		{
			return;
		}
		if (other == this)
		{
			Clear();
			return;
		}
		foreach (T item in other)
		{
			Remove(item);
		}
	}

	public void SymmetricExceptWith(IEnumerable<T> other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		if (_count == 0)
		{
			UnionWith(other);
		}
		else if (other == this)
		{
			Clear();
		}
		else if (other is HashSet<T> hashSet && AreEqualityComparersEqual(this, hashSet))
		{
			SymmetricExceptWithUniqueHashSet(hashSet);
		}
		else
		{
			SymmetricExceptWithEnumerable(other);
		}
	}

	public bool IsSubsetOf(IEnumerable<T> other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		if (_count == 0)
		{
			return true;
		}
		if (other == this)
		{
			return true;
		}
		if (other is HashSet<T> hashSet && AreEqualityComparersEqual(this, hashSet))
		{
			if (_count > hashSet.Count)
			{
				return false;
			}
			return IsSubsetOfHashSetWithSameEC(hashSet);
		}
		ElementCount elementCount = CheckUniqueAndUnfoundElements(other, returnIfUnfound: false);
		if (elementCount.uniqueCount == _count)
		{
			return elementCount.unfoundCount >= 0;
		}
		return false;
	}

	public bool IsProperSubsetOf(IEnumerable<T> other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		if (other == this)
		{
			return false;
		}
		if (other is ICollection<T> collection)
		{
			if (collection.Count == 0)
			{
				return false;
			}
			if (_count == 0)
			{
				return collection.Count > 0;
			}
			if (other is HashSet<T> hashSet && AreEqualityComparersEqual(this, hashSet))
			{
				if (_count >= hashSet.Count)
				{
					return false;
				}
				return IsSubsetOfHashSetWithSameEC(hashSet);
			}
		}
		ElementCount elementCount = CheckUniqueAndUnfoundElements(other, returnIfUnfound: false);
		if (elementCount.uniqueCount == _count)
		{
			return elementCount.unfoundCount > 0;
		}
		return false;
	}

	public bool IsSupersetOf(IEnumerable<T> other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		if (other == this)
		{
			return true;
		}
		if (other is ICollection<T> collection)
		{
			if (collection.Count == 0)
			{
				return true;
			}
			if (other is HashSet<T> hashSet && AreEqualityComparersEqual(this, hashSet) && hashSet.Count > _count)
			{
				return false;
			}
		}
		return ContainsAllElements(other);
	}

	public bool IsProperSupersetOf(IEnumerable<T> other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		if (_count == 0)
		{
			return false;
		}
		if (other == this)
		{
			return false;
		}
		if (other is ICollection<T> collection)
		{
			if (collection.Count == 0)
			{
				return true;
			}
			if (other is HashSet<T> hashSet && AreEqualityComparersEqual(this, hashSet))
			{
				if (hashSet.Count >= _count)
				{
					return false;
				}
				return ContainsAllElements(hashSet);
			}
		}
		ElementCount elementCount = CheckUniqueAndUnfoundElements(other, returnIfUnfound: true);
		if (elementCount.uniqueCount < _count)
		{
			return elementCount.unfoundCount == 0;
		}
		return false;
	}

	public bool Overlaps(IEnumerable<T> other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		if (_count == 0)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		foreach (T item in other)
		{
			if (Contains(item))
			{
				return true;
			}
		}
		return false;
	}

	public bool SetEquals(IEnumerable<T> other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		if (other == this)
		{
			return true;
		}
		if (other is HashSet<T> hashSet && AreEqualityComparersEqual(this, hashSet))
		{
			if (_count != hashSet.Count)
			{
				return false;
			}
			return ContainsAllElements(hashSet);
		}
		if (other is ICollection<T> collection && _count == 0 && collection.Count > 0)
		{
			return false;
		}
		ElementCount elementCount = CheckUniqueAndUnfoundElements(other, returnIfUnfound: true);
		if (elementCount.uniqueCount == _count)
		{
			return elementCount.unfoundCount == 0;
		}
		return false;
	}

	public void CopyTo(T[] array)
	{
		CopyTo(array, 0, _count);
	}

	public void CopyTo(T[] array, int arrayIndex, int count)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (arrayIndex < 0)
		{
			throw new ArgumentOutOfRangeException("arrayIndex", arrayIndex, "Non negative number is required.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", count, "Non negative number is required.");
		}
		if (arrayIndex > array.Length || count > array.Length - arrayIndex)
		{
			throw new ArgumentException("Destination array is not long enough to copy all the items in the collection. Check array index and length.");
		}
		int num = 0;
		for (int i = 0; i < _lastIndex; i++)
		{
			if (num >= count)
			{
				break;
			}
			if (_slots[i].hashCode >= 0)
			{
				array[arrayIndex + num] = _slots[i].value;
				num++;
			}
		}
	}

	public int RemoveWhere(Predicate<T> match)
	{
		if (match == null)
		{
			throw new ArgumentNullException("match");
		}
		int num = 0;
		for (int i = 0; i < _lastIndex; i++)
		{
			if (_slots[i].hashCode >= 0)
			{
				T value = _slots[i].value;
				if (match(value) && Remove(value))
				{
					num++;
				}
			}
		}
		return num;
	}

	public int EnsureCapacity(int capacity)
	{
		if (capacity < 0)
		{
			throw new ArgumentOutOfRangeException("capacity");
		}
		int num = ((_slots != null) ? _slots.Length : 0);
		if (num >= capacity)
		{
			return num;
		}
		if (_buckets == null)
		{
			return Initialize(capacity);
		}
		int prime = HashHelpers.GetPrime(capacity);
		SetCapacity(prime);
		return prime;
	}

	public void TrimExcess()
	{
		if (_count == 0)
		{
			_buckets = null;
			_slots = null;
			_version++;
			return;
		}
		int prime = HashHelpers.GetPrime(_count);
		Slot[] array = new Slot[prime];
		int[] array2 = new int[prime];
		int num = 0;
		for (int i = 0; i < _lastIndex; i++)
		{
			if (_slots[i].hashCode >= 0)
			{
				array[num] = _slots[i];
				int num2 = array[num].hashCode % prime;
				array[num].next = array2[num2] - 1;
				array2[num2] = num + 1;
				num++;
			}
		}
		_lastIndex = num;
		_slots = array;
		_buckets = array2;
		_freeList = -1;
	}

	public static IEqualityComparer<HashSet<T>> CreateSetComparer()
	{
		return new HashSetEqualityComparer<T>();
	}

	private int Initialize(int capacity)
	{
		int prime = HashHelpers.GetPrime(capacity);
		_buckets = new int[prime];
		_slots = new Slot[prime];
		return prime;
	}

	private void IncreaseCapacity()
	{
		int num = HashHelpers.ExpandPrime(_count);
		if (num <= _count)
		{
			throw new ArgumentException("HashSet capacity is too big.");
		}
		SetCapacity(num);
	}

	private void SetCapacity(int newSize)
	{
		Slot[] array = new Slot[newSize];
		if (_slots != null)
		{
			Array.Copy(_slots, 0, array, 0, _lastIndex);
		}
		int[] array2 = new int[newSize];
		for (int i = 0; i < _lastIndex; i++)
		{
			int num = array[i].hashCode % newSize;
			array[i].next = array2[num] - 1;
			array2[num] = i + 1;
		}
		_slots = array;
		_buckets = array2;
	}

	private bool AddIfNotPresent(T value)
	{
		if (_buckets == null)
		{
			Initialize(0);
		}
		int num = InternalGetHashCode(value);
		int num2 = num % _buckets.Length;
		int num3 = 0;
		Slot[] slots = _slots;
		for (int num4 = _buckets[num2] - 1; num4 >= 0; num4 = slots[num4].next)
		{
			if (slots[num4].hashCode == num && _comparer.Equals(slots[num4].value, value))
			{
				return false;
			}
			if (num3 >= slots.Length)
			{
				throw new InvalidOperationException("Operations that change non-concurrent collections must have exclusive access. A concurrent update was performed on this collection and corrupted its state. The collection's state is no longer correct.");
			}
			num3++;
		}
		int num5;
		if (_freeList >= 0)
		{
			num5 = _freeList;
			_freeList = slots[num5].next;
		}
		else
		{
			if (_lastIndex == slots.Length)
			{
				IncreaseCapacity();
				slots = _slots;
				num2 = num % _buckets.Length;
			}
			num5 = _lastIndex;
			_lastIndex++;
		}
		slots[num5].hashCode = num;
		slots[num5].value = value;
		slots[num5].next = _buckets[num2] - 1;
		_buckets[num2] = num5 + 1;
		_count++;
		_version++;
		return true;
	}

	private void AddValue(int index, int hashCode, T value)
	{
		int num = hashCode % _buckets.Length;
		_slots[index].hashCode = hashCode;
		_slots[index].value = value;
		_slots[index].next = _buckets[num] - 1;
		_buckets[num] = index + 1;
	}

	private bool ContainsAllElements(IEnumerable<T> other)
	{
		foreach (T item in other)
		{
			if (!Contains(item))
			{
				return false;
			}
		}
		return true;
	}

	private bool IsSubsetOfHashSetWithSameEC(HashSet<T> other)
	{
		using (Enumerator enumerator = GetEnumerator())
		{
			while (enumerator.MoveNext())
			{
				T current = enumerator.Current;
				if (!other.Contains(current))
				{
					return false;
				}
			}
		}
		return true;
	}

	private void IntersectWithHashSetWithSameEC(HashSet<T> other)
	{
		for (int i = 0; i < _lastIndex; i++)
		{
			if (_slots[i].hashCode >= 0)
			{
				T value = _slots[i].value;
				if (!other.Contains(value))
				{
					Remove(value);
				}
			}
		}
	}

	private unsafe void IntersectWithEnumerable(IEnumerable<T> other)
	{
		int lastIndex = _lastIndex;
		int num = System.Collections.Generic.BitHelper.ToIntArrayLength(lastIndex);
		System.Collections.Generic.BitHelper bitHelper = ((num > 100) ? new System.Collections.Generic.BitHelper(new int[num], num) : new System.Collections.Generic.BitHelper(stackalloc int[num], num));
		foreach (T item in other)
		{
			int num2 = InternalIndexOf(item);
			if (num2 >= 0)
			{
				bitHelper.MarkBit(num2);
			}
		}
		for (int i = 0; i < lastIndex; i++)
		{
			if (_slots[i].hashCode >= 0 && !bitHelper.IsMarked(i))
			{
				Remove(_slots[i].value);
			}
		}
	}

	private int InternalIndexOf(T item)
	{
		int num = 0;
		int num2 = InternalGetHashCode(item);
		Slot[] slots = _slots;
		for (int num3 = _buckets[num2 % _buckets.Length] - 1; num3 >= 0; num3 = slots[num3].next)
		{
			if (slots[num3].hashCode == num2 && _comparer.Equals(slots[num3].value, item))
			{
				return num3;
			}
			if (num >= slots.Length)
			{
				throw new InvalidOperationException("Operations that change non-concurrent collections must have exclusive access. A concurrent update was performed on this collection and corrupted its state. The collection's state is no longer correct.");
			}
			num++;
		}
		return -1;
	}

	private void SymmetricExceptWithUniqueHashSet(HashSet<T> other)
	{
		foreach (T item in other)
		{
			if (!Remove(item))
			{
				AddIfNotPresent(item);
			}
		}
	}

	private unsafe void SymmetricExceptWithEnumerable(IEnumerable<T> other)
	{
		int lastIndex = _lastIndex;
		int num = System.Collections.Generic.BitHelper.ToIntArrayLength(lastIndex);
		System.Collections.Generic.BitHelper bitHelper;
		System.Collections.Generic.BitHelper bitHelper2;
		if (num <= 50)
		{
			bitHelper = new System.Collections.Generic.BitHelper(stackalloc int[num], num);
			bitHelper2 = new System.Collections.Generic.BitHelper(stackalloc int[num], num);
		}
		else
		{
			bitHelper = new System.Collections.Generic.BitHelper(new int[num], num);
			bitHelper2 = new System.Collections.Generic.BitHelper(new int[num], num);
		}
		foreach (T item in other)
		{
			int location = 0;
			if (AddOrGetLocation(item, out location))
			{
				bitHelper2.MarkBit(location);
			}
			else if (location < lastIndex && !bitHelper2.IsMarked(location))
			{
				bitHelper.MarkBit(location);
			}
		}
		for (int i = 0; i < lastIndex; i++)
		{
			if (bitHelper.IsMarked(i))
			{
				Remove(_slots[i].value);
			}
		}
	}

	private bool AddOrGetLocation(T value, out int location)
	{
		int num = InternalGetHashCode(value);
		int num2 = num % _buckets.Length;
		int num3 = 0;
		Slot[] slots = _slots;
		for (int num4 = _buckets[num2] - 1; num4 >= 0; num4 = slots[num4].next)
		{
			if (slots[num4].hashCode == num && _comparer.Equals(slots[num4].value, value))
			{
				location = num4;
				return false;
			}
			if (num3 >= slots.Length)
			{
				throw new InvalidOperationException("Operations that change non-concurrent collections must have exclusive access. A concurrent update was performed on this collection and corrupted its state. The collection's state is no longer correct.");
			}
			num3++;
		}
		int num5;
		if (_freeList >= 0)
		{
			num5 = _freeList;
			_freeList = slots[num5].next;
		}
		else
		{
			if (_lastIndex == slots.Length)
			{
				IncreaseCapacity();
				slots = _slots;
				num2 = num % _buckets.Length;
			}
			num5 = _lastIndex;
			_lastIndex++;
		}
		slots[num5].hashCode = num;
		slots[num5].value = value;
		slots[num5].next = _buckets[num2] - 1;
		_buckets[num2] = num5 + 1;
		_count++;
		_version++;
		location = num5;
		return true;
	}

	private unsafe ElementCount CheckUniqueAndUnfoundElements(IEnumerable<T> other, bool returnIfUnfound)
	{
		ElementCount result = default(ElementCount);
		if (_count == 0)
		{
			int num = 0;
			using (IEnumerator<T> enumerator = other.GetEnumerator())
			{
				if (enumerator.MoveNext())
				{
					_ = enumerator.Current;
					num++;
				}
			}
			result.uniqueCount = 0;
			result.unfoundCount = num;
			return result;
		}
		int num2 = System.Collections.Generic.BitHelper.ToIntArrayLength(_lastIndex);
		System.Collections.Generic.BitHelper bitHelper = ((num2 > 100) ? new System.Collections.Generic.BitHelper(new int[num2], num2) : new System.Collections.Generic.BitHelper(stackalloc int[num2], num2));
		int num3 = 0;
		int num4 = 0;
		foreach (T item in other)
		{
			int num5 = InternalIndexOf(item);
			if (num5 >= 0)
			{
				if (!bitHelper.IsMarked(num5))
				{
					bitHelper.MarkBit(num5);
					num4++;
				}
			}
			else
			{
				num3++;
				if (returnIfUnfound)
				{
					break;
				}
			}
		}
		result.uniqueCount = num4;
		result.unfoundCount = num3;
		return result;
	}

	internal static bool HashSetEquals(HashSet<T> set1, HashSet<T> set2, IEqualityComparer<T> comparer)
	{
		if (set1 == null)
		{
			return set2 == null;
		}
		if (set2 == null)
		{
			return false;
		}
		if (AreEqualityComparersEqual(set1, set2))
		{
			if (set1.Count != set2.Count)
			{
				return false;
			}
			foreach (T item in set2)
			{
				if (!set1.Contains(item))
				{
					return false;
				}
			}
			return true;
		}
		foreach (T item2 in set2)
		{
			bool flag = false;
			foreach (T item3 in set1)
			{
				if (comparer.Equals(item2, item3))
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				return false;
			}
		}
		return true;
	}

	private static bool AreEqualityComparersEqual(HashSet<T> set1, HashSet<T> set2)
	{
		return set1.Comparer.Equals(set2.Comparer);
	}

	private int InternalGetHashCode(T item)
	{
		if (item == null)
		{
			return 0;
		}
		return _comparer.GetHashCode(item) & 0x7FFFFFFF;
	}
}
