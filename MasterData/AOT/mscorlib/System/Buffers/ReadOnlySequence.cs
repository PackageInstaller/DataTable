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

		private ReadOnlyMemory<T> _currentMemory = default;

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

	public bool IsSingleSegment
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return _startObject == _endObject;
		}
	}

	public ReadOnlyMemory<T> First => GetFirstBuffer();

	public SequencePosition Start
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new SequencePosition(_startObject, _startInteger);
		}
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
				return string.Create((int)Length, readOnlySequence, (Span<char> span, ReadOnlySequence<char> sequence) =>
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
		next = default;
		if (obj == null)
		{
			memory = default;
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
			return default;
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
}
internal static class ReadOnlySequence
{
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
}
