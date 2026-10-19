using System.Collections.Generic;
using System.Globalization;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace System;

public static class MemoryExtensions
{
	public static bool Contains(this ReadOnlySpan<char> span, ReadOnlySpan<char> value, StringComparison comparisonType)
	{
		return span.IndexOf(value, comparisonType) >= 0;
	}

	public static bool Equals(this ReadOnlySpan<char> span, ReadOnlySpan<char> other, StringComparison comparisonType)
	{
		string.CheckStringComparison(comparisonType);
		return comparisonType switch
		{
			StringComparison.CurrentCulture => CultureInfo.CurrentCulture.CompareInfo.CompareOptionNone(span, other) == 0, 
			StringComparison.CurrentCultureIgnoreCase => CultureInfo.CurrentCulture.CompareInfo.CompareOptionIgnoreCase(span, other) == 0, 
			StringComparison.InvariantCulture => CompareInfo.Invariant.CompareOptionNone(span, other) == 0, 
			StringComparison.InvariantCultureIgnoreCase => CompareInfo.Invariant.CompareOptionIgnoreCase(span, other) == 0, 
			StringComparison.Ordinal => span.EqualsOrdinal(other), 
			StringComparison.OrdinalIgnoreCase => span.EqualsOrdinalIgnoreCase(other), 
			_ => false, 
		};
	}

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

	public static int CompareTo(this ReadOnlySpan<char> span, ReadOnlySpan<char> other, StringComparison comparisonType)
	{
		string.CheckStringComparison(comparisonType);
		switch (comparisonType)
		{
		case StringComparison.CurrentCulture:
			return CultureInfo.CurrentCulture.CompareInfo.CompareOptionNone(span, other);
		case StringComparison.CurrentCultureIgnoreCase:
			return CultureInfo.CurrentCulture.CompareInfo.CompareOptionIgnoreCase(span, other);
		case StringComparison.InvariantCulture:
			return CompareInfo.Invariant.CompareOptionNone(span, other);
		case StringComparison.InvariantCultureIgnoreCase:
			return CompareInfo.Invariant.CompareOptionIgnoreCase(span, other);
		case StringComparison.Ordinal:
			if (span.Length == 0 || other.Length == 0)
			{
				return span.Length - other.Length;
			}
			return string.CompareOrdinal(span, other);
		case StringComparison.OrdinalIgnoreCase:
			return CompareInfo.CompareOrdinalIgnoreCase(span, other);
		default:
			return 0;
		}
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

	public static int ToLower(this ReadOnlySpan<char> source, Span<char> destination, CultureInfo culture)
	{
		if (culture == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.culture);
		}
		if (destination.Length < source.Length)
		{
			return -1;
		}
		if (GlobalizationMode.Invariant)
		{
			culture.TextInfo.ToLowerAsciiInvariant(source, destination);
		}
		else
		{
			culture.TextInfo.ChangeCase(source, destination, toUpper: false);
		}
		return source.Length;
	}

	public static int ToLowerInvariant(this ReadOnlySpan<char> source, Span<char> destination)
	{
		if (destination.Length < source.Length)
		{
			return -1;
		}
		if (GlobalizationMode.Invariant)
		{
			CultureInfo.InvariantCulture.TextInfo.ToLowerAsciiInvariant(source, destination);
		}
		else
		{
			CultureInfo.InvariantCulture.TextInfo.ChangeCase(source, destination, toUpper: false);
		}
		return source.Length;
	}

