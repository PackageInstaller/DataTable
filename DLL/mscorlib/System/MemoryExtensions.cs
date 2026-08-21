using System.Globalization;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace System;

public static class MemoryExtensions
{
	[MethodImpl((MethodImplOptions)256)]
	internal static bool EqualsOrdinal(this ReadOnlySpan<char> span, ReadOnlySpan<char> value)
	{
		if (span.Length != value.Length)
		{
			return false;
		}
		if (value.Length == 0)
		{
			return true;
		}
		return span.SequenceEqual(value);
	}

	[MethodImpl((MethodImplOptions)256)]
	internal static bool EqualsOrdinalIgnoreCase(this ReadOnlySpan<char> span, ReadOnlySpan<char> value)
	{
		if (span.Length != value.Length)
		{
			return false;
		}
		if (value.Length == 0)
		{
			return true;
		}
		return CompareInfo.CompareOrdinalIgnoreCase(span, value) == 0;
	}

	internal static bool Contains(this ReadOnlySpan<char> source, char value)
	{
		for (int i = 0; i < source.Length; i++)
		{
			if (source[i] == value)
			{
				return true;
			}
		}
		return false;
	}

	public static int IndexOf(this ReadOnlySpan<char> span, ReadOnlySpan<char> value, StringComparison comparisonType)
	{
		string.CheckStringComparison(comparisonType);
		if (value.Length == 0)
		{
			return 0;
		}
		if (span.Length == 0)
		{
			return -1;
		}
		return comparisonType switch
		{
			StringComparison.CurrentCulture => SpanHelpers.IndexOfCultureHelper(span, value, CultureInfo.CurrentCulture.CompareInfo), 
			StringComparison.CurrentCultureIgnoreCase => SpanHelpers.IndexOfCultureIgnoreCaseHelper(span, value, CultureInfo.CurrentCulture.CompareInfo), 
			StringComparison.InvariantCulture => SpanHelpers.IndexOfCultureHelper(span, value, CompareInfo.Invariant), 
			StringComparison.InvariantCultureIgnoreCase => SpanHelpers.IndexOfCultureIgnoreCaseHelper(span, value, CompareInfo.Invariant), 
			StringComparison.Ordinal => SpanHelpers.IndexOfOrdinalHelper(span, value, ignoreCase: false), 
			StringComparison.OrdinalIgnoreCase => SpanHelpers.IndexOfOrdinalHelper(span, value, ignoreCase: true), 
			_ => -1, 
		};
	}

	public static int ToUpperInvariant(this ReadOnlySpan<char> source, Span<char> destination)
	{
		if (destination.Length < source.Length)
		{
			return -1;
		}
		if (GlobalizationMode.Invariant)
		{
			CultureInfo.InvariantCulture.TextInfo.ToUpperAsciiInvariant(source, destination);
		}
		else
		{
			CultureInfo.InvariantCulture.TextInfo.ChangeCase(source, destination, toUpper: true);
		}
		return source.Length;
	}

	public static bool EndsWith(this ReadOnlySpan<char> span, ReadOnlySpan<char> value, StringComparison comparisonType)
	{
		if (value.Length == 0)
		{
			string.CheckStringComparison(comparisonType);
			return true;
		}
		return comparisonType switch
		{
			StringComparison.CurrentCulture => SpanHelpers.EndsWithCultureHelper(span, value, CultureInfo.CurrentCulture.CompareInfo), 
			StringComparison.CurrentCultureIgnoreCase => SpanHelpers.EndsWithCultureIgnoreCaseHelper(span, value, CultureInfo.CurrentCulture.CompareInfo), 
			StringComparison.InvariantCulture => SpanHelpers.EndsWithCultureHelper(span, value, CompareInfo.Invariant), 
			StringComparison.InvariantCultureIgnoreCase => SpanHelpers.EndsWithCultureIgnoreCaseHelper(span, value, CompareInfo.Invariant), 
			StringComparison.Ordinal => span.EndsWith(value), 
			StringComparison.OrdinalIgnoreCase => SpanHelpers.EndsWithOrdinalIgnoreCaseHelper(span, value), 
			_ => throw new ArgumentException("The string comparison type passed in is currently not supported.", "comparisonType"), 
		};
	}

