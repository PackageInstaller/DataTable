namespace System.Diagnostics;

public sealed class Trace
{
	private static volatile CorrelationManager correlationManager;

	public static TraceListenerCollection Listeners => TraceInternal.Listeners;

	public static bool AutoFlush => TraceInternal.AutoFlush;

	public static CorrelationManager CorrelationManager
	{
		get
		{
			if (correlationManager == null)
			{
				correlationManager = new CorrelationManager();
			}
			return correlationManager;
		}
	}

	[Conditional("TRACE")]
	public static void Fail(string message)
	{
		TraceInternal.Fail(message);
	}

	[Conditional("TRACE")]
	public static void TraceInformation(string message)
	{
		TraceInternal.TraceEvent(TraceEventType.Information, 0, message, null);
	}

	[Conditional("TRACE")]
	public static void TraceWarning(string message)
	{
		TraceInternal.TraceEvent(TraceEventType.Warning, 0, message, null);
	}

	[Conditional("TRACE")]
	public static void TraceError(string message)
	{
		TraceInternal.TraceEvent(TraceEventType.Error, 0, message, null);
	}

	[Conditional("TRACE")]
	public static void WriteLine(string message)
	{
		TraceInternal.WriteLine(message);
	}

	[Conditional("TRACE")]
	public static void WriteLine(string message, string category)
	{
		TraceInternal.WriteLine(message, category);
	}
}
