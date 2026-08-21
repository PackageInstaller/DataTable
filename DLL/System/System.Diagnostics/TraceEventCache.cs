using System.Collections;
using System.Globalization;
using System.Threading;

namespace System.Diagnostics;

public class TraceEventCache
{
	private static volatile int processId;

	private static volatile string processName;

	private long timeStamp = -1L;

	private DateTime dateTime = DateTime.MinValue;

	private string stackTrace;

	public string Callstack
	{
		get
		{
			if (stackTrace == null)
			{
				stackTrace = Environment.StackTrace;
			}
			return stackTrace;
		}
	}

	public Stack LogicalOperationStack => Trace.CorrelationManager.LogicalOperationStack;

	public DateTime DateTime
	{
		get
		{
			if (dateTime == DateTime.MinValue)
			{
				dateTime = DateTime.UtcNow;
			}
			return dateTime;
		}
	}

	public int ProcessId => GetProcessId();

	public string ThreadId => GetThreadId().ToString(CultureInfo.InvariantCulture);

	public long Timestamp
	{
		get
		{
			if (timeStamp == -1)
			{
				timeStamp = Stopwatch.GetTimestamp();
			}
			return timeStamp;
		}
	}

	private static void InitProcessInfo()
	{
		if (processName == null)
		{
			Process currentProcess = Process.GetCurrentProcess();
			try
			{
				processId = currentProcess.Id;
				processName = currentProcess.ProcessName;
			}
			finally
			{
				currentProcess.Dispose();
			}
		}
	}

	internal static int GetProcessId()
	{
		InitProcessInfo();
		return processId;
	}

	internal static int GetThreadId()
	{
		return Thread.CurrentThread.ManagedThreadId;
	}
}