	public static int ToUpper(this ReadOnlySpan<char> source, Span<char> destination, CultureInfo culture)
	{
		if (culture == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.culture);
		}
		if (destination.Length < source.Length)
		{
			return -1;
		}
		if (GlobalizationMode.Invariant)
		{
			culture.TextInfo.ToUpperAsciiInvariant(source, destination);
		}
		else
		{
			culture.TextInfo.ChangeCase(source, destination, toUpper: true);
		}
		return source.Length;
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
			return default;
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
	public static Span<T> AsSpan<T>(this T[] array, Index startIndex)
	{
		if (array == null)
		{
			if (!startIndex.Equals(Index.Start))
			{
				ThrowHelper.ThrowArgumentNullException(ExceptionArgument.array);
			}
			return default;
		}
		if (default(T) == null && array.GetType() != typeof(T[]))
		{
			ThrowHelper.ThrowArrayTypeMismatchException();
		}
		int offset = startIndex.GetOffset(array.Length);
		if ((uint)offset > (uint)array.Length)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException();
		}
		return new Span<T>(ref Unsafe.Add(ref Unsafe.As<byte, T>(ref array.GetRawSzArrayData()), offset), array.Length - offset);
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
			return default;
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
			return default;
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
			return default;
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
			return default;
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
			return default;
		}
		return new ReadOnlyMemory<char>(text, 0, text.Length);
	}

	public static ReadOnlyMemory<char> AsMemory(this string text, int start)
	{
		if (text == null)
		{
			if (start != 0)
			{
				ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.start);
			}
			return default;
		}
		if ((uint)start > (uint)text.Length)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.start);
		}
		return new ReadOnlyMemory<char>(text, start, text.Length - start);
	}

	public static ReadOnlyMemory<char> AsMemory(this string text, Index startIndex)
	{
		if (text == null)
		{
			if (!startIndex.Equals(Index.Start))
			{
				ThrowHelper.ThrowArgumentNullException(ExceptionArgument.text);
			}
			return default;
		}
		int offset = startIndex.GetOffset(text.Length);
		if ((uint)offset > (uint)text.Length)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException();
		}
		return new ReadOnlyMemory<char>(text, offset, text.Length - offset);
	}

	public static ReadOnlyMemory<char> AsMemory(this string text, int start, int length)
	{
		if (text == null)
		{
			if (start != 0 || length != 0)
			{
				ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.start);
			}
			return default;
		}
		if ((uint)start > (uint)text.Length || (uint)length > (uint)(text.Length - start))
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.start);
		}
		return new ReadOnlyMemory<char>(text, start, length);
	}

	public static ReadOnlyMemory<char> AsMemory(this string text, Range range)
	{
		if (text == null)
		{
			Index start = range.Start;
			Index end = range.End;
			if (!start.Equals(Index.Start) || !end.Equals(Index.Start))
			{
				ThrowHelper.ThrowArgumentNullException(ExceptionArgument.text);
			}
			return default;
		}
		var (start2, length) = range.GetOffsetAndLength(text.Length);
		return new ReadOnlyMemory<char>(text, start2, length);
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

	public static ReadOnlySpan<char> Trim(this ReadOnlySpan<char> span, char trimChar)
	{
		return span.TrimStart(trimChar).TrimEnd(trimChar);
	}

	public static ReadOnlySpan<char> TrimStart(this ReadOnlySpan<char> span, char trimChar)
	{
		int i;
		for (i = 0; i < span.Length && span[i] == trimChar; i++)
		{
		}
		return span.Slice(i);
	}

	public static ReadOnlySpan<char> TrimEnd(this ReadOnlySpan<char> span, char trimChar)
	{
		int num = span.Length - 1;
		while (num >= 0 && span[num] == trimChar)
		{
			num--;
		}
		return span.Slice(0, num + 1);
	}

	public static ReadOnlySpan<char> Trim(this ReadOnlySpan<char> span, ReadOnlySpan<char> trimChars)
	{
		return span.TrimStart(trimChars).TrimEnd(trimChars);
	}

	public static ReadOnlySpan<char> TrimStart(this ReadOnlySpan<char> span, ReadOnlySpan<char> trimChars)
	{
		if (trimChars.IsEmpty)
		{
			return span.TrimStart();
		}
		int i;
		for (i = 0; i < span.Length; i++)
		{
			int num = 0;
			while (num < trimChars.Length)
			{
				if (span[i] != trimChars[num])
				{
					num++;
					continue;
				}
				goto IL_003c;
			}
			break;
			IL_003c:;
		}
		return span.Slice(i);
	}

	public static ReadOnlySpan<char> TrimEnd(this ReadOnlySpan<char> span, ReadOnlySpan<char> trimChars)
	{
		if (trimChars.IsEmpty)
		{
			return span.TrimEnd();
		}
		int num;
		for (num = span.Length - 1; num >= 0; num--)
		{
			int num2 = 0;
			while (num2 < trimChars.Length)
			{
				if (span[num] != trimChars[num2])
				{
					num2++;
					continue;
				}
				goto IL_0044;
			}
			break;
			IL_0044:;
		}
		return span.Slice(0, num + 1);
	}

	public static bool IsWhiteSpace(this ReadOnlySpan<char> span)
	{
		for (int i = 0; i < span.Length; i++)
		{
			if (!char.IsWhiteSpace(span[i]))
			{
				return false;
			}
		}
		return true;
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
	public static int IndexOf<T>(this Span<T> span, ReadOnlySpan<T> value) where T : IEquatable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.IndexOf(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), span.Length, ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(value)), value.Length);
		}
		return SpanHelpers.IndexOf(ref MemoryMarshal.GetReference(span), span.Length, ref MemoryMarshal.GetReference(value), value.Length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int LastIndexOf<T>(this Span<T> span, T value) where T : IEquatable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.LastIndexOf(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), Unsafe.As<T, byte>(ref value), span.Length);
		}
		if (typeof(T) == typeof(char))
		{
			return SpanHelpers.LastIndexOf(ref Unsafe.As<T, char>(ref MemoryMarshal.GetReference(span)), Unsafe.As<T, char>(ref value), span.Length);
		}
		return SpanHelpers.LastIndexOf(ref MemoryMarshal.GetReference(span), value, span.Length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int LastIndexOf<T>(this Span<T> span, ReadOnlySpan<T> value) where T : IEquatable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.LastIndexOf(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), span.Length, ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(value)), value.Length);
		}
		return SpanHelpers.LastIndexOf(ref MemoryMarshal.GetReference(span), span.Length, ref MemoryMarshal.GetReference(value), value.Length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool SequenceEqual<T>(this Span<T> span, ReadOnlySpan<T> other) where T : IEquatable<T>
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

	public static int SequenceCompareTo<T>(this Span<T> span, ReadOnlySpan<T> other) where T : IComparable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.SequenceCompareTo(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), span.Length, ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(other)), other.Length);
		}
		if (typeof(T) == typeof(char))
		{
			return SpanHelpers.SequenceCompareTo(ref Unsafe.As<T, char>(ref MemoryMarshal.GetReference(span)), span.Length, ref Unsafe.As<T, char>(ref MemoryMarshal.GetReference(other)), other.Length);
		}
		return SpanHelpers.SequenceCompareTo(ref MemoryMarshal.GetReference(span), span.Length, ref MemoryMarshal.GetReference(other), other.Length);
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
	public static int IndexOf<T>(this ReadOnlySpan<T> span, ReadOnlySpan<T> value) where T : IEquatable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.IndexOf(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), span.Length, ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(value)), value.Length);
		}
		return SpanHelpers.IndexOf(ref MemoryMarshal.GetReference(span), span.Length, ref MemoryMarshal.GetReference(value), value.Length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int LastIndexOf<T>(this ReadOnlySpan<T> span, T value) where T : IEquatable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.LastIndexOf(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), Unsafe.As<T, byte>(ref value), span.Length);
		}
		if (typeof(T) == typeof(char))
		{
			return SpanHelpers.LastIndexOf(ref Unsafe.As<T, char>(ref MemoryMarshal.GetReference(span)), Unsafe.As<T, char>(ref value), span.Length);
		}
		return SpanHelpers.LastIndexOf(ref MemoryMarshal.GetReference(span), value, span.Length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int LastIndexOf<T>(this ReadOnlySpan<T> span, ReadOnlySpan<T> value) where T : IEquatable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.LastIndexOf(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), span.Length, ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(value)), value.Length);
		}
		return SpanHelpers.LastIndexOf(ref MemoryMarshal.GetReference(span), span.Length, ref MemoryMarshal.GetReference(value), value.Length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int IndexOfAny<T>(this Span<T> span, T value0, T value1) where T : IEquatable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.IndexOfAny(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), Unsafe.As<T, byte>(ref value0), Unsafe.As<T, byte>(ref value1), span.Length);
		}
		return SpanHelpers.IndexOfAny(ref MemoryMarshal.GetReference(span), value0, value1, span.Length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int IndexOfAny<T>(this Span<T> span, T value0, T value1, T value2) where T : IEquatable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.IndexOfAny(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), Unsafe.As<T, byte>(ref value0), Unsafe.As<T, byte>(ref value1), Unsafe.As<T, byte>(ref value2), span.Length);
		}
		return SpanHelpers.IndexOfAny(ref MemoryMarshal.GetReference(span), value0, value1, value2, span.Length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int IndexOfAny<T>(this Span<T> span, ReadOnlySpan<T> values) where T : IEquatable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.IndexOfAny(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), span.Length, ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(values)), values.Length);
		}
		return SpanHelpers.IndexOfAny(ref MemoryMarshal.GetReference(span), span.Length, ref MemoryMarshal.GetReference(values), values.Length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int IndexOfAny<T>(this ReadOnlySpan<T> span, T value0, T value1) where T : IEquatable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.IndexOfAny(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), Unsafe.As<T, byte>(ref value0), Unsafe.As<T, byte>(ref value1), span.Length);
		}
		return SpanHelpers.IndexOfAny(ref MemoryMarshal.GetReference(span), value0, value1, span.Length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int IndexOfAny<T>(this ReadOnlySpan<T> span, T value0, T value1, T value2) where T : IEquatable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.IndexOfAny(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), Unsafe.As<T, byte>(ref value0), Unsafe.As<T, byte>(ref value1), Unsafe.As<T, byte>(ref value2), span.Length);
		}
		return SpanHelpers.IndexOfAny(ref MemoryMarshal.GetReference(span), value0, value1, value2, span.Length);
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
	public static int LastIndexOfAny<T>(this Span<T> span, T value0, T value1) where T : IEquatable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.LastIndexOfAny(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), Unsafe.As<T, byte>(ref value0), Unsafe.As<T, byte>(ref value1), span.Length);
		}
		return SpanHelpers.LastIndexOfAny(ref MemoryMarshal.GetReference(span), value0, value1, span.Length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int LastIndexOfAny<T>(this Span<T> span, T value0, T value1, T value2) where T : IEquatable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.LastIndexOfAny(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), Unsafe.As<T, byte>(ref value0), Unsafe.As<T, byte>(ref value1), Unsafe.As<T, byte>(ref value2), span.Length);
		}
		return SpanHelpers.LastIndexOfAny(ref MemoryMarshal.GetReference(span), value0, value1, value2, span.Length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int LastIndexOfAny<T>(this Span<T> span, ReadOnlySpan<T> values) where T : IEquatable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.LastIndexOfAny(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), span.Length, ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(values)), values.Length);
		}
		return SpanHelpers.LastIndexOfAny(ref MemoryMarshal.GetReference(span), span.Length, ref MemoryMarshal.GetReference(values), values.Length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int LastIndexOfAny<T>(this ReadOnlySpan<T> span, T value0, T value1) where T : IEquatable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.LastIndexOfAny(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), Unsafe.As<T, byte>(ref value0), Unsafe.As<T, byte>(ref value1), span.Length);
		}
		return SpanHelpers.LastIndexOfAny(ref MemoryMarshal.GetReference(span), value0, value1, span.Length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int LastIndexOfAny<T>(this ReadOnlySpan<T> span, T value0, T value1, T value2) where T : IEquatable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.LastIndexOfAny(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), Unsafe.As<T, byte>(ref value0), Unsafe.As<T, byte>(ref value1), Unsafe.As<T, byte>(ref value2), span.Length);
		}
		return SpanHelpers.LastIndexOfAny(ref MemoryMarshal.GetReference(span), value0, value1, value2, span.Length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int LastIndexOfAny<T>(this ReadOnlySpan<T> span, ReadOnlySpan<T> values) where T : IEquatable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.LastIndexOfAny(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), span.Length, ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(values)), values.Length);
		}
		return SpanHelpers.LastIndexOfAny(ref MemoryMarshal.GetReference(span), span.Length, ref MemoryMarshal.GetReference(values), values.Length);
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
	public static int SequenceCompareTo<T>(this ReadOnlySpan<T> span, ReadOnlySpan<T> other) where T : IComparable<T>
	{
		if (typeof(T) == typeof(byte))
		{
			return SpanHelpers.SequenceCompareTo(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(span)), span.Length, ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(other)), other.Length);
		}
		if (typeof(T) == typeof(char))
		{
			return SpanHelpers.SequenceCompareTo(ref Unsafe.As<T, char>(ref MemoryMarshal.GetReference(span)), span.Length, ref Unsafe.As<T, char>(ref MemoryMarshal.GetReference(other)), other.Length);
		}
		return SpanHelpers.SequenceCompareTo(ref MemoryMarshal.GetReference(span), span.Length, ref MemoryMarshal.GetReference(other), other.Length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool StartsWith<T>(this Span<T> span, ReadOnlySpan<T> value) where T : IEquatable<T>
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
	public static bool EndsWith<T>(this Span<T> span, ReadOnlySpan<T> value) where T : IEquatable<T>
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

	public static void Reverse<T>(this Span<T> span)
	{
		ref T reference = ref MemoryMarshal.GetReference(span);
		int num = 0;
		int num2 = span.Length - 1;
		while (num < num2)
		{
			T val = Unsafe.Add(ref reference, num);
			Unsafe.Add(ref reference, num) = Unsafe.Add(ref reference, num2);
			Unsafe.Add(ref reference, num2) = val;
			num++;
			num2--;
		}
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
	public static Span<T> AsSpan<T>(this ArraySegment<T> segment)
	{
		return new Span<T>(segment.Array, segment.Offset, segment.Count);
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

	[MethodImpl((MethodImplOptions)256)]
	public static Span<T> AsSpan<T>(this ArraySegment<T> segment, Index startIndex)
	{
		int offset = startIndex.GetOffset(segment.Count);
		return segment.AsSpan(offset);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Span<T> AsSpan<T>(this ArraySegment<T> segment, int start, int length)
	{
		if ((uint)start > segment.Count)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.start);
		}
		if ((uint)length > segment.Count - start)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.length);
		}
		return new Span<T>(segment.Array, segment.Offset + start, length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Span<T> AsSpan<T>(this ArraySegment<T> segment, Range range)
	{
		var (num, length) = range.GetOffsetAndLength(segment.Count);
		return new Span<T>(segment.Array, segment.Offset + num, length);
	}

	public static Memory<T> AsMemory<T>(this T[] array)
	{
		return new Memory<T>(array);
	}

	public static Memory<T> AsMemory<T>(this T[] array, int start)
	{
		return new Memory<T>(array, start);
	}

	public static Memory<T> AsMemory<T>(this T[] array, Index startIndex)
	{
		if (array == null)
		{
			if (!startIndex.Equals(Index.Start))
			{
				ThrowHelper.ThrowArgumentNullException(ExceptionArgument.array);
			}
			return default;
		}
		int offset = startIndex.GetOffset(array.Length);
		return new Memory<T>(array, offset);
	}

	public static Memory<T> AsMemory<T>(this T[] array, int start, int length)
	{
		return new Memory<T>(array, start, length);
	}

	public static Memory<T> AsMemory<T>(this T[] array, Range range)
	{
		if (array == null)
		{
			Index start = range.Start;
			Index end = range.End;
			if (!start.Equals(Index.Start) || !end.Equals(Index.Start))
			{
				ThrowHelper.ThrowArgumentNullException(ExceptionArgument.array);
			}
			return default;
		}
		var (start2, length) = range.GetOffsetAndLength(array.Length);
		return new Memory<T>(array, start2, length);
	}

	public static Memory<T> AsMemory<T>(this ArraySegment<T> segment)
	{
		return new Memory<T>(segment.Array, segment.Offset, segment.Count);
	}

	public static Memory<T> AsMemory<T>(this ArraySegment<T> segment, int start)
	{
		if ((uint)start > segment.Count)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.start);
		}
		return new Memory<T>(segment.Array, segment.Offset + start, segment.Count - start);
	}

	public static Memory<T> AsMemory<T>(this ArraySegment<T> segment, int start, int length)
	{
		if ((uint)start > segment.Count)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.start);
		}
		if ((uint)length > segment.Count - start)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.length);
		}
		return new Memory<T>(segment.Array, segment.Offset + start, length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static void CopyTo<T>(this T[] source, Span<T> destination)
	{
		new ReadOnlySpan<T>(source).CopyTo(destination);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static void CopyTo<T>(this T[] source, Memory<T> destination)
	{
		source.CopyTo(destination.Span);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool Overlaps<T>(this Span<T> span, ReadOnlySpan<T> other)
	{
		return ((ReadOnlySpan<T>)span).Overlaps(other);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool Overlaps<T>(this Span<T> span, ReadOnlySpan<T> other, out int elementOffset)
	{
		return ((ReadOnlySpan<T>)span).Overlaps(other, out elementOffset);
	}

	public static bool Overlaps<T>(this ReadOnlySpan<T> span, ReadOnlySpan<T> other)
	{
		if (span.IsEmpty || other.IsEmpty)
		{
			return false;
		}
		IntPtr intPtr = Unsafe.ByteOffset(ref MemoryMarshal.GetReference(span), ref MemoryMarshal.GetReference(other));
		if (Unsafe.SizeOf<IntPtr>() == 4)
		{
			if ((uint)(int)intPtr >= (uint)(span.Length * Unsafe.SizeOf<T>()))
			{
				return (uint)(int)intPtr > (uint)(-(other.Length * Unsafe.SizeOf<T>()));
			}
			return true;
		}
		if ((ulong)(long)intPtr >= (ulong)((long)span.Length * (long)Unsafe.SizeOf<T>()))
		{
			return (ulong)(long)intPtr > (ulong)(-((long)other.Length * (long)Unsafe.SizeOf<T>()));
		}
		return true;
	}

	public static bool Overlaps<T>(this ReadOnlySpan<T> span, ReadOnlySpan<T> other, out int elementOffset)
	{
		if (span.IsEmpty || other.IsEmpty)
		{
			elementOffset = 0;
			return false;
		}
		IntPtr intPtr = Unsafe.ByteOffset(ref MemoryMarshal.GetReference(span), ref MemoryMarshal.GetReference(other));
		if (Unsafe.SizeOf<IntPtr>() == 4)
		{
			if ((uint)(int)intPtr < (uint)(span.Length * Unsafe.SizeOf<T>()) || (uint)(int)intPtr > (uint)(-(other.Length * Unsafe.SizeOf<T>())))
			{
				if ((int)intPtr % Unsafe.SizeOf<T>() != 0)
				{
					ThrowHelper.ThrowArgumentException_OverlapAlignmentMismatch();
				}
				elementOffset = (int)intPtr / Unsafe.SizeOf<T>();
				return true;
			}
			elementOffset = 0;
			return false;
		}
		if ((ulong)(long)intPtr < (ulong)((long)span.Length * (long)Unsafe.SizeOf<T>()) || (ulong)(long)intPtr > (ulong)(-((long)other.Length * (long)Unsafe.SizeOf<T>())))
		{
			if ((long)intPtr % Unsafe.SizeOf<T>() != 0L)
			{
				ThrowHelper.ThrowArgumentException_OverlapAlignmentMismatch();
			}
			elementOffset = (int)((long)intPtr / Unsafe.SizeOf<T>());
			return true;
		}
		elementOffset = 0;
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int BinarySearch<T>(this Span<T> span, IComparable<T> comparable)
	{
		return span.BinarySearch<T, IComparable<T>>(comparable);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int BinarySearch<T, TComparable>(this Span<T> span, TComparable comparable) where TComparable : IComparable<T>
	{
		return BinarySearch((ReadOnlySpan<T>)span, comparable);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int BinarySearch<T, TComparer>(this Span<T> span, T value, TComparer comparer) where TComparer : IComparer<T>
	{
		return ((ReadOnlySpan<T>)span).BinarySearch(value, comparer);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int BinarySearch<T>(this ReadOnlySpan<T> span, IComparable<T> comparable)
	{
		return MemoryExtensions.BinarySearch<T, IComparable<T>>(span, comparable);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int BinarySearch<T, TComparable>(this ReadOnlySpan<T> span, TComparable comparable) where TComparable : IComparable<T>
	{
		return SpanHelpers.BinarySearch(span, comparable);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int BinarySearch<T, TComparer>(this ReadOnlySpan<T> span, T value, TComparer comparer) where TComparer : IComparer<T>
	{
		if (comparer == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.comparer);
		}
		SpanHelpers.ComparerComparable<T, TComparer> comparable = new SpanHelpers.ComparerComparable<T, TComparer>(value, comparer);
		return BinarySearch(span, comparable);
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
