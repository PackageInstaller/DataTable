using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Google.Protobuf.Collections;

public sealed class MapField<TKey, TValue> : IDeepCloneable<MapField<TKey, TValue>>, IDictionary<TKey, TValue>, ICollection<KeyValuePair<TKey, TValue>>, IEnumerable<KeyValuePair<TKey, TValue>>, IEnumerable, IEquatable<MapField<TKey, TValue>>, IDictionary, ICollection, IReadOnlyDictionary<TKey, TValue>, IReadOnlyCollection<KeyValuePair<TKey, TValue>>
{
	private class DictionaryEnumerator : IDictionaryEnumerator, IEnumerator
	{
		private readonly IEnumerator<KeyValuePair<TKey, TValue>> enumerator;

		public object Current => Entry;

		public DictionaryEntry Entry => new DictionaryEntry(Key, Value);

		public object Key => enumerator.Current.Key;

		public object Value => enumerator.Current.Value;

		internal DictionaryEnumerator(IEnumerator<KeyValuePair<TKey, TValue>> enumerator)
		{
			this.enumerator = enumerator;
		}

		public bool MoveNext()
		{
			return enumerator.MoveNext();
		}

		public void Reset()
		{
			enumerator.Reset();
		}
	}

	public sealed class Codec
	{
		private readonly FieldCodec<TKey> keyCodec;

		private readonly FieldCodec<TValue> valueCodec;

		private readonly uint mapTag;

		internal FieldCodec<TKey> KeyCodec => keyCodec;

		internal FieldCodec<TValue> ValueCodec => valueCodec;

		internal uint MapTag => mapTag;

		public Codec(FieldCodec<TKey> keyCodec, FieldCodec<TValue> valueCodec, uint mapTag)
		{
			this.keyCodec = keyCodec;
			this.valueCodec = valueCodec;
			this.mapTag = mapTag;
		}
	}

	private class MapView<T> : ICollection<T>, IEnumerable<T>, IEnumerable, ICollection
	{
		private readonly MapField<TKey, TValue> parent;

		private readonly Func<KeyValuePair<TKey, TValue>, T> projection;

		private readonly Func<T, bool> containsCheck;

		public int Count => parent.Count;

		public bool IsReadOnly => true;

		public bool IsSynchronized => false;

		public object SyncRoot => parent;

		internal MapView(MapField<TKey, TValue> parent, Func<KeyValuePair<TKey, TValue>, T> projection, Func<T, bool> containsCheck)
		{
			this.parent = parent;
			this.projection = projection;
			this.containsCheck = containsCheck;
		}

		public void Add(T item)
		{
			throw new NotSupportedException();
		}

		public void Clear()
		{
			throw new NotSupportedException();
		}

		public bool Contains(T item)
		{
			return containsCheck(item);
		}

		public void CopyTo(T[] array, int arrayIndex)
		{
			if (arrayIndex < 0)
			{
				throw new ArgumentOutOfRangeException("arrayIndex");
			}
			if (arrayIndex + Count > array.Length)
			{
				throw new ArgumentException("Not enough space in the array", "array");
			}
			using IEnumerator<T> enumerator = GetEnumerator();
			while (enumerator.MoveNext())
			{
				T current = enumerator.Current;
				array[arrayIndex++] = current;
			}
		}

		public IEnumerator<T> GetEnumerator()
		{
			return parent.list.Select(projection).GetEnumerator();
		}

		public bool Remove(T item)
		{
			throw new NotSupportedException();
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return GetEnumerator();
		}

		public void CopyTo(Array array, int index)
		{
			if (index < 0)
			{
				throw new ArgumentOutOfRangeException("index");
			}
			if (index + Count > array.Length)
			{
				throw new ArgumentException("Not enough space in the array", "array");
			}
			using IEnumerator<T> enumerator = GetEnumerator();
			while (enumerator.MoveNext())
			{
				T current = enumerator.Current;
				array.SetValue(current, index++);
			}
		}
	}

	private static readonly EqualityComparer<TValue> ValueEqualityComparer = ProtobufEqualityComparers.GetEqualityComparer<TValue>();

	private static readonly EqualityComparer<TKey> KeyEqualityComparer = ProtobufEqualityComparers.GetEqualityComparer<TKey>();

	private readonly Dictionary<TKey, LinkedListNode<KeyValuePair<TKey, TValue>>> map = new Dictionary<TKey, LinkedListNode<KeyValuePair<TKey, TValue>>>(KeyEqualityComparer);

	private readonly LinkedList<KeyValuePair<TKey, TValue>> list = new LinkedList<KeyValuePair<TKey, TValue>>();

