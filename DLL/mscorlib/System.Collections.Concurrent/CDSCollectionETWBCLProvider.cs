using System.Diagnostics.Tracing;

namespace System.Collections.Concurrent;

[EventSource(Name = "System.Collections.Concurrent.ConcurrentCollectionsEventSource", Guid = "35167F8E-49B2-4b96-AB86-435B59336B5E")]
internal sealed class CDSCollectionETWBCLProvider : EventSource
{
	public static CDSCollectionETWBCLProvider Log = new CDSCollectionETWBCLProvider();

	private CDSCollectionETWBCLProvider()
	{
	}

	[Event(1, Level = EventLevel.Warning)]
	public void ConcurrentStack_FastPushFailed(int spinCount)
	{
		if (IsEnabled(EventLevel.Warning, EventKeywords.All))
		{
			WriteEvent(1, spinCount);
		}
	}

	[Event(2, Level = EventLevel.Warning)]
	public void ConcurrentStack_FastPopFailed(int spinCount)
	{
		if (IsEnabled(EventLevel.Warning, EventKeywords.All))
		{
			WriteEvent(2, spinCount);
		}
	}

	[Event(3, Level = EventLevel.Warning)]
	public void ConcurrentDictionary_AcquiringAllLocks(int numOfBuckets)
	{
		if (IsEnabled(EventLevel.Warning, EventKeywords.All))
		{
			WriteEvent(3, numOfBuckets);
		}
	}
}
