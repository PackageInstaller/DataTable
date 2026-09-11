using System.Collections;
using System.Collections.Specialized;
using System.Globalization;
using System.Runtime.InteropServices;
using System.Text;

namespace System.Diagnostics;

public abstract class TraceListener : MarshalByRefObject, IDisposable
{
	private int indentLevel;

	private int indentSize = 4;

	private TraceOptions traceOptions;

	private bool needIndent = true;

	private string listenerName;

	private TraceFilter filter;

	private StringDictionary attributes;

	public StringDictionary Attributes
	{
		get
		{
			if (attributes == null)
			{
				attributes = new StringDictionary();
			}
			return attributes;
		}
	}

	public virtual string Name
	{
		get
		{
			if (listenerName != null)
			{
				return listenerName;
			}
			return "";
		}
	}

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

	protected TraceListener()
	{
	}

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

	public virtual void Close()
	{
	}

	public virtual void Flush()
	{
	}

	public virtual void Fail(string message)
	{
		Fail(message, null);
	}

	public virtual void Fail(string message, string detailMessage)
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(global::SR.GetString("Fail:"));
		stringBuilder.Append(" ");
		stringBuilder.Append(message);
		if (detailMessage != null)
		{
			stringBuilder.Append(" ");
			stringBuilder.Append(detailMessage);
		}
		WriteLine(stringBuilder.ToString());
	}

	protected internal virtual string[] GetSupportedAttributes()
	{
		return null;
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

	public virtual void WriteLine(string message, string category)
	{
		if (Filter == null || Filter.ShouldTrace(null, "", TraceEventType.Verbose, 0, message))
		{
			if (category == null)
			{
				WriteLine(message);
			}
			else
			{
				WriteLine(category + ": " + ((message == null) ? string.Empty : message));
			}
		}
	}

	[ComVisible(false)]
	public virtual void TraceData(TraceEventCache eventCache, string source, TraceEventType eventType, int id, object data)
	{
		if (Filter == null || Filter.ShouldTrace(eventCache, source, eventType, id, null, null, data))
		{
			WriteHeader(source, eventType, id);
			string message = string.Empty;
			if (data != null)
			{
				message = data.ToString();
			}
			WriteLine(message);
			WriteFooter(eventCache);
		}
	}

	[ComVisible(false)]
	public virtual void TraceData(TraceEventCache eventCache, string source, TraceEventType eventType, int id, params object[] data)
	{
		if (Filter != null && !Filter.ShouldTrace(eventCache, source, eventType, id, null, null, null, data))
		{
			return;
		}
		WriteHeader(source, eventType, id);
		StringBuilder stringBuilder = new StringBuilder();
		if (data != null)
		{
			for (int i = 0; i < data.Length; i++)
			{
				if (i != 0)
				{
					stringBuilder.Append(", ");
				}
				if (data[i] != null)
				{
					stringBuilder.Append(data[i].ToString());
				}
			}
		}
		WriteLine(stringBuilder.ToString());
		WriteFooter(eventCache);
	}

	[ComVisible(false)]
	public virtual void TraceEvent(TraceEventCache eventCache, string source, TraceEventType eventType, int id)
	{
		TraceEvent(eventCache, source, eventType, id, string.Empty);
	}

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

	[ComVisible(false)]
	public virtual void TraceEvent(TraceEventCache eventCache, string source, TraceEventType eventType, int id, string format, params object[] args)
	{
		if (Filter == null || Filter.ShouldTrace(eventCache, source, eventType, id, format, args))
		{
			WriteHeader(source, eventType, id);
			if (args != null)
			{
				WriteLine(string.Format(CultureInfo.InvariantCulture, format, args));
			}
			else
			{
				WriteLine(format);
			}
			WriteFooter(eventCache);
		}
	}

	[ComVisible(false)]
	public virtual void TraceTransfer(TraceEventCache eventCache, string source, int id, string message, Guid relatedActivityId)
	{
		TraceEvent(eventCache, source, TraceEventType.Transfer, id, message + ", relatedActivityId=" + relatedActivityId.ToString());
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