	public static bool StartsWith(this ReadOnlySpan<char> span, ReadOnlySpan<char> value, StringComparison comparisonType)
	{
		if (value.Length == 0)
		{
			string.CheckStringComparison(comparisonType);
			return true;
		}
		return comparisonType switch
		{
			StringComparison.CurrentCulture => SpanHelpers.StartsWithCultureHelper(span, value, CultureInfo.CurrentCulture.CompareInfo), 
			StringComparison.CurrentCultureIgnoreCase => SpanHelpers.StartsWithCultureIgnoreCaseHelper(span, value, CultureInfo.CurrentCulture.CompareInfo), 
			StringComparison.InvariantCulture => SpanHelpers.StartsWithCultureHelper(span, value, CompareInfo.Invariant), 
			StringComparison.InvariantCultureIgnoreCase => SpanHelpers.StartsWithCultureIgnoreCaseHelper(span, value, CompareInfo.Invariant), 
			StringComparison.Ordinal => span.StartsWith(value), 
			StringComparison.OrdinalIgnoreCase => SpanHelpers.StartsWithOrdinalIgnoreCaseHelper(span, value), 
			_ => throw new ArgumentException("The string comparison type passed in is currently not supported.", "comparisonType"), 
		};
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Span<T> AsSpan<T>(this T[] array, int start)
	{
		if (array == null)
		{
			if (start != 0)
			{
				ThrowHelper.ThrowArgumentOutOfRangeException();
			}
			return default(Span<T>);
		}
		if (default(T) == null && array.GetType() != typeof(T[]))
		{
			ThrowHelper.ThrowArrayTypeMismatchException();
		}
		if ((uint)start > (uint)array.Length)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException();
		}
		return new Span<T>(ref Unsafe.Add(ref Unsafe.As<byte, T>(ref array.GetRawSzArrayData()), start), array.Length - start);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Span<T> AsSpan<T>(this T[] array, Range range)
	{
		if (array == null)
		{
			Index start = range.Start;
			Index end = range.End;
			if (!start.Equals(Index.Start) || !end.Equals(Index.Start))
			{
				ThrowHelper.ThrowArgumentNullException(ExceptionArgument.array);
			}
			return default(Span<T>);
		}
		if (default(T) == null && array.GetType() != typeof(T[]))
		{
			ThrowHelper.ThrowArrayTypeMismatchException();
		}
		var (elementOffset, length) = range.GetOffsetAndLength(array.Length);
		return new Span<T>(ref Unsafe.Add(ref Unsafe.As<byte, T>(ref array.GetRawSzArrayData()), elementOffset), length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static ReadOnlySpan<char> AsSpan(this string text)
	{
		if (text == null)
		{
			return default(ReadOnlySpan<char>);
		}
		return new ReadOnlySpan<char>(ref text.GetRawStringData(), text.Length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static ReadOnlySpan<char> AsSpan(this string text, int start)
	{
		if (text == null)
		{
			if (start != 0)
			{
				ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.start);
			}
			return default(ReadOnlySpan<char>);
		}
		if ((uint)start > (uint)text.Length)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.start);
		}
		return new ReadOnlySpan<char>(ref Unsafe.Add(ref text.GetRawStringData(), start), text.Length - start);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static ReadOnlySpan<char> AsSpan(this string text, int start, int length)
	{
		if (text == null)
		{
			if (start != 0 || length != 0)
			{
				ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.start);
			}
			return default(ReadOnlySpan<char>);
		}
		if ((uint)start > (uint)text.Length || (uint)length > (uint)(text.Length - start))
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.start);
		}
		return new ReadOnlySpan<char>(ref Unsafe.Add(ref text.GetRawStringData(), start), length);
	}

	public static ReadOnlyMemory<char> AsMemory(this string text)
	{
		if (text == null)
		{
			return default(ReadOnlyMemory<char>);
		}
		return new ReadOnlyMemory<char>(text, 0, text.Length);
	}

