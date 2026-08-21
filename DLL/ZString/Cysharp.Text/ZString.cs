using System;
using System.Buffers;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;

namespace Cysharp.Text;

public static class ZString
{
	private static Encoding UTF8NoBom = new UTF8Encoding(encoderShouldEmitUTF8Identifier: false);

	public static string Concat<T1>(T1 arg1)
	{
		if (typeof(T1) == typeof(string))
		{
			if (arg1 == null)
			{
				return string.Empty;
			}
			return Unsafe.As<string>(arg1);
		}
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			if (typeof(T1) == typeof(string))
			{
				if (arg1 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T1, string>(ref arg1));
				}
			}
			else if (typeof(T1) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T1, int>(ref arg1));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg1);
			}
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	public static string Concat<T1, T2>(T1 arg1, T2 arg2)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			if (typeof(T1) == typeof(string))
			{
				if (arg1 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T1, string>(ref arg1));
				}
			}
			else if (typeof(T1) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T1, int>(ref arg1));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg1);
			}
			if (typeof(T2) == typeof(string))
			{
				if (arg2 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T2, string>(ref arg2));
				}
			}
			else if (typeof(T2) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T2, int>(ref arg2));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg2);
			}
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	public static string Concat<T1, T2, T3>(T1 arg1, T2 arg2, T3 arg3)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			if (typeof(T1) == typeof(string))
			{
				if (arg1 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T1, string>(ref arg1));
				}
			}
			else if (typeof(T1) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T1, int>(ref arg1));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg1);
			}
			if (typeof(T2) == typeof(string))
			{
				if (arg2 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T2, string>(ref arg2));
				}
			}
			else if (typeof(T2) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T2, int>(ref arg2));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg2);
			}
			if (typeof(T3) == typeof(string))
			{
				if (arg3 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T3, string>(ref arg3));
				}
			}
			else if (typeof(T3) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T3, int>(ref arg3));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg3);
			}
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	public static string Concat<T1, T2, T3, T4>(T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			if (typeof(T1) == typeof(string))
			{
				if (arg1 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T1, string>(ref arg1));
				}
			}
			else if (typeof(T1) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T1, int>(ref arg1));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg1);
			}
			if (typeof(T2) == typeof(string))
			{
				if (arg2 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T2, string>(ref arg2));
				}
			}
			else if (typeof(T2) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T2, int>(ref arg2));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg2);
			}
			if (typeof(T3) == typeof(string))
			{
				if (arg3 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T3, string>(ref arg3));
				}
			}
			else if (typeof(T3) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T3, int>(ref arg3));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg3);
			}
			if (typeof(T4) == typeof(string))
			{
				if (arg4 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T4, string>(ref arg4));
				}
			}
			else if (typeof(T4) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T4, int>(ref arg4));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg4);
			}
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	public static string Concat<T1, T2, T3, T4, T5>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			if (typeof(T1) == typeof(string))
			{
				if (arg1 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T1, string>(ref arg1));
				}
			}
			else if (typeof(T1) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T1, int>(ref arg1));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg1);
			}
			if (typeof(T2) == typeof(string))
			{
				if (arg2 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T2, string>(ref arg2));
				}
			}
			else if (typeof(T2) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T2, int>(ref arg2));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg2);
			}
			if (typeof(T3) == typeof(string))
			{
				if (arg3 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T3, string>(ref arg3));
				}
			}
			else if (typeof(T3) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T3, int>(ref arg3));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg3);
			}
			if (typeof(T4) == typeof(string))
			{
				if (arg4 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T4, string>(ref arg4));
				}
			}
			else if (typeof(T4) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T4, int>(ref arg4));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg4);
			}
			if (typeof(T5) == typeof(string))
			{
				if (arg5 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T5, string>(ref arg5));
				}
			}
			else if (typeof(T5) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T5, int>(ref arg5));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg5);
			}
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	public static string Concat<T1, T2, T3, T4, T5, T6>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			if (typeof(T1) == typeof(string))
			{
				if (arg1 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T1, string>(ref arg1));
				}
			}
			else if (typeof(T1) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T1, int>(ref arg1));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg1);
			}
			if (typeof(T2) == typeof(string))
			{
				if (arg2 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T2, string>(ref arg2));
				}
			}
			else if (typeof(T2) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T2, int>(ref arg2));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg2);
			}
			if (typeof(T3) == typeof(string))
			{
				if (arg3 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T3, string>(ref arg3));
				}
			}
			else if (typeof(T3) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T3, int>(ref arg3));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg3);
			}
			if (typeof(T4) == typeof(string))
			{
				if (arg4 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T4, string>(ref arg4));
				}
			}
			else if (typeof(T4) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T4, int>(ref arg4));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg4);
			}
			if (typeof(T5) == typeof(string))
			{
				if (arg5 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T5, string>(ref arg5));
				}
			}
			else if (typeof(T5) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T5, int>(ref arg5));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg5);
			}
			if (typeof(T6) == typeof(string))
			{
				if (arg6 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T6, string>(ref arg6));
				}
			}
			else if (typeof(T6) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T6, int>(ref arg6));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg6);
			}
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	public static string Concat<T1, T2, T3, T4, T5, T6, T7>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			if (typeof(T1) == typeof(string))
			{
				if (arg1 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T1, string>(ref arg1));
				}
			}
			else if (typeof(T1) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T1, int>(ref arg1));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg1);
			}
			if (typeof(T2) == typeof(string))
			{
				if (arg2 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T2, string>(ref arg2));
				}
			}
			else if (typeof(T2) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T2, int>(ref arg2));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg2);
			}
			if (typeof(T3) == typeof(string))
			{
				if (arg3 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T3, string>(ref arg3));
				}
			}
			else if (typeof(T3) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T3, int>(ref arg3));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg3);
			}
			if (typeof(T4) == typeof(string))
			{
				if (arg4 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T4, string>(ref arg4));
				}
			}
			else if (typeof(T4) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T4, int>(ref arg4));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg4);
			}
			if (typeof(T5) == typeof(string))
			{
				if (arg5 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T5, string>(ref arg5));
				}
			}
			else if (typeof(T5) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T5, int>(ref arg5));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg5);
			}
			if (typeof(T6) == typeof(string))
			{
				if (arg6 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T6, string>(ref arg6));
				}
			}
			else if (typeof(T6) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T6, int>(ref arg6));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg6);
			}
			if (typeof(T7) == typeof(string))
			{
				if (arg7 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T7, string>(ref arg7));
				}
			}
			else if (typeof(T7) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T7, int>(ref arg7));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg7);
			}
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	public static string Concat<T1, T2, T3, T4, T5, T6, T7, T8>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			if (typeof(T1) == typeof(string))
			{
				if (arg1 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T1, string>(ref arg1));
				}
			}
			else if (typeof(T1) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T1, int>(ref arg1));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg1);
			}
			if (typeof(T2) == typeof(string))
			{
				if (arg2 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T2, string>(ref arg2));
				}
			}
			else if (typeof(T2) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T2, int>(ref arg2));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg2);
			}
			if (typeof(T3) == typeof(string))
			{
				if (arg3 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T3, string>(ref arg3));
				}
			}
			else if (typeof(T3) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T3, int>(ref arg3));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg3);
			}
			if (typeof(T4) == typeof(string))
			{
				if (arg4 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T4, string>(ref arg4));
				}
			}
			else if (typeof(T4) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T4, int>(ref arg4));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg4);
			}
			if (typeof(T5) == typeof(string))
			{
				if (arg5 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T5, string>(ref arg5));
				}
			}
			else if (typeof(T5) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T5, int>(ref arg5));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg5);
			}
			if (typeof(T6) == typeof(string))
			{
				if (arg6 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T6, string>(ref arg6));
				}
			}
			else if (typeof(T6) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T6, int>(ref arg6));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg6);
			}
			if (typeof(T7) == typeof(string))
			{
				if (arg7 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T7, string>(ref arg7));
				}
			}
			else if (typeof(T7) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T7, int>(ref arg7));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg7);
			}
			if (typeof(T8) == typeof(string))
			{
				if (arg8 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T8, string>(ref arg8));
				}
			}
			else if (typeof(T8) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T8, int>(ref arg8));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg8);
			}
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	public static string Concat<T1, T2, T3, T4, T5, T6, T7, T8, T9>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			if (typeof(T1) == typeof(string))
			{
				if (arg1 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T1, string>(ref arg1));
				}
			}
			else if (typeof(T1) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T1, int>(ref arg1));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg1);
			}
			if (typeof(T2) == typeof(string))
			{
				if (arg2 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T2, string>(ref arg2));
				}
			}
			else if (typeof(T2) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T2, int>(ref arg2));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg2);
			}
			if (typeof(T3) == typeof(string))
			{
				if (arg3 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T3, string>(ref arg3));
				}
			}
			else if (typeof(T3) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T3, int>(ref arg3));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg3);
			}
			if (typeof(T4) == typeof(string))
			{
				if (arg4 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T4, string>(ref arg4));
				}
			}
			else if (typeof(T4) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T4, int>(ref arg4));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg4);
			}
			if (typeof(T5) == typeof(string))
			{
				if (arg5 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T5, string>(ref arg5));
				}
			}
			else if (typeof(T5) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T5, int>(ref arg5));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg5);
			}
			if (typeof(T6) == typeof(string))
			{
				if (arg6 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T6, string>(ref arg6));
				}
			}
			else if (typeof(T6) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T6, int>(ref arg6));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg6);
			}
			if (typeof(T7) == typeof(string))
			{
				if (arg7 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T7, string>(ref arg7));
				}
			}
			else if (typeof(T7) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T7, int>(ref arg7));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg7);
			}
			if (typeof(T8) == typeof(string))
			{
				if (arg8 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T8, string>(ref arg8));
				}
			}
			else if (typeof(T8) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T8, int>(ref arg8));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg8);
			}
			if (typeof(T9) == typeof(string))
			{
				if (arg9 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T9, string>(ref arg9));
				}
			}
			else if (typeof(T9) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T9, int>(ref arg9));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg9);
			}
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	public static string Concat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			if (typeof(T1) == typeof(string))
			{
				if (arg1 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T1, string>(ref arg1));
				}
			}
			else if (typeof(T1) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T1, int>(ref arg1));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg1);
			}
			if (typeof(T2) == typeof(string))
			{
				if (arg2 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T2, string>(ref arg2));
				}
			}
			else if (typeof(T2) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T2, int>(ref arg2));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg2);
			}
			if (typeof(T3) == typeof(string))
			{
				if (arg3 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T3, string>(ref arg3));
				}
			}
			else if (typeof(T3) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T3, int>(ref arg3));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg3);
			}
			if (typeof(T4) == typeof(string))
			{
				if (arg4 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T4, string>(ref arg4));
				}
			}
			else if (typeof(T4) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T4, int>(ref arg4));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg4);
			}
			if (typeof(T5) == typeof(string))
			{
				if (arg5 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T5, string>(ref arg5));
				}
			}
			else if (typeof(T5) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T5, int>(ref arg5));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg5);
			}
			if (typeof(T6) == typeof(string))
			{
				if (arg6 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T6, string>(ref arg6));
				}
			}
			else if (typeof(T6) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T6, int>(ref arg6));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg6);
			}
			if (typeof(T7) == typeof(string))
			{
				if (arg7 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T7, string>(ref arg7));
				}
			}
			else if (typeof(T7) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T7, int>(ref arg7));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg7);
			}
			if (typeof(T8) == typeof(string))
			{
				if (arg8 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T8, string>(ref arg8));
				}
			}
			else if (typeof(T8) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T8, int>(ref arg8));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg8);
			}
			if (typeof(T9) == typeof(string))
			{
				if (arg9 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T9, string>(ref arg9));
				}
			}
			else if (typeof(T9) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T9, int>(ref arg9));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg9);
			}
			if (typeof(T10) == typeof(string))
			{
				if (arg10 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T10, string>(ref arg10));
				}
			}
			else if (typeof(T10) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T10, int>(ref arg10));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg10);
			}
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	public static string Concat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			if (typeof(T1) == typeof(string))
			{
				if (arg1 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T1, string>(ref arg1));
				}
			}
			else if (typeof(T1) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T1, int>(ref arg1));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg1);
			}
			if (typeof(T2) == typeof(string))
			{
				if (arg2 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T2, string>(ref arg2));
				}
			}
			else if (typeof(T2) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T2, int>(ref arg2));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg2);
			}
			if (typeof(T3) == typeof(string))
			{
				if (arg3 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T3, string>(ref arg3));
				}
			}
			else if (typeof(T3) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T3, int>(ref arg3));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg3);
			}
			if (typeof(T4) == typeof(string))
			{
				if (arg4 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T4, string>(ref arg4));
				}
			}
			else if (typeof(T4) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T4, int>(ref arg4));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg4);
			}
			if (typeof(T5) == typeof(string))
			{
				if (arg5 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T5, string>(ref arg5));
				}
			}
			else if (typeof(T5) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T5, int>(ref arg5));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg5);
			}
			if (typeof(T6) == typeof(string))
			{
				if (arg6 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T6, string>(ref arg6));
				}
			}
			else if (typeof(T6) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T6, int>(ref arg6));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg6);
			}
			if (typeof(T7) == typeof(string))
			{
				if (arg7 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T7, string>(ref arg7));
				}
			}
			else if (typeof(T7) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T7, int>(ref arg7));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg7);
			}
			if (typeof(T8) == typeof(string))
			{
				if (arg8 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T8, string>(ref arg8));
				}
			}
			else if (typeof(T8) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T8, int>(ref arg8));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg8);
			}
			if (typeof(T9) == typeof(string))
			{
				if (arg9 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T9, string>(ref arg9));
				}
			}
			else if (typeof(T9) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T9, int>(ref arg9));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg9);
			}
			if (typeof(T10) == typeof(string))
			{
				if (arg10 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T10, string>(ref arg10));
				}
			}
			else if (typeof(T10) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T10, int>(ref arg10));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg10);
			}
			if (typeof(T11) == typeof(string))
			{
				if (arg11 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T11, string>(ref arg11));
				}
			}
			else if (typeof(T11) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T11, int>(ref arg11));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg11);
			}
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	public static string Concat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			if (typeof(T1) == typeof(string))
			{
				if (arg1 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T1, string>(ref arg1));
				}
			}
			else if (typeof(T1) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T1, int>(ref arg1));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg1);
			}
			if (typeof(T2) == typeof(string))
			{
				if (arg2 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T2, string>(ref arg2));
				}
			}
			else if (typeof(T2) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T2, int>(ref arg2));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg2);
			}
			if (typeof(T3) == typeof(string))
			{
				if (arg3 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T3, string>(ref arg3));
				}
			}
			else if (typeof(T3) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T3, int>(ref arg3));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg3);
			}
			if (typeof(T4) == typeof(string))
			{
				if (arg4 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T4, string>(ref arg4));
				}
			}
			else if (typeof(T4) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T4, int>(ref arg4));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg4);
			}
			if (typeof(T5) == typeof(string))
			{
				if (arg5 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T5, string>(ref arg5));
				}
			}
			else if (typeof(T5) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T5, int>(ref arg5));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg5);
			}
			if (typeof(T6) == typeof(string))
			{
				if (arg6 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T6, string>(ref arg6));
				}
			}
			else if (typeof(T6) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T6, int>(ref arg6));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg6);
			}
			if (typeof(T7) == typeof(string))
			{
				if (arg7 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T7, string>(ref arg7));
				}
			}
			else if (typeof(T7) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T7, int>(ref arg7));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg7);
			}
			if (typeof(T8) == typeof(string))
			{
				if (arg8 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T8, string>(ref arg8));
				}
			}
			else if (typeof(T8) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T8, int>(ref arg8));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg8);
			}
			if (typeof(T9) == typeof(string))
			{
				if (arg9 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T9, string>(ref arg9));
				}
			}
			else if (typeof(T9) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T9, int>(ref arg9));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg9);
			}
			if (typeof(T10) == typeof(string))
			{
				if (arg10 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T10, string>(ref arg10));
				}
			}
			else if (typeof(T10) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T10, int>(ref arg10));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg10);
			}
			if (typeof(T11) == typeof(string))
			{
				if (arg11 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T11, string>(ref arg11));
				}
			}
			else if (typeof(T11) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T11, int>(ref arg11));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg11);
			}
			if (typeof(T12) == typeof(string))
			{
				if (arg12 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T12, string>(ref arg12));
				}
			}
			else if (typeof(T12) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T12, int>(ref arg12));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg12);
			}
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	public static string Concat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			if (typeof(T1) == typeof(string))
			{
				if (arg1 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T1, string>(ref arg1));
				}
			}
			else if (typeof(T1) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T1, int>(ref arg1));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg1);
			}
			if (typeof(T2) == typeof(string))
			{
				if (arg2 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T2, string>(ref arg2));
				}
			}
			else if (typeof(T2) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T2, int>(ref arg2));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg2);
			}
			if (typeof(T3) == typeof(string))
			{
				if (arg3 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T3, string>(ref arg3));
				}
			}
			else if (typeof(T3) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T3, int>(ref arg3));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg3);
			}
			if (typeof(T4) == typeof(string))
			{
				if (arg4 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T4, string>(ref arg4));
				}
			}
			else if (typeof(T4) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T4, int>(ref arg4));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg4);
			}
			if (typeof(T5) == typeof(string))
			{
				if (arg5 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T5, string>(ref arg5));
				}
			}
			else if (typeof(T5) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T5, int>(ref arg5));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg5);
			}
			if (typeof(T6) == typeof(string))
			{
				if (arg6 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T6, string>(ref arg6));
				}
			}
			else if (typeof(T6) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T6, int>(ref arg6));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg6);
			}
			if (typeof(T7) == typeof(string))
			{
				if (arg7 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T7, string>(ref arg7));
				}
			}
			else if (typeof(T7) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T7, int>(ref arg7));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg7);
			}
			if (typeof(T8) == typeof(string))
			{
				if (arg8 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T8, string>(ref arg8));
				}
			}
			else if (typeof(T8) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T8, int>(ref arg8));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg8);
			}
			if (typeof(T9) == typeof(string))
			{
				if (arg9 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T9, string>(ref arg9));
				}
			}
			else if (typeof(T9) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T9, int>(ref arg9));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg9);
			}
			if (typeof(T10) == typeof(string))
			{
				if (arg10 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T10, string>(ref arg10));
				}
			}
			else if (typeof(T10) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T10, int>(ref arg10));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg10);
			}
			if (typeof(T11) == typeof(string))
			{
				if (arg11 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T11, string>(ref arg11));
				}
			}
			else if (typeof(T11) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T11, int>(ref arg11));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg11);
			}
			if (typeof(T12) == typeof(string))
			{
				if (arg12 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T12, string>(ref arg12));
				}
			}
			else if (typeof(T12) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T12, int>(ref arg12));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg12);
			}
			if (typeof(T13) == typeof(string))
			{
				if (arg13 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T13, string>(ref arg13));
				}
			}
			else if (typeof(T13) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T13, int>(ref arg13));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg13);
			}
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	public static string Concat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			if (typeof(T1) == typeof(string))
			{
				if (arg1 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T1, string>(ref arg1));
				}
			}
			else if (typeof(T1) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T1, int>(ref arg1));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg1);
			}
			if (typeof(T2) == typeof(string))
			{
				if (arg2 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T2, string>(ref arg2));
				}
			}
			else if (typeof(T2) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T2, int>(ref arg2));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg2);
			}
			if (typeof(T3) == typeof(string))
			{
				if (arg3 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T3, string>(ref arg3));
				}
			}
			else if (typeof(T3) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T3, int>(ref arg3));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg3);
			}
			if (typeof(T4) == typeof(string))
			{
				if (arg4 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T4, string>(ref arg4));
				}
			}
			else if (typeof(T4) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T4, int>(ref arg4));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg4);
			}
			if (typeof(T5) == typeof(string))
			{
				if (arg5 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T5, string>(ref arg5));
				}
			}
			else if (typeof(T5) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T5, int>(ref arg5));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg5);
			}
			if (typeof(T6) == typeof(string))
			{
				if (arg6 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T6, string>(ref arg6));
				}
			}
			else if (typeof(T6) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T6, int>(ref arg6));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg6);
			}
			if (typeof(T7) == typeof(string))
			{
				if (arg7 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T7, string>(ref arg7));
				}
			}
			else if (typeof(T7) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T7, int>(ref arg7));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg7);
			}
			if (typeof(T8) == typeof(string))
			{
				if (arg8 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T8, string>(ref arg8));
				}
			}
			else if (typeof(T8) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T8, int>(ref arg8));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg8);
			}
			if (typeof(T9) == typeof(string))
			{
				if (arg9 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T9, string>(ref arg9));
				}
			}
			else if (typeof(T9) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T9, int>(ref arg9));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg9);
			}
			if (typeof(T10) == typeof(string))
			{
				if (arg10 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T10, string>(ref arg10));
				}
			}
			else if (typeof(T10) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T10, int>(ref arg10));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg10);
			}
			if (typeof(T11) == typeof(string))
			{
				if (arg11 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T11, string>(ref arg11));
				}
			}
			else if (typeof(T11) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T11, int>(ref arg11));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg11);
			}
			if (typeof(T12) == typeof(string))
			{
				if (arg12 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T12, string>(ref arg12));
				}
			}
			else if (typeof(T12) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T12, int>(ref arg12));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg12);
			}
			if (typeof(T13) == typeof(string))
			{
				if (arg13 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T13, string>(ref arg13));
				}
			}
			else if (typeof(T13) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T13, int>(ref arg13));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg13);
			}
			if (typeof(T14) == typeof(string))
			{
				if (arg14 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T14, string>(ref arg14));
				}
			}
			else if (typeof(T14) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T14, int>(ref arg14));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg14);
			}
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	public static string Concat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			if (typeof(T1) == typeof(string))
			{
				if (arg1 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T1, string>(ref arg1));
				}
			}
			else if (typeof(T1) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T1, int>(ref arg1));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg1);
			}
			if (typeof(T2) == typeof(string))
			{
				if (arg2 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T2, string>(ref arg2));
				}
			}
			else if (typeof(T2) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T2, int>(ref arg2));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg2);
			}
			if (typeof(T3) == typeof(string))
			{
				if (arg3 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T3, string>(ref arg3));
				}
			}
			else if (typeof(T3) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T3, int>(ref arg3));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg3);
			}
			if (typeof(T4) == typeof(string))
			{
				if (arg4 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T4, string>(ref arg4));
				}
			}
			else if (typeof(T4) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T4, int>(ref arg4));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg4);
			}
			if (typeof(T5) == typeof(string))
			{
				if (arg5 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T5, string>(ref arg5));
				}
			}
			else if (typeof(T5) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T5, int>(ref arg5));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg5);
			}
			if (typeof(T6) == typeof(string))
			{
				if (arg6 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T6, string>(ref arg6));
				}
			}
			else if (typeof(T6) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T6, int>(ref arg6));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg6);
			}
			if (typeof(T7) == typeof(string))
			{
				if (arg7 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T7, string>(ref arg7));
				}
			}
			else if (typeof(T7) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T7, int>(ref arg7));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg7);
			}
			if (typeof(T8) == typeof(string))
			{
				if (arg8 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T8, string>(ref arg8));
				}
			}
			else if (typeof(T8) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T8, int>(ref arg8));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg8);
			}
			if (typeof(T9) == typeof(string))
			{
				if (arg9 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T9, string>(ref arg9));
				}
			}
			else if (typeof(T9) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T9, int>(ref arg9));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg9);
			}
			if (typeof(T10) == typeof(string))
			{
				if (arg10 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T10, string>(ref arg10));
				}
			}
			else if (typeof(T10) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T10, int>(ref arg10));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg10);
			}
			if (typeof(T11) == typeof(string))
			{
				if (arg11 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T11, string>(ref arg11));
				}
			}
			else if (typeof(T11) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T11, int>(ref arg11));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg11);
			}
			if (typeof(T12) == typeof(string))
			{
				if (arg12 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T12, string>(ref arg12));
				}
			}
			else if (typeof(T12) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T12, int>(ref arg12));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg12);
			}
			if (typeof(T13) == typeof(string))
			{
				if (arg13 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T13, string>(ref arg13));
				}
			}
			else if (typeof(T13) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T13, int>(ref arg13));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg13);
			}
			if (typeof(T14) == typeof(string))
			{
				if (arg14 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T14, string>(ref arg14));
				}
			}
			else if (typeof(T14) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T14, int>(ref arg14));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg14);
			}
			if (typeof(T15) == typeof(string))
			{
				if (arg15 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T15, string>(ref arg15));
				}
			}
			else if (typeof(T15) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T15, int>(ref arg15));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg15);
			}
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	public static string Concat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15, T16 arg16)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			if (typeof(T1) == typeof(string))
			{
				if (arg1 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T1, string>(ref arg1));
				}
			}
			else if (typeof(T1) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T1, int>(ref arg1));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg1);
			}
			if (typeof(T2) == typeof(string))
			{
				if (arg2 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T2, string>(ref arg2));
				}
			}
			else if (typeof(T2) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T2, int>(ref arg2));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg2);
			}
			if (typeof(T3) == typeof(string))
			{
				if (arg3 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T3, string>(ref arg3));
				}
			}
			else if (typeof(T3) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T3, int>(ref arg3));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg3);
			}
			if (typeof(T4) == typeof(string))
			{
				if (arg4 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T4, string>(ref arg4));
				}
			}
			else if (typeof(T4) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T4, int>(ref arg4));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg4);
			}
			if (typeof(T5) == typeof(string))
			{
				if (arg5 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T5, string>(ref arg5));
				}
			}
			else if (typeof(T5) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T5, int>(ref arg5));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg5);
			}
			if (typeof(T6) == typeof(string))
			{
				if (arg6 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T6, string>(ref arg6));
				}
			}
			else if (typeof(T6) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T6, int>(ref arg6));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg6);
			}
			if (typeof(T7) == typeof(string))
			{
				if (arg7 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T7, string>(ref arg7));
				}
			}
			else if (typeof(T7) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T7, int>(ref arg7));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg7);
			}
			if (typeof(T8) == typeof(string))
			{
				if (arg8 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T8, string>(ref arg8));
				}
			}
			else if (typeof(T8) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T8, int>(ref arg8));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg8);
			}
			if (typeof(T9) == typeof(string))
			{
				if (arg9 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T9, string>(ref arg9));
				}
			}
			else if (typeof(T9) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T9, int>(ref arg9));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg9);
			}
			if (typeof(T10) == typeof(string))
			{
				if (arg10 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T10, string>(ref arg10));
				}
			}
			else if (typeof(T10) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T10, int>(ref arg10));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg10);
			}
			if (typeof(T11) == typeof(string))
			{
				if (arg11 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T11, string>(ref arg11));
				}
			}
			else if (typeof(T11) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T11, int>(ref arg11));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg11);
			}
			if (typeof(T12) == typeof(string))
			{
				if (arg12 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T12, string>(ref arg12));
				}
			}
			else if (typeof(T12) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T12, int>(ref arg12));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg12);
			}
			if (typeof(T13) == typeof(string))
			{
				if (arg13 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T13, string>(ref arg13));
				}
			}
			else if (typeof(T13) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T13, int>(ref arg13));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg13);
			}
			if (typeof(T14) == typeof(string))
			{
				if (arg14 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T14, string>(ref arg14));
				}
			}
			else if (typeof(T14) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T14, int>(ref arg14));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg14);
			}
			if (typeof(T15) == typeof(string))
			{
				if (arg15 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T15, string>(ref arg15));
				}
			}
			else if (typeof(T15) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T15, int>(ref arg15));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg15);
			}
			if (typeof(T16) == typeof(string))
			{
				if (arg16 != null)
				{
					utf16ValueStringBuilder.Append(Unsafe.As<T16, string>(ref arg16));
				}
			}
			else if (typeof(T16) == typeof(int))
			{
				utf16ValueStringBuilder.Append(Unsafe.As<T16, int>(ref arg16));
			}
			else
			{
				utf16ValueStringBuilder.Append(arg16);
			}
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	internal static void AppendChars<TBufferWriter>(ref TBufferWriter sb, ReadOnlySpan<char> chars) where TBufferWriter : IBufferWriter<byte>
	{
		int maxByteCount = UTF8NoBom.GetMaxByteCount(chars.Length);
		Span<byte> span = sb.GetSpan(maxByteCount);
		int bytes = UTF8NoBom.GetBytes(chars, span);
		sb.Advance(bytes);
	}

	public static Utf16ValueStringBuilder CreateStringBuilder()
	{
		return new Utf16ValueStringBuilder(disposeImmediately: false);
	}

	public static Utf8ValueStringBuilder CreateUtf8StringBuilder()
	{
		return new Utf8ValueStringBuilder(disposeImmediately: false);
	}

	public static Utf16ValueStringBuilder CreateStringBuilder(bool notNested)
	{
		return new Utf16ValueStringBuilder(notNested);
	}

	public static Utf8ValueStringBuilder CreateUtf8StringBuilder(bool notNested)
	{
		return new Utf8ValueStringBuilder(notNested);
	}

	public static string Join<T>(char separator, params T[] values)
	{
		return JoinInternal(stackalloc char[1] { separator }, values.AsSpan());
	}

	public static string Join<T>(char separator, List<T> values)
	{
		return JoinInternal((ReadOnlySpan<char>)stackalloc char[1] { separator }, (IReadOnlyList<T>)values);
	}

	public static string Join<T>(char separator, ReadOnlySpan<T> values)
	{
		return JoinInternal(stackalloc char[1] { separator }, values);
	}

	public static string Join<T>(char separator, IEnumerable<T> values)
	{
		return JoinInternal(stackalloc char[1] { separator }, values);
	}

	public static string Join<T>(char separator, ICollection<T> values)
	{
		return JoinInternal(stackalloc char[1] { separator }, values.AsEnumerable());
	}

	public static string Join<T>(char separator, IList<T> values)
	{
		return JoinInternal(stackalloc char[1] { separator }, values);
	}

	public static string Join<T>(char separator, IReadOnlyList<T> values)
	{
		return JoinInternal(stackalloc char[1] { separator }, values);
	}

	public static string Join<T>(char separator, IReadOnlyCollection<T> values)
	{
		return JoinInternal(stackalloc char[1] { separator }, values.AsEnumerable());
	}

	public static string Join<T>(string separator, params T[] values)
	{
		return JoinInternal(separator.AsSpan(), values.AsSpan());
	}

	public static string Join<T>(string separator, List<T> values)
	{
		return JoinInternal(separator.AsSpan(), (IReadOnlyList<T>)values);
	}

	public static string Join<T>(string separator, ReadOnlySpan<T> values)
	{
		return JoinInternal(separator.AsSpan(), values);
	}

	public static string Join<T>(string separator, ICollection<T> values)
	{
		return JoinInternal(separator.AsSpan(), values.AsEnumerable());
	}

	public static string Join<T>(string separator, IList<T> values)
	{
		return JoinInternal(separator.AsSpan(), values);
	}

	public static string Join<T>(string separator, IReadOnlyList<T> values)
	{
		return JoinInternal(separator.AsSpan(), values);
	}

	public static string Join<T>(string separator, IReadOnlyCollection<T> values)
	{
		return JoinInternal(separator.AsSpan(), values.AsEnumerable());
	}

	public static string Join<T>(string separator, IEnumerable<T> values)
	{
		return JoinInternal(separator.AsSpan(), values);
	}

	public static string Concat<T>(params T[] values)
	{
		return JoinInternal(default(ReadOnlySpan<char>), values.AsSpan());
	}

	public static string Concat<T>(List<T> values)
	{
		return JoinInternal(default(ReadOnlySpan<char>), (IReadOnlyList<T>)values);
	}

	public static string Concat<T>(ReadOnlySpan<T> values)
	{
		return JoinInternal(default(ReadOnlySpan<char>), values);
	}

	public static string Concat<T>(ICollection<T> values)
	{
		return JoinInternal(default(ReadOnlySpan<char>), values.AsEnumerable());
	}

	public static string Concat<T>(IList<T> values)
	{
		return JoinInternal(default(ReadOnlySpan<char>), values);
	}

	public static string Concat<T>(IReadOnlyList<T> values)
	{
		return JoinInternal(default(ReadOnlySpan<char>), values);
	}

	public static string Concat<T>(IReadOnlyCollection<T> values)
	{
		return JoinInternal(default(ReadOnlySpan<char>), values.AsEnumerable());
	}

	public static string Concat<T>(IEnumerable<T> values)
	{
		return JoinInternal(default(ReadOnlySpan<char>), values);
	}

	private static string JoinInternal<T>(ReadOnlySpan<char> separator, IList<T> values)
	{
		IReadOnlyList<T> readOnlyList = values as IReadOnlyList<T>;
		readOnlyList = (IReadOnlyList<T>)(readOnlyList ?? ((object)new ReadOnlyListAdaptor<T>(values)));
		return JoinInternal(separator, readOnlyList);
	}

	private static string JoinInternal<T>(ReadOnlySpan<char> separator, IReadOnlyList<T> values)
	{
		if (values.Count == 0)
		{
			return string.Empty;
		}
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendJoinInternal(separator, values);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	private static string JoinInternal<T>(ReadOnlySpan<char> separator, ReadOnlySpan<T> values)
	{
		if (values.Length == 0)
		{
			return string.Empty;
		}
		if (typeof(T) == typeof(string) && values.Length == 1)
		{
			return Unsafe.As<string>(values[0]);
		}
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendJoinInternal(separator, values);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	private static string JoinInternal<T>(ReadOnlySpan<char> separator, IEnumerable<T> values)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendJoinInternal(separator, values);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1>(string format, T1 arg1)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1>(ReadOnlySpan<char> format, T1 arg1)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2>(string format, T1 arg1, T2 arg2)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2>(ReadOnlySpan<char> format, T1 arg1, T2 arg2)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3>(string format, T1 arg1, T2 arg2, T3 arg3)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6, T7>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6, T7>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6, T7, T8>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6, T7, T8>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15, T16 arg16)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16>(ReadOnlySpan<char> format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15, T16 arg16)
	{
		Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		try
		{
			utf16ValueStringBuilder.AppendFormat(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
			return utf16ValueStringBuilder.ToString();
		}
		finally
		{
			utf16ValueStringBuilder.Dispose();
		}
	}

	public static Utf16PreparedFormat<T1> PrepareUtf16<T1>(string format)
	{
		return new Utf16PreparedFormat<T1>(format);
	}

	public static Utf8PreparedFormat<T1> PrepareUtf8<T1>(string format)
	{
		return new Utf8PreparedFormat<T1>(format);
	}

	public static Utf16PreparedFormat<T1, T2> PrepareUtf16<T1, T2>(string format)
	{
		return new Utf16PreparedFormat<T1, T2>(format);
	}

	public static Utf8PreparedFormat<T1, T2> PrepareUtf8<T1, T2>(string format)
	{
		return new Utf8PreparedFormat<T1, T2>(format);
	}

	public static Utf16PreparedFormat<T1, T2, T3> PrepareUtf16<T1, T2, T3>(string format)
	{
		return new Utf16PreparedFormat<T1, T2, T3>(format);
	}

	public static Utf8PreparedFormat<T1, T2, T3> PrepareUtf8<T1, T2, T3>(string format)
	{
		return new Utf8PreparedFormat<T1, T2, T3>(format);
	}

	public static Utf16PreparedFormat<T1, T2, T3, T4> PrepareUtf16<T1, T2, T3, T4>(string format)
	{
		return new Utf16PreparedFormat<T1, T2, T3, T4>(format);
	}

	public static Utf8PreparedFormat<T1, T2, T3, T4> PrepareUtf8<T1, T2, T3, T4>(string format)
	{
		return new Utf8PreparedFormat<T1, T2, T3, T4>(format);
	}

	public static Utf16PreparedFormat<T1, T2, T3, T4, T5> PrepareUtf16<T1, T2, T3, T4, T5>(string format)
	{
		return new Utf16PreparedFormat<T1, T2, T3, T4, T5>(format);
	}

	public static Utf8PreparedFormat<T1, T2, T3, T4, T5> PrepareUtf8<T1, T2, T3, T4, T5>(string format)
	{
		return new Utf8PreparedFormat<T1, T2, T3, T4, T5>(format);
	}

	public static Utf16PreparedFormat<T1, T2, T3, T4, T5, T6> PrepareUtf16<T1, T2, T3, T4, T5, T6>(string format)
	{
		return new Utf16PreparedFormat<T1, T2, T3, T4, T5, T6>(format);
	}

	public static Utf8PreparedFormat<T1, T2, T3, T4, T5, T6> PrepareUtf8<T1, T2, T3, T4, T5, T6>(string format)
	{
		return new Utf8PreparedFormat<T1, T2, T3, T4, T5, T6>(format);
	}

	public static Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7> PrepareUtf16<T1, T2, T3, T4, T5, T6, T7>(string format)
	{
		return new Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7>(format);
	}

	public static Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7> PrepareUtf8<T1, T2, T3, T4, T5, T6, T7>(string format)
	{
		return new Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7>(format);
	}

	public static Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8> PrepareUtf16<T1, T2, T3, T4, T5, T6, T7, T8>(string format)
	{
		return new Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8>(format);
	}

	public static Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8> PrepareUtf8<T1, T2, T3, T4, T5, T6, T7, T8>(string format)
	{
		return new Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8>(format);
	}

	public static Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9> PrepareUtf16<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string format)
	{
		return new Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9>(format);
	}

	public static Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9> PrepareUtf8<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string format)
	{
		return new Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9>(format);
	}

	public static Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> PrepareUtf16<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string format)
	{
		return new Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(format);
	}

	public static Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> PrepareUtf8<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string format)
	{
		return new Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(format);
	}

	public static Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> PrepareUtf16<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(string format)
	{
		return new Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(format);
	}

	public static Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11> PrepareUtf8<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(string format)
	{
		return new Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(format);
	}

	public static Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> PrepareUtf16<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(string format)
	{
		return new Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(format);
	}

	public static Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12> PrepareUtf8<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(string format)
	{
		return new Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(format);
	}

	public static Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> PrepareUtf16<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(string format)
	{
		return new Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(format);
	}

	public static Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13> PrepareUtf8<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(string format)
	{
		return new Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(format);
	}

	public static Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> PrepareUtf16<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(string format)
	{
		return new Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(format);
	}

	public static Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14> PrepareUtf8<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(string format)
	{
		return new Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(format);
	}

	public static Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> PrepareUtf16<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(string format)
	{
		return new Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(format);
	}

	public static Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15> PrepareUtf8<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(string format)
	{
		return new Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(format);
	}

	public static Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16> PrepareUtf16<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16>(string format)
	{
		return new Utf16PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16>(format);
	}

	public static Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16> PrepareUtf8<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16>(string format)
	{
		return new Utf8PreparedFormat<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16>(format);
	}

	public static void Utf8Format<T1>(IBufferWriter<byte> bufferWriter, string format, T1 arg1)
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
					int num3 = i - num;
					Span<byte> span2 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num3));
					int bytes2 = UTF8NoBom.GetBytes(format.AsSpan(num, num3), span2);
					bufferWriter.Advance(bytes2);
					i++;
					num = i;
					break;
				}
				int num4 = i - num;
				Span<byte> span3 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num4));
				int bytes3 = UTF8NoBom.GetBytes(format.AsSpan(num, num4), span3);
				bufferWriter.Advance(bytes3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				StandardFormat format2 = StandardFormat.Parse(parseResult.FormatString);
				if (parseResult.Index == 0)
				{
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg1, parseResult.Alignment, format2, "arg1");
					break;
				}
				ExceptionUtil.ThrowFormatException();
				ExceptionUtil.ThrowFormatException();
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int num2 = i - num;
					Span<byte> span = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num2));
					int bytes = UTF8NoBom.GetBytes(format.AsSpan(num, num2), span);
					bufferWriter.Advance(bytes);
					i++;
					num = i;
				}
				else
				{
					ExceptionUtil.ThrowFormatException();
				}
				break;
			}
		}
		int num5 = format.Length - num;
		if (num5 > 0)
		{
			Span<byte> span4 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num5));
			int bytes4 = UTF8NoBom.GetBytes(format.AsSpan(num, num5), span4);
			bufferWriter.Advance(bytes4);
		}
	}

	public static void Utf8Format<T1, T2>(IBufferWriter<byte> bufferWriter, string format, T1 arg1, T2 arg2)
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
					int num3 = i - num;
					Span<byte> span2 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num3));
					int bytes2 = UTF8NoBom.GetBytes(format.AsSpan(num, num3), span2);
					bufferWriter.Advance(bytes2);
					i++;
					num = i;
					break;
				}
				int num4 = i - num;
				Span<byte> span3 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num4));
				int bytes3 = UTF8NoBom.GetBytes(format.AsSpan(num, num4), span3);
				bufferWriter.Advance(bytes3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				StandardFormat format2 = StandardFormat.Parse(parseResult.FormatString);
				switch (parseResult.Index)
				{
				case 0:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg1, parseResult.Alignment, format2, "arg1");
					break;
				case 1:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg2, parseResult.Alignment, format2, "arg2");
					break;
				default:
					ExceptionUtil.ThrowFormatException();
					ExceptionUtil.ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int num2 = i - num;
					Span<byte> span = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num2));
					int bytes = UTF8NoBom.GetBytes(format.AsSpan(num, num2), span);
					bufferWriter.Advance(bytes);
					i++;
					num = i;
				}
				else
				{
					ExceptionUtil.ThrowFormatException();
				}
				break;
			}
		}
		int num5 = format.Length - num;
		if (num5 > 0)
		{
			Span<byte> span4 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num5));
			int bytes4 = UTF8NoBom.GetBytes(format.AsSpan(num, num5), span4);
			bufferWriter.Advance(bytes4);
		}
	}

	public static void Utf8Format<T1, T2, T3>(IBufferWriter<byte> bufferWriter, string format, T1 arg1, T2 arg2, T3 arg3)
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
					int num3 = i - num;
					Span<byte> span2 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num3));
					int bytes2 = UTF8NoBom.GetBytes(format.AsSpan(num, num3), span2);
					bufferWriter.Advance(bytes2);
					i++;
					num = i;
					break;
				}
				int num4 = i - num;
				Span<byte> span3 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num4));
				int bytes3 = UTF8NoBom.GetBytes(format.AsSpan(num, num4), span3);
				bufferWriter.Advance(bytes3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				StandardFormat format2 = StandardFormat.Parse(parseResult.FormatString);
				switch (parseResult.Index)
				{
				case 0:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg1, parseResult.Alignment, format2, "arg1");
					break;
				case 1:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg2, parseResult.Alignment, format2, "arg2");
					break;
				case 2:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg3, parseResult.Alignment, format2, "arg3");
					break;
				default:
					ExceptionUtil.ThrowFormatException();
					ExceptionUtil.ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int num2 = i - num;
					Span<byte> span = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num2));
					int bytes = UTF8NoBom.GetBytes(format.AsSpan(num, num2), span);
					bufferWriter.Advance(bytes);
					i++;
					num = i;
				}
				else
				{
					ExceptionUtil.ThrowFormatException();
				}
				break;
			}
		}
		int num5 = format.Length - num;
		if (num5 > 0)
		{
			Span<byte> span4 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num5));
			int bytes4 = UTF8NoBom.GetBytes(format.AsSpan(num, num5), span4);
			bufferWriter.Advance(bytes4);
		}
	}

	public static void Utf8Format<T1, T2, T3, T4>(IBufferWriter<byte> bufferWriter, string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
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
					int num3 = i - num;
					Span<byte> span2 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num3));
					int bytes2 = UTF8NoBom.GetBytes(format.AsSpan(num, num3), span2);
					bufferWriter.Advance(bytes2);
					i++;
					num = i;
					break;
				}
				int num4 = i - num;
				Span<byte> span3 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num4));
				int bytes3 = UTF8NoBom.GetBytes(format.AsSpan(num, num4), span3);
				bufferWriter.Advance(bytes3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				StandardFormat format2 = StandardFormat.Parse(parseResult.FormatString);
				switch (parseResult.Index)
				{
				case 0:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg1, parseResult.Alignment, format2, "arg1");
					break;
				case 1:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg2, parseResult.Alignment, format2, "arg2");
					break;
				case 2:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg3, parseResult.Alignment, format2, "arg3");
					break;
				case 3:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg4, parseResult.Alignment, format2, "arg4");
					break;
				default:
					ExceptionUtil.ThrowFormatException();
					ExceptionUtil.ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int num2 = i - num;
					Span<byte> span = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num2));
					int bytes = UTF8NoBom.GetBytes(format.AsSpan(num, num2), span);
					bufferWriter.Advance(bytes);
					i++;
					num = i;
				}
				else
				{
					ExceptionUtil.ThrowFormatException();
				}
				break;
			}
		}
		int num5 = format.Length - num;
		if (num5 > 0)
		{
			Span<byte> span4 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num5));
			int bytes4 = UTF8NoBom.GetBytes(format.AsSpan(num, num5), span4);
			bufferWriter.Advance(bytes4);
		}
	}

	public static void Utf8Format<T1, T2, T3, T4, T5>(IBufferWriter<byte> bufferWriter, string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
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
					int num3 = i - num;
					Span<byte> span2 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num3));
					int bytes2 = UTF8NoBom.GetBytes(format.AsSpan(num, num3), span2);
					bufferWriter.Advance(bytes2);
					i++;
					num = i;
					break;
				}
				int num4 = i - num;
				Span<byte> span3 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num4));
				int bytes3 = UTF8NoBom.GetBytes(format.AsSpan(num, num4), span3);
				bufferWriter.Advance(bytes3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				StandardFormat format2 = StandardFormat.Parse(parseResult.FormatString);
				switch (parseResult.Index)
				{
				case 0:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg1, parseResult.Alignment, format2, "arg1");
					break;
				case 1:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg2, parseResult.Alignment, format2, "arg2");
					break;
				case 2:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg3, parseResult.Alignment, format2, "arg3");
					break;
				case 3:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg4, parseResult.Alignment, format2, "arg4");
					break;
				case 4:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg5, parseResult.Alignment, format2, "arg5");
					break;
				default:
					ExceptionUtil.ThrowFormatException();
					ExceptionUtil.ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int num2 = i - num;
					Span<byte> span = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num2));
					int bytes = UTF8NoBom.GetBytes(format.AsSpan(num, num2), span);
					bufferWriter.Advance(bytes);
					i++;
					num = i;
				}
				else
				{
					ExceptionUtil.ThrowFormatException();
				}
				break;
			}
		}
		int num5 = format.Length - num;
		if (num5 > 0)
		{
			Span<byte> span4 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num5));
			int bytes4 = UTF8NoBom.GetBytes(format.AsSpan(num, num5), span4);
			bufferWriter.Advance(bytes4);
		}
	}

	public static void Utf8Format<T1, T2, T3, T4, T5, T6>(IBufferWriter<byte> bufferWriter, string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
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
					int num3 = i - num;
					Span<byte> span2 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num3));
					int bytes2 = UTF8NoBom.GetBytes(format.AsSpan(num, num3), span2);
					bufferWriter.Advance(bytes2);
					i++;
					num = i;
					break;
				}
				int num4 = i - num;
				Span<byte> span3 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num4));
				int bytes3 = UTF8NoBom.GetBytes(format.AsSpan(num, num4), span3);
				bufferWriter.Advance(bytes3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				StandardFormat format2 = StandardFormat.Parse(parseResult.FormatString);
				switch (parseResult.Index)
				{
				case 0:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg1, parseResult.Alignment, format2, "arg1");
					break;
				case 1:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg2, parseResult.Alignment, format2, "arg2");
					break;
				case 2:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg3, parseResult.Alignment, format2, "arg3");
					break;
				case 3:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg4, parseResult.Alignment, format2, "arg4");
					break;
				case 4:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg5, parseResult.Alignment, format2, "arg5");
					break;
				case 5:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg6, parseResult.Alignment, format2, "arg6");
					break;
				default:
					ExceptionUtil.ThrowFormatException();
					ExceptionUtil.ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int num2 = i - num;
					Span<byte> span = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num2));
					int bytes = UTF8NoBom.GetBytes(format.AsSpan(num, num2), span);
					bufferWriter.Advance(bytes);
					i++;
					num = i;
				}
				else
				{
					ExceptionUtil.ThrowFormatException();
				}
				break;
			}
		}
		int num5 = format.Length - num;
		if (num5 > 0)
		{
			Span<byte> span4 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num5));
			int bytes4 = UTF8NoBom.GetBytes(format.AsSpan(num, num5), span4);
			bufferWriter.Advance(bytes4);
		}
	}

	public static void Utf8Format<T1, T2, T3, T4, T5, T6, T7>(IBufferWriter<byte> bufferWriter, string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
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
					int num3 = i - num;
					Span<byte> span2 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num3));
					int bytes2 = UTF8NoBom.GetBytes(format.AsSpan(num, num3), span2);
					bufferWriter.Advance(bytes2);
					i++;
					num = i;
					break;
				}
				int num4 = i - num;
				Span<byte> span3 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num4));
				int bytes3 = UTF8NoBom.GetBytes(format.AsSpan(num, num4), span3);
				bufferWriter.Advance(bytes3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				StandardFormat format2 = StandardFormat.Parse(parseResult.FormatString);
				switch (parseResult.Index)
				{
				case 0:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg1, parseResult.Alignment, format2, "arg1");
					break;
				case 1:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg2, parseResult.Alignment, format2, "arg2");
					break;
				case 2:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg3, parseResult.Alignment, format2, "arg3");
					break;
				case 3:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg4, parseResult.Alignment, format2, "arg4");
					break;
				case 4:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg5, parseResult.Alignment, format2, "arg5");
					break;
				case 5:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg6, parseResult.Alignment, format2, "arg6");
					break;
				case 6:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg7, parseResult.Alignment, format2, "arg7");
					break;
				default:
					ExceptionUtil.ThrowFormatException();
					ExceptionUtil.ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int num2 = i - num;
					Span<byte> span = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num2));
					int bytes = UTF8NoBom.GetBytes(format.AsSpan(num, num2), span);
					bufferWriter.Advance(bytes);
					i++;
					num = i;
				}
				else
				{
					ExceptionUtil.ThrowFormatException();
				}
				break;
			}
		}
		int num5 = format.Length - num;
		if (num5 > 0)
		{
			Span<byte> span4 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num5));
			int bytes4 = UTF8NoBom.GetBytes(format.AsSpan(num, num5), span4);
			bufferWriter.Advance(bytes4);
		}
	}

	public static void Utf8Format<T1, T2, T3, T4, T5, T6, T7, T8>(IBufferWriter<byte> bufferWriter, string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8)
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
					int num3 = i - num;
					Span<byte> span2 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num3));
					int bytes2 = UTF8NoBom.GetBytes(format.AsSpan(num, num3), span2);
					bufferWriter.Advance(bytes2);
					i++;
					num = i;
					break;
				}
				int num4 = i - num;
				Span<byte> span3 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num4));
				int bytes3 = UTF8NoBom.GetBytes(format.AsSpan(num, num4), span3);
				bufferWriter.Advance(bytes3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				StandardFormat format2 = StandardFormat.Parse(parseResult.FormatString);
				switch (parseResult.Index)
				{
				case 0:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg1, parseResult.Alignment, format2, "arg1");
					break;
				case 1:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg2, parseResult.Alignment, format2, "arg2");
					break;
				case 2:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg3, parseResult.Alignment, format2, "arg3");
					break;
				case 3:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg4, parseResult.Alignment, format2, "arg4");
					break;
				case 4:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg5, parseResult.Alignment, format2, "arg5");
					break;
				case 5:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg6, parseResult.Alignment, format2, "arg6");
					break;
				case 6:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg7, parseResult.Alignment, format2, "arg7");
					break;
				case 7:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg8, parseResult.Alignment, format2, "arg8");
					break;
				default:
					ExceptionUtil.ThrowFormatException();
					ExceptionUtil.ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int num2 = i - num;
					Span<byte> span = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num2));
					int bytes = UTF8NoBom.GetBytes(format.AsSpan(num, num2), span);
					bufferWriter.Advance(bytes);
					i++;
					num = i;
				}
				else
				{
					ExceptionUtil.ThrowFormatException();
				}
				break;
			}
		}
		int num5 = format.Length - num;
		if (num5 > 0)
		{
			Span<byte> span4 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num5));
			int bytes4 = UTF8NoBom.GetBytes(format.AsSpan(num, num5), span4);
			bufferWriter.Advance(bytes4);
		}
	}

	public static void Utf8Format<T1, T2, T3, T4, T5, T6, T7, T8, T9>(IBufferWriter<byte> bufferWriter, string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9)
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
					int num3 = i - num;
					Span<byte> span2 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num3));
					int bytes2 = UTF8NoBom.GetBytes(format.AsSpan(num, num3), span2);
					bufferWriter.Advance(bytes2);
					i++;
					num = i;
					break;
				}
				int num4 = i - num;
				Span<byte> span3 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num4));
				int bytes3 = UTF8NoBom.GetBytes(format.AsSpan(num, num4), span3);
				bufferWriter.Advance(bytes3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				StandardFormat format2 = StandardFormat.Parse(parseResult.FormatString);
				switch (parseResult.Index)
				{
				case 0:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg1, parseResult.Alignment, format2, "arg1");
					break;
				case 1:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg2, parseResult.Alignment, format2, "arg2");
					break;
				case 2:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg3, parseResult.Alignment, format2, "arg3");
					break;
				case 3:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg4, parseResult.Alignment, format2, "arg4");
					break;
				case 4:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg5, parseResult.Alignment, format2, "arg5");
					break;
				case 5:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg6, parseResult.Alignment, format2, "arg6");
					break;
				case 6:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg7, parseResult.Alignment, format2, "arg7");
					break;
				case 7:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg8, parseResult.Alignment, format2, "arg8");
					break;
				case 8:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg9, parseResult.Alignment, format2, "arg9");
					break;
				default:
					ExceptionUtil.ThrowFormatException();
					ExceptionUtil.ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int num2 = i - num;
					Span<byte> span = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num2));
					int bytes = UTF8NoBom.GetBytes(format.AsSpan(num, num2), span);
					bufferWriter.Advance(bytes);
					i++;
					num = i;
				}
				else
				{
					ExceptionUtil.ThrowFormatException();
				}
				break;
			}
		}
		int num5 = format.Length - num;
		if (num5 > 0)
		{
			Span<byte> span4 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num5));
			int bytes4 = UTF8NoBom.GetBytes(format.AsSpan(num, num5), span4);
			bufferWriter.Advance(bytes4);
		}
	}

	public static void Utf8Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(IBufferWriter<byte> bufferWriter, string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10)
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
					int num3 = i - num;
					Span<byte> span2 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num3));
					int bytes2 = UTF8NoBom.GetBytes(format.AsSpan(num, num3), span2);
					bufferWriter.Advance(bytes2);
					i++;
					num = i;
					break;
				}
				int num4 = i - num;
				Span<byte> span3 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num4));
				int bytes3 = UTF8NoBom.GetBytes(format.AsSpan(num, num4), span3);
				bufferWriter.Advance(bytes3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				StandardFormat format2 = StandardFormat.Parse(parseResult.FormatString);
				switch (parseResult.Index)
				{
				case 0:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg1, parseResult.Alignment, format2, "arg1");
					break;
				case 1:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg2, parseResult.Alignment, format2, "arg2");
					break;
				case 2:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg3, parseResult.Alignment, format2, "arg3");
					break;
				case 3:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg4, parseResult.Alignment, format2, "arg4");
					break;
				case 4:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg5, parseResult.Alignment, format2, "arg5");
					break;
				case 5:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg6, parseResult.Alignment, format2, "arg6");
					break;
				case 6:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg7, parseResult.Alignment, format2, "arg7");
					break;
				case 7:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg8, parseResult.Alignment, format2, "arg8");
					break;
				case 8:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg9, parseResult.Alignment, format2, "arg9");
					break;
				case 9:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg10, parseResult.Alignment, format2, "arg10");
					break;
				default:
					ExceptionUtil.ThrowFormatException();
					ExceptionUtil.ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int num2 = i - num;
					Span<byte> span = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num2));
					int bytes = UTF8NoBom.GetBytes(format.AsSpan(num, num2), span);
					bufferWriter.Advance(bytes);
					i++;
					num = i;
				}
				else
				{
					ExceptionUtil.ThrowFormatException();
				}
				break;
			}
		}
		int num5 = format.Length - num;
		if (num5 > 0)
		{
			Span<byte> span4 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num5));
			int bytes4 = UTF8NoBom.GetBytes(format.AsSpan(num, num5), span4);
			bufferWriter.Advance(bytes4);
		}
	}

	public static void Utf8Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(IBufferWriter<byte> bufferWriter, string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11)
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
					int num3 = i - num;
					Span<byte> span2 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num3));
					int bytes2 = UTF8NoBom.GetBytes(format.AsSpan(num, num3), span2);
					bufferWriter.Advance(bytes2);
					i++;
					num = i;
					break;
				}
				int num4 = i - num;
				Span<byte> span3 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num4));
				int bytes3 = UTF8NoBom.GetBytes(format.AsSpan(num, num4), span3);
				bufferWriter.Advance(bytes3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				StandardFormat format2 = StandardFormat.Parse(parseResult.FormatString);
				switch (parseResult.Index)
				{
				case 0:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg1, parseResult.Alignment, format2, "arg1");
					break;
				case 1:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg2, parseResult.Alignment, format2, "arg2");
					break;
				case 2:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg3, parseResult.Alignment, format2, "arg3");
					break;
				case 3:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg4, parseResult.Alignment, format2, "arg4");
					break;
				case 4:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg5, parseResult.Alignment, format2, "arg5");
					break;
				case 5:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg6, parseResult.Alignment, format2, "arg6");
					break;
				case 6:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg7, parseResult.Alignment, format2, "arg7");
					break;
				case 7:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg8, parseResult.Alignment, format2, "arg8");
					break;
				case 8:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg9, parseResult.Alignment, format2, "arg9");
					break;
				case 9:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg10, parseResult.Alignment, format2, "arg10");
					break;
				case 10:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg11, parseResult.Alignment, format2, "arg11");
					break;
				default:
					ExceptionUtil.ThrowFormatException();
					ExceptionUtil.ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int num2 = i - num;
					Span<byte> span = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num2));
					int bytes = UTF8NoBom.GetBytes(format.AsSpan(num, num2), span);
					bufferWriter.Advance(bytes);
					i++;
					num = i;
				}
				else
				{
					ExceptionUtil.ThrowFormatException();
				}
				break;
			}
		}
		int num5 = format.Length - num;
		if (num5 > 0)
		{
			Span<byte> span4 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num5));
			int bytes4 = UTF8NoBom.GetBytes(format.AsSpan(num, num5), span4);
			bufferWriter.Advance(bytes4);
		}
	}

	public static void Utf8Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(IBufferWriter<byte> bufferWriter, string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12)
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
					int num3 = i - num;
					Span<byte> span2 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num3));
					int bytes2 = UTF8NoBom.GetBytes(format.AsSpan(num, num3), span2);
					bufferWriter.Advance(bytes2);
					i++;
					num = i;
					break;
				}
				int num4 = i - num;
				Span<byte> span3 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num4));
				int bytes3 = UTF8NoBom.GetBytes(format.AsSpan(num, num4), span3);
				bufferWriter.Advance(bytes3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				StandardFormat format2 = StandardFormat.Parse(parseResult.FormatString);
				switch (parseResult.Index)
				{
				case 0:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg1, parseResult.Alignment, format2, "arg1");
					break;
				case 1:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg2, parseResult.Alignment, format2, "arg2");
					break;
				case 2:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg3, parseResult.Alignment, format2, "arg3");
					break;
				case 3:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg4, parseResult.Alignment, format2, "arg4");
					break;
				case 4:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg5, parseResult.Alignment, format2, "arg5");
					break;
				case 5:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg6, parseResult.Alignment, format2, "arg6");
					break;
				case 6:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg7, parseResult.Alignment, format2, "arg7");
					break;
				case 7:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg8, parseResult.Alignment, format2, "arg8");
					break;
				case 8:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg9, parseResult.Alignment, format2, "arg9");
					break;
				case 9:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg10, parseResult.Alignment, format2, "arg10");
					break;
				case 10:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg11, parseResult.Alignment, format2, "arg11");
					break;
				case 11:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg12, parseResult.Alignment, format2, "arg12");
					break;
				default:
					ExceptionUtil.ThrowFormatException();
					ExceptionUtil.ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int num2 = i - num;
					Span<byte> span = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num2));
					int bytes = UTF8NoBom.GetBytes(format.AsSpan(num, num2), span);
					bufferWriter.Advance(bytes);
					i++;
					num = i;
				}
				else
				{
					ExceptionUtil.ThrowFormatException();
				}
				break;
			}
		}
		int num5 = format.Length - num;
		if (num5 > 0)
		{
			Span<byte> span4 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num5));
			int bytes4 = UTF8NoBom.GetBytes(format.AsSpan(num, num5), span4);
			bufferWriter.Advance(bytes4);
		}
	}

	public static void Utf8Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(IBufferWriter<byte> bufferWriter, string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13)
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
					int num3 = i - num;
					Span<byte> span2 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num3));
					int bytes2 = UTF8NoBom.GetBytes(format.AsSpan(num, num3), span2);
					bufferWriter.Advance(bytes2);
					i++;
					num = i;
					break;
				}
				int num4 = i - num;
				Span<byte> span3 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num4));
				int bytes3 = UTF8NoBom.GetBytes(format.AsSpan(num, num4), span3);
				bufferWriter.Advance(bytes3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				StandardFormat format2 = StandardFormat.Parse(parseResult.FormatString);
				switch (parseResult.Index)
				{
				case 0:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg1, parseResult.Alignment, format2, "arg1");
					break;
				case 1:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg2, parseResult.Alignment, format2, "arg2");
					break;
				case 2:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg3, parseResult.Alignment, format2, "arg3");
					break;
				case 3:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg4, parseResult.Alignment, format2, "arg4");
					break;
				case 4:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg5, parseResult.Alignment, format2, "arg5");
					break;
				case 5:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg6, parseResult.Alignment, format2, "arg6");
					break;
				case 6:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg7, parseResult.Alignment, format2, "arg7");
					break;
				case 7:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg8, parseResult.Alignment, format2, "arg8");
					break;
				case 8:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg9, parseResult.Alignment, format2, "arg9");
					break;
				case 9:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg10, parseResult.Alignment, format2, "arg10");
					break;
				case 10:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg11, parseResult.Alignment, format2, "arg11");
					break;
				case 11:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg12, parseResult.Alignment, format2, "arg12");
					break;
				case 12:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg13, parseResult.Alignment, format2, "arg13");
					break;
				default:
					ExceptionUtil.ThrowFormatException();
					ExceptionUtil.ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int num2 = i - num;
					Span<byte> span = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num2));
					int bytes = UTF8NoBom.GetBytes(format.AsSpan(num, num2), span);
					bufferWriter.Advance(bytes);
					i++;
					num = i;
				}
				else
				{
					ExceptionUtil.ThrowFormatException();
				}
				break;
			}
		}
		int num5 = format.Length - num;
		if (num5 > 0)
		{
			Span<byte> span4 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num5));
			int bytes4 = UTF8NoBom.GetBytes(format.AsSpan(num, num5), span4);
			bufferWriter.Advance(bytes4);
		}
	}

	public static void Utf8Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(IBufferWriter<byte> bufferWriter, string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14)
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
					int num3 = i - num;
					Span<byte> span2 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num3));
					int bytes2 = UTF8NoBom.GetBytes(format.AsSpan(num, num3), span2);
					bufferWriter.Advance(bytes2);
					i++;
					num = i;
					break;
				}
				int num4 = i - num;
				Span<byte> span3 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num4));
				int bytes3 = UTF8NoBom.GetBytes(format.AsSpan(num, num4), span3);
				bufferWriter.Advance(bytes3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				StandardFormat format2 = StandardFormat.Parse(parseResult.FormatString);
				switch (parseResult.Index)
				{
				case 0:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg1, parseResult.Alignment, format2, "arg1");
					break;
				case 1:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg2, parseResult.Alignment, format2, "arg2");
					break;
				case 2:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg3, parseResult.Alignment, format2, "arg3");
					break;
				case 3:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg4, parseResult.Alignment, format2, "arg4");
					break;
				case 4:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg5, parseResult.Alignment, format2, "arg5");
					break;
				case 5:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg6, parseResult.Alignment, format2, "arg6");
					break;
				case 6:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg7, parseResult.Alignment, format2, "arg7");
					break;
				case 7:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg8, parseResult.Alignment, format2, "arg8");
					break;
				case 8:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg9, parseResult.Alignment, format2, "arg9");
					break;
				case 9:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg10, parseResult.Alignment, format2, "arg10");
					break;
				case 10:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg11, parseResult.Alignment, format2, "arg11");
					break;
				case 11:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg12, parseResult.Alignment, format2, "arg12");
					break;
				case 12:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg13, parseResult.Alignment, format2, "arg13");
					break;
				case 13:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg14, parseResult.Alignment, format2, "arg14");
					break;
				default:
					ExceptionUtil.ThrowFormatException();
					ExceptionUtil.ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int num2 = i - num;
					Span<byte> span = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num2));
					int bytes = UTF8NoBom.GetBytes(format.AsSpan(num, num2), span);
					bufferWriter.Advance(bytes);
					i++;
					num = i;
				}
				else
				{
					ExceptionUtil.ThrowFormatException();
				}
				break;
			}
		}
		int num5 = format.Length - num;
		if (num5 > 0)
		{
			Span<byte> span4 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num5));
			int bytes4 = UTF8NoBom.GetBytes(format.AsSpan(num, num5), span4);
			bufferWriter.Advance(bytes4);
		}
	}

	public static void Utf8Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(IBufferWriter<byte> bufferWriter, string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15)
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
					int num3 = i - num;
					Span<byte> span2 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num3));
					int bytes2 = UTF8NoBom.GetBytes(format.AsSpan(num, num3), span2);
					bufferWriter.Advance(bytes2);
					i++;
					num = i;
					break;
				}
				int num4 = i - num;
				Span<byte> span3 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num4));
				int bytes3 = UTF8NoBom.GetBytes(format.AsSpan(num, num4), span3);
				bufferWriter.Advance(bytes3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				StandardFormat format2 = StandardFormat.Parse(parseResult.FormatString);
				switch (parseResult.Index)
				{
				case 0:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg1, parseResult.Alignment, format2, "arg1");
					break;
				case 1:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg2, parseResult.Alignment, format2, "arg2");
					break;
				case 2:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg3, parseResult.Alignment, format2, "arg3");
					break;
				case 3:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg4, parseResult.Alignment, format2, "arg4");
					break;
				case 4:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg5, parseResult.Alignment, format2, "arg5");
					break;
				case 5:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg6, parseResult.Alignment, format2, "arg6");
					break;
				case 6:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg7, parseResult.Alignment, format2, "arg7");
					break;
				case 7:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg8, parseResult.Alignment, format2, "arg8");
					break;
				case 8:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg9, parseResult.Alignment, format2, "arg9");
					break;
				case 9:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg10, parseResult.Alignment, format2, "arg10");
					break;
				case 10:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg11, parseResult.Alignment, format2, "arg11");
					break;
				case 11:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg12, parseResult.Alignment, format2, "arg12");
					break;
				case 12:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg13, parseResult.Alignment, format2, "arg13");
					break;
				case 13:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg14, parseResult.Alignment, format2, "arg14");
					break;
				case 14:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg15, parseResult.Alignment, format2, "arg15");
					break;
				default:
					ExceptionUtil.ThrowFormatException();
					ExceptionUtil.ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int num2 = i - num;
					Span<byte> span = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num2));
					int bytes = UTF8NoBom.GetBytes(format.AsSpan(num, num2), span);
					bufferWriter.Advance(bytes);
					i++;
					num = i;
				}
				else
				{
					ExceptionUtil.ThrowFormatException();
				}
				break;
			}
		}
		int num5 = format.Length - num;
		if (num5 > 0)
		{
			Span<byte> span4 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num5));
			int bytes4 = UTF8NoBom.GetBytes(format.AsSpan(num, num5), span4);
			bufferWriter.Advance(bytes4);
		}
	}

	public static void Utf8Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16>(IBufferWriter<byte> bufferWriter, string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15, T16 arg16)
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
					int num3 = i - num;
					Span<byte> span2 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num3));
					int bytes2 = UTF8NoBom.GetBytes(format.AsSpan(num, num3), span2);
					bufferWriter.Advance(bytes2);
					i++;
					num = i;
					break;
				}
				int num4 = i - num;
				Span<byte> span3 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num4));
				int bytes3 = UTF8NoBom.GetBytes(format.AsSpan(num, num4), span3);
				bufferWriter.Advance(bytes3);
				FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
				num = parseResult.LastIndex;
				i = parseResult.LastIndex - 1;
				StandardFormat format2 = StandardFormat.Parse(parseResult.FormatString);
				switch (parseResult.Index)
				{
				case 0:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg1, parseResult.Alignment, format2, "arg1");
					break;
				case 1:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg2, parseResult.Alignment, format2, "arg2");
					break;
				case 2:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg3, parseResult.Alignment, format2, "arg3");
					break;
				case 3:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg4, parseResult.Alignment, format2, "arg4");
					break;
				case 4:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg5, parseResult.Alignment, format2, "arg5");
					break;
				case 5:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg6, parseResult.Alignment, format2, "arg6");
					break;
				case 6:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg7, parseResult.Alignment, format2, "arg7");
					break;
				case 7:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg8, parseResult.Alignment, format2, "arg8");
					break;
				case 8:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg9, parseResult.Alignment, format2, "arg9");
					break;
				case 9:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg10, parseResult.Alignment, format2, "arg10");
					break;
				case 10:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg11, parseResult.Alignment, format2, "arg11");
					break;
				case 11:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg12, parseResult.Alignment, format2, "arg12");
					break;
				case 12:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg13, parseResult.Alignment, format2, "arg13");
					break;
				case 13:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg14, parseResult.Alignment, format2, "arg14");
					break;
				case 14:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg15, parseResult.Alignment, format2, "arg15");
					break;
				case 15:
					Utf8FormatHelper.FormatTo(ref bufferWriter, arg16, parseResult.Alignment, format2, "arg16");
					break;
				default:
					ExceptionUtil.ThrowFormatException();
					ExceptionUtil.ThrowFormatException();
					break;
				}
				break;
			}
			case '}':
				if (i + 1 < format.Length && format[i + 1] == '}')
				{
					int num2 = i - num;
					Span<byte> span = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num2));
					int bytes = UTF8NoBom.GetBytes(format.AsSpan(num, num2), span);
					bufferWriter.Advance(bytes);
					i++;
					num = i;
				}
				else
				{
					ExceptionUtil.ThrowFormatException();
				}
				break;
			}
		}
		int num5 = format.Length - num;
		if (num5 > 0)
		{
			Span<byte> span4 = bufferWriter.GetSpan(UTF8NoBom.GetMaxByteCount(num5));
			int bytes4 = UTF8NoBom.GetBytes(format.AsSpan(num, num5), span4);
			bufferWriter.Advance(bytes4);
		}
	}
}
