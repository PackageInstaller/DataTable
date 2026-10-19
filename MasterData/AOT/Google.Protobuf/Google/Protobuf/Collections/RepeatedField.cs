using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;

namespace Google.Protobuf.Collections;

public sealed class RepeatedField<T> : IList<T>, ICollection<T>, IEnumerable<T>, IEnumerable, IList, ICollection, IDeepCloneable<RepeatedField<T>>, IEquatable<RepeatedField<T>>, IReadOnlyList<T>, IReadOnlyCollection<T>
{
	private static readonly EqualityComparer<T> EqualityComparer = ProtobufEqualityComparers.GetEqualityComparer<T>();

	private static readonly T[] EmptyArray = new T[0];

	private const int MinArraySize = 8;

	private T[] array = EmptyArray;

	private int count;

	public int Capacity
	{
		get
		{
			return array.Length;
		}
		set
		{
			if (value < count)
			{
				throw new ArgumentOutOfRangeException("Capacity", value, $"Cannot set Capacity to a value smaller than the current item count, {count}");
			}
			if (value >= 0 && value != array.Length)
			{
				SetSize(value);
			}
		}
	}

	public int Count => count;

	public bool IsReadOnly => false;

	public T this[int index]
	{
		get
		{
			if (index < 0 || index >= count)
			{
				throw new ArgumentOutOfRangeException("index");
			}
			return array[index];
		}
		set
		{
			if (index < 0 || index >= count)
			{
				throw new ArgumentOutOfRangeException("index");
			}
			ProtoPreconditions.CheckNotNullUnconstrained(value, "value");
			array[index] = value;
		}
	}

	bool IList.IsFixedSize => false;

	bool ICollection.IsSynchronized => false;

	object ICollection.SyncRoot => this;

	object IList.this[int index]
	{
		get
		{
			return this[index];
		}
		set
		{
			this[index] = (T)value;
		}
	}

	public RepeatedField<T> Clone()
	{
		RepeatedField<T> repeatedField = new RepeatedField<T>();
		if (this.array != EmptyArray)
		{
			repeatedField.array = (T[])this.array.Clone();
			if (repeatedField.array is IDeepCloneable<T>[] array)
			{
				for (int i = 0; i < count; i++)
				{
					repeatedField.array[i] = array[i].Clone();
				}
			}
		}
		repeatedField.count = count;
		return repeatedField;
	}

	public void AddEntriesFrom(CodedInputStream input, FieldCodec<T> codec)
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

	public void AddEntriesFrom(ref ParseContext ctx, FieldCodec<T> codec)
	{
		uint lastTag = ctx.state.lastTag;
		ValueReader<T> valueReader = codec.ValueReader;
		if (FieldCodec<T>.IsPackedRepeatedField(lastTag))
		{
			int num = ctx.ReadLength();
			if (num <= 0)
			{
				return;
			}
			int oldLimit = SegmentedBufferHelper.PushLimit(ref ctx.state, num);
			if (codec.FixedSize > 0 && num % codec.FixedSize == 0 && ParsingPrimitives.IsDataAvailable(ref ctx.state, num))
			{
				EnsureSize(count + num / codec.FixedSize);
				while (!SegmentedBufferHelper.IsReachedLimit(ref ctx.state))
				{
					array[count++] = valueReader(ref ctx);
				}
			}
			else
			{
				while (!SegmentedBufferHelper.IsReachedLimit(ref ctx.state))
				{
					Add(valueReader(ref ctx));
				}
			}
			SegmentedBufferHelper.PopLimit(ref ctx.state, oldLimit);
		}
		else
		{
			do
			{
				Add(valueReader(ref ctx));
			}
			while (ParsingPrimitives.MaybeConsumeTag(ref ctx.buffer, ref ctx.state, lastTag));
		}
	}

	public int CalculateSize(FieldCodec<T> codec)
	{
		if (count == 0)
		{
			return 0;
		}
		uint tag = codec.Tag;
		if (codec.PackedRepeatedField)
		{
			int num = CalculatePackedDataSize(codec);
			return CodedOutputStream.ComputeRawVarint32Size(tag) + CodedOutputStream.ComputeLengthSize(num) + num;
		}
		Func<T, int> valueSizeCalculator = codec.ValueSizeCalculator;
		int num2 = count * CodedOutputStream.ComputeRawVarint32Size(tag);
		if (codec.EndTag != 0)
		{
			num2 += count * CodedOutputStream.ComputeRawVarint32Size(codec.EndTag);
		}
		for (int i = 0; i < count; i++)
		{
			num2 += valueSizeCalculator(array[i]);
		}
		return num2;
	}

	private int CalculatePackedDataSize(FieldCodec<T> codec)
	{
		int fixedSize = codec.FixedSize;
		if (fixedSize == 0)
		{
			Func<T, int> valueSizeCalculator = codec.ValueSizeCalculator;
			int num = 0;
			for (int i = 0; i < count; i++)
			{
				num += valueSizeCalculator(array[i]);
			}
			return num;
		}
		return fixedSize * Count;
	}

	public void WriteTo(CodedOutputStream output, FieldCodec<T> codec)
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