	public TValue this[TKey key]
	{
		get
		{
			ProtoPreconditions.CheckNotNullUnconstrained(key, "key");
			if (TryGetValue(key, out var value))
			{
				return value;
			}
			throw new KeyNotFoundException();
		}
		set
		{
			ProtoPreconditions.CheckNotNullUnconstrained(key, "key");
			if (value == null)
			{
				ProtoPreconditions.CheckNotNullUnconstrained(value, "value");
			}
			KeyValuePair<TKey, TValue> value2 = new KeyValuePair<TKey, TValue>(key, value);
			if (map.TryGetValue(key, out var value3))
			{
				value3.Value = value2;
				return;
			}
			value3 = list.AddLast(value2);
			map[key] = value3;
		}
	}

	public ICollection<TKey> Keys => new MapView<TKey>(this, (KeyValuePair<TKey, TValue> pair) => pair.Key, ContainsKey);

	public ICollection<TValue> Values => new MapView<TValue>(this, (KeyValuePair<TKey, TValue> pair) => pair.Value, ContainsValue);

	public int Count => list.Count;

	public bool IsReadOnly => false;

	bool IDictionary.IsFixedSize => false;

	ICollection IDictionary.Keys => (ICollection)Keys;

	ICollection IDictionary.Values => (ICollection)Values;

	bool ICollection.IsSynchronized => false;

	object ICollection.SyncRoot => this;

	object IDictionary.this[object key]
	{
		get
		{
			ProtoPreconditions.CheckNotNull(key, "key");
			if (!(key is TKey))
			{
				return null;
			}
			TryGetValue((TKey)key, out var value);
			return value;
		}
		set
		{
			this[(TKey)key] = (TValue)value;
		}
	}

	IEnumerable<TKey> IReadOnlyDictionary<TKey, TValue>.Keys => Keys;

	IEnumerable<TValue> IReadOnlyDictionary<TKey, TValue>.Values => Values;

	public MapField<TKey, TValue> Clone()
	{
		MapField<TKey, TValue> mapField = new MapField<TKey, TValue>();
		if (typeof(IDeepCloneable<TValue>).IsAssignableFrom(typeof(TValue)))
		{
			foreach (KeyValuePair<TKey, TValue> item in list)
			{
				mapField.Add(item.Key, ((IDeepCloneable<TValue>)(object)item.Value).Clone());
			}
		}
		else
		{
			mapField.Add(this);
		}
		return mapField;
	}

	public void Add(TKey key, TValue value)
	{
		if (ContainsKey(key))
		{
			throw new ArgumentException("Key already exists in map", "key");
		}
		this[key] = value;
	}

	public bool ContainsKey(TKey key)
	{
		ProtoPreconditions.CheckNotNullUnconstrained(key, "key");
		return map.ContainsKey(key);
	}

	private bool ContainsValue(TValue value)
	{
		return list.Any((KeyValuePair<TKey, TValue> pair) => ValueEqualityComparer.Equals(pair.Value, value));
	}

	public bool Remove(TKey key)
	{
		ProtoPreconditions.CheckNotNullUnconstrained(key, "key");
		if (map.TryGetValue(key, out var value))
		{
			map.Remove(key);
			value.List.Remove(value);
			return true;
		}
		return false;
	}

	public bool TryGetValue(TKey key, out TValue value)
	{
		if (map.TryGetValue(key, out var value2))
		{
			value = value2.Value.Value;
			return true;
		}
		value = default;
		return false;
	}

	public void Add(IDictionary<TKey, TValue> entries)
	{
		ProtoPreconditions.CheckNotNull(entries, "entries");
		foreach (KeyValuePair<TKey, TValue> entry in entries)
		{
			Add(entry.Key, entry.Value);
		}
	}

