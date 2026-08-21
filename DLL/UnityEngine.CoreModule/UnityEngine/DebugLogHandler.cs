using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Export/Debug/Debug.bindings.h")]
internal sealed class DebugLogHandler : ILogHandler
{
	public void LogFormat(LogType logType, Object context, string format, params object[] args)
	{
		Internal_Log(logType, LogOption.None, string.Format(format, args), context);
	}

	public void LogFormat(LogType logType, LogOption logOptions, Object context, string format, params object[] args)
	{
		Internal_Log(logType, logOptions, string.Format(format, args), context);
	}

	public void LogException(Exception exception, Object context)
	{
		if (exception == null)
		{
			throw new ArgumentNullException("exception");
		}
		Internal_LogException(exception, context);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadAndSerializationSafe]
	internal static extern void Internal_Log(LogType level, LogOption options, string msg, Object obj);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadAndSerializationSafe]
	internal static extern void Internal_LogException(Exception ex, Object obj);
}
