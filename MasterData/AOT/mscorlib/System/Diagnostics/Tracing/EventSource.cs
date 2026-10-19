namespace System.Diagnostics.Tracing;

public class EventSource : IDisposable
{
	protected internal struct EventData
	{
		public IntPtr DataPointer { set; }

		public int Size { set; }

		internal int Reserved { set; }
	}

	private string Name { set; }

	protected EventSource()
	{
		Name = GetType().Name;
	}

	public EventSource(string eventSourceName)
	{
		Name = eventSourceName;
	}

	internal EventSource(Guid eventSourceGuid, string eventSourceName)
		: this(eventSourceName)
	{
	}

	~EventSource()
	{
		Dispose(disposing: false);
	}

	public bool IsEnabled()
	{
		return false;
	}

	public bool IsEnabled(EventLevel level, EventKeywords keywords)
	{
		return false;
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
	}

	protected void WriteEvent(int eventId, int arg1)
	{
		WriteEvent(eventId, new object[1] { arg1 });
	}

	protected void WriteEvent(int eventId, string arg1)
	{
		WriteEvent(eventId, new object[1] { arg1 });
	}

	protected void WriteEvent(int eventId, int arg1, int arg2)
	{
		WriteEvent(eventId, new object[2] { arg1, arg2 });
	}

	protected void WriteEvent(int eventId, int arg1, int arg2, int arg3)
	{
		WriteEvent(eventId, new object[3] { arg1, arg2, arg3 });
	}

	protected void WriteEvent(int eventId, long arg1)
	{
		WriteEvent(eventId, new object[1] { arg1 });
	}

	protected void WriteEvent(int eventId, long arg1, string arg2)
	{
		WriteEvent(eventId, new object[2] { arg1, arg2 });
	}

	protected void WriteEvent(int eventId, params object[] args)
	{
	}

	protected void WriteEvent(int eventId, string arg1, string arg2, string arg3)
	{
		WriteEvent(eventId, new object[3] { arg1, arg2, arg3 });
	}

	[CLSCompliant(false)]
	protected unsafe void WriteEventCore(int eventId, int eventDataCount, EventData* data)
	{
	}
}
