using System;
using System.Reflection;

namespace GameFramework.Runtime;

public class ProxyEventInfo : IProxyEventInfo, IProxyMemberInfo
{
	protected EventInfo eventInfo;

	public Type DeclaringType => eventInfo.DeclaringType;

	public string Name => eventInfo.Name;

	public bool IsStatic => eventInfo.IsStatic();

	public Type HandlerType => eventInfo.EventHandlerType;

	public ProxyEventInfo(EventInfo eventInfo)
	{
		this.eventInfo = eventInfo;
	}

	public void Add(object target, Delegate handler)
	{
		eventInfo.AddEventHandler(target, handler);
	}

	public void Remove(object target, Delegate handler)
	{
		eventInfo.RemoveEventHandler(target, handler);
	}
}
