using System;
using System.ComponentModel;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Internal;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Export/Debug/Debug.bindings.h")]
public class Debug
{
	internal static readonly ILogger s_DefaultLogger = new Logger(new DebugLogHandler());

	internal static ILogger s_Logger = new Logger(new DebugLogHandler());

	public static ILogger unityLogger => s_Logger;

	public static extern bool developerConsoleEnabled
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern bool developerConsoleVisible
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern bool isDebugBuild
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[NativeThrows]
	internal static extern DiagnosticSwitch[] diagnosticSwitches
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Debug.logger is obsolete. Please use Debug.unityLogger instead (UnityUpgradable) -> unityLogger")]
	public static ILogger logger => s_Logger;

	[ExcludeFromDocs]
	public static void DrawLine(Vector3 start, Vector3 end, Color color, float duration)
	{
		bool depthTest = true;
		DrawLine(start, end, color, duration, depthTest);
	}

	[ExcludeFromDocs]
	public static void DrawLine(Vector3 start, Vector3 end, Color color)
	{
		bool depthTest = true;
		float duration = 0f;
		DrawLine(start, end, color, duration, depthTest);
	}

	[ExcludeFromDocs]
	public static void DrawLine(Vector3 start, Vector3 end)
	{
		bool depthTest = true;
		float duration = 0f;
		Color white = Color.white;
		DrawLine(start, end, white, duration, depthTest);
	}

	[FreeFunction("DebugDrawLine", IsThreadSafe = true)]
	public static void DrawLine(Vector3 start, Vector3 end, [UnityEngine.Internal.DefaultValue("Color.white")] Color color, [UnityEngine.Internal.DefaultValue("0.0f")] float duration, [UnityEngine.Internal.DefaultValue("true")] bool depthTest)
	{
		DrawLine_Injected(ref start, ref end, ref color, duration, depthTest);
	}

	[ExcludeFromDocs]
	public static void DrawRay(Vector3 start, Vector3 dir, Color color, float duration)
	{
		bool depthTest = true;
		DrawRay(start, dir, color, duration, depthTest);
	}

	[ExcludeFromDocs]
	public static void DrawRay(Vector3 start, Vector3 dir, Color color)
	{
		bool depthTest = true;
		float duration = 0f;
		DrawRay(start, dir, color, duration, depthTest);
	}

	[ExcludeFromDocs]
	public static void DrawRay(Vector3 start, Vector3 dir)
	{
		bool depthTest = true;
		float duration = 0f;
		Color white = Color.white;
		DrawRay(start, dir, white, duration, depthTest);
	}

	public static void DrawRay(Vector3 start, Vector3 dir, [UnityEngine.Internal.DefaultValue("Color.white")] Color color, [UnityEngine.Internal.DefaultValue("0.0f")] float duration, [UnityEngine.Internal.DefaultValue("true")] bool depthTest)
	{
		DrawLine(start, start + dir, color, duration, depthTest);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("PauseEditor")]
	public static extern void Break();

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void DebugBreak();

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern int ExtractStackTraceNoAlloc(byte* buffer, int bufferMax, string projectFolder);

	public static void Log(object message)
	{
		unityLogger.Log(LogType.Log, message);
	}

	public static void Log(object message, Object context)
	{
		unityLogger.Log(LogType.Log, message, context);
	}

	public static void LogFormat(string format, params object[] args)
	{
		unityLogger.LogFormat(LogType.Log, format, args);
	}

	public static void LogFormat(Object context, string format, params object[] args)
	{
		unityLogger.LogFormat(LogType.Log, context, format, args);
	}

	public static void LogFormat(LogType logType, LogOption logOptions, Object context, string format, params object[] args)
	{
		if (!(unityLogger.logHandler is DebugLogHandler debugLogHandler))
		{
			unityLogger.LogFormat(logType, context, format, args);
		}
		else if (unityLogger.IsLogTypeAllowed(logType))
		{
			debugLogHandler.LogFormat(logType, logOptions, context, format, args);
		}
	}

	public static void LogError(object message)
	{
		unityLogger.Log(LogType.Error, message);
	}

	public static void LogError(object message, Object context)
	{
		unityLogger.Log(LogType.Error, message, context);
	}

	public static void LogErrorFormat(string format, params object[] args)
	{
		unityLogger.LogFormat(LogType.Error, format, args);
	}

