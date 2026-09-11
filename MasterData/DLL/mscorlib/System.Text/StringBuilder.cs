using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System.Text;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
public sealed class StringBuilder : ISerializable
{
	internal char[] m_ChunkChars;

	internal StringBuilder m_ChunkPrevious;

	internal int m_ChunkLength;

	internal int m_ChunkOffset;

	internal int m_MaxCapacity;

	internal const int DefaultCapacity = 16;

	private const string CapacityField = "Capacity";

	private const string MaxCapacityField = "m_MaxCapacity";

	private const string StringValueField = "m_StringValue";

	private const string ThreadIDField = "m_currentThread";

	internal const int MaxChunkSize = 8000;

	private const int IndexLimit = 1000000;

	private const int WidthLimit = 1000000;

	public int Capacity
	{
		get
		{
			return m_ChunkChars.Length + m_ChunkOffset;
		}
		set
		{
			if (value < 0)
			{
				throw new ArgumentOutOfRangeException("value", "Capacity must be positive.");
			}
			if (value > MaxCapacity)
			{
				throw new ArgumentOutOfRangeException("value", "Capacity exceeds maximum capacity.");
			}
			if (value < Length)
			{
				throw new ArgumentOutOfRangeException("value", "capacity was less than the current size.");
			}
			if (Capacity != value)
			{
				char[] array = new char[value - m_ChunkOffset];
				Array.Copy(m_ChunkChars, 0, array, 0, m_ChunkLength);
				m_ChunkChars = array;
			}
		}
	}

	public int MaxCapacity => m_MaxCapacity;

	public int Length
	{
		get
		{
			return m_ChunkOffset + m_ChunkLength;
		}
		set
		{
			if (value < 0)
			{
				throw new ArgumentOutOfRangeException("value", "Length cannot be less than zero.");
			}
			if (value > MaxCapacity)
			{
				throw new ArgumentOutOfRangeException("value", "capacity was less than the current size.");
			}
			if (value == 0 && m_ChunkPrevious == null)
			{
				m_ChunkLength = 0;
				m_ChunkOffset = 0;
				return;
			}
			int num = value - Length;
			if (num > 0)
			{
				Append('\0', num);
				return;
			}
			StringBuilder stringBuilder = FindChunkForIndex(value);
			if (stringBuilder != this)
			{
				int num2 = Math.Min(Capacity, Math.Max(Length * 6 / 5, m_ChunkChars.Length)) - stringBuilder.m_ChunkOffset;
				if (num2 > stringBuilder.m_ChunkChars.Length)
				{
					char[] array = new char[num2];
					Array.Copy(stringBuilder.m_ChunkChars, 0, array, 0, stringBuilder.m_ChunkLength);
					m_ChunkChars = array;
				}
				else
				{
					m_ChunkChars = stringBuilder.m_ChunkChars;
				}
				m_ChunkPrevious = stringBuilder.m_ChunkPrevious;
				m_ChunkOffset = stringBuilder.m_ChunkOffset;
			}
			m_ChunkLength = value - stringBuilder.m_ChunkOffset;
		}
	}

