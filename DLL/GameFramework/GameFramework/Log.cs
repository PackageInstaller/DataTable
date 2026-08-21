#define ENABLE_FATAL_AND_ABOVE_LOG
using System;
using System.Diagnostics;

namespace GameFramework;

public static class Log
{
	[Conditional("ENABLE_DEBUG_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	public static void Debug(object message)
	{
		GameFrameworkLog.Debug(message);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Debug(string message)
	{
		GameFrameworkLog.Debug(message);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Debug<T>(string format, T arg)
	{
		GameFrameworkLog.Debug(format, arg);
	}

	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_LOG")]
	[Conditional("ENABLE_LOG")]
	public static void Debug<T1, T2>(string format, T1 arg1, T2 arg2)
	{
		GameFrameworkLog.Debug(format, arg1, arg2);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Debug<T1, T2, T3>(string format, T1 arg1, T2 arg2, T3 arg3)
	{
		GameFrameworkLog.Debug(format, arg1, arg2, arg3);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Debug<T1, T2, T3, T4>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		GameFrameworkLog.Debug(format, arg1, arg2, arg3, arg4);
	}

	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_LOG")]
	[Conditional("ENABLE_LOG")]
	public static void Debug<T1, T2, T3, T4, T5>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		GameFrameworkLog.Debug(format, arg1, arg2, arg3, arg4, arg5);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Debug<T1, T2, T3, T4, T5, T6>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
	{
		GameFrameworkLog.Debug(format, arg1, arg2, arg3, arg4, arg5, arg6);
	}

	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_LOG")]
	public static void Debug<T1, T2, T3, T4, T5, T6, T7>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
	{
		GameFrameworkLog.Debug(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
	}

	[Conditional("ENABLE_DEBUG_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Debug<T1, T2, T3, T4, T5, T6, T7, T8>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8)
	{
		GameFrameworkLog.Debug(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_LOG")]
	public static void Debug<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9)
	{
		GameFrameworkLog.Debug(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_LOG")]
	public static void Debug<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10)
	{
		GameFrameworkLog.Debug(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_LOG")]
	public static void Debug<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11)
	{
		GameFrameworkLog.Debug(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
	}

	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_LOG")]
	public static void Debug<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12)
	{
		GameFrameworkLog.Debug(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
	}

	[Conditional("ENABLE_DEBUG_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	public static void Debug<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13)
	{
		GameFrameworkLog.Debug(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
	}

	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_LOG")]
	public static void Debug<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14)
	{
		GameFrameworkLog.Debug(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
	}

	[Conditional("ENABLE_DEBUG_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Debug<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15)
	{
		GameFrameworkLog.Debug(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
	}

	[Conditional("ENABLE_DEBUG_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	public static void Debug<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15, T16 arg16)
	{
		GameFrameworkLog.Debug(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
	}

	[Conditional("ENABLE_INFO_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Info(object message)
	{
		GameFrameworkLog.Info(message);
	}

	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Info(string message)
	{
		GameFrameworkLog.Info(message);
	}

	[Conditional("ENABLE_INFO_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	public static void Info<T>(string format, T arg)
	{
		GameFrameworkLog.Info(format, arg);
	}

	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	public static void Info<T1, T2>(string format, T1 arg1, T2 arg2)
	{
		GameFrameworkLog.Info(format, arg1, arg2);
	}

	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_LOG")]
	[Conditional("ENABLE_LOG")]
	public static void Info<T1, T2, T3>(string format, T1 arg1, T2 arg2, T3 arg3)
	{
		GameFrameworkLog.Info(format, arg1, arg2, arg3);
	}

	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Info<T1, T2, T3, T4>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		GameFrameworkLog.Info(format, arg1, arg2, arg3, arg4);
	}

	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Info<T1, T2, T3, T4, T5>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		GameFrameworkLog.Info(format, arg1, arg2, arg3, arg4, arg5);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_INFO_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Info<T1, T2, T3, T4, T5, T6>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
	{
		GameFrameworkLog.Info(format, arg1, arg2, arg3, arg4, arg5, arg6);
	}

	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_LOG")]
	[Conditional("ENABLE_LOG")]
	public static void Info<T1, T2, T3, T4, T5, T6, T7>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
	{
		GameFrameworkLog.Info(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
	}

	[Conditional("ENABLE_INFO_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	public static void Info<T1, T2, T3, T4, T5, T6, T7, T8>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8)
	{
		GameFrameworkLog.Info(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_INFO_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	public static void Info<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9)
	{
		GameFrameworkLog.Info(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
	}

	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_INFO_LOG")]
	public static void Info<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10)
	{
		GameFrameworkLog.Info(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
	}

	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Info<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11)
	{
		GameFrameworkLog.Info(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_INFO_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	public static void Info<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12)
	{
		GameFrameworkLog.Info(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_INFO_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	public static void Info<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13)
	{
		GameFrameworkLog.Info(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_INFO_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	public static void Info<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14)
	{
		GameFrameworkLog.Info(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_INFO_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Info<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15)
	{
		GameFrameworkLog.Info(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
	}

	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_LOG")]
	[Conditional("ENABLE_LOG")]
	public static void Info<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15, T16 arg16)
	{
		GameFrameworkLog.Info(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_WARNING_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	public static void Warning(object message)
	{
		GameFrameworkLog.Warning(message);
	}

	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Warning(string message)
	{
		GameFrameworkLog.Warning(message);
	}

	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_LOG")]
	[Conditional("ENABLE_LOG")]
	public static void Warning<T>(string format, T arg)
	{
		GameFrameworkLog.Warning(format, arg);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_WARNING_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	public static void Warning<T1, T2>(string format, T1 arg1, T2 arg2)
	{
		GameFrameworkLog.Warning(format, arg1, arg2);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_WARNING_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	public static void Warning<T1, T2, T3>(string format, T1 arg1, T2 arg2, T3 arg3)
	{
		GameFrameworkLog.Warning(format, arg1, arg2, arg3);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_WARNING_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Warning<T1, T2, T3, T4>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		GameFrameworkLog.Warning(format, arg1, arg2, arg3, arg4);
	}

	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_WARNING_LOG")]
	public static void Warning<T1, T2, T3, T4, T5>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		GameFrameworkLog.Warning(format, arg1, arg2, arg3, arg4, arg5);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_LOG")]
	public static void Warning<T1, T2, T3, T4, T5, T6>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
	{
		GameFrameworkLog.Warning(format, arg1, arg2, arg3, arg4, arg5, arg6);
	}

	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_LOG")]
	[Conditional("ENABLE_LOG")]
	public static void Warning<T1, T2, T3, T4, T5, T6, T7>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
	{
		GameFrameworkLog.Warning(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_LOG")]
	public static void Warning<T1, T2, T3, T4, T5, T6, T7, T8>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8)
	{
		GameFrameworkLog.Warning(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
	}

	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_LOG")]
	[Conditional("ENABLE_LOG")]
	public static void Warning<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9)
	{
		GameFrameworkLog.Warning(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
	}

	[Conditional("ENABLE_WARNING_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	public static void Warning<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10)
	{
		GameFrameworkLog.Warning(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_WARNING_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Warning<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11)
	{
		GameFrameworkLog.Warning(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
	}

	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	public static void Warning<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12)
	{
		GameFrameworkLog.Warning(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_WARNING_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	public static void Warning<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13)
	{
		GameFrameworkLog.Warning(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
	}

	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_WARNING_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Warning<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14)
	{
		GameFrameworkLog.Warning(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_WARNING_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	public static void Warning<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15)
	{
		GameFrameworkLog.Warning(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	public static void Warning<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15, T16 arg16)
	{
		GameFrameworkLog.Warning(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
	}

	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_ERROR_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Error(object message)
	{
		GameFrameworkLog.Error(message);
	}

	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_ERROR_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Error(string message)
	{
		GameFrameworkLog.Error(message);
	}

	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	public static void Error<T>(string format, T arg)
	{
		GameFrameworkLog.Error(format, arg);
	}

	[Conditional("ENABLE_ERROR_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	public static void Error<T1, T2>(string format, T1 arg1, T2 arg2)
	{
		GameFrameworkLog.Error(format, arg1, arg2);
	}

	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	public static void Error<T1, T2, T3>(string format, T1 arg1, T2 arg2, T3 arg3)
	{
		GameFrameworkLog.Error(format, arg1, arg2, arg3);
	}

	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	public static void Error<T1, T2, T3, T4>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		GameFrameworkLog.Error(format, arg1, arg2, arg3, arg4);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_ERROR_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	public static void Error<T1, T2, T3, T4, T5>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		GameFrameworkLog.Error(format, arg1, arg2, arg3, arg4, arg5);
	}

	[Conditional("ENABLE_ERROR_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	public static void Error<T1, T2, T3, T4, T5, T6>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
	{
		GameFrameworkLog.Error(format, arg1, arg2, arg3, arg4, arg5, arg6);
	}

	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_LOG")]
	[Conditional("ENABLE_LOG")]
	public static void Error<T1, T2, T3, T4, T5, T6, T7>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
	{
		GameFrameworkLog.Error(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
	}

	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_LOG")]
	public static void Error<T1, T2, T3, T4, T5, T6, T7, T8>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8)
	{
		GameFrameworkLog.Error(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
	}

	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_LOG")]
	[Conditional("ENABLE_LOG")]
	public static void Error<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9)
	{
		GameFrameworkLog.Error(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
	}

	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_LOG")]
	[Conditional("ENABLE_LOG")]
	public static void Error<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10)
	{
		GameFrameworkLog.Error(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_ERROR_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	public static void Error<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11)
	{
		GameFrameworkLog.Error(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
	}

	[Conditional("ENABLE_ERROR_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	public static void Error<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12)
	{
		GameFrameworkLog.Error(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
	}

	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	public static void Error<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13)
	{
		GameFrameworkLog.Error(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
	}

	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	public static void Error<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14)
	{
		GameFrameworkLog.Error(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
	}

	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_ERROR_LOG")]
	public static void Error<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15)
	{
		GameFrameworkLog.Error(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
	}

	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_LOG")]
	[Conditional("ENABLE_LOG")]
	public static void Error<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15, T16 arg16)
	{
		GameFrameworkLog.Error(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_FATAL_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_FATAL_AND_ABOVE_LOG")]
	public static void Fatal(object message)
	{
		GameFrameworkLog.Fatal(message);
	}

	[Conditional("ENABLE_FATAL_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_FATAL_LOG")]
	public static void Fatal(string message)
	{
		GameFrameworkLog.Fatal(message);
	}

	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_FATAL_AND_ABOVE_LOG")]
	[Conditional("ENABLE_FATAL_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Fatal<T>(string format, T arg)
	{
		GameFrameworkLog.Fatal(format, arg);
	}

	[Conditional("ENABLE_FATAL_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_FATAL_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	public static void Fatal<T1, T2>(string format, T1 arg1, T2 arg2)
	{
		GameFrameworkLog.Fatal(format, arg1, arg2);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_FATAL_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_FATAL_AND_ABOVE_LOG")]
	public static void Fatal<T1, T2, T3>(string format, T1 arg1, T2 arg2, T3 arg3)
	{
		GameFrameworkLog.Fatal(format, arg1, arg2, arg3);
	}

	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_FATAL_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_FATAL_AND_ABOVE_LOG")]
	public static void Fatal<T1, T2, T3, T4>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		GameFrameworkLog.Fatal(format, arg1, arg2, arg3, arg4);
	}

	[Conditional("ENABLE_FATAL_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_FATAL_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Fatal<T1, T2, T3, T4, T5>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		GameFrameworkLog.Fatal(format, arg1, arg2, arg3, arg4, arg5);
	}

	[Conditional("ENABLE_FATAL_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_FATAL_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	public static void Fatal<T1, T2, T3, T4, T5, T6>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
	{
		GameFrameworkLog.Fatal(format, arg1, arg2, arg3, arg4, arg5, arg6);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_FATAL_LOG")]
	[Conditional("ENABLE_FATAL_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Fatal<T1, T2, T3, T4, T5, T6, T7>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
	{
		GameFrameworkLog.Fatal(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_FATAL_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_FATAL_AND_ABOVE_LOG")]
	public static void Fatal<T1, T2, T3, T4, T5, T6, T7, T8>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8)
	{
		GameFrameworkLog.Fatal(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
	}

	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_FATAL_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_FATAL_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Fatal<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9)
	{
		GameFrameworkLog.Fatal(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
	}

	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_FATAL_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_FATAL_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	public static void Fatal<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10)
	{
		GameFrameworkLog.Fatal(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
	}

	[Conditional("ENABLE_FATAL_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_FATAL_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Fatal<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11)
	{
		GameFrameworkLog.Fatal(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
	}

	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_FATAL_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_FATAL_AND_ABOVE_LOG")]
	public static void Fatal<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12)
	{
		GameFrameworkLog.Fatal(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
	}

	[Conditional("ENABLE_FATAL_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_FATAL_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	public static void Fatal<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13)
	{
		GameFrameworkLog.Fatal(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
	}

	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_FATAL_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_FATAL_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void Fatal<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14)
	{
		GameFrameworkLog.Fatal(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
	}

	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_FATAL_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_FATAL_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	public static void Fatal<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15)
	{
		GameFrameworkLog.Fatal(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
	}

	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_FATAL_AND_ABOVE_LOG")]
	[Conditional("ENABLE_FATAL_LOG")]
	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	public static void Fatal<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15, T16 arg16)
	{
		GameFrameworkLog.Fatal(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
	}

	[Conditional("ENABLE_LOG")]
	public static void Assert(bool condition)
	{
		if (!condition)
		{
			string message = string.Format("{0}\n{1}", "Assert Failed", Environment.StackTrace);
			Fatal(message);
		}
	}

	[Conditional("ENABLE_LOG")]
	public static void Assert(bool condition, string retStr)
	{
		if (!condition)
		{
			string message = string.Format("{0}\n{1}", "Assert Failed" + retStr, Environment.StackTrace);
			Fatal(message);
		}
	}
}
