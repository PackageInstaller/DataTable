using System;

namespace NodeCanvas.Framework;

[AttributeUsage(AttributeTargets.Class)]
[Obsolete("[EventReceiver] is no longer used. Please use the '.router' property to subscribe/unsubscribe to events (in OnExecute/OnStop for actions and OnEnable/OnDisable for conditions). For custom events, use '.router.onCustomEvent'.")]
public class EventReceiverAttribute : Attribute
{
	public readonly string[] eventMessages;

	public EventReceiverAttribute(params string[] args)
	{
		eventMessages = args;
	}
}
