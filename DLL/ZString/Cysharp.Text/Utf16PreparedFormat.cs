using System;
using System.Buffers;

namespace Cysharp.Text;

public sealed class Utf16PreparedFormat<T1>
{
	private readonly Utf16FormatSegment[] segments;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf16PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf16Parse(format);
		int num = 0;
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			if (!utf16FormatSegment.IsFormatArgument)
			{
				num += utf16FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1)
	{
		Utf16ValueStringBuilder sb = new Utf16ValueStringBuilder(disposeImmediately: true);
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

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1) where TBufferWriter : IBufferWriter<char>
	{
		ReadOnlySpan<char> readOnlySpan = FormatString.AsSpan();
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			switch (utf16FormatSegment.FormatIndex)
			{
			case -1:
			{
				ReadOnlySpan<char> readOnlySpan2 = readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count);
				int count = utf16FormatSegment.Count;
				Span<char> span = sb.GetSpan(count);
				readOnlySpan2.TryCopyTo(span);
				int count2 = utf16FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf16FormatHelper.FormatTo(ref sb, arg1, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg1");
				break;
			}
		}
	}
}
public sealed class Utf16PreparedFormat<T1, T2>
{
	private readonly Utf16FormatSegment[] segments;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf16PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf16Parse(format);
		int num = 0;
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			if (!utf16FormatSegment.IsFormatArgument)
			{
				num += utf16FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2)
	{
		Utf16ValueStringBuilder sb = new Utf16ValueStringBuilder(disposeImmediately: true);
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

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2) where TBufferWriter : IBufferWriter<char>
	{
		ReadOnlySpan<char> readOnlySpan = FormatString.AsSpan();
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			switch (utf16FormatSegment.FormatIndex)
			{
			case -1:
			{
				ReadOnlySpan<char> readOnlySpan2 = readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count);
				int count = utf16FormatSegment.Count;
				Span<char> span = sb.GetSpan(count);
				readOnlySpan2.TryCopyTo(span);
				int count2 = utf16FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf16FormatHelper.FormatTo(ref sb, arg1, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg1");
				break;
			case 1:
				Utf16FormatHelper.FormatTo(ref sb, arg2, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg2");
				break;
			}
		}
	}
}
public sealed class Utf16PreparedFormat<T1, T2, T3>
{
	private readonly Utf16FormatSegment[] segments;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf16PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf16Parse(format);
		int num = 0;
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			if (!utf16FormatSegment.IsFormatArgument)
			{
				num += utf16FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3)
	{
		Utf16ValueStringBuilder sb = new Utf16ValueStringBuilder(disposeImmediately: true);
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

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3) where TBufferWriter : IBufferWriter<char>
	{
		ReadOnlySpan<char> readOnlySpan = FormatString.AsSpan();
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			switch (utf16FormatSegment.FormatIndex)
			{
			case -1:
			{
				ReadOnlySpan<char> readOnlySpan2 = readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count);
				int count = utf16FormatSegment.Count;
				Span<char> span = sb.GetSpan(count);
				readOnlySpan2.TryCopyTo(span);
				int count2 = utf16FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf16FormatHelper.FormatTo(ref sb, arg1, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg1");
				break;
			case 1:
				Utf16FormatHelper.FormatTo(ref sb, arg2, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg2");
				break;
			case 2:
				Utf16FormatHelper.FormatTo(ref sb, arg3, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg3");
				break;
			}
		}
	}
}
public sealed class Utf16PreparedFormat<T1, T2, T3, T4>
{
	private readonly Utf16FormatSegment[] segments;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf16PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf16Parse(format);
		int num = 0;
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			if (!utf16FormatSegment.IsFormatArgument)
			{
				num += utf16FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		Utf16ValueStringBuilder sb = new Utf16ValueStringBuilder(disposeImmediately: true);
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

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4) where TBufferWriter : IBufferWriter<char>
	{
		ReadOnlySpan<char> readOnlySpan = FormatString.AsSpan();
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			switch (utf16FormatSegment.FormatIndex)
			{
			case -1:
			{
				ReadOnlySpan<char> readOnlySpan2 = readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count);
				int count = utf16FormatSegment.Count;
				Span<char> span = sb.GetSpan(count);
				readOnlySpan2.TryCopyTo(span);
				int count2 = utf16FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf16FormatHelper.FormatTo(ref sb, arg1, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg1");
				break;
			case 1:
				Utf16FormatHelper.FormatTo(ref sb, arg2, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg2");
				break;
			case 2:
				Utf16FormatHelper.FormatTo(ref sb, arg3, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg3");
				break;
			case 3:
				Utf16FormatHelper.FormatTo(ref sb, arg4, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg4");
				break;
			}
		}
	}
}
public sealed class Utf16PreparedFormat<T1, T2, T3, T4, T5>
{
	private readonly Utf16FormatSegment[] segments;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf16PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf16Parse(format);
		int num = 0;
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			if (!utf16FormatSegment.IsFormatArgument)
			{
				num += utf16FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		Utf16ValueStringBuilder sb = new Utf16ValueStringBuilder(disposeImmediately: true);
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

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5) where TBufferWriter : IBufferWriter<char>
	{
		ReadOnlySpan<char> readOnlySpan = FormatString.AsSpan();
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			switch (utf16FormatSegment.FormatIndex)
			{
			case -1:
			{
				ReadOnlySpan<char> readOnlySpan2 = readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count);
				int count = utf16FormatSegment.Count;
				Span<char> span = sb.GetSpan(count);
				readOnlySpan2.TryCopyTo(span);
				int count2 = utf16FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf16FormatHelper.FormatTo(ref sb, arg1, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg1");
				break;
			case 1:
				Utf16FormatHelper.FormatTo(ref sb, arg2, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg2");
				break;
			case 2:
				Utf16FormatHelper.FormatTo(ref sb, arg3, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg3");
				break;
			case 3:
				Utf16FormatHelper.FormatTo(ref sb, arg4, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg4");
				break;
			case 4:
				Utf16FormatHelper.FormatTo(ref sb, arg5, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg5");
				break;
			}
		}
	}
}
public sealed class Utf16PreparedFormat<T1, T2, T3, T4, T5, T6>
{
	private readonly Utf16FormatSegment[] segments;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf16PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf16Parse(format);
		int num = 0;
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			if (!utf16FormatSegment.IsFormatArgument)
			{
				num += utf16FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
	{
		Utf16ValueStringBuilder sb = new Utf16ValueStringBuilder(disposeImmediately: true);
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

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6) where TBufferWriter : IBufferWriter<char>
	{
		ReadOnlySpan<char> readOnlySpan = FormatString.AsSpan();
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			switch (utf16FormatSegment.FormatIndex)
			{
			case -1:
			{
				ReadOnlySpan<char> readOnlySpan2 = readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count);
				int count = utf16FormatSegment.Count;
				Span<char> span = sb.GetSpan(count);
				readOnlySpan2.TryCopyTo(span);
				int count2 = utf16FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf16FormatHelper.FormatTo(ref sb, arg1, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg1");
				break;
			case 1:
				Utf16FormatHelper.FormatTo(ref sb, arg2, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg2");
				break;
			case 2:
				Utf16FormatHelper.FormatTo(ref sb, arg3, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg3");
				break;
			case 3:
				Utf16FormatHelper.FormatTo(ref sb, arg4, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg4");
				break;
			case 4:
				Utf16FormatHelper.FormatTo(ref sb, arg5, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg5");
				break;
			case 5:
				Utf16FormatHelper.FormatTo(ref sb, arg6, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg6");
				break;
			}
		}
	}
}
public sealed class Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7>
{
	private readonly Utf16FormatSegment[] segments;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf16PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf16Parse(format);
		int num = 0;
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			if (!utf16FormatSegment.IsFormatArgument)
			{
				num += utf16FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
	{
		Utf16ValueStringBuilder sb = new Utf16ValueStringBuilder(disposeImmediately: true);
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

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7) where TBufferWriter : IBufferWriter<char>
	{
		ReadOnlySpan<char> readOnlySpan = FormatString.AsSpan();
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			switch (utf16FormatSegment.FormatIndex)
			{
			case -1:
			{
				ReadOnlySpan<char> readOnlySpan2 = readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count);
				int count = utf16FormatSegment.Count;
				Span<char> span = sb.GetSpan(count);
				readOnlySpan2.TryCopyTo(span);
				int count2 = utf16FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf16FormatHelper.FormatTo(ref sb, arg1, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg1");
				break;
			case 1:
				Utf16FormatHelper.FormatTo(ref sb, arg2, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg2");
				break;
			case 2:
				Utf16FormatHelper.FormatTo(ref sb, arg3, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg3");
				break;
			case 3:
				Utf16FormatHelper.FormatTo(ref sb, arg4, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg4");
				break;
			case 4:
				Utf16FormatHelper.FormatTo(ref sb, arg5, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg5");
				break;
			case 5:
				Utf16FormatHelper.FormatTo(ref sb, arg6, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg6");
				break;
			case 6:
				Utf16FormatHelper.FormatTo(ref sb, arg7, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg7");
				break;
			}
		}
	}
}
public sealed class Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8>
{
	private readonly Utf16FormatSegment[] segments;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf16PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf16Parse(format);
		int num = 0;
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			if (!utf16FormatSegment.IsFormatArgument)
			{
				num += utf16FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8)
	{
		Utf16ValueStringBuilder sb = new Utf16ValueStringBuilder(disposeImmediately: true);
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

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8) where TBufferWriter : IBufferWriter<char>
	{
		ReadOnlySpan<char> readOnlySpan = FormatString.AsSpan();
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			switch (utf16FormatSegment.FormatIndex)
			{
			case -1:
			{
				ReadOnlySpan<char> readOnlySpan2 = readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count);
				int count = utf16FormatSegment.Count;
				Span<char> span = sb.GetSpan(count);
				readOnlySpan2.TryCopyTo(span);
				int count2 = utf16FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf16FormatHelper.FormatTo(ref sb, arg1, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg1");
				break;
			case 1:
				Utf16FormatHelper.FormatTo(ref sb, arg2, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg2");
				break;
			case 2:
				Utf16FormatHelper.FormatTo(ref sb, arg3, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg3");
				break;
			case 3:
				Utf16FormatHelper.FormatTo(ref sb, arg4, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg4");
				break;
			case 4:
				Utf16FormatHelper.FormatTo(ref sb, arg5, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg5");
				break;
			case 5:
				Utf16FormatHelper.FormatTo(ref sb, arg6, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg6");
				break;
			case 6:
				Utf16FormatHelper.FormatTo(ref sb, arg7, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg7");
				break;
			case 7:
				Utf16FormatHelper.FormatTo(ref sb, arg8, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg8");
				break;
			}
		}
	}
}
public sealed class Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9>
{
	private readonly Utf16FormatSegment[] segments;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf16PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf16Parse(format);
		int num = 0;
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			if (!utf16FormatSegment.IsFormatArgument)
			{
				num += utf16FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9)
	{
		Utf16ValueStringBuilder sb = new Utf16ValueStringBuilder(disposeImmediately: true);
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

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9) where TBufferWriter : IBufferWriter<char>
	{
		ReadOnlySpan<char> readOnlySpan = FormatString.AsSpan();
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			switch (utf16FormatSegment.FormatIndex)
			{
			case -1:
			{
				ReadOnlySpan<char> readOnlySpan2 = readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count);
				int count = utf16FormatSegment.Count;
				Span<char> span = sb.GetSpan(count);
				readOnlySpan2.TryCopyTo(span);
				int count2 = utf16FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf16FormatHelper.FormatTo(ref sb, arg1, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg1");
				break;
			case 1:
				Utf16FormatHelper.FormatTo(ref sb, arg2, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg2");
				break;
			case 2:
				Utf16FormatHelper.FormatTo(ref sb, arg3, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg3");
				break;
			case 3:
				Utf16FormatHelper.FormatTo(ref sb, arg4, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg4");
				break;
			case 4:
				Utf16FormatHelper.FormatTo(ref sb, arg5, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg5");
				break;
			case 5:
				Utf16FormatHelper.FormatTo(ref sb, arg6, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg6");
				break;
			case 6:
				Utf16FormatHelper.FormatTo(ref sb, arg7, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg7");
				break;
			case 7:
				Utf16FormatHelper.FormatTo(ref sb, arg8, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg8");
				break;
			case 8:
				Utf16FormatHelper.FormatTo(ref sb, arg9, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg9");
				break;
			}
		}
	}
}
public sealed class Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>
{
	private readonly Utf16FormatSegment[] segments;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf16PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf16Parse(format);
		int num = 0;
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			if (!utf16FormatSegment.IsFormatArgument)
			{
				num += utf16FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10)
	{
		Utf16ValueStringBuilder sb = new Utf16ValueStringBuilder(disposeImmediately: true);
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

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10) where TBufferWriter : IBufferWriter<char>
	{
		ReadOnlySpan<char> readOnlySpan = FormatString.AsSpan();
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			switch (utf16FormatSegment.FormatIndex)
			{
			case -1:
			{
				ReadOnlySpan<char> readOnlySpan2 = readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count);
				int count = utf16FormatSegment.Count;
				Span<char> span = sb.GetSpan(count);
				readOnlySpan2.TryCopyTo(span);
				int count2 = utf16FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf16FormatHelper.FormatTo(ref sb, arg1, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg1");
				break;
			case 1:
				Utf16FormatHelper.FormatTo(ref sb, arg2, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg2");
				break;
			case 2:
				Utf16FormatHelper.FormatTo(ref sb, arg3, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg3");
				break;
			case 3:
				Utf16FormatHelper.FormatTo(ref sb, arg4, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg4");
				break;
			case 4:
				Utf16FormatHelper.FormatTo(ref sb, arg5, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg5");
				break;
			case 5:
				Utf16FormatHelper.FormatTo(ref sb, arg6, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg6");
				break;
			case 6:
				Utf16FormatHelper.FormatTo(ref sb, arg7, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg7");
				break;
			case 7:
				Utf16FormatHelper.FormatTo(ref sb, arg8, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg8");
				break;
			case 8:
				Utf16FormatHelper.FormatTo(ref sb, arg9, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg9");
				break;
			case 9:
				Utf16FormatHelper.FormatTo(ref sb, arg10, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg10");
				break;
			}
		}
	}
}
public sealed class Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>
{
	private readonly Utf16FormatSegment[] segments;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf16PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf16Parse(format);
		int num = 0;
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			if (!utf16FormatSegment.IsFormatArgument)
			{
				num += utf16FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11)
	{
		Utf16ValueStringBuilder sb = new Utf16ValueStringBuilder(disposeImmediately: true);
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

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11) where TBufferWriter : IBufferWriter<char>
	{
		ReadOnlySpan<char> readOnlySpan = FormatString.AsSpan();
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			switch (utf16FormatSegment.FormatIndex)
			{
			case -1:
			{
				ReadOnlySpan<char> readOnlySpan2 = readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count);
				int count = utf16FormatSegment.Count;
				Span<char> span = sb.GetSpan(count);
				readOnlySpan2.TryCopyTo(span);
				int count2 = utf16FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf16FormatHelper.FormatTo(ref sb, arg1, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg1");
				break;
			case 1:
				Utf16FormatHelper.FormatTo(ref sb, arg2, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg2");
				break;
			case 2:
				Utf16FormatHelper.FormatTo(ref sb, arg3, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg3");
				break;
			case 3:
				Utf16FormatHelper.FormatTo(ref sb, arg4, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg4");
				break;
			case 4:
				Utf16FormatHelper.FormatTo(ref sb, arg5, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg5");
				break;
			case 5:
				Utf16FormatHelper.FormatTo(ref sb, arg6, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg6");
				break;
			case 6:
				Utf16FormatHelper.FormatTo(ref sb, arg7, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg7");
				break;
			case 7:
				Utf16FormatHelper.FormatTo(ref sb, arg8, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg8");
				break;
			case 8:
				Utf16FormatHelper.FormatTo(ref sb, arg9, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg9");
				break;
			case 9:
				Utf16FormatHelper.FormatTo(ref sb, arg10, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg10");
				break;
			case 10:
				Utf16FormatHelper.FormatTo(ref sb, arg11, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg11");
				break;
			}
		}
	}
}
public sealed class Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>
{
	private readonly Utf16FormatSegment[] segments;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf16PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf16Parse(format);
		int num = 0;
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			if (!utf16FormatSegment.IsFormatArgument)
			{
				num += utf16FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12)
	{
		Utf16ValueStringBuilder sb = new Utf16ValueStringBuilder(disposeImmediately: true);
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

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12) where TBufferWriter : IBufferWriter<char>
	{
		ReadOnlySpan<char> readOnlySpan = FormatString.AsSpan();
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			switch (utf16FormatSegment.FormatIndex)
			{
			case -1:
			{
				ReadOnlySpan<char> readOnlySpan2 = readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count);
				int count = utf16FormatSegment.Count;
				Span<char> span = sb.GetSpan(count);
				readOnlySpan2.TryCopyTo(span);
				int count2 = utf16FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf16FormatHelper.FormatTo(ref sb, arg1, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg1");
				break;
			case 1:
				Utf16FormatHelper.FormatTo(ref sb, arg2, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg2");
				break;
			case 2:
				Utf16FormatHelper.FormatTo(ref sb, arg3, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg3");
				break;
			case 3:
				Utf16FormatHelper.FormatTo(ref sb, arg4, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg4");
				break;
			case 4:
				Utf16FormatHelper.FormatTo(ref sb, arg5, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg5");
				break;
			case 5:
				Utf16FormatHelper.FormatTo(ref sb, arg6, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg6");
				break;
			case 6:
				Utf16FormatHelper.FormatTo(ref sb, arg7, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg7");
				break;
			case 7:
				Utf16FormatHelper.FormatTo(ref sb, arg8, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg8");
				break;
			case 8:
				Utf16FormatHelper.FormatTo(ref sb, arg9, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg9");
				break;
			case 9:
				Utf16FormatHelper.FormatTo(ref sb, arg10, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg10");
				break;
			case 10:
				Utf16FormatHelper.FormatTo(ref sb, arg11, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg11");
				break;
			case 11:
				Utf16FormatHelper.FormatTo(ref sb, arg12, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg12");
				break;
			}
		}
	}
}
public sealed class Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>
{
	private readonly Utf16FormatSegment[] segments;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf16PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf16Parse(format);
		int num = 0;
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			if (!utf16FormatSegment.IsFormatArgument)
			{
				num += utf16FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13)
	{
		Utf16ValueStringBuilder sb = new Utf16ValueStringBuilder(disposeImmediately: true);
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

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13) where TBufferWriter : IBufferWriter<char>
	{
		ReadOnlySpan<char> readOnlySpan = FormatString.AsSpan();
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			switch (utf16FormatSegment.FormatIndex)
			{
			case -1:
			{
				ReadOnlySpan<char> readOnlySpan2 = readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count);
				int count = utf16FormatSegment.Count;
				Span<char> span = sb.GetSpan(count);
				readOnlySpan2.TryCopyTo(span);
				int count2 = utf16FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf16FormatHelper.FormatTo(ref sb, arg1, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg1");
				break;
			case 1:
				Utf16FormatHelper.FormatTo(ref sb, arg2, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg2");
				break;
			case 2:
				Utf16FormatHelper.FormatTo(ref sb, arg3, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg3");
				break;
			case 3:
				Utf16FormatHelper.FormatTo(ref sb, arg4, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg4");
				break;
			case 4:
				Utf16FormatHelper.FormatTo(ref sb, arg5, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg5");
				break;
			case 5:
				Utf16FormatHelper.FormatTo(ref sb, arg6, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg6");
				break;
			case 6:
				Utf16FormatHelper.FormatTo(ref sb, arg7, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg7");
				break;
			case 7:
				Utf16FormatHelper.FormatTo(ref sb, arg8, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg8");
				break;
			case 8:
				Utf16FormatHelper.FormatTo(ref sb, arg9, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg9");
				break;
			case 9:
				Utf16FormatHelper.FormatTo(ref sb, arg10, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg10");
				break;
			case 10:
				Utf16FormatHelper.FormatTo(ref sb, arg11, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg11");
				break;
			case 11:
				Utf16FormatHelper.FormatTo(ref sb, arg12, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg12");
				break;
			case 12:
				Utf16FormatHelper.FormatTo(ref sb, arg13, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg13");
				break;
			}
		}
	}
}
public sealed class Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>
{
	private readonly Utf16FormatSegment[] segments;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf16PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf16Parse(format);
		int num = 0;
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			if (!utf16FormatSegment.IsFormatArgument)
			{
				num += utf16FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14)
	{
		Utf16ValueStringBuilder sb = new Utf16ValueStringBuilder(disposeImmediately: true);
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

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14) where TBufferWriter : IBufferWriter<char>
	{
		ReadOnlySpan<char> readOnlySpan = FormatString.AsSpan();
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			switch (utf16FormatSegment.FormatIndex)
			{
			case -1:
			{
				ReadOnlySpan<char> readOnlySpan2 = readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count);
				int count = utf16FormatSegment.Count;
				Span<char> span = sb.GetSpan(count);
				readOnlySpan2.TryCopyTo(span);
				int count2 = utf16FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf16FormatHelper.FormatTo(ref sb, arg1, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg1");
				break;
			case 1:
				Utf16FormatHelper.FormatTo(ref sb, arg2, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg2");
				break;
			case 2:
				Utf16FormatHelper.FormatTo(ref sb, arg3, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg3");
				break;
			case 3:
				Utf16FormatHelper.FormatTo(ref sb, arg4, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg4");
				break;
			case 4:
				Utf16FormatHelper.FormatTo(ref sb, arg5, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg5");
				break;
			case 5:
				Utf16FormatHelper.FormatTo(ref sb, arg6, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg6");
				break;
			case 6:
				Utf16FormatHelper.FormatTo(ref sb, arg7, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg7");
				break;
			case 7:
				Utf16FormatHelper.FormatTo(ref sb, arg8, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg8");
				break;
			case 8:
				Utf16FormatHelper.FormatTo(ref sb, arg9, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg9");
				break;
			case 9:
				Utf16FormatHelper.FormatTo(ref sb, arg10, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg10");
				break;
			case 10:
				Utf16FormatHelper.FormatTo(ref sb, arg11, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg11");
				break;
			case 11:
				Utf16FormatHelper.FormatTo(ref sb, arg12, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg12");
				break;
			case 12:
				Utf16FormatHelper.FormatTo(ref sb, arg13, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg13");
				break;
			case 13:
				Utf16FormatHelper.FormatTo(ref sb, arg14, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg14");
				break;
			}
		}
	}
}
public sealed class Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>
{
	private readonly Utf16FormatSegment[] segments;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf16PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf16Parse(format);
		int num = 0;
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			if (!utf16FormatSegment.IsFormatArgument)
			{
				num += utf16FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15)
	{
		Utf16ValueStringBuilder sb = new Utf16ValueStringBuilder(disposeImmediately: true);
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

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15) where TBufferWriter : IBufferWriter<char>
	{
		ReadOnlySpan<char> readOnlySpan = FormatString.AsSpan();
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			switch (utf16FormatSegment.FormatIndex)
			{
			case -1:
			{
				ReadOnlySpan<char> readOnlySpan2 = readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count);
				int count = utf16FormatSegment.Count;
				Span<char> span = sb.GetSpan(count);
				readOnlySpan2.TryCopyTo(span);
				int count2 = utf16FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf16FormatHelper.FormatTo(ref sb, arg1, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg1");
				break;
			case 1:
				Utf16FormatHelper.FormatTo(ref sb, arg2, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg2");
				break;
			case 2:
				Utf16FormatHelper.FormatTo(ref sb, arg3, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg3");
				break;
			case 3:
				Utf16FormatHelper.FormatTo(ref sb, arg4, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg4");
				break;
			case 4:
				Utf16FormatHelper.FormatTo(ref sb, arg5, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg5");
				break;
			case 5:
				Utf16FormatHelper.FormatTo(ref sb, arg6, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg6");
				break;
			case 6:
				Utf16FormatHelper.FormatTo(ref sb, arg7, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg7");
				break;
			case 7:
				Utf16FormatHelper.FormatTo(ref sb, arg8, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg8");
				break;
			case 8:
				Utf16FormatHelper.FormatTo(ref sb, arg9, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg9");
				break;
			case 9:
				Utf16FormatHelper.FormatTo(ref sb, arg10, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg10");
				break;
			case 10:
				Utf16FormatHelper.FormatTo(ref sb, arg11, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg11");
				break;
			case 11:
				Utf16FormatHelper.FormatTo(ref sb, arg12, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg12");
				break;
			case 12:
				Utf16FormatHelper.FormatTo(ref sb, arg13, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg13");
				break;
			case 13:
				Utf16FormatHelper.FormatTo(ref sb, arg14, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg14");
				break;
			case 14:
				Utf16FormatHelper.FormatTo(ref sb, arg15, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg15");
				break;
			}
		}
	}
}
public sealed class Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16>
{
	private readonly Utf16FormatSegment[] segments;

	public string FormatString { get; }

	public int MinSize { get; }

	public Utf16PreparedFormat(string format)
	{
		FormatString = format;
		segments = PreparedFormatHelper.Utf16Parse(format);
		int num = 0;
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			if (!utf16FormatSegment.IsFormatArgument)
			{
				num += utf16FormatSegment.Count;
			}
		}
		MinSize = num;
	}

	public string Format(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15, T16 arg16)
	{
		Utf16ValueStringBuilder sb = new Utf16ValueStringBuilder(disposeImmediately: true);
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

	public void FormatTo<TBufferWriter>(ref TBufferWriter sb, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15, T16 arg16) where TBufferWriter : IBufferWriter<char>
	{
		ReadOnlySpan<char> readOnlySpan = FormatString.AsSpan();
		Utf16FormatSegment[] array = segments;
		for (int i = 0; i < array.Length; i++)
		{
			Utf16FormatSegment utf16FormatSegment = array[i];
			switch (utf16FormatSegment.FormatIndex)
			{
			case -1:
			{
				ReadOnlySpan<char> readOnlySpan2 = readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count);
				int count = utf16FormatSegment.Count;
				Span<char> span = sb.GetSpan(count);
				readOnlySpan2.TryCopyTo(span);
				int count2 = utf16FormatSegment.Count;
				sb.Advance(count2);
				break;
			}
			case 0:
				Utf16FormatHelper.FormatTo(ref sb, arg1, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg1");
				break;
			case 1:
				Utf16FormatHelper.FormatTo(ref sb, arg2, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg2");
				break;
			case 2:
				Utf16FormatHelper.FormatTo(ref sb, arg3, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg3");
				break;
			case 3:
				Utf16FormatHelper.FormatTo(ref sb, arg4, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg4");
				break;
			case 4:
				Utf16FormatHelper.FormatTo(ref sb, arg5, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg5");
				break;
			case 5:
				Utf16FormatHelper.FormatTo(ref sb, arg6, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg6");
				break;
			case 6:
				Utf16FormatHelper.FormatTo(ref sb, arg7, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg7");
				break;
			case 7:
				Utf16FormatHelper.FormatTo(ref sb, arg8, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg8");
				break;
			case 8:
				Utf16FormatHelper.FormatTo(ref sb, arg9, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg9");
				break;
			case 9:
				Utf16FormatHelper.FormatTo(ref sb, arg10, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg10");
				break;
			case 10:
				Utf16FormatHelper.FormatTo(ref sb, arg11, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg11");
				break;
			case 11:
				Utf16FormatHelper.FormatTo(ref sb, arg12, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg12");
				break;
			case 12:
				Utf16FormatHelper.FormatTo(ref sb, arg13, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg13");
				break;
			case 13:
				Utf16FormatHelper.FormatTo(ref sb, arg14, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg14");
				break;
			case 14:
				Utf16FormatHelper.FormatTo(ref sb, arg15, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg15");
				break;
			case 15:
				Utf16FormatHelper.FormatTo(ref sb, arg16, utf16FormatSegment.Alignment, readOnlySpan.Slice(utf16FormatSegment.Offset, utf16FormatSegment.Count), "arg16");
				break;
			}
		}
	}
}
