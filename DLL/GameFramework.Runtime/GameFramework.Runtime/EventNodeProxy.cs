using System;
using GameFramework.Runtime.Proxy;

namespace GameFramework.Runtime;

public class EventNodeProxy : SourceProxyBase, ISourceProxy, IBindingProxy, IDisposable, IModifiable
{
	protected readonly IProxyEventInfo eventInfo;

	private bool disposed = false;

	private bool isStatic = false;

	protected Delegate handler;

	public override Type Type => eventInfo.HandlerType;

	public EventNodeProxy(IProxyEventInfo eventInfo)
		: this(null, eventInfo)
	{
	}

	public EventNodeProxy(object source, IProxyEventInfo eventInfo)
		: base(source)
	{
		this.eventInfo = eventInfo;
		isStatic = this.eventInfo.IsStatic;
	}

	public virtual void SetValue<TValue>(TValue value)
	{
		SetValue((object)value);
	}

	public virtual void SetValue(object value)
	{
		if (value != null && !value.GetType().Equals(Type))
		{
			throw new ArgumentException("Binding delegate to event failed, mismatched delegate type", "value");
		}
		Unbind(Source, handler);
		handler = (Delegate)value;
		Bind(Source, handler);
	}

	protected virtual void Bind(object target, Delegate handler)
	{
		if ((object)handler != null && eventInfo != null)
		{
			eventInfo.Add(target, handler);
		}
	}

	protected virtual void Unbind(object target, Delegate handler)
	{
		if ((object)handler != null && eventInfo != null)
		{
			eventInfo.Remove(target, handler);
		}
	}

	protected override void Dispose(bool disposing)
	{
		if (!disposed)
		{
			object obj = Source;
			if (isStatic || obj != null)
			{
				Unbind(obj, handler);
			}
			handler = null;
			disposed = true;
			base.Dispose(disposing);
		}
	}
}
