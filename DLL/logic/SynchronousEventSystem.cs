using System;
using System.Collections.Generic;

public class SynchronousEventSystem : IEventBroadcaster, IEventReceiver
{
	public Dictionary<Type, EventPosterBase> mHandlers = new Dictionary<Type, EventPosterBase>(200);

	public void AddHandler<T>(EventHandler<T> handler) where T : NEventBase
	{
		if (!mHandlers.TryGetValue(typeof(T), out var value))
		{
			value = new EventPoster<T>();
			mHandlers[typeof(T)] = value;
		}
		((EventPoster<T>)value).Listen += handler;
	}

	public void Execute()
	{
	}

	public bool HasHandler(NEventBase evt)
	{
		Type type = evt.GetType();
		do
		{
			if (mHandlers.TryGetValue(type, out var _))
			{
				return true;
			}
			type = type.BaseType;
		}
		while (type != typeof(NEventBase));
		return false;
	}

	public void Initialize()
	{
	}

	public void Post(NEventBase evt)
	{
		Type type = evt.GetType();
		do
		{
			if (mHandlers.TryGetValue(type, out var value))
			{
				value.DeliverEvent(evt);
			}
			type = type.BaseType;
		}
		while (type != typeof(NEventBase));
	}

	public void RemoveAllHandlers()
	{
		mHandlers.Clear();
	}

	public void RemoveHandler<T>(EventHandler<T> handler) where T : NEventBase
	{
		if (!mHandlers.TryGetValue(typeof(T), out var value))
		{
			XLogger.Error("Core:", $"Unable to remove handler {handler} of type {typeof(T)} because no handlers are currently registered for this type");
			return;
		}
		EventPoster<T> eventPoster = (EventPoster<T>)value;
		eventPoster.Listen -= handler;
		if (eventPoster.IsEmpty)
		{
			mHandlers.Remove(typeof(T));
		}
	}
}
