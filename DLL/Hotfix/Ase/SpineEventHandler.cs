using System;
using System.Collections.Generic;

namespace Ase;

public class SpineEventHandler
{
	private const string WildcardEventName = "*";

	private readonly Dictionary<string, IIntArgHandler> intHandlers = new Dictionary<string, IIntArgHandler>(StringComparer.Ordinal);

	private readonly Dictionary<string, IStringArgHandler> stringHandlers = new Dictionary<string, IStringArgHandler>(StringComparer.Ordinal);

	private readonly Dictionary<string, IFloatArgHandler> floatHandlers = new Dictionary<string, IFloatArgHandler>(StringComparer.Ordinal);

	public void Register(IIntArgHandler handler)
	{
		RegisterHandler(intHandlers, "*", handler);
	}

	public void Register(IStringArgHandler handler)
	{
		RegisterHandler(stringHandlers, "*", handler);
	}

	public void Register(IFloatArgHandler handler)
	{
		RegisterHandler(floatHandlers, "*", handler);
	}

	public void RegisterHandlers(params object[] handlers)
	{
		if (handlers == null)
		{
			return;
		}
		foreach (object obj in handlers)
		{
			if (obj != null)
			{
				if (obj is IIntArgHandler handler)
				{
					Register(handler);
				}
				if (obj is IStringArgHandler handler2)
				{
					Register(handler2);
				}
				if (obj is IFloatArgHandler handler3)
				{
					Register(handler3);
				}
			}
		}
	}

	public void Unregister(string eventName)
	{
		if (!string.IsNullOrEmpty(eventName))
		{
			intHandlers.Remove(eventName);
			stringHandlers.Remove(eventName);
			floatHandlers.Remove(eventName);
		}
	}

	public void Clear()
	{
		intHandlers.Clear();
		stringHandlers.Clear();
		floatHandlers.Clear();
	}

	public bool HandleEvent(SpineEventData eventData)
	{
		if (string.IsNullOrEmpty(eventData.EventName))
		{
			return false;
		}
		if (!TryHandle(eventData, eventData.EventName))
		{
			return TryHandle(eventData, "*");
		}
		return true;
	}

	private static void RegisterHandler<THandler>(Dictionary<string, THandler> handlers, string fallbackEventName, THandler handler) where THandler : class
	{
		string text = fallbackEventName;
		if (handler is IArgHandler argHandler)
		{
			text = argHandler.EventName;
		}
		if (handlers != null && !string.IsNullOrEmpty(text) && handler != null)
		{
			handlers[text] = handler;
		}
	}

	private bool TryHandle(SpineEventData eventData, string eventName)
	{
		string key = eventName.Split('_')[0];
		if ((intHandlers.TryGetValue(key, out var value) || intHandlers.TryGetValue(eventName, out value)) && value.Handle(eventData.EventName, eventData.IntValue, eventData.TrackIndex))
		{
			return true;
		}
		if ((stringHandlers.TryGetValue(key, out var value2) || stringHandlers.TryGetValue(eventName, out value2)) && value2.Handle(eventData.EventName, eventData.StringValue, eventData.TrackIndex))
		{
			return true;
		}
		if ((floatHandlers.TryGetValue(key, out var value3) || floatHandlers.TryGetValue(eventName, out value3)) && value3.Handle(eventData.EventName, eventData.FloatValue, eventData.TrackIndex))
		{
			return true;
		}
		return false;
	}
}
