using System;
using System.Buffers;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;

namespace Cysharp.Text;

public struct Utf16ValueStringBuilder : IDisposable, IBufferWriter<char>, IResettableBufferWriter<char>
{
	public delegate bool TryFormat<T>(T value, Span<char> destination, out int charsWritten, ReadOnlySpan<char> format);

	private static class ExceptionUtil
	{
		public static void ThrowArgumentOutOfRangeException(string paramName)
		{
			throw new ArgumentOutOfRangeException(paramName);
		}
	}

	public static class FormatterCache<T>
	{
		public static TryFormat<T> TryFormatDelegate;

		static FormatterCache()
		{
			TryFormat<T> tryFormat = (TryFormat<T>)CreateFormatter(typeof(T));
			if (tryFormat == null)
			{
				tryFormat = (typeof(T).IsEnum ? new TryFormat<T>(EnumUtil<T>.TryFormatUtf16) : ((!(typeof(T) == typeof(string))) ? new TryFormat<T>(TryFormatDefault) : new TryFormat<T>(TryFormatString)));
			}
			TryFormatDelegate = tryFormat;
		}

		private static bool TryFormatString(T value, Span<char> dest, out int written, ReadOnlySpan<char> format)
		{
			if (!(value is string text))
			{
				written = 0;
				return true;
			}
			written = text.Length;
			return text.AsSpan().TryCopyTo(dest);
		}

		private static bool TryFormatDefault(T value, Span<char> dest, out int written, ReadOnlySpan<char> format)
		{
			if (value == null)
			{
				written = 0;
				return true;
			}
			string text = ((value is IFormattable formattable && format.Length != 0) ? formattable.ToString(format.ToString(), null) : value.ToString());
			written = text.Length;
			return text.AsSpan().TryCopyTo(dest);
		}
	}

	private const int ThreadStaticBufferSize = 31111;

	private const int DefaultBufferSize = 32768;

	private static char newLine1;

	private static char newLine2;

	private static bool crlf;

	[ThreadStatic]
	private static char[]? scratchBuffer;

	[ThreadStatic]
	internal static bool scratchBufferUsed;

	private char[]? buffer;

	private int index;

	private bool disposeImmediately;

	public int Length => index;

	public void AppendJoin<T>(char separator, params T[] values)
	{
		ReadOnlySpan<char> separator2 = stackalloc char[1] { separator };
		AppendJoinInternal(separator2, values.AsSpan());
	}

	public void AppendJoin<T>(char separator, List<T> values)
	{
		ReadOnlySpan<char> separator2 = stackalloc char[1] { separator };
		AppendJoinInternal(separator2, (IReadOnlyList<T>)values);
	}

	public void AppendJoin<T>(char separator, ReadOnlySpan<T> values)
	{
		ReadOnlySpan<char> separator2 = stackalloc char[1] { separator };
		AppendJoinInternal(separator2, values);
	}

	public void AppendJoin<T>(char separator, IEnumerable<T> values)
	{
		ReadOnlySpan<char> separator2 = stackalloc char[1] { separator };
		AppendJoinInternal(separator2, values);
	}

	public void AppendJoin<T>(char separator, ICollection<T> values)
	{
		ReadOnlySpan<char> separator2 = stackalloc char[1] { separator };
		AppendJoinInternal(separator2, values.AsEnumerable());
	}

	public void AppendJoin<T>(char separator, IList<T> values)
	{
		ReadOnlySpan<char> separator2 = stackalloc char[1] { separator };
		AppendJoinInternal(separator2, values);
	}

	public void AppendJoin<T>(char separator, IReadOnlyList<T> values)
	{
		ReadOnlySpan<char> separator2 = stackalloc char[1] { separator };
		AppendJoinInternal(separator2, values);
	}

	public void AppendJoin<T>(char separator, IReadOnlyCollection<T> values)
	{
		ReadOnlySpan<char> separator2 = stackalloc char[1] { separator };
		AppendJoinInternal(separator2, values.AsEnumerable());
	}

	public void AppendJoin<T>(string separator, params T[] values)
	{
		AppendJoinInternal(separator.AsSpan(), values.AsSpan());
	}

	public void AppendJoin<T>(string separator, List<T> values)
	{
		AppendJoinInternal(separator.AsSpan(), (IReadOnlyList<T>)values);
	}

	public void AppendJoin<T>(string separator, ReadOnlySpan<T> values)
	{
		AppendJoinInternal(separator.AsSpan(), values);
	}

	public void AppendJoin<T>(string separator, IEnumerable<T> values)
	{
		AppendJoinInternal(separator.AsSpan(), values);
	}

	public void AppendJoin<T>(string separator, ICollection<T> values)
	{
		AppendJoinInternal(separator.AsSpan(), values.AsEnumerable());
	}

	public void AppendJoin<T>(string separator, IList<T> values)
	{
		AppendJoinInternal(separator.AsSpan(), values);
	}

	public void AppendJoin<T>(string separator, IReadOnlyList<T> values)
	{
		AppendJoinInternal(separator.AsSpan(), values);
	}

	public void AppendJoin<T>(string separator, IReadOnlyCollection<T> values)
	{
		AppendJoinInternal(separator.AsSpan(), values.AsEnumerable());
	}

	internal void AppendJoinInternal<T>(ReadOnlySpan<char> separator, IList<T> values)
	{
		IReadOnlyList<T> readOnlyList = values as IReadOnlyList<T>;
		readOnlyList = (IReadOnlyList<T>)(readOnlyList ?? ((object)new ReadOnlyListAdaptor<T>(values)));
		AppendJoinInternal(separator, readOnlyList);
	}

	internal void AppendJoinInternal<T>(ReadOnlySpan<char> separator, IReadOnlyList<T> values)
	{
		int count = values.Count;
		for (int i = 0; i < count; i++)
		{
			if (i != 0)
			{
				Append(separator);
			}
			T val = values[i];
			if (typeof(T) == typeof(string))
			{
				string value = Unsafe.As<string>(val);
				if (!string.IsNullOrEmpty(value))
				{
					Append(value);
				}
			}
			else
			{
				Append(val);
			}
		}
	}

	internal void AppendJoinInternal<T>(ReadOnlySpan<char> separator, ReadOnlySpan<T> values)
	{
		for (int i = 0; i < values.Length; i++)
		{
			if (i != 0)
			{
				Append(separator);
			}
			T val = values[i];
			if (typeof(T) == typeof(string))
			{
				string value = Unsafe.As<string>(val);
				if (!string.IsNullOrEmpty(value))
				{
					Append(value);
				}
			}
			else
			{
				Append(val);
			}
		}
	}

	internal void AppendJoinInternal<T>(ReadOnlySpan<char> separator, IEnumerable<T> values)
	{
		bool flag = true;
		foreach (T value2 in values)
		{
			if (!flag)
			{
				Append(separator);
			}
			else
			{
				flag = false;
			}
			if (typeof(T) == typeof(string))
			{
				string value = Unsafe.As<string>(value2);
				if (!string.IsNullOrEmpty(value))
				{
					Append(value);
				}
			}
			else
			{
				Append(value2);
			}
		}
	}