	public static void LogErrorFormat(Object context, string format, params object[] args)
	{
		unityLogger.LogFormat(LogType.Error, context, format, args);
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void ClearDeveloperConsole();

	public static void LogException(Exception exception)
	{
		unityLogger.LogException(exception, null);
	}

	public static void LogException(Exception exception, Object context)
	{
		unityLogger.LogException(exception, context);
	}

	public static void LogWarning(object message)
	{
		unityLogger.Log(LogType.Warning, message);
	}

	public static void LogWarning(object message, Object context)
	{
		unityLogger.Log(LogType.Warning, message, context);
	}

	public static void LogWarningFormat(string format, params object[] args)
	{
		unityLogger.LogFormat(LogType.Warning, format, args);
	}

	public static void LogWarningFormat(Object context, string format, params object[] args)
	{
		unityLogger.LogFormat(LogType.Warning, context, format, args);
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void Assert(bool condition)
	{
		if (!condition)
		{
			unityLogger.Log(LogType.Assert, "Assertion failed");
		}
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void Assert(bool condition, Object context)
	{
		if (!condition)
		{
			unityLogger.Log(LogType.Assert, (object)"Assertion failed", context);
		}
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void Assert(bool condition, object message)
	{
		if (!condition)
		{
			unityLogger.Log(LogType.Assert, message);
		}
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void Assert(bool condition, string message)
	{
		if (!condition)
		{
			unityLogger.Log(LogType.Assert, message);
		}
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void Assert(bool condition, object message, Object context)
	{
		if (!condition)
		{
			unityLogger.Log(LogType.Assert, message, context);
		}
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void Assert(bool condition, string message, Object context)
	{
		if (!condition)
		{
			unityLogger.Log(LogType.Assert, (object)message, context);
		}
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void AssertFormat(bool condition, string format, params object[] args)
	{
		if (!condition)
		{
			unityLogger.LogFormat(LogType.Assert, format, args);
		}
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void AssertFormat(bool condition, Object context, string format, params object[] args)
	{
		if (!condition)
		{
			unityLogger.LogFormat(LogType.Assert, context, format, args);
		}
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void LogAssertion(object message)
	{
		unityLogger.Log(LogType.Assert, message);
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void LogAssertion(object message, Object context)
	{
		unityLogger.Log(LogType.Assert, message, context);
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void LogAssertionFormat(string format, params object[] args)
	{
		unityLogger.LogFormat(LogType.Assert, format, args);
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void LogAssertionFormat(Object context, string format, params object[] args)
	{
		unityLogger.LogFormat(LogType.Assert, context, format, args);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("DeveloperConsole_OpenConsoleFile")]
	internal static extern void OpenConsoleFile();

	internal static DiagnosticSwitch GetDiagnosticSwitch(string name)
	{
		DiagnosticSwitch[] array = diagnosticSwitches;
		foreach (DiagnosticSwitch diagnosticSwitch in array)
		{
			if (diagnosticSwitch.name == name)
			{
				return diagnosticSwitch;
			}
		}
		throw new ArgumentException("Could not find DiagnosticSwitch named " + name);
	}

	[RequiredByNativeCode]
	internal static bool CallOverridenDebugHandler(Exception exception, Object obj)
	{
		if (unityLogger.logHandler is DebugLogHandler)
		{
			return false;
		}
		try
		{
			unityLogger.LogException(exception, obj);
		}
		catch (Exception arg)
		{
			s_DefaultLogger.LogError($"Invalid exception thrown from custom {unityLogger.logHandler.GetType()}.LogException(). Message: {arg}", obj);
			return false;
		}
		return true;
	}

	[RequiredByNativeCode]
	internal static bool IsLoggingEnabled()
	{
		if (unityLogger.logHandler is DebugLogHandler)
		{
			return unityLogger.logEnabled;
		}
		return s_DefaultLogger.logEnabled;
	}

	[Conditional("UNITY_ASSERTIONS")]
	[Obsolete("Assert(bool, string, params object[]) is obsolete. Use AssertFormat(bool, string, params object[]) (UnityUpgradable) -> AssertFormat(*)", true)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public static void Assert(bool condition, string format, params object[] args)
	{
		if (!condition)
		{
			unityLogger.LogFormat(LogType.Assert, format, args);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DrawLine_Injected(ref Vector3 start, ref Vector3 end, [UnityEngine.Internal.DefaultValue("Color.white")] ref Color color, [UnityEngine.Internal.DefaultValue("0.0f")] float duration, [UnityEngine.Internal.DefaultValue("true")] bool depthTest);
}