	public IEnumerator<KeyValuePair<TKey, TValue>> GetEnumerator()
	{
		return list.GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	void ICollection<KeyValuePair<TKey, TValue>>.Add(KeyValuePair<TKey, TValue> item)
	{
		Add(item.Key, item.Value);
	}

	public void Clear()
	{
		list.Clear();
		map.Clear();
	}

	bool ICollection<KeyValuePair<TKey, TValue>>.Contains(KeyValuePair<TKey, TValue> item)
	{
		if (TryGetValue(item.Key, out var value))
		{
			return ValueEqualityComparer.Equals(item.Value, value);
		}
		return false;
	}

	void ICollection<KeyValuePair<TKey, TValue>>.CopyTo(KeyValuePair<TKey, TValue>[] array, int arrayIndex)
	{
		list.CopyTo(array, arrayIndex);
	}

	bool ICollection<KeyValuePair<TKey, TValue>>.Remove(KeyValuePair<TKey, TValue> item)
	{
		if (item.Key == null)
		{
			throw new ArgumentException("Key is null", "item");
		}
		if (map.TryGetValue(item.Key, out var value) && EqualityComparer<TValue>.Default.Equals(item.Value, value.Value.Value))
		{
			map.Remove(item.Key);
			value.List.Remove(value);
			return true;
		}
		return false;
	}

	public override bool Equals(object other)
	{
		return Equals(other as MapField<TKey, TValue>);
	}

	public override int GetHashCode()
	{
		EqualityComparer<TKey> keyEqualityComparer = KeyEqualityComparer;
		EqualityComparer<TValue> valueEqualityComparer = ValueEqualityComparer;
		int num = 0;
		foreach (KeyValuePair<TKey, TValue> item in list)
		{
			num ^= keyEqualityComparer.GetHashCode(item.Key) * 31 + valueEqualityComparer.GetHashCode(item.Value);
		}
		return num;
	}

	public bool Equals(MapField<TKey, TValue> other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (other.Count != Count)
		{
			return false;
		}
		EqualityComparer<TValue> valueEqualityComparer = ValueEqualityComparer;
		using (IEnumerator<KeyValuePair<TKey, TValue>> enumerator = GetEnumerator())
		{
			while (enumerator.MoveNext())
			{
				KeyValuePair<TKey, TValue> current = enumerator.Current;
				if (!other.TryGetValue(current.Key, out var value))
				{
					return false;
				}
				if (!valueEqualityComparer.Equals(value, current.Value))
				{
					return false;
				}
			}
		}
		return true;
	}

	public void AddEntriesFrom(CodedInputStream input, Codec codec)
	{
		ParseContext.Initialize(input, out var ctx);
		try
		{
			AddEntriesFrom(ref ctx, codec);
		}
		finally
		{
			ctx.CopyStateTo(input);
		}
	}

	public void AddEntriesFrom(ref ParseContext ctx, Codec codec)
	{
		do
		{
			KeyValuePair<TKey, TValue> keyValuePair = ParsingPrimitivesMessages.ReadMapEntry(ref ctx, codec);
			this[keyValuePair.Key] = keyValuePair.Value;
		}
		while (ParsingPrimitives.MaybeConsumeTag(ref ctx.buffer, ref ctx.state, codec.MapTag));
	}

	public void WriteTo(CodedOutputStream output, Codec codec)
	{
		WriteContext.Initialize(output, out var ctx);
		try
		{
			WriteTo(ref ctx, codec);
		}
		finally
		{
			ctx.CopyStateTo(output);
		}
	}

	public void WriteTo(ref WriteContext ctx, Codec codec)
	{
		foreach (KeyValuePair<TKey, TValue> item in list)
		{
			ctx.WriteTag(codec.MapTag);
			WritingPrimitives.WriteLength(ref ctx.buffer, ref ctx.state, CalculateEntrySize(codec, item));
			codec.KeyCodec.WriteTagAndValue(ref ctx, item.Key);
			codec.ValueCodec.WriteTagAndValue(ref ctx, item.Value);
		}
	}

	public int CalculateSize(Codec codec)
	{
		if (Count == 0)
		{
			return 0;
		}
		int num = 0;
		foreach (KeyValuePair<TKey, TValue> item in list)
		{
			int num2 = CalculateEntrySize(codec, item);
			num += CodedOutputStream.ComputeRawVarint32Size(codec.MapTag);
			num += CodedOutputStream.ComputeLengthSize(num2) + num2;
		}
		return num;
	}

	private static int CalculateEntrySize(Codec codec, KeyValuePair<TKey, TValue> entry)
	{
		return codec.KeyCodec.CalculateSizeWithTag(entry.Key) + codec.ValueCodec.CalculateSizeWithTag(entry.Value);
	}

	public override string ToString()
	{
		StringWriter stringWriter = new StringWriter();
		JsonFormatter.Default.WriteDictionary(stringWriter, this);
		return stringWriter.ToString();
	}

	void IDictionary.Add(object key, object value)
	{
		Add((TKey)key, (TValue)value);
	}

	bool IDictionary.Contains(object key)
	{
		if (!(key is TKey))
		{
			return false;
		}
		return ContainsKey((TKey)key);
	}

	IDictionaryEnumerator IDictionary.GetEnumerator()
	{
		return new DictionaryEnumerator(GetEnumerator());
	}

	void IDictionary.Remove(object key)
	{
		ProtoPreconditions.CheckNotNull(key, "key");
		if (key is TKey)
		{
			Remove((TKey)key);
		}
	}

	void ICollection.CopyTo(Array array, int index)
	{
		((ICollection)this.Select((KeyValuePair<TKey, TValue> pair) => new DictionaryEntry(pair.Key, pair.Value)).ToList()).CopyTo(array, index);
	}
}
