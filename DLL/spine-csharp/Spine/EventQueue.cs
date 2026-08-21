using System;
using System.Collections.Generic;

namespace Spine;

internal class EventQueue
{
	private struct EventQueueEntry(EventType eventType, TrackEntry trackEntry, Event e = null)
	{
		public EventType type = eventType;

		public TrackEntry entry = trackEntry;

		public Event e = e;
	}

	private enum EventType
	{
		Start,
		Interrupt,
		End,
		Dispose,
		Complete,
		Event
	}

	private readonly List<EventQueueEntry> eventQueueEntries = new List<EventQueueEntry>();

	internal bool drainDisabled;

	private readonly AnimationState state;

	private readonly Pool<TrackEntry> trackEntryPool;

	internal event Action AnimationsChanged;

	internal EventQueue(AnimationState state, Action HandleAnimationsChanged, Pool<TrackEntry> trackEntryPool)
	{
		this.state = state;
		AnimationsChanged += HandleAnimationsChanged;
		this.trackEntryPool = trackEntryPool;
	}

	internal void Start(TrackEntry entry)
	{
		eventQueueEntries.Add(new EventQueueEntry(EventType.Start, entry));
		if (AnimationsChanged != null)
		{
			AnimationsChanged();
		}
	}

	internal void Interrupt(TrackEntry entry)
	{
		eventQueueEntries.Add(new EventQueueEntry(EventType.Interrupt, entry));
	}

	internal void End(TrackEntry entry)
	{
		eventQueueEntries.Add(new EventQueueEntry(EventType.End, entry));
		if (AnimationsChanged != null)
		{
			AnimationsChanged();
		}
	}

	internal void Dispose(TrackEntry entry)
	{
		eventQueueEntries.Add(new EventQueueEntry(EventType.Dispose, entry));
	}

	internal void Complete(TrackEntry entry)
	{
		eventQueueEntries.Add(new EventQueueEntry(EventType.Complete, entry));
	}

	internal void Event(TrackEntry entry, Event e)
	{
		eventQueueEntries.Add(new EventQueueEntry(EventType.Event, entry, e));
	}

	internal void Drain()
	{
		if (drainDisabled)
		{
			return;
		}
		drainDisabled = true;
		List<EventQueueEntry> list = eventQueueEntries;
		AnimationState animationState = state;
		for (int i = 0; i < list.Count; i++)
		{
			EventQueueEntry eventQueueEntry = list[i];
			TrackEntry entry = eventQueueEntry.entry;
			switch (eventQueueEntry.type)
			{
			case EventType.Start:
				entry.OnStart();
				animationState.OnStart(entry);
				break;
			case EventType.Interrupt:
				entry.OnInterrupt();
				animationState.OnInterrupt(entry);
				break;
			case EventType.End:
				entry.OnEnd();
				animationState.OnEnd(entry);
				goto case EventType.Dispose;
			case EventType.Dispose:
				entry.OnDispose();
				animationState.OnDispose(entry);
				trackEntryPool.Free(entry);
				break;
			case EventType.Complete:
				entry.OnComplete();
				animationState.OnComplete(entry);
				break;
			case EventType.Event:
				entry.OnEvent(eventQueueEntry.e);
				animationState.OnEvent(entry, eventQueueEntry.e);
				break;
			}
		}
		list.Clear();
		drainDisabled = false;
	}

	internal void Clear()
	{
		eventQueueEntries.Clear();
	}
}
