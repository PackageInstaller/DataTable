using System.Buffers;
using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace System;

[DebuggerTypeProxy(typeof(MemoryDebugView<>))]
[DebuggerDisplay("{ToString(),raw}")]
public readonly struct ReadOnlyMemory<T> : IEquatable<ReadOnlyMemory<T>>
{
	private readonly object _object;

	private readonly int _index;

	private readonly int _length;

	public static ReadOnlyMemory<T> Empty => default(ReadOnlyMemory<T>);

	public int Length => _length & 0x7FFFFFFF;

	public ReadOnlySpan<T> Span
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			if (_index < 0)
			{
				return ((MemoryManager<T>)_object).GetSpan().Slice(_index & 0x7FFFFFFF, _length);
			}
			ReadOnlySpan<T> result;
			if (typeof(T) == typeof(char) && _object is string text)
			{
				result = new ReadOnlySpan<T>(ref Unsafe.As<char, T>(ref text.GetRawStringData()), text.Length);
				return result.Slice(_index, _length);
			}
			if (_object != null)
			{
				return new ReadOnlySpan<T>((T[])_object, _index, _length & 0x7FFFFFFF);
			}
			result = default(ReadOnlySpan<T>);
			return result;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public ReadOnlyMemory(T[] array)
	{
		if (array == null)
		{
			this = default(ReadOnlyMemory<T>);
			return;
		}
		_object = array;
		_index = 0;
		_length = array.Length;
	}

	[MethodImpl((MethodImplOptions)256)]
	public ReadOnlyMemory(T[] array, int start, int length)
	{
		if (array == null)
		{
			if (start != 0 || length != 0)
			{
				ThrowHelper.ThrowArgumentOutOfRangeException();
			}
			this = default(ReadOnlyMemory<T>);
			return;
		}
		if ((uint)start > (uint)array.Length || (uint)length > (uint)(array.Length - start))
		{
			ThrowHelper.ThrowArgumentOutOfRangeException();
		}
		_object = array;
		_index = start;
		_length = length;
	}

	[MethodImpl((MethodImplOptions)256)]
	internal ReadOnlyMemory(object obj, int start, int length)
	{
		_object = obj;
		_index = start;
		_length = length;
	}

	public static implicit operator ReadOnlyMemory<T>(T[] array)
	{
		return new ReadOnlyMemory<T>(array);
	}

	public static implicit operator ReadOnlyMemory<T>(ArraySegment<T> segment)
	{
		return new ReadOnlyMemory<T>(segment.Array, segment.Offset, segment.Count);
	}

	public override string ToString()
	{
		if (typeof(T) == typeof(char))
		{
			if (!(_object is string text))
			{
				return Span.ToString();
			}
			return text.Substring(_index, _length & 0x7FFFFFFF);
		}
		return $"System.ReadOnlyMemory<{typeof(T).Name}>[{_length & 0x7FFFFFFF}]";
	}

	[MethodImpl((MethodImplOptions)256)]
	public ReadOnlyMemory<T> Slice(int start)
	{
		int length = _length;
		int num = length & 0x7FFFFFFF;
		if ((uint)start > (uint)num)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.start);
		}
		return new ReadOnlyMemory<T>(_object, _index + start, length - start);
	}

	[MethodImpl((MethodImplOptions)256)]
	public ReadOnlyMemory<T> Slice(int start, int length)
	{
		int length2 = _length;
		int num = _length & 0x7FFFFFFF;
		if ((uint)start > (uint)num || (uint)length > (uint)(num - start))
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.start);
		}
		return new ReadOnlyMemory<T>(_object, _index + start, length | (length2 & int.MinValue));
	}

	public override bool Equals(object obj)
	{
		if (obj is ReadOnlyMemory<T> other)
		{
			return Equals(other);
		}
		if (obj is Memory<T> memory)
		{
			return Equals(memory);
		}
		return false;
	}

	public bool Equals(ReadOnlyMemory<T> other)
	{
		if (_object == other._object && _index == other._index)
		{
			return _length == other._length;
		}
		return false;
	}

	public override int GetHashCode()
	{
		if (_object == null)
		{
			return 0;
		}
		return CombineHashCodes(_object.GetHashCode(), _index.GetHashCode(), _length.GetHashCode());
	}

	private static int CombineHashCodes(int left, int right)
	{
		return ((left << 5) + left) ^ right;
	}

	private static int CombineHashCodes(int h1, int h2, int h3)
	{
		return CombineHashCodes(CombineHashCodes(h1, h2), h3);
	}

	[MethodImpl((MethodImplOptions)256)]
	internal object GetObjectStartLength(out int start, out int length)
	{
		start = _index;
		length = _length;
		return _object;
	}
}
