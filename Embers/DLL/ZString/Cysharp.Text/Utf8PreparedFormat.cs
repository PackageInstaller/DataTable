using System;
using System.Buffers;

namespace Cysharp.Text;

public sealed class Utf8PreparedFormat<T1>
{
	private readonly Utf8FormatSegment[] segments;

	private readonly byte[] utf8PreEncodedbuffer;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf8PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf8Parse(format, out utf8PreEncodedbuffer);
		int num = 0;
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			if (!utf8FormatSegment.IsFormatArgument)
			{
				num += utf8FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1)
	{
		Utf8ValueStringBuilder sb = new Utf8ValueStringBuilder(disposeImmediately: true);
		try
		{
			FormatTo(ref sb, arg1);
			return sb.ToString();
		}
		finally
		{
			sb.Dispose();
		}
	}

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1) where TBufferWriter : IBufferWriter<byte>
	{
		Span<byte> span = utf8PreEncodedbuffer.AsSpan();
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			switch (utf8FormatSegment.FormatIndex)
			{
			case -1:
			{
				Span<byte> span2 = span.Slice(utf8FormatSegment.Offset, utf8FormatSegment.Count);
				int count = utf8FormatSegment.Count;
				Span<byte> span3 = sb.GetSpan(count);
				span2.TryCopyTo(span3);
				int count2 = utf8FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf8FormatHelper.FormatTo(ref sb, arg1, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg1");
				break;
			}
		}
	}
}
public sealed class Utf8PreparedFormat<T1, T2>
{
	private readonly Utf8FormatSegment[] segments;

