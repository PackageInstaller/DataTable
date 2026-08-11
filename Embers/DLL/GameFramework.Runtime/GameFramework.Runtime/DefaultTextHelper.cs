using System;
using System.Text;

namespace GameFramework.Runtime;

public class DefaultTextHelper : Utility.Text.ITextHelper
{
	private const int StringBuilderCapacity = 1024;

	[ThreadStatic]
	private static StringBuilder s_CachedStringBuilder;

	public string Format(string format, params object[] arg)
	{
		if (format == null)
		{
			throw new GameFrameworkException("Format is invalid.");
		}
		CheckCachedStringBuilder();
		s_CachedStringBuilder.Length = 0;
		s_CachedStringBuilder.AppendFormat(format, arg);
		return s_CachedStringBuilder.ToString();
	}

	public string Format<T>(string format, T arg)
	{
		if (format == null)
		{
			throw new GameFrameworkException("Format is invalid.");
		}
		CheckCachedStringBuilder();
		s_CachedStringBuilder.Length = 0;
		s_CachedStringBuilder.AppendFormat(format, arg);
		return s_CachedStringBuilder.ToString();
	}

	public string Format<T1, T2>(string format, T1 arg1, T2 arg2)
	{
		if (format == null)
		{
			throw new GameFrameworkException("Format is invalid.");
		}
		CheckCachedStringBuilder();
		s_CachedStringBuilder.Length = 0;
		s_CachedStringBuilder.AppendFormat(format, arg1, arg2);
		return s_CachedStringBuilder.ToString();
	}

	public string Format<T1, T2, T3>(string format, T1 arg1, T2 arg2, T3 arg3)
	{
		if (format == null)
		{
			throw new GameFrameworkException("Format is invalid.");
		}
		CheckCachedStringBuilder();
		s_CachedStringBuilder.Length = 0;
		s_CachedStringBuilder.AppendFormat(format, arg1, arg2, arg3);
		return s_CachedStringBuilder.ToString();
	}

	public string Format<T1, T2, T3, T4>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		if (format == null)
		{
			throw new GameFrameworkException("Format is invalid.");
		}
		CheckCachedStringBuilder();
		s_CachedStringBuilder.Length = 0;
		s_CachedStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4);
		return s_CachedStringBuilder.ToString();
	}

	public string Format<T1, T2, T3, T4, T5>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		if (format == null)
		{
			throw new GameFrameworkException("Format is invalid.");
		}
		CheckCachedStringBuilder();
		s_CachedStringBuilder.Length = 0;
		s_CachedStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5);
		return s_CachedStringBuilder.ToString();
	}

	public string Format<T1, T2, T3, T4, T5, T6>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
	{
		if (format == null)
		{
			throw new GameFrameworkException("Format is invalid.");
		}
		CheckCachedStringBuilder();
		s_CachedStringBuilder.Length = 0;
		s_CachedStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6);
		return s_CachedStringBuilder.ToString();
	}

	public string Format<T1, T2, T3, T4, T5, T6, T7>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
	{
		if (format == null)
		{
			throw new GameFrameworkException("Format is invalid.");
		}
		CheckCachedStringBuilder();
		s_CachedStringBuilder.Length = 0;
		s_CachedStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
		return s_CachedStringBuilder.ToString();
	}

	public string Format<T1, T2, T3, T4, T5, T6, T7, T8>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8)
	{
		if (format == null)
		{
			throw new GameFrameworkException("Format is invalid.");
		}
		CheckCachedStringBuilder();
		s_CachedStringBuilder.Length = 0;
		s_CachedStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
		return s_CachedStringBuilder.ToString();
	}

	public string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9)
	{
		if (format == null)
		{
			throw new GameFrameworkException("Format is invalid.");
		}
		CheckCachedStringBuilder();
		s_CachedStringBuilder.Length = 0;
		s_CachedStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
		return s_CachedStringBuilder.ToString();
	}

	public string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10)
	{
		if (format == null)
		{
			throw new GameFrameworkException("Format is invalid.");
		}
		CheckCachedStringBuilder();
		s_CachedStringBuilder.Length = 0;
		s_CachedStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
		return s_CachedStringBuilder.ToString();
	}

	public string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11)
	{
		if (format == null)
		{
			throw new GameFrameworkException("Format is invalid.");
		}
		CheckCachedStringBuilder();
		s_CachedStringBuilder.Length = 0;
		s_CachedStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
		return s_CachedStringBuilder.ToString();
	}

	public string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12)
	{
		if (format == null)
		{
			throw new GameFrameworkException("Format is invalid.");
		}
		CheckCachedStringBuilder();
		s_CachedStringBuilder.Length = 0;
		s_CachedStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
		return s_CachedStringBuilder.ToString();
	}

	public string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13)
	{
		if (format == null)
		{
			throw new GameFrameworkException("Format is invalid.");
		}
		CheckCachedStringBuilder();
		s_CachedStringBuilder.Length = 0;
		s_CachedStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
		return s_CachedStringBuilder.ToString();
	}

	public string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14)
	{
		if (format == null)
		{
			throw new GameFrameworkException("Format is invalid.");
		}
		CheckCachedStringBuilder();
		s_CachedStringBuilder.Length = 0;
		s_CachedStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
		return s_CachedStringBuilder.ToString();
	}

	public string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15)
	{
		if (format == null)
		{
			throw new GameFrameworkException("Format is invalid.");
		}
		CheckCachedStringBuilder();
		s_CachedStringBuilder.Length = 0;
		s_CachedStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
		return s_CachedStringBuilder.ToString();
	}

	public string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15, T16 arg16)
	{
		if (format == null)
		{
			throw new GameFrameworkException("Format is invalid.");
		}
		CheckCachedStringBuilder();
		s_CachedStringBuilder.Length = 0;
		s_CachedStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
		return s_CachedStringBuilder.ToString();
	}

	private static void CheckCachedStringBuilder()
	{
		if (s_CachedStringBuilder == null)
		{
			s_CachedStringBuilder = new StringBuilder(1024);
		}
	}
}
