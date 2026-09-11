using System;
using System.Collections.Generic;

public class AsynchronousEventSystem : IAsynchronousEventSystem, IEventSystem, IEventBroadcaster, IEventReceiver
{
	private List<NEventBase> mActiveEventBuffer;

	private Queue<List<NEventBase>> mEventBufferPool;

	private Dictionary<Type, EventPosterBase> mListeners;

	private object mLockObject = new object();

	public AsynchronousEventSystem(int eventBufferPoolInitialSize = 20, int eventBufferCapacityHint = 500, int listenersInitialCapacity = 500)
	{
		mEventBufferPool = new Queue<List<NEventBase>>(eventBufferPoolInitialSize);
		for (int i = 0; i < eventBufferPoolInitialSize; i++)
		{
			mEventBufferPool.Enqueue(new List<NEventBase>(eventBufferCapacityHint));
		}
		mActiveEventBuffer = mEventBufferPool.Dequeue();
		mListeners = new Dictionary<Type, EventPosterBase>(listenersInitialCapacity);
	}

	public void AddHandler<T>(EventHandler<T> handler) where T : NEventBase
	{
		if (!mListeners.TryGetValue(typeof(T), out var value))
		{
			value = new EventPoster<T>();
			mListeners[typeof(T)] = value;
		}
		((EventPoster<T>)value).Listen += handler;
	}

	public void DispatchEventsToListeners(List<NEventBase> events)
	{
		if (events == null)
		{
			return;
		}
		foreach (NEventBase @event in events)
		{
			if (@event is IPostToPresentation && mListeners.TryGetValue(@event.GetType(), out var value))
			{
				value?.DeliverEvent(@event);
			}
		}
	}

	public void DispatchPreEventsToListeners(List<NEventBase> preEvents)
	{
		if (preEvents == null)
		{
			return;
		}
		for (int i = 0; i < preEvents.Count; i++)
		{
			NEventBase nEventBase = preEvents[i];
			if (nEventBase is IPostToPreliminaryPresentation && mListeners.TryGetValue(nEventBase.GetType(), out var value))
			{
				value?.DeliverEvent(nEventBase);
			}
		}
	}

	public List<NEventBase> GetBufferedEvents()
	{
		lock (mLockObject)
		{
			List<NEventBase> result = mActiveEventBuffer;
			if (mEventBufferPool.Count > 0)
			{
				mActiveEventBuffer = mEventBufferPool.Dequeue();
			}
			else
			{
				mActiveEventBuffer = new List<NEventBase>();
			}
			return result;
		}
	}

	public void Post(NEventBase evt)
	{
		lock (mLockObject)
		{
			mActiveEventBuffer.Add(evt);
		}
	}

	public void ReleaseBufferedEvents(List<NEventBase> buffer)
	{
		if (buffer != null)
		{
			buffer.Clear();
			lock (mLockObject)
			{
				mEventBufferPool.Enqueue(buffer);
			}
		}
	}

	public void RemoveAllHandlers()
	{
		mListeners.Clear();
	}

	public void RemoveHandler<T>(EventHandler<T> handler) where T : NEventBase
	{
		if (!mListeners.TryGetValue(typeof(T), out var value))
		{
			XLogger.Error("Core:" + $"Unable to remove handler {handler} of type {typeof(T)} because no handlers are currently registered for this type");
			return;
		}
		EventPoster<T> eventPoster = (EventPoster<T>)value;
		eventPoster.Listen -= handler;
		if (eventPoster.IsEmpty)
		{
			mListeners.Remove(typeof(T));
		}
	}
}
