using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

public static class EventBus
{
	private static readonly Dictionary<EventHook, HashSet<Delegate>> events;

	internal static Dictionary<EventHook, HashSet<Delegate>> testAccessEvents => events;

	static EventBus()
	{
		events = new Dictionary<EventHook, HashSet<Delegate>>(new EventHookComparer());
	}

	public static void Register<TArgs>(EventHook hook, Action<TArgs> handler)
	{
		if (!events.TryGetValue(hook, out var value))
		{
			value = new HashSet<Delegate>();
			events.Add(hook, value);
		}
		value.Add(handler);
	}

	public static void Unregister(EventHook hook, Delegate handler)
	{
		if (events.TryGetValue(hook, out var value) && value.Remove(handler) && value.Count == 0)
		{
			events.Remove(hook);
		}
	}

	public static void Trigger<TArgs>(EventHook hook, TArgs args)
	{
		HashSet<Action<TArgs>> hashSet = null;
		if (events.TryGetValue(hook, out var value))
		{
			foreach (Delegate item2 in value)
			{
				if (item2 is Action<TArgs> item)
				{
					if (hashSet == null)
					{
						hashSet = HashSetPool<Action<TArgs>>.New();
					}
					hashSet.Add(item);
				}
			}
		}
		if (hashSet == null)
		{
			return;
		}
		foreach (Action<TArgs> item3 in hashSet)
		{
			if (value.Contains(item3))
			{
				item3(args);
			}
		}
		hashSet.Free();
	}

	public static void Trigger<TArgs>(string name, GameObject target, TArgs args)
	{
		Trigger(new EventHook(name, target), args);
	}

	public static void Trigger(EventHook hook)
	{
		Trigger<EmptyEventArgs>(hook, default);
	}

	public static void Trigger(string name, GameObject target)
	{
		Trigger(new EventHook(name, target));
	}
}
