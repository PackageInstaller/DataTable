using System.Collections;
using System.Globalization;
using System.Runtime.InteropServices;

namespace System.Diagnostics;

public abstract class TraceListener : MarshalByRefObject, IDisposable
{
	private int indentLevel;

	private int indentSize = 4;

	private TraceOptions traceOptions;

	private bool needIndent = true;

	private string listenerName;

	private TraceFilter filter;

	public virtual bool IsThreadSafe => false;

	public int IndentLevel
	{
		set
		{
			indentLevel = ((value >= 0) ? value : 0);
		}
	}

	public int IndentSize
	{
		set
		{
			if (value < 0)
			{
				throw new ArgumentOutOfRangeException("IndentSize", value, global::SR.GetString("The IndentSize property must be non-negative."));
			}
			indentSize = value;
		}
	}

	[ComVisible(false)]
	public TraceFilter Filter => filter;

	protected bool NeedIndent
	{
		get
		{
			return needIndent;
		}
		set
		{
			needIndent = value;
		}
	}

	[ComVisible(false)]
	public TraceOptions TraceOutputOptions => traceOptions;

	protected TraceListener(string name)
	{
		listenerName = name;
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
	}

	public virtual void Flush()
	{
	}

	public abstract void Write(string message);

	protected virtual void WriteIndent()
	{
		NeedIndent = false;
		for (int i = 0; i < indentLevel; i++)
		{
			if (indentSize == 4)
			{
				Write("    ");
				continue;
			}
			for (int j = 0; j < indentSize; j++)
			{
				Write(" ");
			}
		}
	}

	public abstract void WriteLine(string message);

	[ComVisible(false)]
	public virtual void TraceEvent(TraceEventCache eventCache, string source, TraceEventType eventType, int id, string message)
	{
		if (Filter == null || Filter.ShouldTrace(eventCache, source, eventType, id, message))
		{
			WriteHeader(source, eventType, id);
			WriteLine(message);
			WriteFooter(eventCache);
		}
	}

	private void WriteHeader(string source, TraceEventType eventType, int id)
	{
		Write(string.Format(CultureInfo.InvariantCulture, "{0} {1}: {2} : ", source, eventType.ToString(), id.ToString(CultureInfo.InvariantCulture)));
	}

	private void WriteFooter(TraceEventCache eventCache)
	{
		if (eventCache == null)
		{
			return;
		}
		indentLevel++;
		if (IsEnabled(TraceOptions.ProcessId))
		{
			WriteLine("ProcessId=" + eventCache.ProcessId);
		}
		if (IsEnabled(TraceOptions.LogicalOperationStack))
		{
			Write("LogicalOperationStack=");
			Stack logicalOperationStack = eventCache.LogicalOperationStack;
			bool flag = true;
			foreach (object item in logicalOperationStack)
			{
				if (!flag)
				{
					Write(", ");
				}
				else
				{
					flag = false;
				}
				Write(item.ToString());
			}
			WriteLine(string.Empty);
		}
		if (IsEnabled(TraceOptions.ThreadId))
		{
			WriteLine("ThreadId=" + eventCache.ThreadId);
		}
		if (IsEnabled(TraceOptions.DateTime))
		{
			WriteLine("DateTime=" + eventCache.DateTime.ToString("o", CultureInfo.InvariantCulture));
		}
		if (IsEnabled(TraceOptions.Timestamp))
		{
			WriteLine("Timestamp=" + eventCache.Timestamp);
		}
		if (IsEnabled(TraceOptions.Callstack))
		{
			WriteLine("Callstack=" + eventCache.Callstack);
		}
		indentLevel--;
	}

	internal bool IsEnabled(TraceOptions opts)
	{
		return (opts & TraceOutputOptions) != 0;
	}
}
