using System;
using System.Buffers;
using System.Runtime.CompilerServices;

namespace Cysharp.Text;

internal static class Utf16FormatHelper
{
	private const char sp = ' ';

	[MethodImpl((MethodImplOptions)256)]
	public static void FormatTo<TBufferWriter, T>(ref TBufferWriter sb, T arg, int width, ReadOnlySpan<char> format, string argName) where TBufferWriter : IBufferWriter<char>
	{
		if (width <= 0)
		{
			Span<char> span = sb.GetSpan();
			if (!Utf16ValueStringBuilder.FormatterCache<T>.TryFormatDelegate(arg, span, out var charsWritten, format))
			{
				sb.Advance(0);
				int sizeHint = Math.Max(span.Length + 1, charsWritten);
				span = sb.GetSpan(sizeHint);
				if (!Utf16ValueStringBuilder.FormatterCache<T>.TryFormatDelegate(arg, span, out charsWritten, format))
				{
					ExceptionUtil.ThrowArgumentException(argName);
				}
			}
			int count = charsWritten;
			sb.Advance(count);
			width *= -1;
			int num = width - charsWritten;
			if (width > 0 && num > 0)
			{
				sb.GetSpan(num).Fill(' ');
				sb.Advance(num);
			}
		}
		else
		{
			FormatToRightJustify(ref sb, arg, width, format, argName);
		}
	}

	private static void FormatToRightJustify<TBufferWriter, T>(ref TBufferWriter sb, T arg, int width, ReadOnlySpan<char> format, string argName) where TBufferWriter : IBufferWriter<char>
	{
		if (typeof(T) == typeof(string))
		{
			string text = Unsafe.As<string>(arg);
			int num = width - text.Length;
			if (num > 0)
			{
				sb.GetSpan(num).Fill(' ');
				sb.Advance(num);
			}
			int length = text.Length;
			Span<char> span = sb.GetSpan(length);
			text.AsSpan().CopyTo(span);
			int length2 = text.Length;
			sb.Advance(length2);
			return;
		}
		Span<char> destination = stackalloc char[typeof(T).IsValueType ? (Unsafe.SizeOf<T>() * 8) : 1024];
		if (!Utf16ValueStringBuilder.FormatterCache<T>.TryFormatDelegate(arg, destination, out var charsWritten, format))
		{
			destination = stackalloc char[destination.Length * 2];
			if (!Utf16ValueStringBuilder.FormatterCache<T>.TryFormatDelegate(arg, destination, out charsWritten, format))
			{
				ExceptionUtil.ThrowArgumentException(argName);
			}
		}
		int num2 = width - charsWritten;
		if (num2 > 0)
		{
			sb.GetSpan(num2).Fill(' ');
			sb.Advance(num2);
		}
		int sizeHint = charsWritten;
		Span<char> span2 = sb.GetSpan(sizeHint);
		destination.CopyTo(span2);
		int count = charsWritten;
		sb.Advance(count);
	}
}