	public static ReadOnlyMemory<char> AsMemory(this string text, int start, int length)
	{
		if (text == null)
		{
			if (start != 0 || length != 0)
			{
				ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.start);
			}
			return default(ReadOnlyMemory<char>);
		}
		if ((uint)start > (uint)text.Length || (uint)length > (uint)(text.Length - start))
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.start);
		}
		return new ReadOnlyMemory<char>(text, start, length);
	}

	public static ReadOnlySpan<char> Trim(this ReadOnlySpan<char> span)
	{
		return span.TrimStart().TrimEnd();
	}

	public static ReadOnlySpan<char> TrimStart(this ReadOnlySpan<char> span)
	{
		int i;
		for (i = 0; i < span.Length && char.IsWhiteSpace(span[i]); i++)
		{
		}
		return span.Slice(i);
	}

	public static ReadOnlySpan<char> TrimEnd(this ReadOnlySpan<char> span)
	{
		int num = span.Length - 1;
		while (num >= 0 && char.IsWhiteSpace(span[num]))
		{
			num--;
		}
		return span.Slice(0, num + 1);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int IndexOf<T>(this Span<T> span, T value) where T : IEquatable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.IndexOf(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), Unsafe.As<T, byte>(ref value), span.Length);
		}
		if (typeof(T) == typeof(char))
		{
			return SpanHelpers.IndexOf(ref Unsafe.As<T, char>(ref MemoryMarshal.GetReference(span)), Unsafe.As<T, char>(ref value), span.Length);
		}
		return SpanHelpers.IndexOf(ref MemoryMarshal.GetReference(span), value, span.Length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int IndexOf<T>(this ReadOnlySpan<T> span, T value) where T : IEquatable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.IndexOf(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), Unsafe.As<T, byte>(ref value), span.Length);
		}
		if (typeof(T) == typeof(char))
		{
			return SpanHelpers.IndexOf(ref Unsafe.As<T, char>(ref MemoryMarshal.GetReference(span)), Unsafe.As<T, char>(ref value), span.Length);
		}
		return SpanHelpers.IndexOf(ref MemoryMarshal.GetReference(span), value, span.Length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int IndexOfAny<T>(this ReadOnlySpan<T> span, ReadOnlySpan<T> values) where T : IEquatable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.IndexOfAny(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), span.Length, ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(values)), values.Length);
		}
		return SpanHelpers.IndexOfAny(ref MemoryMarshal.GetReference(span), span.Length, ref MemoryMarshal.GetReference(values), values.Length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool SequenceEqual<T>(this ReadOnlySpan<T> span, ReadOnlySpan<T> other) where T : IEquatable<T>
	{
		int length = span.Length;
		if (default(T) != null && IsTypeComparableAsBytes<T>(out var size))
		{
			if (length == other.Length)
			{
				return SpanHelpers.SequenceEqual(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(other)), (ulong)length * size);
			}
			return false;
		}
		if (length == other.Length)
		{
			return SpanHelpers.SequenceEqual(ref MemoryMarshal.GetReference(span), ref MemoryMarshal.GetReference(other), length);
		}
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool StartsWith<T>(this ReadOnlySpan<T> span, ReadOnlySpan<T> value) where T : IEquatable<T>
	{
		int length = value.Length;
		if (default(T) != null && IsTypeComparableAsBytes<T>(out var size))
		{
			if (length <= span.Length)
			{
				return SpanHelpers.SequenceEqual(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(value)), (ulong)length * size);
			}
			return false;
		}
		if (length <= span.Length)
		{
			return SpanHelpers.SequenceEqual(ref MemoryMarshal.GetReference(span), ref MemoryMarshal.GetReference(value), length);
		}
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool EndsWith<T>(this ReadOnlySpan<T> span, ReadOnlySpan<T> value) where T : IEquatable<T>
	{
		int length = span.Length;
		int length2 = value.Length;
		if (default(T) != null && IsTypeComparableAsBytes<T>(out var size))
		{
			if (length2 <= length)
			{
				return SpanHelpers.SequenceEqual(ref Unsafe.As<T, byte>(ref Unsafe.Add(ref MemoryMarshal.GetReference(span), length - length2)), ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(value)), (ulong)length2 * size);
			}
			return false;
		}
		if (length2 <= length)
		{
			return SpanHelpers.SequenceEqual(ref Unsafe.Add(ref MemoryMarshal.GetReference(span), length - length2), ref MemoryMarshal.GetReference(value), length2);
		}
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Span<T> AsSpan<T>(this T[] array)
	{
		return new Span<T>(array);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Span<T> AsSpan<T>(this T[] array, int start, int length)
	{
		return new Span<T>(array, start, length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Span<T> AsSpan<T>(this ArraySegment<T> segment, int start)
	{
		if ((uint)start > segment.Count)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.start);
		}
		return new Span<T>(segment.Array, segment.Offset + start, segment.Count - start);
	}

	public static Memory<T> AsMemory<T>(this T[] array, int start)
	{
		return new Memory<T>(array, start);
	}

	public static Memory<T> AsMemory<T>(this T[] array, int start, int length)
	{
		return new Memory<T>(array, start, length);
	}

	public static Memory<T> AsMemory<T>(this ArraySegment<T> segment)
	{
		return new Memory<T>(segment.Array, segment.Offset, segment.Count);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static void CopyTo<T>(this T[] source, Span<T> destination)
	{
		new ReadOnlySpan<T>(source).CopyTo(destination);
	}

	[MethodImpl((MethodImplOptions)256)]
	private static bool IsTypeComparableAsBytes<T>(out ulong size)
	{
		if (typeof(T) == typeof(byte) || typeof(T) == typeof(sbyte))
		{
			size = 1uL;
			return true;
		}
		if (typeof(T) == typeof(char) || typeof(T) == typeof(short) || typeof(T) == typeof(ushort))
		{
			size = 2uL;
			return true;
		}
		if (typeof(T) == typeof(int) || typeof(T) == typeof(uint))
		{
			size = 4uL;
			return true;
		}
		if (typeof(T) == typeof(long) || typeof(T) == typeof(ulong))
		{
			size = 8uL;
			return true;
		}
		size = 0uL;
		return false;
	}
}