	[IndexerName("Chars")]
	public char this[int index]
	{
		get
		{
			StringBuilder stringBuilder = this;
			do
			{
				int num = index - stringBuilder.m_ChunkOffset;
				if (num >= 0)
				{
					if (num >= stringBuilder.m_ChunkLength)
					{
						throw new IndexOutOfRangeException();
					}
					return stringBuilder.m_ChunkChars[num];
				}
				stringBuilder = stringBuilder.m_ChunkPrevious;
			}
			while (stringBuilder != null);
			throw new IndexOutOfRangeException();
		}
		set
		{
			StringBuilder stringBuilder = this;
			do
			{
				int num = index - stringBuilder.m_ChunkOffset;
				if (num >= 0)
				{
					if (num >= stringBuilder.m_ChunkLength)
					{
						throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
					}
					stringBuilder.m_ChunkChars[num] = value;
					return;
				}
				stringBuilder = stringBuilder.m_ChunkPrevious;
			}
			while (stringBuilder != null);
			throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
	}

	private Span<char> RemainingCurrentChunk
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new Span<char>(m_ChunkChars, m_ChunkLength, m_ChunkChars.Length - m_ChunkLength);
		}
	}

	public StringBuilder()
	{
		m_MaxCapacity = int.MaxValue;
		m_ChunkChars = new char[16];
	}

	public StringBuilder(int capacity)
		: this(capacity, int.MaxValue)
	{
	}

	public StringBuilder(string value)
		: this(value, 16)
	{
	}

	public StringBuilder(string value, int capacity)
		: this(value, 0, value?.Length ?? 0, capacity)
	{
	}

	public unsafe StringBuilder(string value, int startIndex, int length, int capacity)
	{
		if (capacity < 0)
		{
			throw new ArgumentOutOfRangeException("capacity", SR.Format("'{0}' must be greater than zero.", "capacity"));
		}
		if (length < 0)
		{
			throw new ArgumentOutOfRangeException("length", SR.Format("'{0}' must be non-negative.", "length"));
		}
		if (startIndex < 0)
		{
			throw new ArgumentOutOfRangeException("startIndex", "StartIndex cannot be less than zero.");
		}
		if (value == null)
		{
			value = string.Empty;
		}
		if (startIndex > value.Length - length)
		{
			throw new ArgumentOutOfRangeException("length", "Index and length must refer to a location within the string.");
		}
		m_MaxCapacity = int.MaxValue;
		if (capacity == 0)
		{
			capacity = 16;
		}
		capacity = Math.Max(capacity, length);
		m_ChunkChars = new char[capacity];
		m_ChunkLength = length;
		fixed (char* ptr = value)
		{
			ThreadSafeCopy(ptr + startIndex, m_ChunkChars, 0, length);
		}
	}

	public StringBuilder(int capacity, int maxCapacity)
	{
		if (capacity > maxCapacity)
		{
			throw new ArgumentOutOfRangeException("capacity", "Capacity exceeds maximum capacity.");
		}
		if (maxCapacity < 1)
		{
			throw new ArgumentOutOfRangeException("maxCapacity", "MaxCapacity must be one or greater.");
		}
		if (capacity < 0)
		{
			throw new ArgumentOutOfRangeException("capacity", SR.Format("'{0}' must be greater than zero.", "capacity"));
		}
		if (capacity == 0)
		{
			capacity = Math.Min(16, maxCapacity);
		}
		m_MaxCapacity = maxCapacity;
		m_ChunkChars = new char[capacity];
	}

	private StringBuilder(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		int num = 0;
		string text = null;
		int num2 = int.MaxValue;
		bool flag = false;
		foreach (string item in info)
		{
			switch (item)
			{
			case "m_MaxCapacity":
				num2 = info.GetInt32("m_MaxCapacity");
				break;
			case "m_StringValue":
				text = info.GetString("m_StringValue");
				break;
			case "Capacity":
				num = info.GetInt32("Capacity");
				flag = true;
				break;
			}
		}
		if (text == null)
		{
			text = string.Empty;
		}
		if (num2 < 1 || text.Length > num2)
		{
			throw new SerializationException("The serialized MaxCapacity property of StringBuilder must be positive and greater than or equal to the String length.");
		}
		if (!flag)
		{
			num = Math.Min(Math.Max(16, text.Length), num2);
		}
		if (num < 0 || num < text.Length || num > num2)
		{
			throw new SerializationException("The serialized Capacity property of StringBuilder must be positive, less than or equal to MaxCapacity and greater than or equal to the String length.");
		}
		m_MaxCapacity = num2;
		m_ChunkChars = new char[num];
		text.CopyTo(0, m_ChunkChars, 0, text.Length);
		m_ChunkLength = text.Length;
		m_ChunkPrevious = null;
	}

	void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		info.AddValue("m_MaxCapacity", m_MaxCapacity);
		info.AddValue("Capacity", Capacity);
		info.AddValue("m_StringValue", ToString());
		info.AddValue("m_currentThread", 0);
	}

	[Conditional("DEBUG")]
	private void AssertInvariants()
	{
		StringBuilder stringBuilder = this;
		_ = m_MaxCapacity;
		while (true)
		{
			StringBuilder chunkPrevious = stringBuilder.m_ChunkPrevious;
			if (chunkPrevious != null)
			{
				stringBuilder = chunkPrevious;
				continue;
			}
			break;
		}
	}

	public int EnsureCapacity(int capacity)
	{
		if (capacity < 0)
		{
			throw new ArgumentOutOfRangeException("capacity", "Capacity must be positive.");
		}
		if (Capacity < capacity)
		{
			Capacity = capacity;
		}
		return Capacity;
	}

	public unsafe override string ToString()
	{
		if (Length == 0)
		{
			return string.Empty;
		}
		string text = string.FastAllocateString(Length);
		StringBuilder stringBuilder = this;
		fixed (char* ptr = text)
		{
			do
			{
				if (stringBuilder.m_ChunkLength > 0)
				{
					char[] chunkChars = stringBuilder.m_ChunkChars;
					int chunkOffset = stringBuilder.m_ChunkOffset;
					int chunkLength = stringBuilder.m_ChunkLength;
					if ((uint)(chunkLength + chunkOffset) > (uint)text.Length || (uint)chunkLength > (uint)chunkChars.Length)
					{
						throw new ArgumentOutOfRangeException("chunkLength", "Index was out of range. Must be non-negative and less than the size of the collection.");
					}
					fixed (char* smem = &chunkChars[0])
					{
						string.wstrcpy(ptr + chunkOffset, smem, chunkLength);
					}
				}
				stringBuilder = stringBuilder.m_ChunkPrevious;
			}
			while (stringBuilder != null);
			return text;
		}
	}

	public unsafe string ToString(int startIndex, int length)
	{
		int length2 = Length;
		if (startIndex < 0)
		{
			throw new ArgumentOutOfRangeException("startIndex", "StartIndex cannot be less than zero.");
		}
		if (startIndex > length2)
		{
			throw new ArgumentOutOfRangeException("startIndex", "startIndex cannot be larger than length of string.");
		}
		if (length < 0)
		{
			throw new ArgumentOutOfRangeException("length", "Length cannot be less than zero.");
		}
		if (startIndex > length2 - length)
		{
			throw new ArgumentOutOfRangeException("length", "Index and length must refer to a location within the string.");
		}
		string text = string.FastAllocateString(length);
		fixed (char* pointer = text)
		{
			CopyTo(startIndex, new Span<char>(pointer, length), length);
			return text;
		}
	}

	public StringBuilder Clear()
	{
		Length = 0;
		return this;
	}

	public StringBuilder Append(char value, int repeatCount)
	{
		if (repeatCount < 0)
		{
			throw new ArgumentOutOfRangeException("repeatCount", "Count cannot be less than zero.");
		}
		if (repeatCount == 0)
		{
			return this;
		}
		int num = Length + repeatCount;
		if (num > m_MaxCapacity || num < repeatCount)
		{
			throw new ArgumentOutOfRangeException("repeatCount", "The length cannot be greater than the capacity.");
		}
		int num2 = m_ChunkLength;
		while (repeatCount > 0)
		{
			if (num2 < m_ChunkChars.Length)
			{
				m_ChunkChars[num2++] = value;
				repeatCount--;
			}
			else
			{
				m_ChunkLength = num2;
				ExpandByABlock(repeatCount);
				num2 = 0;
			}
		}
		m_ChunkLength = num2;
		return this;
	}

	public unsafe StringBuilder Append(char[] value, int startIndex, int charCount)
	{
		if (startIndex < 0)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Value must be positive.");
		}
		if (charCount < 0)
		{
			throw new ArgumentOutOfRangeException("charCount", "Value must be positive.");
		}
		if (value == null)
		{
			if (startIndex == 0 && charCount == 0)
			{
				return this;
			}
			throw new ArgumentNullException("value");
		}
		if (charCount > value.Length - startIndex)
		{
			throw new ArgumentOutOfRangeException("charCount", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (charCount == 0)
		{
			return this;
		}
		fixed (char* value2 = &value[startIndex])
		{
			Append(value2, charCount);
			return this;
		}
	}

	public unsafe StringBuilder Append(string value)
	{
		if (value != null)
		{
			char[] chunkChars = m_ChunkChars;
			int chunkLength = m_ChunkLength;
			int length = value.Length;
			int num = chunkLength + length;
			if (num < chunkChars.Length)
			{
				if (length <= 2)
				{
					if (length > 0)
					{
						chunkChars[chunkLength] = value[0];
					}
					if (length > 1)
					{
						chunkChars[chunkLength + 1] = value[1];
					}
				}
				else
				{
					fixed (char* smem = value)
					{
						fixed (char* dmem = &chunkChars[chunkLength])
						{
							string.wstrcpy(dmem, smem, length);
						}
					}
				}
				m_ChunkLength = num;
			}
			else
			{
				AppendHelper(value);
			}
		}
		return this;
	}

	private unsafe void AppendHelper(string value)
	{
		fixed (char* value2 = value)
		{
			Append(value2, value.Length);
		}
	}

	public unsafe StringBuilder Append(string value, int startIndex, int count)
	{
		if (startIndex < 0)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Value must be positive.");
		}
		if (value == null)
		{
			if (startIndex == 0 && count == 0)
			{
				return this;
			}
			throw new ArgumentNullException("value");
		}
		if (count == 0)
		{
			return this;
		}
		if (startIndex > value.Length - count)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		fixed (char* ptr = value)
		{
			Append(ptr + startIndex, count);
			return this;
		}
	}

	public StringBuilder Append(StringBuilder value)
	{
		if (value != null && value.Length != 0)
		{
			return AppendCore(value, 0, value.Length);
		}
		return this;
	}

	public StringBuilder Append(StringBuilder value, int startIndex, int count)
	{
		if (startIndex < 0)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Value must be positive.");
		}
		if (value == null)
		{
			if (startIndex == 0 && count == 0)
			{
				return this;
			}
			throw new ArgumentNullException("value");
		}
		if (count == 0)
		{
			return this;
		}
		if (count > value.Length - startIndex)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		return AppendCore(value, startIndex, count);
	}

	private StringBuilder AppendCore(StringBuilder value, int startIndex, int count)
	{
		if (value == this)
		{
			return Append(value.ToString(startIndex, count));
		}
		if ((uint)(Length + count) > (uint)m_MaxCapacity)
		{
			throw new ArgumentOutOfRangeException("Capacity", "Capacity exceeds maximum capacity.");
		}
		while (count > 0)
		{
			int num = Math.Min(m_ChunkChars.Length - m_ChunkLength, count);
			if (num == 0)
			{
				ExpandByABlock(count);
				num = Math.Min(m_ChunkChars.Length - m_ChunkLength, count);
			}
			value.CopyTo(startIndex, new Span<char>(m_ChunkChars, m_ChunkLength, num), num);
			m_ChunkLength += num;
			startIndex += num;
			count -= num;
		}
		return this;
	}

	public StringBuilder AppendLine()
	{
		return Append(Environment.NewLine);
	}

	public StringBuilder AppendLine(string value)
	{
		Append(value);
		return Append(Environment.NewLine);
	}

	public void CopyTo(int sourceIndex, char[] destination, int destinationIndex, int count)
	{
		if (destination == null)
		{
			throw new ArgumentNullException("destination");
		}
		if (destinationIndex < 0)
		{
			throw new ArgumentOutOfRangeException("destinationIndex", SR.Format("'{0}' must be non-negative.", "destinationIndex"));
		}
		if (destinationIndex > destination.Length - count)
		{
			throw new ArgumentException("Either offset did not refer to a position in the string, or there is an insufficient length of destination character array.");
		}
		CopyTo(sourceIndex, new Span<char>(destination).Slice(destinationIndex), count);
	}

	public void CopyTo(int sourceIndex, Span<char> destination, int count)
	{
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Argument count must not be negative.");
		}
		if ((uint)sourceIndex > (uint)Length)
		{
			throw new ArgumentOutOfRangeException("sourceIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (sourceIndex > Length - count)
		{
			throw new ArgumentException("Source string was not long enough. Check sourceIndex and count.");
		}
		StringBuilder stringBuilder = this;
		int num = sourceIndex + count;
		int num2 = count;
		while (count > 0)
		{
			int num3 = num - stringBuilder.m_ChunkOffset;
			if (num3 >= 0)
			{
				num3 = Math.Min(num3, stringBuilder.m_ChunkLength);
				int num4 = count;
				int num5 = num3 - count;
				if (num5 < 0)
				{
					num4 += num5;
					num5 = 0;
				}
				num2 -= num4;
				count -= num4;
				ThreadSafeCopy(stringBuilder.m_ChunkChars, num5, destination, num2, num4);
			}
			stringBuilder = stringBuilder.m_ChunkPrevious;
		}
	}

	public unsafe StringBuilder Insert(int index, string value, int count)
	{
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		int length = Length;
		if ((uint)index > (uint)length)
		{
			throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (string.IsNullOrEmpty(value) || count == 0)
		{
			return this;
		}
		long num = (long)value.Length * (long)count;
		if (num > MaxCapacity - Length)
		{
			throw new OutOfMemoryException();
		}
		MakeRoom(index, (int)num, out var chunk, out var indexInChunk, doNotMoveFollowingChars: false);
		fixed (char* value2 = value)
		{
			while (count > 0)
			{
				ReplaceInPlaceAtChunk(ref chunk, ref indexInChunk, value2, value.Length);
				count--;
			}
			return this;
		}
	}

	public StringBuilder Remove(int startIndex, int length)
	{
		if (length < 0)
		{
			throw new ArgumentOutOfRangeException("length", "Length cannot be less than zero.");
		}
		if (startIndex < 0)
		{
			throw new ArgumentOutOfRangeException("startIndex", "StartIndex cannot be less than zero.");
		}
		if (length > Length - startIndex)
		{
			throw new ArgumentOutOfRangeException("length", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (Length == length && startIndex == 0)
		{
			Length = 0;
			return this;
		}
		if (length > 0)
		{
			Remove(startIndex, length, out var _, out var _);
		}
		return this;
	}

	public StringBuilder Append(bool value)
	{
		return Append(value.ToString());
	}

	public StringBuilder Append(char value)
	{
		if (m_ChunkLength < m_ChunkChars.Length)
		{
			m_ChunkChars[m_ChunkLength++] = value;
		}
		else
		{
			Append(value, 1);
		}
		return this;
	}

	[CLSCompliant(false)]
	public StringBuilder Append(sbyte value)
	{
		return AppendSpanFormattable(value);
	}

	public StringBuilder Append(byte value)
	{
		return AppendSpanFormattable(value);
	}

	public StringBuilder Append(short value)
	{
		return AppendSpanFormattable(value);
	}

	public StringBuilder Append(int value)
	{
		return AppendSpanFormattable(value);
	}

	public StringBuilder Append(long value)
	{
		return AppendSpanFormattable(value);
	}

	public StringBuilder Append(float value)
	{
		return AppendSpanFormattable(value);
	}

	public StringBuilder Append(double value)
	{
		return AppendSpanFormattable(value);
	}

	public StringBuilder Append(decimal value)
	{
		return AppendSpanFormattable(value);
	}

	[CLSCompliant(false)]
	public StringBuilder Append(ushort value)
	{
		return AppendSpanFormattable(value);
	}

	[CLSCompliant(false)]
	public StringBuilder Append(uint value)
	{
		return AppendSpanFormattable(value);
	}

	[CLSCompliant(false)]
	public StringBuilder Append(ulong value)
	{
		return AppendSpanFormattable(value);
	}

	private StringBuilder AppendSpanFormattable<T>(T value) where T : IFormattable
	{
		return Append(value.ToString(null, CultureInfo.CurrentCulture));
	}

	public StringBuilder Append(object value)
	{
		if (value != null)
		{
			return Append(value.ToString());
		}
		return this;
	}

	public unsafe StringBuilder Append(char[] value)
	{
		if (value != null && value.Length != 0)
		{
			fixed (char* value2 = &value[0])
			{
				Append(value2, value.Length);
			}
		}
		return this;
	}

	public unsafe StringBuilder Append(ReadOnlySpan<char> value)
	{
		if (value.Length > 0)
		{
			fixed (char* reference = &MemoryMarshal.GetReference(value))
			{
				Append(reference, value.Length);
			}
		}
		return this;
	}

	public unsafe StringBuilder AppendJoin(string separator, params object[] values)
	{
		separator = separator ?? string.Empty;
		fixed (char* separator2 = separator)
		{
			return AppendJoinCore(separator2, separator.Length, values);
		}
	}

	public unsafe StringBuilder AppendJoin<T>(string separator, IEnumerable<T> values)
	{
		separator = separator ?? string.Empty;
		fixed (char* separator2 = separator)
		{
			return AppendJoinCore(separator2, separator.Length, values);
		}
	}

	public unsafe StringBuilder AppendJoin(string separator, params string[] values)
	{
		separator = separator ?? string.Empty;
		fixed (char* separator2 = separator)
		{
			return AppendJoinCore(separator2, separator.Length, values);
		}
	}

	public unsafe StringBuilder AppendJoin(char separator, params object[] values)
	{
		return AppendJoinCore(&separator, 1, values);
	}

	public unsafe StringBuilder AppendJoin<T>(char separator, IEnumerable<T> values)
	{
		return AppendJoinCore(&separator, 1, values);
	}

	public unsafe StringBuilder AppendJoin(char separator, params string[] values)
	{
		return AppendJoinCore(&separator, 1, values);
	}

	private unsafe StringBuilder AppendJoinCore<T>(char* separator, int separatorLength, IEnumerable<T> values)
	{
		if (values == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.values);
		}
		using IEnumerator<T> enumerator = values.GetEnumerator();
		if (!enumerator.MoveNext())
		{
			return this;
		}
		T current = enumerator.Current;
		if (current != null)
		{
			Append(current.ToString());
		}
		while (enumerator.MoveNext())
		{
			Append(separator, separatorLength);
			current = enumerator.Current;
			if (current != null)
			{
				Append(current.ToString());
			}
		}
		return this;
	}

	private unsafe StringBuilder AppendJoinCore<T>(char* separator, int separatorLength, T[] values)
	{
		if (values == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.values);
		}
		if (values.Length == 0)
		{
			return this;
		}
		if (values[0] != null)
		{
			Append(values[0].ToString());
		}
		for (int i = 1; i < values.Length; i++)
		{
			Append(separator, separatorLength);
			if (values[i] != null)
			{
				Append(values[i].ToString());
			}
		}
		return this;
	}

	public unsafe StringBuilder Insert(int index, string value)
	{
		if ((uint)index > (uint)Length)
		{
			throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (value != null)
		{
			fixed (char* value2 = value)
			{
				Insert(index, value2, value.Length);
			}
		}
		return this;
	}

	public StringBuilder Insert(int index, bool value)
	{
		return Insert(index, value.ToString(), 1);
	}

	[CLSCompliant(false)]
	public StringBuilder Insert(int index, sbyte value)
	{
		return Insert(index, value.ToString(), 1);
	}

	public StringBuilder Insert(int index, byte value)
	{
		return Insert(index, value.ToString(), 1);
	}

	public StringBuilder Insert(int index, short value)
	{
		return Insert(index, value.ToString(), 1);
	}

	public unsafe StringBuilder Insert(int index, char value)
	{
		Insert(index, &value, 1);
		return this;
	}

	public StringBuilder Insert(int index, char[] value)
	{
		if ((uint)index > (uint)Length)
		{
			throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (value != null)
		{
			Insert(index, value, 0, value.Length);
		}
		return this;
	}

	public unsafe StringBuilder Insert(int index, char[] value, int startIndex, int charCount)
	{
		int length = Length;
		if ((uint)index > (uint)length)
		{
			throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (value == null)
		{
			if (startIndex == 0 && charCount == 0)
			{
				return this;
			}
			throw new ArgumentNullException("value", "String reference not set to an instance of a String.");
		}
		if (startIndex < 0)
		{
			throw new ArgumentOutOfRangeException("startIndex", "StartIndex cannot be less than zero.");
		}
		if (charCount < 0)
		{
			throw new ArgumentOutOfRangeException("charCount", "Value must be positive.");
		}
		if (startIndex > value.Length - charCount)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (charCount > 0)
		{
			fixed (char* value2 = &value[startIndex])
			{
				Insert(index, value2, charCount);
			}
		}
		return this;
	}

	public StringBuilder Insert(int index, int value)
	{
		return Insert(index, value.ToString(), 1);
	}

	public StringBuilder Insert(int index, long value)
	{
		return Insert(index, value.ToString(), 1);
	}

	public StringBuilder Insert(int index, float value)
	{
		return Insert(index, value.ToString(), 1);
	}

	public StringBuilder Insert(int index, double value)
	{
		return Insert(index, value.ToString(), 1);
	}

	public StringBuilder Insert(int index, decimal value)
	{
		return Insert(index, value.ToString(), 1);
	}

	[CLSCompliant(false)]
	public StringBuilder Insert(int index, ushort value)
	{
		return Insert(index, value.ToString(), 1);
	}

	[CLSCompliant(false)]
	public StringBuilder Insert(int index, uint value)
	{
		return Insert(index, value.ToString(), 1);
	}

	[CLSCompliant(false)]
	public StringBuilder Insert(int index, ulong value)
	{
		return Insert(index, value.ToString(), 1);
	}

	public StringBuilder Insert(int index, object value)
	{
		if (value != null)
		{
			return Insert(index, value.ToString(), 1);
		}
		return this;
	}

	public unsafe StringBuilder Insert(int index, ReadOnlySpan<char> value)
	{
		if ((uint)index > (uint)Length)
		{
			throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (value.Length > 0)
		{
			fixed (char* reference = &MemoryMarshal.GetReference(value))
			{
				Insert(index, reference, value.Length);
			}
		}
		return this;
	}

	public StringBuilder AppendFormat(string format, object arg0)
	{
		return AppendFormatHelper(null, format, new ParamsArray(arg0));
	}

	public StringBuilder AppendFormat(string format, object arg0, object arg1)
	{
		return AppendFormatHelper(null, format, new ParamsArray(arg0, arg1));
	}

	public StringBuilder AppendFormat(string format, object arg0, object arg1, object arg2)
	{
		return AppendFormatHelper(null, format, new ParamsArray(arg0, arg1, arg2));
	}

	public StringBuilder AppendFormat(string format, params object[] args)
	{
		if (args == null)
		{
			throw new ArgumentNullException((format == null) ? "format" : "args");
		}
		return AppendFormatHelper(null, format, new ParamsArray(args));
	}

	public StringBuilder AppendFormat(IFormatProvider provider, string format, object arg0)
	{
		return AppendFormatHelper(provider, format, new ParamsArray(arg0));
	}

	public StringBuilder AppendFormat(IFormatProvider provider, string format, object arg0, object arg1)
	{
		return AppendFormatHelper(provider, format, new ParamsArray(arg0, arg1));
	}

	public StringBuilder AppendFormat(IFormatProvider provider, string format, object arg0, object arg1, object arg2)
	{
		return AppendFormatHelper(provider, format, new ParamsArray(arg0, arg1, arg2));
	}

	public StringBuilder AppendFormat(IFormatProvider provider, string format, params object[] args)
	{
		if (args == null)
		{
			throw new ArgumentNullException((format == null) ? "format" : "args");
		}
		return AppendFormatHelper(provider, format, new ParamsArray(args));
	}

	private static void FormatError()
	{
		throw new FormatException("Input string was not in a correct format.");
	}

	internal StringBuilder AppendFormatHelper(IFormatProvider provider, string format, ParamsArray args)
	{
		if (format == null)
		{
			throw new ArgumentNullException("format");
		}
		int num = 0;
		int length = format.Length;
		char c = '\0';
		StringBuilder stringBuilder = null;
		ICustomFormatter customFormatter = null;
		if (provider != null)
		{
			customFormatter = (ICustomFormatter)provider.GetFormat(typeof(ICustomFormatter));
		}
		while (true)
		{
			if (num < length)
			{
				c = format[num];
				num++;
				if (c == '}')
				{
					if (num < length && format[num] == '}')
					{
						num++;
					}
					else
					{
						FormatError();
					}
				}
				if (c == '{')
				{
					if (num >= length || format[num] != '{')
					{
						num--;
						goto IL_0091;
					}
					num++;
				}
				Append(c);
				continue;
			}
			goto IL_0091;
			IL_0091:
			if (num == length)
			{
				break;
			}
			num++;
			if (num == length || (c = format[num]) < '0' || c > '9')
			{
				FormatError();
			}
			int num2 = 0;
			do
			{
				num2 = num2 * 10 + c - 48;
				num++;
				if (num == length)
				{
					FormatError();
				}
				c = format[num];
			}
			while (c >= '0' && c <= '9' && num2 < 1000000);
			if (num2 >= args.Length)
			{
				throw new FormatException("Index (zero based) must be greater than or equal to zero and less than the size of the argument list.");
			}
			for (; num < length; num++)
			{
				if ((c = format[num]) != ' ')
				{
					break;
				}
			}
			bool flag = false;
			int num3 = 0;
			if (c == ',')
			{
				for (num++; num < length && format[num] == ' '; num++)
				{
				}
				if (num == length)
				{
					FormatError();
				}
				c = format[num];
				if (c == '-')
				{
					flag = true;
					num++;
					if (num == length)
					{
						FormatError();
					}
					c = format[num];
				}
				if (c < '0' || c > '9')
				{
					FormatError();
				}
				do
				{
					num3 = num3 * 10 + c - 48;
					num++;
					if (num == length)
					{
						FormatError();
					}
					c = format[num];
				}
				while (c >= '0' && c <= '9' && num3 < 1000000);
			}
			for (; num < length; num++)
			{
				if ((c = format[num]) != ' ')
				{
					break;
				}
			}
			object obj = args[num2];
			string text = null;
			ReadOnlySpan<char> readOnlySpan = default(ReadOnlySpan<char>);
			if (c == ':')
			{
				num++;
				int num4 = num;
				while (true)
				{
					if (num == length)
					{
						FormatError();
					}
					c = format[num];
					num++;
					if (c != '}' && c != '{')
					{
						continue;
					}
					if (c == '{')
					{
						if (num < length && format[num] == '{')
						{
							num++;
						}
						else
						{
							FormatError();
						}
					}
					else
					{
						if (num >= length || format[num] != '}')
						{
							break;
						}
						num++;
					}
					if (stringBuilder == null)
					{
						stringBuilder = new StringBuilder();
					}
					stringBuilder.Append(format, num4, num - num4 - 1);
					num4 = num;
				}
				num--;
				if (stringBuilder == null || stringBuilder.Length == 0)
				{
					if (num4 != num)
					{
						readOnlySpan = format.AsSpan(num4, num - num4);
					}
				}
				else
				{
					stringBuilder.Append(format, num4, num - num4);
					readOnlySpan = (text = stringBuilder.ToString());
					stringBuilder.Clear();
				}
			}
			if (c != '}')
			{
				FormatError();
			}
			num++;
			string text2 = null;
			if (customFormatter != null)
			{
				if (readOnlySpan.Length != 0 && text == null)
				{
					text = new string(readOnlySpan);
				}
				text2 = customFormatter.Format(text, obj, provider);
			}
			if (text2 == null)
			{
				if (obj is ISpanFormattable spanFormattable && (flag || num3 == 0) && spanFormattable.TryFormat(RemainingCurrentChunk, out var charsWritten, readOnlySpan, provider))
				{
					m_ChunkLength += charsWritten;
					int num5 = num3 - charsWritten;
					if (flag && num5 > 0)
					{
						Append(' ', num5);
					}
					continue;
				}
				if (obj is IFormattable formattable)
				{
					if (readOnlySpan.Length != 0 && text == null)
					{
						text = new string(readOnlySpan);
					}
					text2 = formattable.ToString(text, provider);
				}
				else if (obj != null)
				{
					text2 = obj.ToString();
				}
			}
			if (text2 == null)
			{
				text2 = string.Empty;
			}
			int num6 = num3 - text2.Length;
			if (!flag && num6 > 0)
			{
				Append(' ', num6);
			}
			Append(text2);
			if (flag && num6 > 0)
			{
				Append(' ', num6);
			}
		}
		return this;
	}

	public StringBuilder Replace(string oldValue, string newValue)
	{
		return Replace(oldValue, newValue, 0, Length);
	}

	public bool Equals(StringBuilder sb)
	{
		if (sb == null)
		{
			return false;
		}
		if (Capacity != sb.Capacity || MaxCapacity != sb.MaxCapacity || Length != sb.Length)
		{
			return false;
		}
		if (sb == this)
		{
			return true;
		}
		StringBuilder stringBuilder = this;
		int num = stringBuilder.m_ChunkLength;
		StringBuilder stringBuilder2 = sb;
		int num2 = stringBuilder2.m_ChunkLength;
		do
		{
			num--;
			num2--;
			while (num < 0)
			{
				stringBuilder = stringBuilder.m_ChunkPrevious;
				if (stringBuilder == null)
				{
					break;
				}
				num = stringBuilder.m_ChunkLength + num;
			}
			while (num2 < 0)
			{
				stringBuilder2 = stringBuilder2.m_ChunkPrevious;
				if (stringBuilder2 == null)
				{
					break;
				}
				num2 = stringBuilder2.m_ChunkLength + num2;
			}
			if (num < 0)
			{
				return num2 < 0;
			}
			if (num2 < 0)
			{
				return false;
			}
		}
		while (stringBuilder.m_ChunkChars[num] == stringBuilder2.m_ChunkChars[num2]);
		return false;
	}

	public bool Equals(ReadOnlySpan<char> span)
	{
		if (span.Length != Length)
		{
			return false;
		}
		StringBuilder stringBuilder = this;
		int num = 0;
		do
		{
			int chunkLength = stringBuilder.m_ChunkLength;
			num += chunkLength;
			if (!new ReadOnlySpan<char>(stringBuilder.m_ChunkChars, 0, chunkLength).EqualsOrdinal(span.Slice(span.Length - num, chunkLength)))
			{
				return false;
			}
			stringBuilder = stringBuilder.m_ChunkPrevious;
		}
		while (stringBuilder != null);
		return true;
	}

	public StringBuilder Replace(string oldValue, string newValue, int startIndex, int count)
	{
		int length = Length;
		if ((uint)startIndex > (uint)length)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (count < 0 || startIndex > length - count)
		{
			throw new ArgumentOutOfRangeException("count", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (oldValue == null)
		{
			throw new ArgumentNullException("oldValue");
		}
		if (oldValue.Length == 0)
		{
			throw new ArgumentException("Empty name is not legal.", "oldValue");
		}
		newValue = newValue ?? string.Empty;
		_ = newValue.Length;
		_ = oldValue.Length;
		int[] array = null;
		int num = 0;
		StringBuilder stringBuilder = FindChunkForIndex(startIndex);
		int num2 = startIndex - stringBuilder.m_ChunkOffset;
		while (count > 0)
		{
			if (StartsWith(stringBuilder, num2, count, oldValue))
			{
				if (array == null)
				{
					array = new int[5];
				}
				else if (num >= array.Length)
				{
					Array.Resize(ref array, array.Length * 3 / 2 + 4);
				}
				array[num++] = num2;
				num2 += oldValue.Length;
				count -= oldValue.Length;
			}
			else
			{
				num2++;
				count--;
			}
			if (num2 >= stringBuilder.m_ChunkLength || count == 0)
			{
				int num3 = num2 + stringBuilder.m_ChunkOffset;
				ReplaceAllInChunk(array, num, stringBuilder, oldValue.Length, newValue);
				num3 += (newValue.Length - oldValue.Length) * num;
				num = 0;
				stringBuilder = FindChunkForIndex(num3);
				num2 = num3 - stringBuilder.m_ChunkOffset;
			}
		}
		return this;
	}

	public StringBuilder Replace(char oldChar, char newChar)
	{
		return Replace(oldChar, newChar, 0, Length);
	}

	public StringBuilder Replace(char oldChar, char newChar, int startIndex, int count)
	{
		int length = Length;
		if ((uint)startIndex > (uint)length)
		{
			throw new ArgumentOutOfRangeException("startIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (count < 0 || startIndex > length - count)
		{
			throw new ArgumentOutOfRangeException("count", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		int num = startIndex + count;
		StringBuilder stringBuilder = this;
		while (true)
		{
			int num2 = num - stringBuilder.m_ChunkOffset;
			int num3 = startIndex - stringBuilder.m_ChunkOffset;
			if (num2 >= 0)
			{
				int i = Math.Max(num3, 0);
				for (int num4 = Math.Min(stringBuilder.m_ChunkLength, num2); i < num4; i++)
				{
					if (stringBuilder.m_ChunkChars[i] == oldChar)
					{
						stringBuilder.m_ChunkChars[i] = newChar;
					}
				}
			}
			if (num3 >= 0)
			{
				break;
			}
			stringBuilder = stringBuilder.m_ChunkPrevious;
		}
		return this;
	}

	[CLSCompliant(false)]
	public unsafe StringBuilder Append(char* value, int valueCount)
	{
		if (valueCount < 0)
		{
			throw new ArgumentOutOfRangeException("valueCount", "Count cannot be less than zero.");
		}
		int num = Length + valueCount;
		if (num > m_MaxCapacity || num < valueCount)
		{
			throw new ArgumentOutOfRangeException("valueCount", "The length cannot be greater than the capacity.");
		}
		int num2 = valueCount + m_ChunkLength;
		if (num2 <= m_ChunkChars.Length)
		{
			ThreadSafeCopy(value, m_ChunkChars, m_ChunkLength, valueCount);
			m_ChunkLength = num2;
		}
		else
		{
			int num3 = m_ChunkChars.Length - m_ChunkLength;
			if (num3 > 0)
			{
				ThreadSafeCopy(value, m_ChunkChars, m_ChunkLength, num3);
				m_ChunkLength = m_ChunkChars.Length;
			}
			int num4 = valueCount - num3;
			ExpandByABlock(num4);
			ThreadSafeCopy(value + num3, m_ChunkChars, 0, num4);
			m_ChunkLength = num4;
		}
		return this;
	}

	private unsafe void Insert(int index, char* value, int valueCount)
	{
		if ((uint)index > (uint)Length)
		{
			throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (valueCount > 0)
		{
			MakeRoom(index, valueCount, out var chunk, out var indexInChunk, doNotMoveFollowingChars: false);
			ReplaceInPlaceAtChunk(ref chunk, ref indexInChunk, value, valueCount);
		}
	}

	private unsafe void ReplaceAllInChunk(int[] replacements, int replacementsCount, StringBuilder sourceChunk, int removeCount, string value)
	{
		if (replacementsCount <= 0)
		{
			return;
		}
		fixed (char* value2 = value)
		{
			int num = (value.Length - removeCount) * replacementsCount;
			StringBuilder chunk = sourceChunk;
			int indexInChunk = replacements[0];
			if (num > 0)
			{
				MakeRoom(chunk.m_ChunkOffset + indexInChunk, num, out chunk, out indexInChunk, doNotMoveFollowingChars: true);
			}
			int num2 = 0;
			while (true)
			{
				ReplaceInPlaceAtChunk(ref chunk, ref indexInChunk, value2, value.Length);
				int num3 = replacements[num2] + removeCount;
				num2++;
				if (num2 >= replacementsCount)
				{
					break;
				}
				int num4 = replacements[num2];
				if (num != 0)
				{
					fixed (char* value3 = &sourceChunk.m_ChunkChars[num3])
					{
						ReplaceInPlaceAtChunk(ref chunk, ref indexInChunk, value3, num4 - num3);
					}
				}
				else
				{
					indexInChunk += num4 - num3;
				}
			}
			if (num < 0)
			{
				Remove(chunk.m_ChunkOffset + indexInChunk, -num, out chunk, out indexInChunk);
			}
		}
	}

	private bool StartsWith(StringBuilder chunk, int indexInChunk, int count, string value)
	{
		for (int i = 0; i < value.Length; i++)
		{
			if (count == 0)
			{
				return false;
			}
			if (indexInChunk >= chunk.m_ChunkLength)
			{
				chunk = Next(chunk);
				if (chunk == null)
				{
					return false;
				}
				indexInChunk = 0;
			}
			if (value[i] != chunk.m_ChunkChars[indexInChunk])
			{
				return false;
			}
			indexInChunk++;
			count--;
		}
		return true;
	}

	private unsafe void ReplaceInPlaceAtChunk(ref StringBuilder chunk, ref int indexInChunk, char* value, int count)
	{
		if (count == 0)
		{
			return;
		}
		while (true)
		{
			int num = Math.Min(chunk.m_ChunkLength - indexInChunk, count);
			ThreadSafeCopy(value, chunk.m_ChunkChars, indexInChunk, num);
			indexInChunk += num;
			if (indexInChunk >= chunk.m_ChunkLength)
			{
				chunk = Next(chunk);
				indexInChunk = 0;
			}
			count -= num;
			if (count != 0)
			{
				value += num;
				continue;
			}
			break;
		}
	}

	private unsafe static void ThreadSafeCopy(char* sourcePtr, char[] destination, int destinationIndex, int count)
	{
		if (count > 0)
		{
			if ((uint)destinationIndex > (uint)destination.Length || destinationIndex + count > destination.Length)
			{
				throw new ArgumentOutOfRangeException("destinationIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
			}
			fixed (char* dmem = &destination[destinationIndex])
			{
				string.wstrcpy(dmem, sourcePtr, count);
			}
		}
	}

	private unsafe static void ThreadSafeCopy(char[] source, int sourceIndex, Span<char> destination, int destinationIndex, int count)
	{
		if (count <= 0)
		{
			return;
		}
		if ((uint)sourceIndex > (uint)source.Length || count > source.Length - sourceIndex)
		{
			throw new ArgumentOutOfRangeException("sourceIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if ((uint)destinationIndex > (uint)destination.Length || count > destination.Length - destinationIndex)
		{
			throw new ArgumentOutOfRangeException("destinationIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		fixed (char* smem = &source[sourceIndex])
		{
			fixed (char* reference = &MemoryMarshal.GetReference(destination))
			{
				string.wstrcpy(reference + destinationIndex, smem, count);
			}
		}
	}

	private StringBuilder FindChunkForIndex(int index)
	{
		StringBuilder stringBuilder = this;
		while (stringBuilder.m_ChunkOffset > index)
		{
			stringBuilder = stringBuilder.m_ChunkPrevious;
		}
		return stringBuilder;
	}

	private StringBuilder FindChunkForByte(int byteIndex)
	{
		StringBuilder stringBuilder = this;
		while (stringBuilder.m_ChunkOffset * 2 > byteIndex)
		{
			stringBuilder = stringBuilder.m_ChunkPrevious;
		}
		return stringBuilder;
	}

	private StringBuilder Next(StringBuilder chunk)
	{
		if (chunk != this)
		{
			return FindChunkForIndex(chunk.m_ChunkOffset + chunk.m_ChunkLength);
		}
		return null;
	}

	private void ExpandByABlock(int minBlockCharCount)
	{
		if (minBlockCharCount + Length > m_MaxCapacity || minBlockCharCount + Length < minBlockCharCount)
		{
			throw new ArgumentOutOfRangeException("requiredLength", "capacity was less than the current size.");
		}
		int num = Math.Max(minBlockCharCount, Math.Min(Length, 8000));
		m_ChunkPrevious = new StringBuilder(this);
		m_ChunkOffset += m_ChunkLength;
		m_ChunkLength = 0;
		if (m_ChunkOffset + num < num)
		{
			m_ChunkChars = null;
			throw new OutOfMemoryException();
		}
		m_ChunkChars = new char[num];
	}

	private StringBuilder(StringBuilder from)
	{
		m_ChunkLength = from.m_ChunkLength;
		m_ChunkOffset = from.m_ChunkOffset;
		m_ChunkChars = from.m_ChunkChars;
		m_ChunkPrevious = from.m_ChunkPrevious;
		m_MaxCapacity = from.m_MaxCapacity;
	}

	private unsafe void MakeRoom(int index, int count, out StringBuilder chunk, out int indexInChunk, bool doNotMoveFollowingChars)
	{
		if (count + Length > m_MaxCapacity || count + Length < count)
		{
			throw new ArgumentOutOfRangeException("requiredLength", "capacity was less than the current size.");
		}
		chunk = this;
		while (chunk.m_ChunkOffset > index)
		{
			chunk.m_ChunkOffset += count;
			chunk = chunk.m_ChunkPrevious;
		}
		indexInChunk = index - chunk.m_ChunkOffset;
		if (!doNotMoveFollowingChars && chunk.m_ChunkLength <= 32 && chunk.m_ChunkChars.Length - chunk.m_ChunkLength >= count)
		{
			int num = chunk.m_ChunkLength;
			while (num > indexInChunk)
			{
				num--;
				chunk.m_ChunkChars[num + count] = chunk.m_ChunkChars[num];
			}
			chunk.m_ChunkLength += count;
			return;
		}
		StringBuilder stringBuilder = new StringBuilder(Math.Max(count, 16), chunk.m_MaxCapacity, chunk.m_ChunkPrevious);
		stringBuilder.m_ChunkLength = count;
		int num2 = Math.Min(count, indexInChunk);
		if (num2 > 0)
		{
			fixed (char* ptr = &chunk.m_ChunkChars[0])
			{
				ThreadSafeCopy(ptr, stringBuilder.m_ChunkChars, 0, num2);
				int num3 = indexInChunk - num2;
				if (num3 >= 0)
				{
					ThreadSafeCopy(ptr + num2, chunk.m_ChunkChars, 0, num3);
					indexInChunk = num3;
				}
			}
		}
		chunk.m_ChunkPrevious = stringBuilder;
		chunk.m_ChunkOffset += count;
		if (num2 < count)
		{
			chunk = stringBuilder;
			indexInChunk = num2;
		}
	}

	private StringBuilder(int size, int maxCapacity, StringBuilder previousBlock)
	{
		m_ChunkChars = new char[size];
		m_MaxCapacity = maxCapacity;
		m_ChunkPrevious = previousBlock;
		if (previousBlock != null)
		{
			m_ChunkOffset = previousBlock.m_ChunkOffset + previousBlock.m_ChunkLength;
		}
	}

	private void Remove(int startIndex, int count, out StringBuilder chunk, out int indexInChunk)
	{
		int num = startIndex + count;
		chunk = this;
		StringBuilder stringBuilder = null;
		int num2 = 0;
		while (true)
		{
			if (num - chunk.m_ChunkOffset >= 0)
			{
				if (stringBuilder == null)
				{
					stringBuilder = chunk;
					num2 = num - stringBuilder.m_ChunkOffset;
				}
				if (startIndex - chunk.m_ChunkOffset >= 0)
				{
					break;
				}
			}
			else
			{
				chunk.m_ChunkOffset -= count;
			}
			chunk = chunk.m_ChunkPrevious;
		}
		indexInChunk = startIndex - chunk.m_ChunkOffset;
		int num3 = indexInChunk;
		int count2 = stringBuilder.m_ChunkLength - num2;
		if (stringBuilder != chunk)
		{
			num3 = 0;
			chunk.m_ChunkLength = indexInChunk;
			stringBuilder.m_ChunkPrevious = chunk;
			stringBuilder.m_ChunkOffset = chunk.m_ChunkOffset + chunk.m_ChunkLength;
			if (indexInChunk == 0)
			{
				stringBuilder.m_ChunkPrevious = chunk.m_ChunkPrevious;
				chunk = stringBuilder;
			}
		}
		stringBuilder.m_ChunkLength -= num2 - num3;
		if (num3 != num2)
		{
			ThreadSafeCopy(stringBuilder.m_ChunkChars, num2, stringBuilder.m_ChunkChars, num3, count2);
		}
	}
}
