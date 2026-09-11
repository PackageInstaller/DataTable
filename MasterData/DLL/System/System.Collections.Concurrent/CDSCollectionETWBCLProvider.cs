using System.Diagnostics.Tracing;

namespace System.Collections.Concurrent;

[EventSource(Name = "System.Collections.Concurrent.ConcurrentCollectionsEventSource", Guid = "35167F8E-49B2-4b96-AB86-435B59336B5E")]
internal sealed class CDSCollectionETWBCLProvider : EventSource
{
	public static CDSCollectionETWBCLProvider Log = new CDSCollectionETWBCLProvider();

	private CDSCollectionETWBCLProvider()
	{
	}

	[Event(4, Level = EventLevel.Verbose)]
	public void ConcurrentBag_TryTakeSteals()
	{
		if (IsEnabled(EventLevel.Verbose, EventKeywords.All))
		{
			WriteEvent(4);
		}
	}

	[Event(5, Level = EventLevel.Verbose)]
	public void ConcurrentBag_TryPeekSteals()
	{
		if (IsEnabled(EventLevel.Verbose, EventKeywords.All))
		{
			WriteEvent(5);
		}
	}
}