	public void WriteTo(ref WriteContext ctx, FieldCodec<T> codec)
	{
		if (count == 0)
		{
			return;
		}
		ValueWriter<T> valueWriter = codec.ValueWriter;
		uint tag = codec.Tag;
		if (codec.PackedRepeatedField)
		{
			int length = CalculatePackedDataSize(codec);
			ctx.WriteTag(tag);
			ctx.WriteLength(length);
			for (int i = 0; i < count; i++)
			{
				valueWriter(ref ctx, array[i]);
			}
			return;
		}
		for (int j = 0; j < count; j++)
		{
			ctx.WriteTag(tag);
			valueWriter(ref ctx, array[j]);
			if (codec.EndTag != 0)
			{
				ctx.WriteTag(codec.EndTag);
			}
		}
	}

	private void EnsureSize(int size)
	{
		if (array.Length < size)
		{
			size = Math.Max(size, 8);
			int size2 = Math.Max(array.Length * 2, size);
			SetSize(size2);
		}
	}

	private void SetSize(int size)
	{
		if (size != array.Length)
		{
			T[] destinationArray = new T[size];
			Array.Copy(array, 0, destinationArray, 0, count);
			array = destinationArray;
		}
	}

	public void Add(T item)
	{
		ProtoPreconditions.CheckNotNullUnconstrained(item, "item");
		EnsureSize(count + 1);
		array[count++] = item;
	}

	public void Clear()
	{
		array = EmptyArray;
		count = 0;
	}

	public bool Contains(T item)
	{
		return IndexOf(item) != -1;
	}

	public void CopyTo(T[] array, int arrayIndex)
	{
		Array.Copy(this.array, 0, array, arrayIndex, count);
	}

	public bool Remove(T item)
	{
		int num = IndexOf(item);
		if (num == -1)
		{
			return false;
		}
		Array.Copy(array, num + 1, array, num, count - num - 1);
		count--;
		array[count] = default;
		return true;
	}

	public void AddRange(IEnumerable<T> values)
	{
		ProtoPreconditions.CheckNotNull(values, "values");
		if (values is RepeatedField<T> repeatedField)
		{
			EnsureSize(count + repeatedField.count);
			Array.Copy(repeatedField.array, 0, array, count, repeatedField.count);
			count += repeatedField.count;
			return;
		}
		if (values is ICollection { Count: var num } collection)
		{
			if (default(T) == null)
			{
				foreach (object item in collection)
				{
					if (item == null)
					{
						throw new ArgumentException("Sequence contained null element", "values");
					}
				}
			}
			EnsureSize(count + num);
			collection.CopyTo(array, count);
			count += num;
			return;
		}
		foreach (T value in values)
		{
			Add(value);
		}
	}

	public void Add(IEnumerable<T> values)
	{
		AddRange(values);
	}

	public IEnumerator<T> GetEnumerator()
	{
		for (int i = 0; i < count; i++)
		{
			yield return array[i];
		}
	}

	public override bool Equals(object obj)
	{
		return Equals(obj as RepeatedField<T>);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	public override int GetHashCode()
	{
		int num = 0;
		for (int i = 0; i < count; i++)
		{
			num = num * 31 + array[i].GetHashCode();
		}
		return num;
	}

	public bool Equals(RepeatedField<T> other)
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
		EqualityComparer<T> equalityComparer = EqualityComparer;
		for (int i = 0; i < count; i++)
		{
			if (!equalityComparer.Equals(array[i], other.array[i]))
			{
				return false;
			}
		}
		return true;
	}

	public int IndexOf(T item)
	{
		ProtoPreconditions.CheckNotNullUnconstrained(item, "item");
		EqualityComparer<T> equalityComparer = EqualityComparer;
		for (int i = 0; i < count; i++)
		{
			if (equalityComparer.Equals(array[i], item))
			{
				return i;
			}
		}
		return -1;
	}

	public void Insert(int index, T item)
	{
		ProtoPreconditions.CheckNotNullUnconstrained(item, "item");
		if (index < 0 || index > count)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		EnsureSize(count + 1);
		Array.Copy(array, index, array, index + 1, count - index);
		array[index] = item;
		count++;
	}

	public void RemoveAt(int index)
	{
		if (index < 0 || index >= count)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		Array.Copy(array, index + 1, array, index, count - index - 1);
		count--;
		array[count] = default;
	}

	public override string ToString()
	{
		StringWriter stringWriter = new StringWriter();
		JsonFormatter.Default.WriteList(stringWriter, this);
		return stringWriter.ToString();
	}

	void ICollection.CopyTo(Array array, int index)
	{
		Array.Copy(this.array, 0, array, index, count);
	}

	int IList.Add(object value)
	{
		Add((T)value);
		return count - 1;
	}

	bool IList.Contains(object value)
	{
		if (value is T)
		{
			return Contains((T)value);
		}
		return false;
	}

	int IList.IndexOf(object value)
	{
		if (!(value is T))
		{
			return -1;
		}
		return IndexOf((T)value);
	}

	void IList.Insert(int index, object value)
	{
		Insert(index, (T)value);
	}

	void IList.Remove(object value)
	{
		if (value is T)
		{
			Remove((T)value);
		}
	}
}
