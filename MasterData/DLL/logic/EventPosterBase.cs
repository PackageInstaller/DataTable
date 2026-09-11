using System.IO;

public abstract class EventPosterBase
{
	public abstract bool IsEmpty { get; }

	public abstract int ReceiverCount { get; }

	public abstract void DeliverEvent(NEventBase evt);

	public abstract void LogListeners(TextWriter writer);
}
