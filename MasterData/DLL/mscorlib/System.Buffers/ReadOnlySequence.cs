using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace System.Buffers;

[DebuggerTypeProxy(typeof(ReadOnlySequenceDebugView<>))]
[DebuggerDisplay("{ToString(),raw}")]
public readonly struct ReadOnlySequence<T>
{
	public struct Enumerator(in ReadOnlySequence<T> sequence)
	{
		private readonly ReadOnlySequence<T> _sequence = sequence;

		private SequencePosition _next = sequence.Start;

		private ReadOnlyMemory<T> _currentMemory = default(ReadOnlyMemory<T>);

		public ReadOnlyMemory<T> Current => _currentMemory;

		public bool MoveNext()
		{
			if (_next.GetObject() == null)
			{
				return false;
			}
			return _sequence.TryGet(ref _next, out _currentMemory);
		}
	}

	private enum SequenceType
	{
		MultiSegment,
		Array,
		MemoryManager,
		String,
		Empty
	}

	private readonly object _startObject;

	private readonly object _endObject;

	private readonly int _startInteger;

	private readonly int _endInteger;

	public static readonly ReadOnlySequence<T> Empty = new ReadOnlySequence<T>(Array.Empty<T>());

	public long Length => GetLength();

	public bool IsEmpty => Length == 0;

	public bool IsSingleSegment
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return _startObject == _endObject;
		}
	}

	public ReadOnlyMemory<T> First => GetFirstBuffer();

	public ReadOnlySpan<T> FirstSpan => GetFirstSpan();

	public SequencePosition Start
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new SequencePosition(_startObject, _startInteger);
		}
	}

	public SequencePosition End
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new SequencePosition(_endObject, _endInteger);
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	private ReadOnlySequence(object startSegment, int startIndexAndFlags, object endSegment, int endIndexAndFlags)
	{
		_startObject = startSegment;
		_endObject = endSegment;
		_startInteger = startIndexAndFlags;
		_endInteger = endIndexAndFlags;
	}

	public ReadOnlySequence(ReadOnlySequenceSegment<T> startSegment, int startIndex, ReadOnlySequenceSegment<T> endSegment, int endIndex)
	{
		if (startSegment == null || endSegment == null || (startSegment != endSegment && startSegment.RunningIndex > endSegment.RunningIndex) || (uint)startSegment.Memory.Length < (uint)startIndex || (uint)endSegment.Memory.Length < (uint)endIndex || (startSegment == endSegment && endIndex < startIndex))
		{
			ThrowHelper.ThrowArgumentValidationException(startSegment, startIndex, endSegment);
		}
		_startObject = startSegment;
		_endObject = endSegment;
		_startInteger = ReadOnlySequence.SegmentToSequenceStart(startIndex);
		_endInteger = ReadOnlySequence.SegmentToSequenceEnd(endIndex);
	}

	public ReadOnlySequence(T[] array)
	{
		if (array == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.array);
		}
		_startObject = array;
		_endObject = array;
		_startInteger = ReadOnlySequence.ArrayToSequenceStart(0);
		_endInteger = ReadOnlySequence.ArrayToSequenceEnd(array.Length);
	}

	public ReadOnlySequence(T[] array, int start, int length)
	{
		if (array == null || (uint)start > (uint)array.Length || (uint)length > (uint)(array.Length - start))
		{
			ThrowHelper.ThrowArgumentValidationException(array, start);
		}
		_startObject = array;
		_endObject = array;
		_startInteger = ReadOnlySequence.ArrayToSequenceStart(start);
		_endInteger = ReadOnlySequence.ArrayToSequenceEnd(start + length);
	}

	public ReadOnlySequence(ReadOnlyMemory<T> memory)
	{
		ArraySegment<T> segment;
		if (MemoryMarshal.TryGetMemoryManager<T, MemoryManager<T>>(memory, out var manager, out var start, out var length))
		{
			_startObject = manager;
			_endObject = manager;
			_startInteger = ReadOnlySequence.MemoryManagerToSequenceStart(start);
			_endInteger = ReadOnlySequence.MemoryManagerToSequenceEnd(length);
		}
		else if (MemoryMarshal.TryGetArray(memory, out segment))
		{
			T[] array = segment.Array;
			int offset = segment.Offset;
			_startObject = array;
			_endObject = array;
			_startInteger = ReadOnlySequence.ArrayToSequenceStart(offset);
			_endInteger = ReadOnlySequence.ArrayToSequenceEnd(offset + segment.Count);
		}
		else if (typeof(T) == typeof(char))
		{
			if (!MemoryMarshal.TryGetString((ReadOnlyMemory<char>)(object)memory, out var text, out var start2, out length))
			{
				ThrowHelper.ThrowInvalidOperationException();
			}
			_startObject = text;
			_endObject = text;
			_startInteger = ReadOnlySequence.StringToSequenceStart(start2);
			_endInteger = ReadOnlySequence.StringToSequenceEnd(start2 + length);
		}
		else
		{
			ThrowHelper.ThrowInvalidOperationException();
			_startObject = null;
			_endObject = null;
			_startInteger = 0;
			_endInteger = 0;
		}
	}

	public ReadOnlySequence<T> Slice(long start, long length)
	{
		if (start < 0 || length < 0)
		{
			ThrowHelper.ThrowStartOrEndArgumentValidationException(start);
		}
		int index = GetIndex(_startInteger);
		int index2 = GetIndex(_endInteger);
		object startObject = _startObject;
		object endObject = _endObject;
		SequencePosition position;
		SequencePosition end;
		if (startObject != endObject)
		{
			ReadOnlySequenceSegment<T> readOnlySequenceSegment = (ReadOnlySequenceSegment<T>)startObject;
			int num = readOnlySequenceSegment.Memory.Length - index;
			if (num > start)
			{
				index += (int)start;
				position = new SequencePosition(startObject, index);
				end = GetEndPosition(readOnlySequenceSegment, startObject, index, endObject, index2, length);
			}
			else
			{
				if (num < 0)
				{
					ThrowHelper.ThrowArgumentOutOfRangeException_PositionOutOfRange();
				}
				position = SeekMultiSegment(readOnlySequenceSegment.Next, endObject, index2, start - num, ExceptionArgument.start);
				int index3 = GetIndex(in position);
				object obj = position.GetObject();
				if (obj != endObject)
				{
					end = GetEndPosition((ReadOnlySequenceSegment<T>)obj, obj, index3, endObject, index2, length);
				}
				else
				{
					if (index2 - index3 < length)
					{
						ThrowHelper.ThrowStartOrEndArgumentValidationException(0L);
					}
					end = new SequencePosition(obj, index3 + (int)length);
				}
			}
		}
		else
		{
			if (index2 - index < start)
			{
				ThrowHelper.ThrowStartOrEndArgumentValidationException(-1L);
			}
			index += (int)start;
			position = new SequencePosition(startObject, index);
			if (index2 - index < length)
			{
				ThrowHelper.ThrowStartOrEndArgumentValidationException(0L);
			}
			end = new SequencePosition(startObject, index + (int)length);
		}
		return SliceImpl(in position, in end);
	}

	public ReadOnlySequence<T> Slice(long start, SequencePosition end)
	{
		if (start < 0)
		{
			ThrowHelper.ThrowStartOrEndArgumentValidationException(start);
		}
		uint index = (uint)GetIndex(_startInteger);
		object startObject = _startObject;
		uint index2 = (uint)GetIndex(_endInteger);
		object endObject = _endObject;
		uint num = (uint)GetIndex(in end);
		object obj = end.GetObject();
		if (obj == null)
		{
			obj = _startObject;
			num = index;
		}
		if (startObject == endObject)
		{
			if (!InRange(num, index, index2))
			{
				ThrowHelper.ThrowArgumentOutOfRangeException_PositionOutOfRange();
			}
			if (num - index < start)
			{
				ThrowHelper.ThrowStartOrEndArgumentValidationException(-1L);
			}
		}
		else
		{
			ReadOnlySequenceSegment<T> readOnlySequenceSegment = (ReadOnlySequenceSegment<T>)startObject;
			ulong num2 = (ulong)(readOnlySequenceSegment.RunningIndex + index);
			ulong num3 = (ulong)(((ReadOnlySequenceSegment<T>)obj).RunningIndex + num);
			if (!InRange(num3, num2, (ulong)(((ReadOnlySequenceSegment<T>)endObject).RunningIndex + index2)))
			{
				ThrowHelper.ThrowArgumentOutOfRangeException_PositionOutOfRange();
			}
			if ((ulong)((long)num2 + start) > num3)
			{
				ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.start);
			}
			int num4 = readOnlySequenceSegment.Memory.Length - (int)index;
			if (num4 <= start)
			{
				if (num4 < 0)
				{
					ThrowHelper.ThrowArgumentOutOfRangeException_PositionOutOfRange();
				}
				return SliceImpl(SeekMultiSegment(readOnlySequenceSegment.Next, obj, (int)num, start - num4, ExceptionArgument.start), in end);
			}
		}
		return SliceImpl(new SequencePosition(startObject, (int)index + (int)start), new SequencePosition(obj, (int)num));
	}

	public ReadOnlySequence<T> Slice(SequencePosition start, long length)
	{
		uint index = (uint)GetIndex(_startInteger);
		object startObject = _startObject;
		uint index2 = (uint)GetIndex(_endInteger);
		object endObject = _endObject;
		uint num = (uint)GetIndex(in start);
		object obj = start.GetObject();
		if (obj == null)
		{
			num = index;
			obj = _startObject;
		}
		if (startObject == endObject)
		{
			if (!InRange(num, index, index2))
			{
				ThrowHelper.ThrowArgumentOutOfRangeException_PositionOutOfRange();
			}
			if (length < 0)
			{
				ThrowHelper.ThrowStartOrEndArgumentValidationException(0L);
			}
			if (index2 - num < length)
			{
				ThrowHelper.ThrowStartOrEndArgumentValidationException(0L);
			}
		}
		else
		{
			ReadOnlySequenceSegment<T> readOnlySequenceSegment = (ReadOnlySequenceSegment<T>)obj;
			long num2 = readOnlySequenceSegment.RunningIndex + num;
			ulong start2 = (ulong)(((ReadOnlySequenceSegment<T>)startObject).RunningIndex + index);
			ulong num3 = (ulong)(((ReadOnlySequenceSegment<T>)endObject).RunningIndex + index2);
			if (!InRange((ulong)num2, start2, num3))
			{
				ThrowHelper.ThrowArgumentOutOfRangeException_PositionOutOfRange();
			}
			if (length < 0)
			{
				ThrowHelper.ThrowStartOrEndArgumentValidationException(0L);
			}
			if ((ulong)(num2 + length) > num3)
			{
				ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.length);
			}
			int num4 = readOnlySequenceSegment.Memory.Length - (int)num;
			if (num4 < length)
			{
				if (num4 < 0)
				{
					ThrowHelper.ThrowArgumentOutOfRangeException_PositionOutOfRange();
				}
				return SliceImpl(in start, SeekMultiSegment(readOnlySequenceSegment.Next, endObject, (int)index2, length - num4, ExceptionArgument.length));
			}
		}
		return SliceImpl(new SequencePosition(obj, (int)num), new SequencePosition(obj, (int)num + (int)length));
	}

	public ReadOnlySequence<T> Slice(int start, int length)
	{
		return Slice((long)start, (long)length);
	}

	public ReadOnlySequence<T> Slice(int start, SequencePosition end)
	{
		return Slice((long)start, end);
	}

	public ReadOnlySequence<T> Slice(SequencePosition start, int length)
	{
		return Slice(start, (long)length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public ReadOnlySequence<T> Slice(SequencePosition start, SequencePosition end)
	{
		BoundsCheck((uint)GetIndex(in start), start.GetObject(), (uint)GetIndex(in end), end.GetObject());
		return SliceImpl(in start, in end);
	}

	[MethodImpl((MethodImplOptions)256)]
	public ReadOnlySequence<T> Slice(SequencePosition start)
	{
		bool flag = start.GetObject() != null;
		BoundsCheck(in start, flag);
		return SliceImpl(flag ? start : Start);
	}

	public ReadOnlySequence<T> Slice(long start)
	{
		if (start < 0)
		{
			ThrowHelper.ThrowStartOrEndArgumentValidationException(start);
		}
		if (start == 0L)
		{
			return this;
		}
		return SliceImpl(Seek(start, ExceptionArgument.start));
	}

	public override string ToString()
	{
		if (typeof(T) == typeof(char))
		{
			ReadOnlySequence<T> source = this;
			ReadOnlySequence<char> readOnlySequence = Unsafe.As<ReadOnlySequence<T>, ReadOnlySequence<char>>(ref source);
			if (SequenceMarshal.TryGetString(readOnlySequence, out var text, out var start, out var length))
			{
				return text.Substring(start, length);
			}
			if (Length < int.MaxValue)
			{
				return string.Create((int)Length, readOnlySequence, delegate(Span<char> span, ReadOnlySequence<char> sequence)
				{
					sequence.CopyTo(span);
				});
			}
		}
		return $"System.Buffers.ReadOnlySequence<{typeof(T).Name}>[{Length}]";
	}

	public Enumerator GetEnumerator()
	{
		return new Enumerator(this);
	}

	public SequencePosition GetPosition(long offset)
	{
		if (offset < 0)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException_OffsetOutOfRange();
		}
		return Seek(offset);
	}

	public SequencePosition GetPosition(long offset, SequencePosition origin)
	{
		if (offset < 0)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException_OffsetOutOfRange();
		}
		return Seek(in origin, offset);
	}

	public bool TryGet(ref SequencePosition position, out ReadOnlyMemory<T> memory, bool advance = true)
	{
		bool result = TryGetBuffer(in position, out memory, out var next);
		if (advance)
		{
			position = next;
		}
		return result;
	}

	[MethodImpl((MethodImplOptions)256)]
	internal bool TryGetBuffer(in SequencePosition position, out ReadOnlyMemory<T> memory, out SequencePosition next)
	{
		object obj = position.GetObject();
		next = default(SequencePosition);
		if (obj == null)
		{
			memory = default(ReadOnlyMemory<T>);
			return false;
		}
		SequenceType sequenceType = GetSequenceType();
		object endObject = _endObject;
		int index = GetIndex(in position);
		int index2 = GetIndex(_endInteger);
		if (sequenceType == SequenceType.MultiSegment)
		{
			ReadOnlySequenceSegment<T> readOnlySequenceSegment = (ReadOnlySequenceSegment<T>)obj;
			if (readOnlySequenceSegment != endObject)
			{
				ReadOnlySequenceSegment<T> next2 = readOnlySequenceSegment.Next;
				if (next2 == null)
				{
					ThrowHelper.ThrowInvalidOperationException_EndPositionNotReached();
				}
				next = new SequencePosition(next2, 0);
				memory = readOnlySequenceSegment.Memory.Slice(index);
			}
			else
			{
				memory = readOnlySequenceSegment.Memory.Slice(index, index2 - index);
			}
		}
		else
		{
			if (obj != endObject)
			{
				ThrowHelper.ThrowInvalidOperationException_EndPositionNotReached();
			}
			if (sequenceType == SequenceType.Array)
			{
				memory = new ReadOnlyMemory<T>((T[])obj, index, index2 - index);
			}
			else if (typeof(T) == typeof(char) && sequenceType == SequenceType.String)
			{
				memory = (ReadOnlyMemory<T>)(object)((string)obj).AsMemory(index, index2 - index);
			}
			else
			{
				memory = ((MemoryManager<T>)obj).Memory.Slice(index, index2 - index);
			}
		}
		return true;
	}

	[MethodImpl((MethodImplOptions)256)]
	private ReadOnlyMemory<T> GetFirstBuffer()
	{
		object startObject = _startObject;
		if (startObject == null)
		{
			return default(ReadOnlyMemory<T>);
		}
		int startInteger = _startInteger;
		int endInteger = _endInteger;
		bool flag = startObject != _endObject;
		if ((startInteger | endInteger) >= 0)
		{
			ReadOnlyMemory<T> memory = ((ReadOnlySequenceSegment<T>)startObject).Memory;
			if (flag)
			{
				return memory.Slice(startInteger);
			}
			return memory.Slice(startInteger, endInteger - startInteger);
		}
		return GetFirstBufferSlow(startObject, flag);
	}

	[MethodImpl((MethodImplOptions)8)]
	private ReadOnlyMemory<T> GetFirstBufferSlow(object startObject, bool isMultiSegment)
	{
		if (isMultiSegment)
		{
			ThrowHelper.ThrowInvalidOperationException_EndPositionNotReached();
		}
		int startInteger = _startInteger;
		int endInteger = _endInteger;
		if (startInteger >= 0)
		{
			return new ReadOnlyMemory<T>((T[])startObject, startInteger, (endInteger & 0x7FFFFFFF) - startInteger);
		}
		if (typeof(T) == typeof(char) && endInteger < 0)
		{
			return (ReadOnlyMemory<T>)(object)((string)startObject).AsMemory(startInteger & 0x7FFFFFFF, endInteger - startInteger);
		}
		startInteger &= 0x7FFFFFFF;
		return ((MemoryManager<T>)startObject).Memory.Slice(startInteger, endInteger - startInteger);
	}

	[MethodImpl((MethodImplOptions)256)]
	private ReadOnlySpan<T> GetFirstSpan()
	{
		object startObject = _startObject;
		if (startObject == null)
		{
			return default(ReadOnlySpan<T>);
		}
		int startInteger = _startInteger;
		int endInteger = _endInteger;
		bool flag = startObject != _endObject;
		if ((startInteger | endInteger) >= 0)
		{
			ReadOnlySpan<T> span = ((ReadOnlySequenceSegment<T>)startObject).Memory.Span;
			if (flag)
			{
				return span.Slice(startInteger);
			}
			return span.Slice(startInteger, endInteger - startInteger);
		}
		return GetFirstSpanSlow(startObject, flag);
	}

	[MethodImpl((MethodImplOptions)8)]
	private ReadOnlySpan<T> GetFirstSpanSlow(object startObject, bool isMultiSegment)
	{
		if (isMultiSegment)
		{
			ThrowHelper.ThrowInvalidOperationException_EndPositionNotReached();
		}
		int startInteger = _startInteger;
		int endInteger = _endInteger;
		if (startInteger >= 0)
		{
			return ((ReadOnlySpan<T>)(T[])startObject).Slice(startInteger, (endInteger & 0x7FFFFFFF) - startInteger);
		}
		if (typeof(T) == typeof(char) && endInteger < 0)
		{
			return ((ReadOnlyMemory<T>)(object)((string)startObject).AsMemory()).Span.Slice(startInteger & 0x7FFFFFFF, endInteger - startInteger);
		}
		startInteger &= 0x7FFFFFFF;
		return ((MemoryManager<T>)startObject).Memory.Span.Slice(startInteger, endInteger - startInteger);
	}

	[MethodImpl((MethodImplOptions)256)]
	internal SequencePosition Seek(long offset, ExceptionArgument exceptionArgument = ExceptionArgument.offset)
	{
		object startObject = _startObject;
		object endObject = _endObject;
		int index = GetIndex(_startInteger);
		int index2 = GetIndex(_endInteger);
		if (startObject != endObject)
		{
			ReadOnlySequenceSegment<T> readOnlySequenceSegment = (ReadOnlySequenceSegment<T>)startObject;
			int num = readOnlySequenceSegment.Memory.Length - index;
			if (num <= offset)
			{
				if (num < 0)
				{
					ThrowHelper.ThrowArgumentOutOfRangeException_PositionOutOfRange();
				}
				return SeekMultiSegment(readOnlySequenceSegment.Next, endObject, index2, offset - num, exceptionArgument);
			}
		}
		else if (index2 - index < offset)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(exceptionArgument);
		}
		return new SequencePosition(startObject, index + (int)offset);
	}

	[MethodImpl((MethodImplOptions)256)]
	private SequencePosition Seek(in SequencePosition start, long offset)
	{
		object obj = start.GetObject();
		object endObject = _endObject;
		int index = GetIndex(in start);
		int index2 = GetIndex(_endInteger);
		if (obj != endObject)
		{
			ReadOnlySequenceSegment<T> readOnlySequenceSegment = (ReadOnlySequenceSegment<T>)obj;
			int num = readOnlySequenceSegment.Memory.Length - index;
			if (num <= offset)
			{
				if (num < 0)
				{
					ThrowHelper.ThrowArgumentOutOfRangeException_PositionOutOfRange();
				}
				return SeekMultiSegment(readOnlySequenceSegment.Next, endObject, index2, offset - num, ExceptionArgument.offset);
			}
		}
		else if (index2 - index < offset)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.offset);
		}
		return new SequencePosition(obj, index + (int)offset);
	}

	[MethodImpl((MethodImplOptions)8)]
	private static SequencePosition SeekMultiSegment(ReadOnlySequenceSegment<T> currentSegment, object endObject, int endIndex, long offset, ExceptionArgument argument)
	{
		while (true)
		{
			if (currentSegment != null && currentSegment != endObject)
			{
				int length = currentSegment.Memory.Length;
				if (length > offset)
				{
					break;
				}
				offset -= length;
				currentSegment = currentSegment.Next;
				continue;
			}
			if (currentSegment == null || endIndex < offset)
			{
				ThrowHelper.ThrowArgumentOutOfRangeException(argument);
			}
			break;
		}
		return new SequencePosition(currentSegment, (int)offset);
	}

	private void BoundsCheck(in SequencePosition position, bool positionIsNotNull)
	{
		uint index = (uint)GetIndex(in position);
		object startObject = _startObject;
		object endObject = _endObject;
		uint index2 = (uint)GetIndex(_startInteger);
		uint index3 = (uint)GetIndex(_endInteger);
		if (startObject == endObject)
		{
			if (!InRange(index, index2, index3))
			{
				ThrowHelper.ThrowArgumentOutOfRangeException_PositionOutOfRange();
			}
			return;
		}
		ulong start = (ulong)(((ReadOnlySequenceSegment<T>)startObject).RunningIndex + index2);
		long num = 0L;
		if (positionIsNotNull)
		{
			num = ((ReadOnlySequenceSegment<T>)position.GetObject()).RunningIndex;
		}
		if (!InRange((ulong)(num + index), start, (ulong)(((ReadOnlySequenceSegment<T>)endObject).RunningIndex + index3)))
		{
			ThrowHelper.ThrowArgumentOutOfRangeException_PositionOutOfRange();
		}
	}

	private void BoundsCheck(uint sliceStartIndex, object sliceStartObject, uint sliceEndIndex, object sliceEndObject)
	{
		object startObject = _startObject;
		object endObject = _endObject;
		uint index = (uint)GetIndex(_startInteger);
		uint index2 = (uint)GetIndex(_endInteger);
		if (startObject == endObject)
		{
			if (sliceStartObject != sliceEndObject || sliceStartObject != startObject || sliceStartIndex > sliceEndIndex || sliceStartIndex < index || sliceEndIndex > index2)
			{
				ThrowHelper.ThrowArgumentOutOfRangeException_PositionOutOfRange();
			}
			return;
		}
		ulong num = sliceStartIndex;
		ulong num2 = sliceEndIndex;
		if (sliceStartObject != null)
		{
			num += (ulong)((ReadOnlySequenceSegment<T>)sliceStartObject).RunningIndex;
		}
		if (sliceEndObject != null)
		{
			num2 += (ulong)((ReadOnlySequenceSegment<T>)sliceEndObject).RunningIndex;
		}
		if (num > num2)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException_PositionOutOfRange();
		}
		if (num < (ulong)(((ReadOnlySequenceSegment<T>)startObject).RunningIndex + index) || num2 > (ulong)(((ReadOnlySequenceSegment<T>)endObject).RunningIndex + index2))
		{
			ThrowHelper.ThrowArgumentOutOfRangeException_PositionOutOfRange();
		}
	}

	private static SequencePosition GetEndPosition(ReadOnlySequenceSegment<T> startSegment, object startObject, int startIndex, object endObject, int endIndex, long length)
	{
		int num = startSegment.Memory.Length - startIndex;
		if (num > length)
		{
			return new SequencePosition(startObject, startIndex + (int)length);
		}
		if (num < 0)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException_PositionOutOfRange();
		}
		return SeekMultiSegment(startSegment.Next, endObject, endIndex, length - num, ExceptionArgument.length);
	}

	[MethodImpl((MethodImplOptions)256)]
	private SequenceType GetSequenceType()
	{
		return (SequenceType)(-(2 * (_startInteger >> 31) + (_endInteger >> 31)));
	}

	[MethodImpl((MethodImplOptions)256)]
	private static int GetIndex(in SequencePosition position)
	{
		return position.GetInteger() & 0x7FFFFFFF;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static int GetIndex(int Integer)
	{
		return Integer & 0x7FFFFFFF;
	}

	[MethodImpl((MethodImplOptions)256)]
	private ReadOnlySequence<T> SliceImpl(in SequencePosition start, in SequencePosition end)
	{
		return new ReadOnlySequence<T>(start.GetObject(), GetIndex(in start) | (_startInteger & int.MinValue), end.GetObject(), GetIndex(in end) | (_endInteger & int.MinValue));
	}

	[MethodImpl((MethodImplOptions)256)]
	private ReadOnlySequence<T> SliceImpl(in SequencePosition start)
	{
		return new ReadOnlySequence<T>(start.GetObject(), GetIndex(in start) | (_startInteger & int.MinValue), _endObject, _endInteger);
	}

	[MethodImpl((MethodImplOptions)256)]
	private long GetLength()
	{
		object startObject = _startObject;
		object endObject = _endObject;
		int index = GetIndex(_startInteger);
		int index2 = GetIndex(_endInteger);
		if (startObject != endObject)
		{
			ReadOnlySequenceSegment<T> readOnlySequenceSegment = (ReadOnlySequenceSegment<T>)startObject;
			return ((ReadOnlySequenceSegment<T>)endObject).RunningIndex + index2 - (readOnlySequenceSegment.RunningIndex + index);
		}
		return index2 - index;
	}

	internal bool TryGetReadOnlySequenceSegment(out ReadOnlySequenceSegment<T> startSegment, out int startIndex, out ReadOnlySequenceSegment<T> endSegment, out int endIndex)
	{
		object startObject = _startObject;
		if (startObject == null || GetSequenceType() != SequenceType.MultiSegment)
		{
			startSegment = null;
			startIndex = 0;
			endSegment = null;
			endIndex = 0;
			return false;
		}
		startSegment = (ReadOnlySequenceSegment<T>)startObject;
		startIndex = GetIndex(_startInteger);
		endSegment = (ReadOnlySequenceSegment<T>)_endObject;
		endIndex = GetIndex(_endInteger);
		return true;
	}

	internal bool TryGetArray(out ArraySegment<T> segment)
	{
		if (GetSequenceType() != SequenceType.Array)
		{
			segment = default(ArraySegment<T>);
			return false;
		}
		int index = GetIndex(_startInteger);
		segment = new ArraySegment<T>((T[])_startObject, index, GetIndex(_endInteger) - index);
		return true;
	}

	internal bool TryGetString(out string text, out int start, out int length)
	{
		if (typeof(T) != typeof(char) || GetSequenceType() != SequenceType.String)
		{
			start = 0;
			length = 0;
			text = null;
			return false;
		}
		start = GetIndex(_startInteger);
		length = GetIndex(_endInteger) - start;
		text = (string)_startObject;
		return true;
	}

	private static bool InRange(uint value, uint start, uint end)
	{
		return value - start <= end - start;
	}

	private static bool InRange(ulong value, ulong start, ulong end)
	{
		return value - start <= end - start;
	}

	[MethodImpl((MethodImplOptions)256)]
	internal void GetFirstSpan(out ReadOnlySpan<T> first, out SequencePosition next)
	{
		first = default(ReadOnlySpan<T>);
		next = default(SequencePosition);
		object startObject = _startObject;
		int startInteger = _startInteger;
		if (startObject == null)
		{
			return;
		}
		bool flag = startObject != _endObject;
		int endInteger = _endInteger;
		if (startInteger >= 0)
		{
			if (endInteger >= 0)
			{
				ReadOnlySequenceSegment<T> readOnlySequenceSegment = (ReadOnlySequenceSegment<T>)startObject;
				next = new SequencePosition(readOnlySequenceSegment.Next, 0);
				first = readOnlySequenceSegment.Memory.Span;
				if (flag)
				{
					first = first.Slice(startInteger);
				}
				else
				{
					first = first.Slice(startInteger, endInteger - startInteger);
				}
			}
			else
			{
				if (flag)
				{
					ThrowHelper.ThrowInvalidOperationException_EndPositionNotReached();
				}
				first = new ReadOnlySpan<T>((T[])startObject, startInteger, (endInteger & 0x7FFFFFFF) - startInteger);
			}
		}
		else
		{
			first = GetFirstSpanSlow(startObject, startInteger, endInteger, flag);
		}
	}

	[MethodImpl((MethodImplOptions)8)]
	private static ReadOnlySpan<T> GetFirstSpanSlow(object startObject, int startIndex, int endIndex, bool hasMultipleSegments)
	{
		if (hasMultipleSegments)
		{
			ThrowHelper.ThrowInvalidOperationException_EndPositionNotReached();
		}
		if (typeof(T) == typeof(char) && endIndex < 0)
		{
			ReadOnlySpan<char> span = ((string)startObject).AsSpan(startIndex & 0x7FFFFFFF, endIndex - startIndex);
			return MemoryMarshal.CreateReadOnlySpan(ref Unsafe.As<char, T>(ref MemoryMarshal.GetReference(span)), span.Length);
		}
		startIndex &= 0x7FFFFFFF;
		return ((MemoryManager<T>)startObject).Memory.Span.Slice(startIndex, endIndex - startIndex);
	}
}
internal static class ReadOnlySequence
{
	[MethodImpl((MethodImplOptions)256)]
	public static int SegmentToSequenceStart(int startIndex)
	{
		return startIndex | 0;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int SegmentToSequenceEnd(int endIndex)
	{
		return endIndex | 0;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int ArrayToSequenceStart(int startIndex)
	{
		return startIndex | 0;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int ArrayToSequenceEnd(int endIndex)
	{
		return endIndex | int.MinValue;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int MemoryManagerToSequenceStart(int startIndex)
	{
		return startIndex | int.MinValue;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int MemoryManagerToSequenceEnd(int endIndex)
	{
		return endIndex | 0;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int StringToSequenceStart(int startIndex)
	{
		return startIndex | int.MinValue;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int StringToSequenceEnd(int endIndex)
	{
		return endIndex | int.MinValue;
	}
}
