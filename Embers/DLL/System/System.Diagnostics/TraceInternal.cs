namespace System.Diagnostics;

internal static class TraceInternal
{
	private static volatile string appName = null;

	private static volatile TraceListenerCollection listeners;

	private static volatile bool autoFlush;

	[ThreadStatic]
	private static int indentLevel;

	private static volatile int indentSize;

	internal static readonly object critSec = new object();

	public static TraceListenerCollection Listeners
	{
		get
		{
			InitializeSettings();
			if (listeners == null)
			{
				lock (critSec)
				{
					if (listeners == null)
					{
						listeners = new TraceListenerCollection();
						TraceListener traceListener = new DefaultTraceListener();
						traceListener.IndentLevel = indentLevel;
						traceListener.IndentSize = indentSize;
						listeners.Add(traceListener);
					}
				}
			}
			return listeners;
		}
	}

	public static bool AutoFlush
	{
		get
		{
			InitializeSettings();
			return autoFlush;
		}
	}

	public static int IndentLevel => indentLevel;

	public static int IndentSize
	{
		get
		{
			InitializeSettings();
			return indentSize;
		}
	}

	private static void InitializeSettings()
	{
	}
}
