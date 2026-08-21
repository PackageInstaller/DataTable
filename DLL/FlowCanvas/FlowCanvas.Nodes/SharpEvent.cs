using System.Reflection;
using ParadoxNotion;

namespace FlowCanvas.Nodes;

public abstract class SharpEvent
{
	public object instance { get; private set; }

	public EventInfo eventInfo { get; private set; }

	public static SharpEvent Create(EventInfo eventInfo)
	{
		if (eventInfo == null)
		{
			return null;
		}
		SharpEvent obj = (SharpEvent)typeof(SharpEvent<>).RTMakeGenericType(eventInfo.EventHandlerType).CreateObjectUninitialized();
		obj.eventInfo = eventInfo;
		return obj;
	}

	public void SetInstance(object instance)
	{
		this.instance = instance;
	}

	public void StartListening(ReflectedDelegateEvent reflectedEvent, ReflectedDelegateEvent.DelegateEventCallback callback)
	{
		if (reflectedEvent != null && callback != null)
		{
			reflectedEvent.Add(callback);
			eventInfo.AddEventHandler(instance, reflectedEvent.AsDelegate());
		}
	}

	public void StopListening(ReflectedDelegateEvent reflectedEvent, ReflectedDelegateEvent.DelegateEventCallback callback)
	{
		if (reflectedEvent != null && callback != null)
		{
			reflectedEvent.Remove(callback);
			eventInfo.RemoveEventHandler(instance, reflectedEvent.AsDelegate());
		}
	}
}
public class SharpEvent<T> : SharpEvent
{
}