	private readonly byte[] utf8PreEncodedbuffer;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf8PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf8Parse(format, out utf8PreEncodedbuffer);
		int num = 0;
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			if (!utf8FormatSegment.IsFormatArgument)
			{
				num += utf8FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2)
	{
		Utf8ValueStringBuilder sb = new Utf8ValueStringBuilder(disposeImmediately: true);
		try
		{
			FormatTo(ref sb, arg1, arg2);
			return sb.ToString();
		}
		finally
		{
			sb.Dispose();
		}
	}

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2) where TBufferWriter : IBufferWriter<byte>
	{
		Span<byte> span = utf8PreEncodedbuffer.AsSpan();
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			switch (utf8FormatSegment.FormatIndex)
			{
			case -1:
			{
				Span<byte> span2 = span.Slice(utf8FormatSegment.Offset, utf8FormatSegment.Count);
				int count = utf8FormatSegment.Count;
				Span<byte> span3 = sb.GetSpan(count);
				span2.TryCopyTo(span3);
				int count2 = utf8FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf8FormatHelper.FormatTo(ref sb, arg1, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg1");
				break;
			case 1:
				Utf8FormatHelper.FormatTo(ref sb, arg2, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg2");
				break;
			}
		}
	}
}
public sealed class Utf8PreparedFormat<T1, T2, T3>
{
	private readonly Utf8FormatSegment[] segments;

	private readonly byte[] utf8PreEncodedbuffer;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf8PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf8Parse(format, out utf8PreEncodedbuffer);
		int num = 0;
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			if (!utf8FormatSegment.IsFormatArgument)
			{
				num += utf8FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3)
	{
		Utf8ValueStringBuilder sb = new Utf8ValueStringBuilder(disposeImmediately: true);
		try
		{
			FormatTo(ref sb, arg1, arg2, arg3);
			return sb.ToString();
		}
		finally
		{
			sb.Dispose();
		}
	}

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3) where TBufferWriter : IBufferWriter<byte>
	{
		Span<byte> span = utf8PreEncodedbuffer.AsSpan();
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			switch (utf8FormatSegment.FormatIndex)
			{
			case -1:
			{
				Span<byte> span2 = span.Slice(utf8FormatSegment.Offset, utf8FormatSegment.Count);
				int count = utf8FormatSegment.Count;
				Span<byte> span3 = sb.GetSpan(count);
				span2.TryCopyTo(span3);
				int count2 = utf8FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf8FormatHelper.FormatTo(ref sb, arg1, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg1");
				break;
			case 1:
				Utf8FormatHelper.FormatTo(ref sb, arg2, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg2");
				break;
			case 2:
				Utf8FormatHelper.FormatTo(ref sb, arg3, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg3");
				break;
			}
		}
	}
}
public sealed class Utf8PreparedFormat<T1, T2, T3, T4>
{
	private readonly Utf8FormatSegment[] segments;

	private readonly byte[] utf8PreEncodedbuffer;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf8PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf8Parse(format, out utf8PreEncodedbuffer);
		int num = 0;
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			if (!utf8FormatSegment.IsFormatArgument)
			{
				num += utf8FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		Utf8ValueStringBuilder sb = new Utf8ValueStringBuilder(disposeImmediately: true);
		try
		{
			FormatTo(ref sb, arg1, arg2, arg3, arg4);
			return sb.ToString();
		}
		finally
		{
			sb.Dispose();
		}
	}

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4) where TBufferWriter : IBufferWriter<byte>
	{
		Span<byte> span = utf8PreEncodedbuffer.AsSpan();
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			switch (utf8FormatSegment.FormatIndex)
			{
			case -1:
			{
				Span<byte> span2 = span.Slice(utf8FormatSegment.Offset, utf8FormatSegment.Count);
				int count = utf8FormatSegment.Count;
				Span<byte> span3 = sb.GetSpan(count);
				span2.TryCopyTo(span3);
				int count2 = utf8FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf8FormatHelper.FormatTo(ref sb, arg1, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg1");
				break;
			case 1:
				Utf8FormatHelper.FormatTo(ref sb, arg2, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg2");
				break;
			case 2:
				Utf8FormatHelper.FormatTo(ref sb, arg3, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg3");
				break;
			case 3:
				Utf8FormatHelper.FormatTo(ref sb, arg4, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg4");
				break;
			}
		}
	}
}
public sealed class Utf8PreparedFormat<T1, T2, T3, T4, T5>
{
	private readonly Utf8FormatSegment[] segments;

	private readonly byte[] utf8PreEncodedbuffer;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf8PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf8Parse(format, out utf8PreEncodedbuffer);
		int num = 0;
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			if (!utf8FormatSegment.IsFormatArgument)
			{
				num += utf8FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		Utf8ValueStringBuilder sb = new Utf8ValueStringBuilder(disposeImmediately: true);
		try
		{
			FormatTo(ref sb, arg1, arg2, arg3, arg4, arg5);
			return sb.ToString();
		}
		finally
		{
			sb.Dispose();
		}
	}

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5) where TBufferWriter : IBufferWriter<byte>
	{
		Span<byte> span = utf8PreEncodedbuffer.AsSpan();
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			switch (utf8FormatSegment.FormatIndex)
			{
			case -1:
			{
				Span<byte> span2 = span.Slice(utf8FormatSegment.Offset, utf8FormatSegment.Count);
				int count = utf8FormatSegment.Count;
				Span<byte> span3 = sb.GetSpan(count);
				span2.TryCopyTo(span3);
				int count2 = utf8FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf8FormatHelper.FormatTo(ref sb, arg1, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg1");
				break;
			case 1:
				Utf8FormatHelper.FormatTo(ref sb, arg2, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg2");
				break;
			case 2:
				Utf8FormatHelper.FormatTo(ref sb, arg3, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg3");
				break;
			case 3:
				Utf8FormatHelper.FormatTo(ref sb, arg4, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg4");
				break;
			case 4:
				Utf8FormatHelper.FormatTo(ref sb, arg5, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg5");
				break;
			}
		}
	}
}
public sealed class Utf8PreparedFormat<T1, T2, T3, T4, T5, T6>
{
	private readonly Utf8FormatSegment[] segments;

	private readonly byte[] utf8PreEncodedbuffer;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf8PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf8Parse(format, out utf8PreEncodedbuffer);
		int num = 0;
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			if (!utf8FormatSegment.IsFormatArgument)
			{
				num += utf8FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
	{
		Utf8ValueStringBuilder sb = new Utf8ValueStringBuilder(disposeImmediately: true);
		try
		{
			FormatTo(ref sb, arg1, arg2, arg3, arg4, arg5, arg6);
			return sb.ToString();
		}
		finally
		{
			sb.Dispose();
		}
	}

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6) where TBufferWriter : IBufferWriter<byte>
	{
		Span<byte> span = utf8PreEncodedbuffer.AsSpan();
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			switch (utf8FormatSegment.FormatIndex)
			{
			case -1:
			{
				Span<byte> span2 = span.Slice(utf8FormatSegment.Offset, utf8FormatSegment.Count);
				int count = utf8FormatSegment.Count;
				Span<byte> span3 = sb.GetSpan(count);
				span2.TryCopyTo(span3);
				int count2 = utf8FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf8FormatHelper.FormatTo(ref sb, arg1, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg1");
				break;
			case 1:
				Utf8FormatHelper.FormatTo(ref sb, arg2, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg2");
				break;
			case 2:
				Utf8FormatHelper.FormatTo(ref sb, arg3, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg3");
				break;
			case 3:
				Utf8FormatHelper.FormatTo(ref sb, arg4, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg4");
				break;
			case 4:
				Utf8FormatHelper.FormatTo(ref sb, arg5, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg5");
				break;
			case 5:
				Utf8FormatHelper.FormatTo(ref sb, arg6, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg6");
				break;
			}
		}
	}
}
public sealed class Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7>
{
	private readonly Utf8FormatSegment[] segments;

	private readonly byte[] utf8PreEncodedbuffer;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf8PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf8Parse(format, out utf8PreEncodedbuffer);
		int num = 0;
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			if (!utf8FormatSegment.IsFormatArgument)
			{
				num += utf8FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
	{
		Utf8ValueStringBuilder sb = new Utf8ValueStringBuilder(disposeImmediately: true);
		try
		{
			FormatTo(ref sb, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
			return sb.ToString();
		}
		finally
		{
			sb.Dispose();
		}
	}

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7) where TBufferWriter : IBufferWriter<byte>
	{
		Span<byte> span = utf8PreEncodedbuffer.AsSpan();
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			switch (utf8FormatSegment.FormatIndex)
			{
			case -1:
			{
				Span<byte> span2 = span.Slice(utf8FormatSegment.Offset, utf8FormatSegment.Count);
				int count = utf8FormatSegment.Count;
				Span<byte> span3 = sb.GetSpan(count);
				span2.TryCopyTo(span3);
				int count2 = utf8FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf8FormatHelper.FormatTo(ref sb, arg1, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg1");
				break;
			case 1:
				Utf8FormatHelper.FormatTo(ref sb, arg2, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg2");
				break;
			case 2:
				Utf8FormatHelper.FormatTo(ref sb, arg3, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg3");
				break;
			case 3:
				Utf8FormatHelper.FormatTo(ref sb, arg4, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg4");
				break;
			case 4:
				Utf8FormatHelper.FormatTo(ref sb, arg5, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg5");
				break;
			case 5:
				Utf8FormatHelper.FormatTo(ref sb, arg6, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg6");
				break;
			case 6:
				Utf8FormatHelper.FormatTo(ref sb, arg7, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg7");
				break;
			}
		}
	}
}
public sealed class Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8>
{
	private readonly Utf8FormatSegment[] segments;

	private readonly byte[] utf8PreEncodedbuffer;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf8PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf8Parse(format, out utf8PreEncodedbuffer);
		int num = 0;
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			if (!utf8FormatSegment.IsFormatArgument)
			{
				num += utf8FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8)
	{
		Utf8ValueStringBuilder sb = new Utf8ValueStringBuilder(disposeImmediately: true);
		try
		{
			FormatTo(ref sb, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
			return sb.ToString();
		}
		finally
		{
			sb.Dispose();
		}
	}

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8) where TBufferWriter : IBufferWriter<byte>
	{
		Span<byte> span = utf8PreEncodedbuffer.AsSpan();
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			switch (utf8FormatSegment.FormatIndex)
			{
			case -1:
			{
				Span<byte> span2 = span.Slice(utf8FormatSegment.Offset, utf8FormatSegment.Count);
				int count = utf8FormatSegment.Count;
				Span<byte> span3 = sb.GetSpan(count);
				span2.TryCopyTo(span3);
				int count2 = utf8FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf8FormatHelper.FormatTo(ref sb, arg1, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg1");
				break;
			case 1:
				Utf8FormatHelper.FormatTo(ref sb, arg2, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg2");
				break;
			case 2:
				Utf8FormatHelper.FormatTo(ref sb, arg3, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg3");
				break;
			case 3:
				Utf8FormatHelper.FormatTo(ref sb, arg4, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg4");
				break;
			case 4:
				Utf8FormatHelper.FormatTo(ref sb, arg5, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg5");
				break;
			case 5:
				Utf8FormatHelper.FormatTo(ref sb, arg6, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg6");
				break;
			case 6:
				Utf8FormatHelper.FormatTo(ref sb, arg7, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg7");
				break;
			case 7:
				Utf8FormatHelper.FormatTo(ref sb, arg8, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg8");
				break;
			}
		}
	}
}
public sealed class Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9>
{
	private readonly Utf8FormatSegment[] segments;

	private readonly byte[] utf8PreEncodedbuffer;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf8PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf8Parse(format, out utf8PreEncodedbuffer);
		int num = 0;
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			if (!utf8FormatSegment.IsFormatArgument)
			{
				num += utf8FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9)
	{
		Utf8ValueStringBuilder sb = new Utf8ValueStringBuilder(disposeImmediately: true);
		try
		{
			FormatTo(ref sb, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
			return sb.ToString();
		}
		finally
		{
			sb.Dispose();
		}
	}

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9) where TBufferWriter : IBufferWriter<byte>
	{
		Span<byte> span = utf8PreEncodedbuffer.AsSpan();
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			switch (utf8FormatSegment.FormatIndex)
			{
			case -1:
			{
				Span<byte> span2 = span.Slice(utf8FormatSegment.Offset, utf8FormatSegment.Count);
				int count = utf8FormatSegment.Count;
				Span<byte> span3 = sb.GetSpan(count);
				span2.TryCopyTo(span3);
				int count2 = utf8FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf8FormatHelper.FormatTo(ref sb, arg1, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg1");
				break;
			case 1:
				Utf8FormatHelper.FormatTo(ref sb, arg2, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg2");
				break;
			case 2:
				Utf8FormatHelper.FormatTo(ref sb, arg3, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg3");
				break;
			case 3:
				Utf8FormatHelper.FormatTo(ref sb, arg4, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg4");
				break;
			case 4:
				Utf8FormatHelper.FormatTo(ref sb, arg5, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg5");
				break;
			case 5:
				Utf8FormatHelper.FormatTo(ref sb, arg6, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg6");
				break;
			case 6:
				Utf8FormatHelper.FormatTo(ref sb, arg7, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg7");
				break;
			case 7:
				Utf8FormatHelper.FormatTo(ref sb, arg8, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg8");
				break;
			case 8:
				Utf8FormatHelper.FormatTo(ref sb, arg9, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg9");
				break;
			}
		}
	}
}
public sealed class Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>
{
	private readonly Utf8FormatSegment[] segments;

	private readonly byte[] utf8PreEncodedbuffer;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf8PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf8Parse(format, out utf8PreEncodedbuffer);
		int num = 0;
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			if (!utf8FormatSegment.IsFormatArgument)
			{
				num += utf8FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10)
	{
		Utf8ValueStringBuilder sb = new Utf8ValueStringBuilder(disposeImmediately: true);
		try
		{
			FormatTo(ref sb, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
			return sb.ToString();
		}
		finally
		{
			sb.Dispose();
		}
	}

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10) where TBufferWriter : IBufferWriter<byte>
	{
		Span<byte> span = utf8PreEncodedbuffer.AsSpan();
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			switch (utf8FormatSegment.FormatIndex)
			{
			case -1:
			{
				Span<byte> span2 = span.Slice(utf8FormatSegment.Offset, utf8FormatSegment.Count);
				int count = utf8FormatSegment.Count;
				Span<byte> span3 = sb.GetSpan(count);
				span2.TryCopyTo(span3);
				int count2 = utf8FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf8FormatHelper.FormatTo(ref sb, arg1, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg1");
				break;
			case 1:
				Utf8FormatHelper.FormatTo(ref sb, arg2, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg2");
				break;
			case 2:
				Utf8FormatHelper.FormatTo(ref sb, arg3, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg3");
				break;
			case 3:
				Utf8FormatHelper.FormatTo(ref sb, arg4, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg4");
				break;
			case 4:
				Utf8FormatHelper.FormatTo(ref sb, arg5, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg5");
				break;
			case 5:
				Utf8FormatHelper.FormatTo(ref sb, arg6, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg6");
				break;
			case 6:
				Utf8FormatHelper.FormatTo(ref sb, arg7, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg7");
				break;
			case 7:
				Utf8FormatHelper.FormatTo(ref sb, arg8, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg8");
				break;
			case 8:
				Utf8FormatHelper.FormatTo(ref sb, arg9, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg9");
				break;
			case 9:
				Utf8FormatHelper.FormatTo(ref sb, arg10, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg10");
				break;
			}
		}
	}
}
public sealed class Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>
{
	private readonly Utf8FormatSegment[] segments;

	private readonly byte[] utf8PreEncodedbuffer;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf8PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf8Parse(format, out utf8PreEncodedbuffer);
		int num = 0;
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			if (!utf8FormatSegment.IsFormatArgument)
			{
				num += utf8FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11)
	{
		Utf8ValueStringBuilder sb = new Utf8ValueStringBuilder(disposeImmediately: true);
		try
		{
			FormatTo(ref sb, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
			return sb.ToString();
		}
		finally
		{
			sb.Dispose();
		}
	}

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11) where TBufferWriter : IBufferWriter<byte>
	{
		Span<byte> span = utf8PreEncodedbuffer.AsSpan();
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			switch (utf8FormatSegment.FormatIndex)
			{
			case -1:
			{
				Span<byte> span2 = span.Slice(utf8FormatSegment.Offset, utf8FormatSegment.Count);
				int count = utf8FormatSegment.Count;
				Span<byte> span3 = sb.GetSpan(count);
				span2.TryCopyTo(span3);
				int count2 = utf8FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf8FormatHelper.FormatTo(ref sb, arg1, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg1");
				break;
			case 1:
				Utf8FormatHelper.FormatTo(ref sb, arg2, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg2");
				break;
			case 2:
				Utf8FormatHelper.FormatTo(ref sb, arg3, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg3");
				break;
			case 3:
				Utf8FormatHelper.FormatTo(ref sb, arg4, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg4");
				break;
			case 4:
				Utf8FormatHelper.FormatTo(ref sb, arg5, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg5");
				break;
			case 5:
				Utf8FormatHelper.FormatTo(ref sb, arg6, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg6");
				break;
			case 6:
				Utf8FormatHelper.FormatTo(ref sb, arg7, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg7");
				break;
			case 7:
				Utf8FormatHelper.FormatTo(ref sb, arg8, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg8");
				break;
			case 8:
				Utf8FormatHelper.FormatTo(ref sb, arg9, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg9");
				break;
			case 9:
				Utf8FormatHelper.FormatTo(ref sb, arg10, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg10");
				break;
			case 10:
				Utf8FormatHelper.FormatTo(ref sb, arg11, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg11");
				break;
			}
		}
	}
}
public sealed class Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>
{
	private readonly Utf8FormatSegment[] segments;

	private readonly byte[] utf8PreEncodedbuffer;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf8PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf8Parse(format, out utf8PreEncodedbuffer);
		int num = 0;
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			if (!utf8FormatSegment.IsFormatArgument)
			{
				num += utf8FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12)
	{
		Utf8ValueStringBuilder sb = new Utf8ValueStringBuilder(disposeImmediately: true);
		try
		{
			FormatTo(ref sb, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
			return sb.ToString();
		}
		finally
		{
			sb.Dispose();
		}
	}

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12) where TBufferWriter : IBufferWriter<byte>
	{
		Span<byte> span = utf8PreEncodedbuffer.AsSpan();
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			switch (utf8FormatSegment.FormatIndex)
			{
			case -1:
			{
				Span<byte> span2 = span.Slice(utf8FormatSegment.Offset, utf8FormatSegment.Count);
				int count = utf8FormatSegment.Count;
				Span<byte> span3 = sb.GetSpan(count);
				span2.TryCopyTo(span3);
				int count2 = utf8FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf8FormatHelper.FormatTo(ref sb, arg1, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg1");
				break;
			case 1:
				Utf8FormatHelper.FormatTo(ref sb, arg2, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg2");
				break;
			case 2:
				Utf8FormatHelper.FormatTo(ref sb, arg3, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg3");
				break;
			case 3:
				Utf8FormatHelper.FormatTo(ref sb, arg4, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg4");
				break;
			case 4:
				Utf8FormatHelper.FormatTo(ref sb, arg5, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg5");
				break;
			case 5:
				Utf8FormatHelper.FormatTo(ref sb, arg6, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg6");
				break;
			case 6:
				Utf8FormatHelper.FormatTo(ref sb, arg7, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg7");
				break;
			case 7:
				Utf8FormatHelper.FormatTo(ref sb, arg8, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg8");
				break;
			case 8:
				Utf8FormatHelper.FormatTo(ref sb, arg9, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg9");
				break;
			case 9:
				Utf8FormatHelper.FormatTo(ref sb, arg10, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg10");
				break;
			case 10:
				Utf8FormatHelper.FormatTo(ref sb, arg11, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg11");
				break;
			case 11:
				Utf8FormatHelper.FormatTo(ref sb, arg12, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg12");
				break;
			}
		}
	}
}
public sealed class Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>
{
	private readonly Utf8FormatSegment[] segments;

	private readonly byte[] utf8PreEncodedbuffer;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf8PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf8Parse(format, out utf8PreEncodedbuffer);
		int num = 0;
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			if (!utf8FormatSegment.IsFormatArgument)
			{
				num += utf8FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13)
	{
		Utf8ValueStringBuilder sb = new Utf8ValueStringBuilder(disposeImmediately: true);
		try
		{
			FormatTo(ref sb, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
			return sb.ToString();
		}
		finally
		{
			sb.Dispose();
		}
	}

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13) where TBufferWriter : IBufferWriter<byte>
	{
		Span<byte> span = utf8PreEncodedbuffer.AsSpan();
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			switch (utf8FormatSegment.FormatIndex)
			{
			case -1:
			{
				Span<byte> span2 = span.Slice(utf8FormatSegment.Offset, utf8FormatSegment.Count);
				int count = utf8FormatSegment.Count;
				Span<byte> span3 = sb.GetSpan(count);
				span2.TryCopyTo(span3);
				int count2 = utf8FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf8FormatHelper.FormatTo(ref sb, arg1, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg1");
				break;
			case 1:
				Utf8FormatHelper.FormatTo(ref sb, arg2, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg2");
				break;
			case 2:
				Utf8FormatHelper.FormatTo(ref sb, arg3, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg3");
				break;
			case 3:
				Utf8FormatHelper.FormatTo(ref sb, arg4, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg4");
				break;
			case 4:
				Utf8FormatHelper.FormatTo(ref sb, arg5, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg5");
				break;
			case 5:
				Utf8FormatHelper.FormatTo(ref sb, arg6, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg6");
				break;
			case 6:
				Utf8FormatHelper.FormatTo(ref sb, arg7, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg7");
				break;
			case 7:
				Utf8FormatHelper.FormatTo(ref sb, arg8, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg8");
				break;
			case 8:
				Utf8FormatHelper.FormatTo(ref sb, arg9, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg9");
				break;
			case 9:
				Utf8FormatHelper.FormatTo(ref sb, arg10, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg10");
				break;
			case 10:
				Utf8FormatHelper.FormatTo(ref sb, arg11, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg11");
				break;
			case 11:
				Utf8FormatHelper.FormatTo(ref sb, arg12, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg12");
				break;
			case 12:
				Utf8FormatHelper.FormatTo(ref sb, arg13, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg13");
				break;
			}
		}
	}
}
public sealed class Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>
{
	private readonly Utf8FormatSegment[] segments;

	private readonly byte[] utf8PreEncodedbuffer;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf8PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf8Parse(format, out utf8PreEncodedbuffer);
		int num = 0;
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			if (!utf8FormatSegment.IsFormatArgument)
			{
				num += utf8FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14)
	{
		Utf8ValueStringBuilder sb = new Utf8ValueStringBuilder(disposeImmediately: true);
		try
		{
			FormatTo(ref sb, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
			return sb.ToString();
		}
		finally
		{
			sb.Dispose();
		}
	}

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14) where TBufferWriter : IBufferWriter<byte>
	{
		Span<byte> span = utf8PreEncodedbuffer.AsSpan();
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			switch (utf8FormatSegment.FormatIndex)
			{
			case -1:
			{
				Span<byte> span2 = span.Slice(utf8FormatSegment.Offset, utf8FormatSegment.Count);
				int count = utf8FormatSegment.Count;
				Span<byte> span3 = sb.GetSpan(count);
				span2.TryCopyTo(span3);
				int count2 = utf8FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf8FormatHelper.FormatTo(ref sb, arg1, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg1");
				break;
			case 1:
				Utf8FormatHelper.FormatTo(ref sb, arg2, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg2");
				break;
			case 2:
				Utf8FormatHelper.FormatTo(ref sb, arg3, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg3");
				break;
			case 3:
				Utf8FormatHelper.FormatTo(ref sb, arg4, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg4");
				break;
			case 4:
				Utf8FormatHelper.FormatTo(ref sb, arg5, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg5");
				break;
			case 5:
				Utf8FormatHelper.FormatTo(ref sb, arg6, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg6");
				break;
			case 6:
				Utf8FormatHelper.FormatTo(ref sb, arg7, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg7");
				break;
			case 7:
				Utf8FormatHelper.FormatTo(ref sb, arg8, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg8");
				break;
			case 8:
				Utf8FormatHelper.FormatTo(ref sb, arg9, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg9");
				break;
			case 9:
				Utf8FormatHelper.FormatTo(ref sb, arg10, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg10");
				break;
			case 10:
				Utf8FormatHelper.FormatTo(ref sb, arg11, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg11");
				break;
			case 11:
				Utf8FormatHelper.FormatTo(ref sb, arg12, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg12");
				break;
			case 12:
				Utf8FormatHelper.FormatTo(ref sb, arg13, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg13");
				break;
			case 13:
				Utf8FormatHelper.FormatTo(ref sb, arg14, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg14");
				break;
			}
		}
	}
}
public sealed class Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>
{
	private readonly Utf8FormatSegment[] segments;

	private readonly byte[] utf8PreEncodedbuffer;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf8PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf8Parse(format, out utf8PreEncodedbuffer);
		int num = 0;
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			if (!utf8FormatSegment.IsFormatArgument)
			{
				num += utf8FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15)
	{
		Utf8ValueStringBuilder sb = new Utf8ValueStringBuilder(disposeImmediately: true);
		try
		{
			FormatTo(ref sb, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
			return sb.ToString();
		}
		finally
		{
			sb.Dispose();
		}
	}

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15) where TBufferWriter : IBufferWriter<byte>
	{
		Span<byte> span = utf8PreEncodedbuffer.AsSpan();
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			switch (utf8FormatSegment.FormatIndex)
			{
			case -1:
			{
				Span<byte> span2 = span.Slice(utf8FormatSegment.Offset, utf8FormatSegment.Count);
				int count = utf8FormatSegment.Count;
				Span<byte> span3 = sb.GetSpan(count);
				span2.TryCopyTo(span3);
				int count2 = utf8FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf8FormatHelper.FormatTo(ref sb, arg1, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg1");
				break;
			case 1:
				Utf8FormatHelper.FormatTo(ref sb, arg2, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg2");
				break;
			case 2:
				Utf8FormatHelper.FormatTo(ref sb, arg3, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg3");
				break;
			case 3:
				Utf8FormatHelper.FormatTo(ref sb, arg4, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg4");
				break;
			case 4:
				Utf8FormatHelper.FormatTo(ref sb, arg5, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg5");
				break;
			case 5:
				Utf8FormatHelper.FormatTo(ref sb, arg6, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg6");
				break;
			case 6:
				Utf8FormatHelper.FormatTo(ref sb, arg7, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg7");
				break;
			case 7:
				Utf8FormatHelper.FormatTo(ref sb, arg8, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg8");
				break;
			case 8:
				Utf8FormatHelper.FormatTo(ref sb, arg9, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg9");
				break;
			case 9:
				Utf8FormatHelper.FormatTo(ref sb, arg10, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg10");
				break;
			case 10:
				Utf8FormatHelper.FormatTo(ref sb, arg11, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg11");
				break;
			case 11:
				Utf8FormatHelper.FormatTo(ref sb, arg12, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg12");
				break;
			case 12:
				Utf8FormatHelper.FormatTo(ref sb, arg13, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg13");
				break;
			case 13:
				Utf8FormatHelper.FormatTo(ref sb, arg14, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg14");
				break;
			case 14:
				Utf8FormatHelper.FormatTo(ref sb, arg15, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg15");
				break;
			}
		}
	}
}
public sealed class Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16>
{
	private readonly Utf8FormatSegment[] segments;

	private readonly byte[] utf8PreEncodedbuffer;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf8PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf8Parse(format, out utf8PreEncodedbuffer);
		int num = 0;
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			if (!utf8FormatSegment.IsFormatArgument)
			{
				num += utf8FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15, T16 arg16)
	{
		Utf8ValueStringBuilder sb = new Utf8ValueStringBuilder(disposeImmediately: true);
		try
		{
			FormatTo(ref sb, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
			return sb.ToString();
		}
		finally
		{
			sb.Dispose();
		}
	}

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15, T16 arg16) where TBufferWriter : IBufferWriter<byte>
	{
		Span<byte> span = utf8PreEncodedbuffer.AsSpan();
		Utf8FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf8FormatSegment utf8FormatSegment = array[i];
			switch (utf8FormatSegment.FormatIndex)
			{
			case -1:
			{
				Span<byte> span2 = span.Slice(utf8FormatSegment.Offset, utf8FormatSegment.Count);
				int count = utf8FormatSegment.Count;
				Span<byte> span3 = sb.GetSpan(count);
				span2.TryCopyTo(span3);
				int count2 = utf8FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf8FormatHelper.FormatTo(ref sb, arg1, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg1");
				break;
			case 1:
				Utf8FormatHelper.FormatTo(ref sb, arg2, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg2");
				break;
			case 2:
				Utf8FormatHelper.FormatTo(ref sb, arg3, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg3");
				break;
			case 3:
				Utf8FormatHelper.FormatTo(ref sb, arg4, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg4");
				break;
			case 4:
				Utf8FormatHelper.FormatTo(ref sb, arg5, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg5");
				break;
			case 5:
				Utf8FormatHelper.FormatTo(ref sb, arg6, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg6");
				break;
			case 6:
				Utf8FormatHelper.FormatTo(ref sb, arg7, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg7");
				break;
			case 7:
				Utf8FormatHelper.FormatTo(ref sb, arg8, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg8");
				break;
			case 8:
				Utf8FormatHelper.FormatTo(ref sb, arg9, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg9");
				break;
			case 9:
				Utf8FormatHelper.FormatTo(ref sb, arg10, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg10");
				break;
			case 10:
				Utf8FormatHelper.FormatTo(ref sb, arg11, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg11");
				break;
			case 11:
				Utf8FormatHelper.FormatTo(ref sb, arg12, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg12");
				break;
			case 12:
				Utf8FormatHelper.FormatTo(ref sb, arg13, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg13");
				break;
			case 13:
				Utf8FormatHelper.FormatTo(ref sb, arg14, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg14");
				break;
			case 14:
				Utf8FormatHelper.FormatTo(ref sb, arg15, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg15");
				break;
			case 15:
				Utf8FormatHelper.FormatTo(ref sb, arg16, utf8FormatSegment.Alignment, utf8FormatSegment.StandardFormat, "arg16");
				break;
			}
		}
	}
}
