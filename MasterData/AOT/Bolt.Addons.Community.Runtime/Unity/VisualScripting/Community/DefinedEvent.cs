using System;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.DefinedEvent")]
public static class DefinedEvent
{
	public static void Trigger(GameObject target, object eventData)
	{
		DefinedEventNode.Trigger(target, eventData);
	}

	public static void TriggerGlobal(object eventData)
	{
		GlobalDefinedEventNode.Trigger(eventData);
	}

	public static IDisposable RegisterListener<T>(GameObject target, Action<T> onEvent)
	{
		return DefinedEventNode.RegisterListener(target, onEvent);
	}

	public static IDisposable RegisterGlobalListener<T>(Action<T> onEvent)
	{
		return GlobalDefinedEventNode.RegisterListener(onEvent);
	}
}
