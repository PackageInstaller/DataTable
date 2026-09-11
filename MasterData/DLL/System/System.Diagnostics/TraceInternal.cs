using System.IO;

namespace System.Diagnostics;

internal static class TraceInternal
{
	private static volatile string appName = null;

	private static volatile TraceListenerCollection listeners;

	private static volatile bool autoFlush;

	private static volatile bool useGlobalLock;

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

	internal static string AppName
	{
		get
		{
			if (appName == null)
			{
				string[] commandLineArgs = Environment.GetCommandLineArgs();
				if (commandLineArgs.Length != 0)
				{
					appName = Path.GetFileName(commandLineArgs[0]);
				}
			}
			return appName;
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

	public static bool UseGlobalLock
	{
		get
		{
			InitializeSettings();
			return useGlobalLock;
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

	public static void Fail(string message)
	{
		if (UseGlobalLock)
		{
			lock (critSec)
			{
				foreach (TraceListener listener in Listeners)
				{
					listener.Fail(message);
					if (AutoFlush)
					{
						listener.Flush();
					}
				}
				return;
			}
		}
		foreach (TraceListener listener2 in Listeners)
		{
			if (!listener2.IsThreadSafe)
			{
				lock (listener2)
				{
					listener2.Fail(message);
					if (AutoFlush)
					{
						listener2.Flush();
					}
				}
			}
			else
			{
				listener2.Fail(message);
				if (AutoFlush)
				{
					listener2.Flush();
				}
			}
		}
	}

	private static void InitializeSettings()
	{
	}

	public static void TraceEvent(TraceEventType eventType, int id, string format, params object[] args)
	{
		TraceEventCache eventCache = new TraceEventCache();
		if (UseGlobalLock)
		{
			lock (critSec)
			{
				if (args == null)
				{
					foreach (TraceListener listener in Listeners)
					{
						listener.TraceEvent(eventCache, AppName, eventType, id, format);
						if (AutoFlush)
						{
							listener.Flush();
						}
					}
					return;
				}
				foreach (TraceListener listener2 in Listeners)
				{
					listener2.TraceEvent(eventCache, AppName, eventType, id, format, args);
					if (AutoFlush)
					{
						listener2.Flush();
					}
				}
				return;
			}
		}
		if (args == null)
		{
			foreach (TraceListener listener3 in Listeners)
			{
				if (!listener3.IsThreadSafe)
				{
					lock (listener3)
					{
						listener3.TraceEvent(eventCache, AppName, eventType, id, format);
						if (AutoFlush)
						{
							listener3.Flush();
						}
					}
				}
				else
				{
					listener3.TraceEvent(eventCache, AppName, eventType, id, format);
					if (AutoFlush)
					{
						listener3.Flush();
					}
				}
			}
			return;
		}
		foreach (TraceListener listener4 in Listeners)
		{
			if (!listener4.IsThreadSafe)
			{
				lock (listener4)
				{
					listener4.TraceEvent(eventCache, AppName, eventType, id, format, args);
					if (AutoFlush)
					{
						listener4.Flush();
					}
				}
			}
			else
			{
				listener4.TraceEvent(eventCache, AppName, eventType, id, format, args);
				if (AutoFlush)
				{
					listener4.Flush();
				}
			}
		}
	}

	public static void WriteLine(string message)
	{
		if (UseGlobalLock)
		{
			lock (critSec)
			{
				foreach (TraceListener listener in Listeners)
				{
					listener.WriteLine(message);
					if (AutoFlush)
					{
						listener.Flush();
					}
				}
				return;
			}
		}
		foreach (TraceListener listener2 in Listeners)
		{
			if (!listener2.IsThreadSafe)
			{
				lock (listener2)
				{
					listener2.WriteLine(message);
					if (AutoFlush)
					{
						listener2.Flush();
					}
				}
			}
			else
			{
				listener2.WriteLine(message);
				if (AutoFlush)
				{
					listener2.Flush();
				}
			}
		}
	}

	public static void WriteLine(string message, string category)
	{
		if (UseGlobalLock)
		{
			lock (critSec)
			{
				foreach (TraceListener listener in Listeners)
				{
					listener.WriteLine(message, category);
					if (AutoFlush)
					{
						listener.Flush();
					}
				}
				return;
			}
		}
		foreach (TraceListener listener2 in Listeners)
		{
			if (!listener2.IsThreadSafe)
			{
				lock (listener2)
				{
					listener2.WriteLine(message, category);
					if (AutoFlush)
					{
						listener2.Flush();
					}
				}
			}
			else
			{
				listener2.WriteLine(message, category);
				if (AutoFlush)
				{
					listener2.Flush();
				}
			}
		}
	}
}
