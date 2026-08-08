using System.Collections.Generic;

public interface IAsynchronousEventSystem : IEventSystem, IEventBroadcaster, IEventReceiver
{
	void DispatchEventsToListeners(List<NEventBase> events);

	void DispatchPreEventsToListeners(List<NEventBase> events);

	List<NEventBase> GetBufferedEvents();

	void ReleaseBufferedEvents(List<NEventBase> buffer);
}