	public void AppendFormat<T1>(string format, T1 arg1)
	{
		if (format == null)
		{
			throw new ArgumentNullException("format");
		}
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int count2 = i - num;
					Append(format, num, count2);
					i++;
					num = i;
					break;
				}
				int count3 = i - num;
				Append(format, num, count3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				if (parseResult.Index == 0)
				{
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int count = i - num;
					Append(format, num, count);
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format, num, num2);
		}
	}

	public void AppendFormat<T1>(ReadOnlySpan<char> format, T1 arg1)
	{
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int length2 = i - num;
					Append(format.Slice(num, length2));
					i++;
					num = i;
					break;
				}
				int length3 = i - num;
				Append(format.Slice(num, length3));
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				if (parseResult.Index == 0)
				{
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int length = i - num;
					Append(format.Slice(num, length));
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format.Slice(num, num2));
		}
	}

	public void AppendFormat<T1, T2>(string format, T1 arg1, T2 arg2)
	{
		if (format == null)
		{
			throw new ArgumentNullException("format");
		}
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int count2 = i - num;
					Append(format, num, count2);
					i++;
					num = i;
					break;
				}
				int count3 = i - num;
				Append(format, num, count3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int count = i - num;
					Append(format, num, count);
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format, num, num2);
		}
	}

	public void AppendFormat<T1, T2>(ReadOnlySpan<char> format, T1 arg1, T2 arg2)
	{
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int length2 = i - num;
					Append(format.Slice(num, length2));
					i++;
					num = i;
					break;
				}
				int length3 = i - num;
				Append(format.Slice(num, length3));
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int length = i - num;
					Append(format.Slice(num, length));
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format.Slice(num, num2));
		}
	}

	public void AppendFormat<T1, T2, T3>(string format, T1 arg1, T2 arg2, T3 arg3)
	{
		if (format == null)
		{
			throw new ArgumentNullException("format");
		}
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int count2 = i - num;
					Append(format, num, count2);
					i++;
					num = i;
					break;
				}
				int count3 = i - num;
				Append(format, num, count3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int count = i - num;
					Append(format, num, count);
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format, num, num2);
		}
	}

	public void AppendFormat<T1, T2, T3>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3)
	{
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int length2 = i - num;
					Append(format.Slice(num, length2));
					i++;
					num = i;
					break;
				}
				int length3 = i - num;
				Append(format.Slice(num, length3));
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int length = i - num;
					Append(format.Slice(num, length));
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format.Slice(num, num2));
		}
	}

	public void AppendFormat<T1, T2, T3, T4>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		if (format == null)
		{
			throw new ArgumentNullException("format");
		}
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int count2 = i - num;
					Append(format, num, count2);
					i++;
					num = i;
					break;
				}
				int count3 = i - num;
				Append(format, num, count3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int count = i - num;
					Append(format, num, count);
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format, num, num2);
		}
	}

	public void AppendFormat<T1, T2, T3, T4>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int length2 = i - num;
					Append(format.Slice(num, length2));
					i++;
					num = i;
					break;
				}
				int length3 = i - num;
				Append(format.Slice(num, length3));
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int length = i - num;
					Append(format.Slice(num, length));
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format.Slice(num, num2));
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		if (format == null)
		{
			throw new ArgumentNullException("format");
		}
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int count2 = i - num;
					Append(format, num, count2);
					i++;
					num = i;
					break;
				}
				int count3 = i - num;
				Append(format, num, count3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int count = i - num;
					Append(format, num, count);
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format, num, num2);
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int length2 = i - num;
					Append(format.Slice(num, length2));
					i++;
					num = i;
					break;
				}
				int length3 = i - num;
				Append(format.Slice(num, length3));
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int length = i - num;
					Append(format.Slice(num, length));
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format.Slice(num, num2));
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
	{
		if (format == null)
		{
			throw new ArgumentNullException("format");
		}
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int count2 = i - num;
					Append(format, num, count2);
					i++;
					num = i;
					break;
				}
				int count3 = i - num;
				Append(format, num, count3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int count = i - num;
					Append(format, num, count);
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format, num, num2);
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
	{
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int length2 = i - num;
					Append(format.Slice(num, length2));
					i++;
					num = i;
					break;
				}
				int length3 = i - num;
				Append(format.Slice(num, length3));
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int length = i - num;
					Append(format.Slice(num, length));
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format.Slice(num, num2));
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6, T7>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
	{
		if (format == null)
		{
			throw new ArgumentNullException("format");
		}
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int count2 = i - num;
					Append(format, num, count2);
					i++;
					num = i;
					break;
				}
				int count3 = i - num;
				Append(format, num, count3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				case 6:
					AppendFormatInternal(arg7, parseResult.Alignment, parseResult.FormatString, "arg7");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int count = i - num;
					Append(format, num, count);
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format, num, num2);
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6, T7>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
	{
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int length2 = i - num;
					Append(format.Slice(num, length2));
					i++;
					num = i;
					break;
				}
				int length3 = i - num;
				Append(format.Slice(num, length3));
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				case 6:
					AppendFormatInternal(arg7, parseResult.Alignment, parseResult.FormatString, "arg7");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int length = i - num;
					Append(format.Slice(num, length));
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format.Slice(num, num2));
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6, T7, T8>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8)
	{
		if (format == null)
		{
			throw new ArgumentNullException("format");
		}
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int count2 = i - num;
					Append(format, num, count2);
					i++;
					num = i;
					break;
				}
				int count3 = i - num;
				Append(format, num, count3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				case 6:
					AppendFormatInternal(arg7, parseResult.Alignment, parseResult.FormatString, "arg7");
					break;
				case 7:
					AppendFormatInternal(arg8, parseResult.Alignment, parseResult.FormatString, "arg8");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int count = i - num;
					Append(format, num, count);
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format, num, num2);
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6, T7, T8>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8)
	{
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int length2 = i - num;
					Append(format.Slice(num, length2));
					i++;
					num = i;
					break;
				}
				int length3 = i - num;
				Append(format.Slice(num, length3));
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				case 6:
					AppendFormatInternal(arg7, parseResult.Alignment, parseResult.FormatString, "arg7");
					break;
				case 7:
					AppendFormatInternal(arg8, parseResult.Alignment, parseResult.FormatString, "arg8");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int length = i - num;
					Append(format.Slice(num, length));
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format.Slice(num, num2));
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9)
	{
		if (format == null)
		{
			throw new ArgumentNullException("format");
		}
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int count2 = i - num;
					Append(format, num, count2);
					i++;
					num = i;
					break;
				}
				int count3 = i - num;
				Append(format, num, count3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				case 6:
					AppendFormatInternal(arg7, parseResult.Alignment, parseResult.FormatString, "arg7");
					break;
				case 7:
					AppendFormatInternal(arg8, parseResult.Alignment, parseResult.FormatString, "arg8");
					break;
				case 8:
					AppendFormatInternal(arg9, parseResult.Alignment, parseResult.FormatString, "arg9");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int count = i - num;
					Append(format, num, count);
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format, num, num2);
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9)
	{
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int length2 = i - num;
					Append(format.Slice(num, length2));
					i++;
					num = i;
					break;
				}
				int length3 = i - num;
				Append(format.Slice(num, length3));
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				case 6:
					AppendFormatInternal(arg7, parseResult.Alignment, parseResult.FormatString, "arg7");
					break;
				case 7:
					AppendFormatInternal(arg8, parseResult.Alignment, parseResult.FormatString, "arg8");
					break;
				case 8:
					AppendFormatInternal(arg9, parseResult.Alignment, parseResult.FormatString, "arg9");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int length = i - num;
					Append(format.Slice(num, length));
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format.Slice(num, num2));
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10)
	{
		if (format == null)
		{
			throw new ArgumentNullException("format");
		}
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int count2 = i - num;
					Append(format, num, count2);
					i++;
					num = i;
					break;
				}
				int count3 = i - num;
				Append(format, num, count3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				case 6:
					AppendFormatInternal(arg7, parseResult.Alignment, parseResult.FormatString, "arg7");
					break;
				case 7:
					AppendFormatInternal(arg8, parseResult.Alignment, parseResult.FormatString, "arg8");
					break;
				case 8:
					AppendFormatInternal(arg9, parseResult.Alignment, parseResult.FormatString, "arg9");
					break;
				case 9:
					AppendFormatInternal(arg10, parseResult.Alignment, parseResult.FormatString, "arg10");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int count = i - num;
					Append(format, num, count);
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format, num, num2);
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10)
	{
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int length2 = i - num;
					Append(format.Slice(num, length2));
					i++;
					num = i;
					break;
				}
				int length3 = i - num;
				Append(format.Slice(num, length3));
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				case 6:
					AppendFormatInternal(arg7, parseResult.Alignment, parseResult.FormatString, "arg7");
					break;
				case 7:
					AppendFormatInternal(arg8, parseResult.Alignment, parseResult.FormatString, "arg8");
					break;
				case 8:
					AppendFormatInternal(arg9, parseResult.Alignment, parseResult.FormatString, "arg9");
					break;
				case 9:
					AppendFormatInternal(arg10, parseResult.Alignment, parseResult.FormatString, "arg10");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int length = i - num;
					Append(format.Slice(num, length));
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format.Slice(num, num2));
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11)
	{
		if (format == null)
		{
			throw new ArgumentNullException("format");
		}
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int count2 = i - num;
					Append(format, num, count2);
					i++;
					num = i;
					break;
				}
				int count3 = i - num;
				Append(format, num, count3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				case 6:
					AppendFormatInternal(arg7, parseResult.Alignment, parseResult.FormatString, "arg7");
					break;
				case 7:
					AppendFormatInternal(arg8, parseResult.Alignment, parseResult.FormatString, "arg8");
					break;
				case 8:
					AppendFormatInternal(arg9, parseResult.Alignment, parseResult.FormatString, "arg9");
					break;
				case 9:
					AppendFormatInternal(arg10, parseResult.Alignment, parseResult.FormatString, "arg10");
					break;
				case 10:
					AppendFormatInternal(arg11, parseResult.Alignment, parseResult.FormatString, "arg11");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int count = i - num;
					Append(format, num, count);
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format, num, num2);
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11)
	{
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int length2 = i - num;
					Append(format.Slice(num, length2));
					i++;
					num = i;
					break;
				}
				int length3 = i - num;
				Append(format.Slice(num, length3));
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				case 6:
					AppendFormatInternal(arg7, parseResult.Alignment, parseResult.FormatString, "arg7");
					break;
				case 7:
					AppendFormatInternal(arg8, parseResult.Alignment, parseResult.FormatString, "arg8");
					break;
				case 8:
					AppendFormatInternal(arg9, parseResult.Alignment, parseResult.FormatString, "arg9");
					break;
				case 9:
					AppendFormatInternal(arg10, parseResult.Alignment, parseResult.FormatString, "arg10");
					break;
				case 10:
					AppendFormatInternal(arg11, parseResult.Alignment, parseResult.FormatString, "arg11");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int length = i - num;
					Append(format.Slice(num, length));
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format.Slice(num, num2));
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12)
	{
		if (format == null)
		{
			throw new ArgumentNullException("format");
		}
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int count2 = i - num;
					Append(format, num, count2);
					i++;
					num = i;
					break;
				}
				int count3 = i - num;
				Append(format, num, count3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				case 6:
					AppendFormatInternal(arg7, parseResult.Alignment, parseResult.FormatString, "arg7");
					break;
				case 7:
					AppendFormatInternal(arg8, parseResult.Alignment, parseResult.FormatString, "arg8");
					break;
				case 8:
					AppendFormatInternal(arg9, parseResult.Alignment, parseResult.FormatString, "arg9");
					break;
				case 9:
					AppendFormatInternal(arg10, parseResult.Alignment, parseResult.FormatString, "arg10");
					break;
				case 10:
					AppendFormatInternal(arg11, parseResult.Alignment, parseResult.FormatString, "arg11");
					break;
				case 11:
					AppendFormatInternal(arg12, parseResult.Alignment, parseResult.FormatString, "arg12");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int count = i - num;
					Append(format, num, count);
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format, num, num2);
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12)
	{
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int length2 = i - num;
					Append(format.Slice(num, length2));
					i++;
					num = i;
					break;
				}
				int length3 = i - num;
				Append(format.Slice(num, length3));
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				case 6:
					AppendFormatInternal(arg7, parseResult.Alignment, parseResult.FormatString, "arg7");
					break;
				case 7:
					AppendFormatInternal(arg8, parseResult.Alignment, parseResult.FormatString, "arg8");
					break;
				case 8:
					AppendFormatInternal(arg9, parseResult.Alignment, parseResult.FormatString, "arg9");
					break;
				case 9:
					AppendFormatInternal(arg10, parseResult.Alignment, parseResult.FormatString, "arg10");
					break;
				case 10:
					AppendFormatInternal(arg11, parseResult.Alignment, parseResult.FormatString, "arg11");
					break;
				case 11:
					AppendFormatInternal(arg12, parseResult.Alignment, parseResult.FormatString, "arg12");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int length = i - num;
					Append(format.Slice(num, length));
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format.Slice(num, num2));
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13)
	{
		if (format == null)
		{
			throw new ArgumentNullException("format");
		}
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int count2 = i - num;
					Append(format, num, count2);
					i++;
					num = i;
					break;
				}
				int count3 = i - num;
				Append(format, num, count3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				case 6:
					AppendFormatInternal(arg7, parseResult.Alignment, parseResult.FormatString, "arg7");
					break;
				case 7:
					AppendFormatInternal(arg8, parseResult.Alignment, parseResult.FormatString, "arg8");
					break;
				case 8:
					AppendFormatInternal(arg9, parseResult.Alignment, parseResult.FormatString, "arg9");
					break;
				case 9:
					AppendFormatInternal(arg10, parseResult.Alignment, parseResult.FormatString, "arg10");
					break;
				case 10:
					AppendFormatInternal(arg11, parseResult.Alignment, parseResult.FormatString, "arg11");
					break;
				case 11:
					AppendFormatInternal(arg12, parseResult.Alignment, parseResult.FormatString, "arg12");
					break;
				case 12:
					AppendFormatInternal(arg13, parseResult.Alignment, parseResult.FormatString, "arg13");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int count = i - num;
					Append(format, num, count);
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format, num, num2);
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13)
	{
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int length2 = i - num;
					Append(format.Slice(num, length2));
					i++;
					num = i;
					break;
				}
				int length3 = i - num;
				Append(format.Slice(num, length3));
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				case 6:
					AppendFormatInternal(arg7, parseResult.Alignment, parseResult.FormatString, "arg7");
					break;
				case 7:
					AppendFormatInternal(arg8, parseResult.Alignment, parseResult.FormatString, "arg8");
					break;
				case 8:
					AppendFormatInternal(arg9, parseResult.Alignment, parseResult.FormatString, "arg9");
					break;
				case 9:
					AppendFormatInternal(arg10, parseResult.Alignment, parseResult.FormatString, "arg10");
					break;
				case 10:
					AppendFormatInternal(arg11, parseResult.Alignment, parseResult.FormatString, "arg11");
					break;
				case 11:
					AppendFormatInternal(arg12, parseResult.Alignment, parseResult.FormatString, "arg12");
					break;
				case 12:
					AppendFormatInternal(arg13, parseResult.Alignment, parseResult.FormatString, "arg13");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int length = i - num;
					Append(format.Slice(num, length));
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format.Slice(num, num2));
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14)
	{
		if (format == null)
		{
			throw new ArgumentNullException("format");
		}
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int count2 = i - num;
					Append(format, num, count2);
					i++;
					num = i;
					break;
				}
				int count3 = i - num;
				Append(format, num, count3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				case 6:
					AppendFormatInternal(arg7, parseResult.Alignment, parseResult.FormatString, "arg7");
					break;
				case 7:
					AppendFormatInternal(arg8, parseResult.Alignment, parseResult.FormatString, "arg8");
					break;
				case 8:
					AppendFormatInternal(arg9, parseResult.Alignment, parseResult.FormatString, "arg9");
					break;
				case 9:
					AppendFormatInternal(arg10, parseResult.Alignment, parseResult.FormatString, "arg10");
					break;
				case 10:
					AppendFormatInternal(arg11, parseResult.Alignment, parseResult.FormatString, "arg11");
					break;
				case 11:
					AppendFormatInternal(arg12, parseResult.Alignment, parseResult.FormatString, "arg12");
					break;
				case 12:
					AppendFormatInternal(arg13, parseResult.Alignment, parseResult.FormatString, "arg13");
					break;
				case 13:
					AppendFormatInternal(arg14, parseResult.Alignment, parseResult.FormatString, "arg14");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int count = i - num;
					Append(format, num, count);
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format, num, num2);
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14)
	{
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int length2 = i - num;
					Append(format.Slice(num, length2));
					i++;
					num = i;
					break;
				}
				int length3 = i - num;
				Append(format.Slice(num, length3));
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				case 6:
					AppendFormatInternal(arg7, parseResult.Alignment, parseResult.FormatString, "arg7");
					break;
				case 7:
					AppendFormatInternal(arg8, parseResult.Alignment, parseResult.FormatString, "arg8");
					break;
				case 8:
					AppendFormatInternal(arg9, parseResult.Alignment, parseResult.FormatString, "arg9");
					break;
				case 9:
					AppendFormatInternal(arg10, parseResult.Alignment, parseResult.FormatString, "arg10");
					break;
				case 10:
					AppendFormatInternal(arg11, parseResult.Alignment, parseResult.FormatString, "arg11");
					break;
				case 11:
					AppendFormatInternal(arg12, parseResult.Alignment, parseResult.FormatString, "arg12");
					break;
				case 12:
					AppendFormatInternal(arg13, parseResult.Alignment, parseResult.FormatString, "arg13");
					break;
				case 13:
					AppendFormatInternal(arg14, parseResult.Alignment, parseResult.FormatString, "arg14");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int length = i - num;
					Append(format.Slice(num, length));
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format.Slice(num, num2));
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15)
	{
		if (format == null)
		{
			throw new ArgumentNullException("format");
		}
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int count2 = i - num;
					Append(format, num, count2);
					i++;
					num = i;
					break;
				}
				int count3 = i - num;
				Append(format, num, count3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				case 6:
					AppendFormatInternal(arg7, parseResult.Alignment, parseResult.FormatString, "arg7");
					break;
				case 7:
					AppendFormatInternal(arg8, parseResult.Alignment, parseResult.FormatString, "arg8");
					break;
				case 8:
					AppendFormatInternal(arg9, parseResult.Alignment, parseResult.FormatString, "arg9");
					break;
				case 9:
					AppendFormatInternal(arg10, parseResult.Alignment, parseResult.FormatString, "arg10");
					break;
				case 10:
					AppendFormatInternal(arg11, parseResult.Alignment, parseResult.FormatString, "arg11");
					break;
				case 11:
					AppendFormatInternal(arg12, parseResult.Alignment, parseResult.FormatString, "arg12");
					break;
				case 12:
					AppendFormatInternal(arg13, parseResult.Alignment, parseResult.FormatString, "arg13");
					break;
				case 13:
					AppendFormatInternal(arg14, parseResult.Alignment, parseResult.FormatString, "arg14");
					break;
				case 14:
					AppendFormatInternal(arg15, parseResult.Alignment, parseResult.FormatString, "arg15");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int count = i - num;
					Append(format, num, count);
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format, num, num2);
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15)
	{
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int length2 = i - num;
					Append(format.Slice(num, length2));
					i++;
					num = i;
					break;
				}
				int length3 = i - num;
				Append(format.Slice(num, length3));
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				case 6:
					AppendFormatInternal(arg7, parseResult.Alignment, parseResult.FormatString, "arg7");
					break;
				case 7:
					AppendFormatInternal(arg8, parseResult.Alignment, parseResult.FormatString, "arg8");
					break;
				case 8:
					AppendFormatInternal(arg9, parseResult.Alignment, parseResult.FormatString, "arg9");
					break;
				case 9:
					AppendFormatInternal(arg10, parseResult.Alignment, parseResult.FormatString, "arg10");
					break;
				case 10:
					AppendFormatInternal(arg11, parseResult.Alignment, parseResult.FormatString, "arg11");
					break;
				case 11:
					AppendFormatInternal(arg12, parseResult.Alignment, parseResult.FormatString, "arg12");
					break;
				case 12:
					AppendFormatInternal(arg13, parseResult.Alignment, parseResult.FormatString, "arg13");
					break;
				case 13:
					AppendFormatInternal(arg14, parseResult.Alignment, parseResult.FormatString, "arg14");
					break;
				case 14:
					AppendFormatInternal(arg15, parseResult.Alignment, parseResult.FormatString, "arg15");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int length = i - num;
					Append(format.Slice(num, length));
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format.Slice(num, num2));
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15, T16 arg16)
	{
		if (format == null)
		{
			throw new ArgumentNullException("format");
		}
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int count2 = i - num;
					Append(format, num, count2);
					i++;
					num = i;
					break;
				}
				int count3 = i - num;
				Append(format, num, count3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				case 6:
					AppendFormatInternal(arg7, parseResult.Alignment, parseResult.FormatString, "arg7");
					break;
				case 7:
					AppendFormatInternal(arg8, parseResult.Alignment, parseResult.FormatString, "arg8");
					break;
				case 8:
					AppendFormatInternal(arg9, parseResult.Alignment, parseResult.FormatString, "arg9");
					break;
				case 9:
					AppendFormatInternal(arg10, parseResult.Alignment, parseResult.FormatString, "arg10");
					break;
				case 10:
					AppendFormatInternal(arg11, parseResult.Alignment, parseResult.FormatString, "arg11");
					break;
				case 11:
					AppendFormatInternal(arg12, parseResult.Alignment, parseResult.FormatString, "arg12");
					break;
				case 12:
					AppendFormatInternal(arg13, parseResult.Alignment, parseResult.FormatString, "arg13");
					break;
				case 13:
					AppendFormatInternal(arg14, parseResult.Alignment, parseResult.FormatString, "arg14");
					break;
				case 14:
					AppendFormatInternal(arg15, parseResult.Alignment, parseResult.FormatString, "arg15");
					break;
				case 15:
					AppendFormatInternal(arg16, parseResult.Alignment, parseResult.FormatString, "arg16");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int count = i - num;
					Append(format, num, count);
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format, num, num2);
		}
	}

	public void AppendFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15, T16 arg16)
	{
		int num = 0;
		for (int i = 0; i < format.Length; i++)
		{
			switch (format[i])
			{
			case '{':
			{
				if (i == format.Length - 1)
				{
					throw new FormatException("invalid format");
				}
				if (i != format.Length && format[i + 1] == '{')
				{
					int length2 = i - num;
					Append(format.Slice(num, length2));
					i++;
					num = i;
					break;
				}
				int length3 = i - num;
				Append(format.Slice(num, length3));
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				switch (parseResult.Index)
				{
				case 0:
					AppendFormatInternal(arg1, parseResult.Alignment, parseResult.FormatString, "arg1");
					break;
				case 1:
					AppendFormatInternal(arg2, parseResult.Alignment, parseResult.FormatString, "arg2");
					break;
				case 2:
					AppendFormatInternal(arg3, parseResult.Alignment, parseResult.FormatString, "arg3");
					break;
				case 3:
					AppendFormatInternal(arg4, parseResult.Alignment, parseResult.FormatString, "arg4");
					break;
				case 4:
					AppendFormatInternal(arg5, parseResult.Alignment, parseResult.FormatString, "arg5");
					break;
				case 5:
					AppendFormatInternal(arg6, parseResult.Alignment, parseResult.FormatString, "arg6");
					break;
				case 6:
					AppendFormatInternal(arg7, parseResult.Alignment, parseResult.FormatString, "arg7");
					break;
				case 7:
					AppendFormatInternal(arg8, parseResult.Alignment, parseResult.FormatString, "arg8");
					break;
				case 8:
					AppendFormatInternal(arg9, parseResult.Alignment, parseResult.FormatString, "arg9");
					break;
				case 9:
					AppendFormatInternal(arg10, parseResult.Alignment, parseResult.FormatString, "arg10");
					break;
				case 10:
					AppendFormatInternal(arg11, parseResult.Alignment, parseResult.FormatString, "arg11");
					break;
				case 11:
					AppendFormatInternal(arg12, parseResult.Alignment, parseResult.FormatString, "arg12");
					break;
				case 12:
					AppendFormatInternal(arg13, parseResult.Alignment, parseResult.FormatString, "arg13");
					break;
				case 13:
					AppendFormatInternal(arg14, parseResult.Alignment, parseResult.FormatString, "arg14");
					break;
				case 14:
					AppendFormatInternal(arg15, parseResult.Alignment, parseResult.FormatString, "arg15");
					break;
				case 15:
					AppendFormatInternal(arg16, parseResult.Alignment, parseResult.FormatString, "arg16");
					break;
				default:
					ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int length = i - num;
					Append(format.Slice(num, length));
					i++;
					num = i;
				}
				else
				{
					ThrowFormatException();
				}
				break;
			}
		}
		int num2 = format.Length - num;
		if (num2 > 0)
		{
			Append(format.Slice(num, num2));
		}
	}

	private static object? CreateFormatter(Type type)
	{
		if (type == typeof(sbyte))
		{
			return (TryFormat<sbyte>)delegate(sbyte x, Span<char> dest, out int written, ReadOnlySpan<char> format)
			{
				return (format.Length != 0) ? x.TryFormat(dest, out written, format) : FastNumberWriter.TryWriteInt64(dest, out written, x);
			};
		}
		if (type == typeof(short))
		{
			return (TryFormat<short>)delegate(short x, Span<char> dest, out int written, ReadOnlySpan<char> format)
			{
				return (format.Length != 0) ? x.TryFormat(dest, out written, format) : FastNumberWriter.TryWriteInt64(dest, out written, x);
			};
		}
		if (type == typeof(int))
		{
			return (TryFormat<int>)delegate(int x, Span<char> dest, out int written, ReadOnlySpan<char> format)
			{
				return (format.Length != 0) ? x.TryFormat(dest, out written, format) : FastNumberWriter.TryWriteInt64(dest, out written, x);
			};
		}
		if (type == typeof(long))
		{
			return (TryFormat<long>)delegate(long x, Span<char> dest, out int written, ReadOnlySpan<char> format)
			{
				return (format.Length != 0) ? x.TryFormat(dest, out written, format) : FastNumberWriter.TryWriteInt64(dest, out written, x);
			};
		}
		if (type == typeof(byte))
		{
			return (TryFormat<byte>)delegate(byte x, Span<char> dest, out int written, ReadOnlySpan<char> format)
			{
				return (format.Length != 0) ? x.TryFormat(dest, out written, format) : FastNumberWriter.TryWriteUInt64(dest, out written, x);
			};
		}
		if (type == typeof(ushort))
		{
			return (TryFormat<ushort>)delegate(ushort x, Span<char> dest, out int written, ReadOnlySpan<char> format)
			{
				return (format.Length != 0) ? x.TryFormat(dest, out written, format) : FastNumberWriter.TryWriteUInt64(dest, out written, x);
			};
		}
		if (type == typeof(uint))
		{
			return (TryFormat<uint>)delegate(uint x, Span<char> dest, out int written, ReadOnlySpan<char> format)
			{
				return (format.Length != 0) ? x.TryFormat(dest, out written, format) : FastNumberWriter.TryWriteUInt64(dest, out written, x);
			};
		}
		if (type == typeof(ulong))
		{
			return (TryFormat<ulong>)delegate(ulong x, Span<char> dest, out int written, ReadOnlySpan<char> format)
			{
				return (format.Length != 0) ? x.TryFormat(dest, out written, format) : FastNumberWriter.TryWriteUInt64(dest, out written, x);
			};
		}
		if (type == typeof(float))
		{
			return (TryFormat<float>)delegate(float x, Span<char> dest, out int written, ReadOnlySpan<char> format)
			{
				return x.TryFormat(dest, out written, format);
			};
		}
		if (type == typeof(double))
		{
			return (TryFormat<double>)delegate(double x, Span<char> dest, out int written, ReadOnlySpan<char> format)
			{
				return x.TryFormat(dest, out written, format);
			};
		}
		if (type == typeof(TimeSpan))
		{
			return (TryFormat<TimeSpan>)delegate(TimeSpan x, Span<char> dest, out int written, ReadOnlySpan<char> format)
			{
				return x.TryFormat(dest, out written, format);
			};
		}
		if (type == typeof(DateTime))
		{
			return (TryFormat<DateTime>)delegate(DateTime x, Span<char> dest, out int written, ReadOnlySpan<char> format)
			{
				return x.TryFormat(dest, out written, format);
			};
		}
		if (type == typeof(DateTimeOffset))
		{
			return (TryFormat<DateTimeOffset>)delegate(DateTimeOffset x, Span<char> dest, out int written, ReadOnlySpan<char> format)
			{
				return x.TryFormat(dest, out written, format);
			};
		}
		if (type == typeof(decimal))
		{
			return (TryFormat<decimal>)delegate(decimal x, Span<char> dest, out int written, ReadOnlySpan<char> format)
			{
				return x.TryFormat(dest, out written, format);
			};
		}
		if (type == typeof(Guid))
		{
			return (TryFormat<Guid>)delegate(Guid x, Span<char> dest, out int written, ReadOnlySpan<char> format)
			{
				return x.TryFormat(dest, out written, format);
			};
		}
		if (type == typeof(byte?))
		{
			return CreateNullableFormatter<byte>();
		}
		if (type == typeof(DateTime?))
		{
			return CreateNullableFormatter<DateTime>();
		}
		if (type == typeof(DateTimeOffset?))
		{
			return CreateNullableFormatter<DateTimeOffset>();
		}
		if (type == typeof(decimal?))
		{
			return CreateNullableFormatter<decimal>();
		}
		if (type == typeof(double?))
		{
			return CreateNullableFormatter<double>();
		}
		if (type == typeof(short?))
		{
			return CreateNullableFormatter<short>();
		}
		if (type == typeof(int?))
		{
			return CreateNullableFormatter<int>();
		}
		if (type == typeof(long?))
		{
			return CreateNullableFormatter<long>();
		}
		if (type == typeof(sbyte?))
		{
			return CreateNullableFormatter<sbyte>();
		}
		if (type == typeof(float?))
		{
			return CreateNullableFormatter<float>();
		}
		if (type == typeof(TimeSpan?))
		{
			return CreateNullableFormatter<TimeSpan>();
		}
		if (type == typeof(ushort?))
		{
			return CreateNullableFormatter<ushort>();
		}
		if (type == typeof(uint?))
		{
			return CreateNullableFormatter<uint>();
		}
		if (type == typeof(ulong?))
		{
			return CreateNullableFormatter<ulong>();
		}
		if (type == typeof(Guid?))
		{
			return CreateNullableFormatter<Guid>();
		}
		if (type == typeof(bool?))
		{
			return CreateNullableFormatter<bool>();
		}
		if (type == typeof(IntPtr))
		{
			return (TryFormat<IntPtr>)delegate(IntPtr x, Span<char> dest, out int written, ReadOnlySpan<char> format)
			{
				return (IntPtr.Size != 4) ? x.ToInt64().TryFormat(dest, out written, format) : x.ToInt32().TryFormat(dest, out written, format);
			};
		}
		if (type == typeof(UIntPtr))
		{
			return (TryFormat<UIntPtr>)delegate(UIntPtr x, Span<char> dest, out int written, ReadOnlySpan<char> format)
			{
				return (UIntPtr.Size != 4) ? x.ToUInt64().TryFormat(dest, out written, format) : x.ToUInt32().TryFormat(dest, out written, format);
			};
		}
		return null;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(byte value)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(byte value, string format)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten, format.AsSpan()))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten, format.AsSpan()))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(byte value)
	{
		Append(value);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(byte value, string format)
	{
		Append(value, format);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(DateTime value)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(DateTime value, string format)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten, format.AsSpan()))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten, format.AsSpan()))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(DateTime value)
	{
		Append(value);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(DateTime value, string format)
	{
		Append(value, format);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(DateTimeOffset value)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(DateTimeOffset value, string format)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten, format.AsSpan()))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten, format.AsSpan()))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(DateTimeOffset value)
	{
		Append(value);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(DateTimeOffset value, string format)
	{
		Append(value, format);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(decimal value)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(decimal value, string format)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten, format.AsSpan()))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten, format.AsSpan()))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(decimal value)
	{
		Append(value);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(decimal value, string format)
	{
		Append(value, format);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(double value)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(double value, string format)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten, format.AsSpan()))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten, format.AsSpan()))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(double value)
	{
		Append(value);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(double value, string format)
	{
		Append(value, format);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(short value)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(short value, string format)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten, format.AsSpan()))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten, format.AsSpan()))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(short value)
	{
		Append(value);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(short value, string format)
	{
		Append(value, format);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(int value)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(int value, string format)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten, format.AsSpan()))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten, format.AsSpan()))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(int value)
	{
		Append(value);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(int value, string format)
	{
		Append(value, format);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(long value)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(long value, string format)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten, format.AsSpan()))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten, format.AsSpan()))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(long value)
	{
		Append(value);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(long value, string format)
	{
		Append(value, format);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(sbyte value)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(sbyte value, string format)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten, format.AsSpan()))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten, format.AsSpan()))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(sbyte value)
	{
		Append(value);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(sbyte value, string format)
	{
		Append(value, format);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(float value)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(float value, string format)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten, format.AsSpan()))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten, format.AsSpan()))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(float value)
	{
		Append(value);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(float value, string format)
	{
		Append(value, format);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(TimeSpan value)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(TimeSpan value, string format)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten, format.AsSpan()))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten, format.AsSpan()))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(TimeSpan value)
	{
		Append(value);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(TimeSpan value, string format)
	{
		Append(value, format);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(ushort value)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(ushort value, string format)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten, format.AsSpan()))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten, format.AsSpan()))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(ushort value)
	{
		Append(value);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(ushort value, string format)
	{
		Append(value, format);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(uint value)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(uint value, string format)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten, format.AsSpan()))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten, format.AsSpan()))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(uint value)
	{
		Append(value);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(uint value, string format)
	{
		Append(value, format);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(ulong value)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(ulong value, string format)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten, format.AsSpan()))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten, format.AsSpan()))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(ulong value)
	{
		Append(value);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(ulong value, string format)
	{
		Append(value, format);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(Guid value)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(Guid value, string format)
	{
		if (!value.TryFormat(buffer.AsSpan(index), out var charsWritten, format.AsSpan()))
		{
			Grow(charsWritten);
			if (!value.TryFormat(buffer.AsSpan(index), out charsWritten, format.AsSpan()))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(Guid value)
	{
		Append(value);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(Guid value, string format)
	{
		Append(value, format);
		AppendLine();
	}

	static Utf16ValueStringBuilder()
	{
		char[] array = Environment.NewLine.ToCharArray();
		if (array.Length == 1)
		{
			newLine1 = array[0];
			crlf = false;
		}
		else
		{
			newLine1 = array[0];
			newLine2 = array[1];
			crlf = true;
		}
	}

	public ReadOnlySpan<char> AsSpan()
	{
		return buffer.AsSpan(0, index);
	}

	public ReadOnlyMemory<char> AsMemory()
	{
		return buffer.AsMemory(0, index);
	}

	public ArraySegment<char> AsArraySegment()
	{
		return new ArraySegment<char>(buffer, 0, index);
	}

	[MethodImpl((MethodImplOptions)256)]
	public Utf16ValueStringBuilder(bool disposeImmediately)
	{
		if (disposeImmediately && scratchBufferUsed)
		{
			ThrowNestedException();
		}
		char[] array;
		if (disposeImmediately)
		{
			array = scratchBuffer;
			if (array == null)
			{
				array = (scratchBuffer = new char[31111]);
			}
			scratchBufferUsed = true;
		}
		else
		{
			array = ArrayPool<char>.Shared.Rent(32768);
		}
		buffer = array;
		index = 0;
		this.disposeImmediately = disposeImmediately;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Dispose()
	{
		if (buffer != null)
		{
			if (buffer.Length != 31111)
			{
				ArrayPool<char>.Shared.Return(buffer);
			}
			buffer = null;
			index = 0;
			if (disposeImmediately)
			{
				scratchBufferUsed = false;
			}
		}
	}

	public void Clear()
	{
		index = 0;
	}

	public void TryGrow(int sizeHint)
	{
		if (buffer.Length < index + sizeHint)
		{
			Grow(sizeHint);
		}
	}

	public void Grow(int sizeHint)
	{
		int num = buffer.Length * 2;
		if (sizeHint != 0)
		{
			num = Math.Max(num, index + sizeHint);
		}
		char[] array = ArrayPool<char>.Shared.Rent(num);
		buffer.CopyTo(array, 0);
		if (buffer.Length != 31111)
		{
			ArrayPool<char>.Shared.Return(buffer);
		}
		buffer = array;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine()
	{
		if (crlf)
		{
			if (buffer.Length - index < 2)
			{
				Grow(2);
			}
			buffer[index] = newLine1;
			buffer[index + 1] = newLine2;
			index += 2;
		}
		else
		{
			if (buffer.Length - index < 1)
			{
				Grow(1);
			}
			buffer[index] = newLine1;
			index++;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(char value)
	{
		if (buffer.Length - index < 1)
		{
			Grow(1);
		}
		buffer[index++] = value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(char value, int repeatCount)
	{
		if (repeatCount < 0)
		{
			throw new ArgumentOutOfRangeException("repeatCount");
		}
		GetSpan(repeatCount).Fill(value);
		Advance(repeatCount);
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(char value)
	{
		Append(value);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(string value)
	{
		Append(value.AsSpan());
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(string value)
	{
		Append(value);
		AppendLine();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(string value, int startIndex, int count)
	{
		if (value == null)
		{
			if (startIndex != 0 || count != 0)
			{
				throw new ArgumentNullException("value");
			}
		}
		else
		{
			Append(value.AsSpan(startIndex, count));
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(char[] value, int startIndex, int charCount)
	{
		if (buffer.Length - index < charCount)
		{
			Grow(charCount);
		}
		Array.Copy(value, startIndex, buffer, index, charCount);
		index += charCount;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(ReadOnlySpan<char> value)
	{
		if (buffer.Length - index < value.Length)
		{
			Grow(value.Length);
		}
		value.CopyTo(buffer.AsSpan(index));
		index += value.Length;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void AppendLine(ReadOnlySpan<char> value)
	{
		Append(value);
		AppendLine();
	}

	public void Append<T>(T value)
	{
		if (!FormatterCache<T>.TryFormatDelegate(value, buffer.AsSpan(index), out var charsWritten, default(ReadOnlySpan<char>)))
		{
			Grow(charsWritten);
			if (!FormatterCache<T>.TryFormatDelegate(value, buffer.AsSpan(index), out charsWritten, default(ReadOnlySpan<char>)))
			{
				ThrowArgumentException("value");
			}
		}
		index += charsWritten;
	}

	public void AppendLine<T>(T value)
	{
		Append(value);
		AppendLine();
	}

	public void Insert(int index, string value, int count)
	{
		Insert(index, value.AsSpan(), count);
	}

	public void Insert(int index, string value)
	{
		Insert(index, value.AsSpan(), 1);
	}

	public void Insert(int index, ReadOnlySpan<char> value, int count)
	{
		if (count < 0)
		{
			ExceptionUtil.ThrowArgumentOutOfRangeException("count");
		}
		int length = Length;
		if ((uint)index > (uint)length)
		{
			ExceptionUtil.ThrowArgumentOutOfRangeException("index");
		}
		if (value.Length != 0 && count != 0)
		{
			int val = index + value.Length * count;
			char[] array = ArrayPool<char>.Shared.Rent(Math.Max(32768, val));
			buffer.AsSpan(0, index).CopyTo(array);
			int num = index;
			for (int i = 0; i < count; i++)
			{
				value.CopyTo(array.AsSpan(num));
				num += value.Length;
			}
			int num2 = this.index - index;
			buffer.AsSpan(index, num2).CopyTo(array.AsSpan(num));
			if (buffer.Length != 31111 && buffer != null)
			{
				ArrayPool<char>.Shared.Return(buffer);
			}
			buffer = array;
			this.index = num + num2;
		}
	}

	public void Replace(char oldChar, char newChar)
	{
		Replace(oldChar, newChar, 0, Length);
	}

	public void Replace(char oldChar, char newChar, int startIndex, int count)
	{
		int length = Length;
		if ((uint)startIndex > (uint)length)
		{
			ExceptionUtil.ThrowArgumentOutOfRangeException("startIndex");
		}
		if (count < 0 || startIndex > length - count)
		{
			ExceptionUtil.ThrowArgumentOutOfRangeException("count");
		}
		int num = startIndex + count;
		for (int i = startIndex; i < num; i++)
		{
			if (buffer[i] == oldChar)
			{
				buffer[i] = newChar;
			}
		}
	}

	public void Replace(string oldValue, string newValue)
	{
		Replace(oldValue, newValue, 0, Length);
	}

	public void Replace(ReadOnlySpan<char> oldValue, ReadOnlySpan<char> newValue)
	{
		Replace(oldValue, newValue, 0, Length);
	}

	public void Replace(string oldValue, string newValue, int startIndex, int count)
	{
		if (oldValue == null)
		{
			throw new ArgumentNullException("oldValue");
		}
		Replace(oldValue.AsSpan(), newValue.AsSpan(), startIndex, count);
	}

	public void Replace(ReadOnlySpan<char> oldValue, ReadOnlySpan<char> newValue, int startIndex, int count)
	{
		int length = Length;
		if ((uint)startIndex > (uint)length)
		{
			ExceptionUtil.ThrowArgumentOutOfRangeException("startIndex");
		}
		if (count < 0 || startIndex > length - count)
		{
			ExceptionUtil.ThrowArgumentOutOfRangeException("count");
		}
		if (oldValue.Length == 0)
		{
			throw new ArgumentException("oldValue.Length is 0", "oldValue");
		}
		ReadOnlySpan<char> readOnlySpan = AsSpan();
		int num = startIndex + count;
		int num2 = 0;
		int num3;
		for (num3 = startIndex; num3 < num; num3 += oldValue.Length)
		{
			int num4 = readOnlySpan.Slice(num3, num - num3).IndexOf(oldValue, StringComparison.Ordinal);
			if (num4 == -1)
			{
				break;
			}
			num3 += num4;
			num2++;
		}
		if (num2 == 0)
		{
			return;
		}
		char[] array = ArrayPool<char>.Shared.Rent(Math.Max(32768, Length + (newValue.Length - oldValue.Length) * num2));
		buffer.AsSpan(0, startIndex).CopyTo(array);
		int num5 = startIndex;
		int num6;
		for (num6 = startIndex; num6 < num; num6 += oldValue.Length)
		{
			int num7 = readOnlySpan.Slice(num6, num - num6).IndexOf(oldValue, StringComparison.Ordinal);
			if (num7 == -1)
			{
				ReadOnlySpan<char> readOnlySpan2 = readOnlySpan.Slice(num6);
				readOnlySpan2.CopyTo(array.AsSpan(num5));
				num5 += readOnlySpan2.Length;
				break;
			}
			readOnlySpan.Slice(num6, num7).CopyTo(array.AsSpan(num5));
			newValue.CopyTo(array.AsSpan(num5 + num7));
			num5 += num7 + newValue.Length;
			num6 += num7;
		}
		if (buffer.Length != 31111)
		{
			ArrayPool<char>.Shared.Return(buffer);
		}
		buffer = array;
		index = num5;
	}

	public void ReplaceAt(char newChar, int replaceIndex)
	{
		int length = Length;
		if ((uint)replaceIndex > (uint)length)
		{
			ExceptionUtil.ThrowArgumentOutOfRangeException("replaceIndex");
		}
		buffer[replaceIndex] = newChar;
	}

	public void Remove(int startIndex, int length)
	{
		if (length < 0)
		{
			ExceptionUtil.ThrowArgumentOutOfRangeException("length");
		}
		if (startIndex < 0)
		{
			ExceptionUtil.ThrowArgumentOutOfRangeException("startIndex");
		}
		if (length > Length - startIndex)
		{
			ExceptionUtil.ThrowArgumentOutOfRangeException("length");
		}
		if (Length == length && startIndex == 0)
		{
			index = 0;
		}
		else if (length != 0)
		{
			int num = startIndex + length;
			buffer.AsSpan(num, Length - num).CopyTo(buffer.AsSpan(startIndex));
			index -= length;
		}
	}

	public bool TryCopyTo(Span<char> destination, out int charsWritten)
	{
		if (destination.Length < index)
		{
			charsWritten = 0;
			return false;
		}
		charsWritten = index;
		buffer.AsSpan(0, index).CopyTo(destination);
		return true;
	}

	public override string ToString()
	{
		if (index == 0)
		{
			return string.Empty;
		}
		return new string(buffer, 0, index);
	}

	public Memory<char> GetMemory(int sizeHint)
	{
		if (buffer.Length - index < sizeHint)
		{
			Grow(sizeHint);
		}
		return buffer.AsMemory(index);
	}

	public Span<char> GetSpan(int sizeHint)
	{
		if (buffer.Length - index < sizeHint)
		{
			Grow(sizeHint);
		}
		return buffer.AsSpan(index);
	}

	public void Advance(int count)
	{
		index += count;
	}

	void IResettableBufferWriter<char>.Reset()
	{
		index = 0;
	}

	private void ThrowArgumentException(string paramName)
	{
		throw new ArgumentException("Can't format argument.", paramName);
	}

	private static void ThrowFormatException()
	{
		throw new FormatException("Index (zero based) must be greater than or equal to zero and less than the size of the argument list.");
	}

	private void AppendFormatInternal<T>(T arg, int width, ReadOnlySpan<char> format, string argName)
	{
		if (width <= 0)
		{
			width *= -1;
			if (!FormatterCache<T>.TryFormatDelegate(arg, buffer.AsSpan(index), out var charsWritten, format))
			{
				Grow(charsWritten);
				if (!FormatterCache<T>.TryFormatDelegate(arg, buffer.AsSpan(index), out charsWritten, format))
				{
					ThrowArgumentException(argName);
				}
			}
			index += charsWritten;
			int num = width - charsWritten;
			if (width > 0 && num > 0)
			{
				Append(' ', num);
			}
			return;
		}
		if (typeof(T) == typeof(string))
		{
			string text = Unsafe.As<string>(arg);
			int num2 = width - text.Length;
			if (num2 > 0)
			{
				Append(' ', num2);
			}
			Append(text);
			return;
		}
		Span<char> destination = stackalloc char[typeof(T).IsValueType ? (Unsafe.SizeOf<T>() * 8) : 1024];
		if (!FormatterCache<T>.TryFormatDelegate(arg, destination, out var charsWritten2, format))
		{
			destination = stackalloc char[destination.Length * 2];
			if (!FormatterCache<T>.TryFormatDelegate(arg, destination, out charsWritten2, format))
			{
				ThrowArgumentException(argName);
			}
		}
		int num3 = width - charsWritten2;
		if (num3 > 0)
		{
			Append(' ', num3);
		}
		Append((ReadOnlySpan<char>)destination.Slice(0, charsWritten2));
	}

	private static void ThrowNestedException()
	{
		throw new NestedStringBuilderCreationException("Utf16ValueStringBuilder");
	}

	public static void RegisterTryFormat<T>(TryFormat<T> formatMethod)
	{
		FormatterCache<T>.TryFormatDelegate = formatMethod;
	}

	private static TryFormat<T?> CreateNullableFormatter<T>() where T : struct
	{
		return delegate(T? x, Span<char> dest, out int written, ReadOnlySpan<char> format)
		{
			if (!x.HasValue)
			{
				written = 0;
				return true;
			}
			return FormatterCache<T>.TryFormatDelegate(x.Value, dest, out written, format);
		};
	}

	public static void EnableNullableFormat<T>() where T : struct
	{
		RegisterTryFormat(CreateNullableFormatter<T>());
	}
}
