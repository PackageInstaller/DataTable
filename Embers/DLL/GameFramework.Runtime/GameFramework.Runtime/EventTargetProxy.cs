using System;

namespace GameFramework.Runtime;

public class EventTargetProxy : EventTargetProxyBase
{
	private bool disposed = false;

	protected readonly IProxyEventInfo eventInfo;

	protected Delegate handler;

	public override Type Type => eventInfo.HandlerType;

	public override BindingMode DefaultMode => BindingMode.OneWay;

	public EventTargetProxy(object target, IProxyEventInfo eventInfo)
		: base(target)
	{
		this.eventInfo = eventInfo;
	}

	public override void SetValue(object value)
	{
		if (value != null && !value.GetType().Equals(Type))
		{
			throw new ArgumentException("Binding delegate to event failed, mismatched delegate type", "value");
		}
		object obj = Target;
		if (obj != null)
		{
			Unbind(obj);
			if (value != null && value.GetType().Equals(Type))
			{
				handler = (Delegate)value;
				Bind(obj);
			}
		}
	}

	public override void SetValue<TValue>(TValue value)
	{
		SetValue((object)value);
	}

	protected virtual void Bind(object target)
	{
		if ((object)handler != null && eventInfo != null)
		{
			eventInfo.Add(target, handler);
		}
	}

	protected virtual void Unbind(object target)
	{
		if ((object)handler != null)
		{
			if (eventInfo != null)
			{
				eventInfo.Remove(target, handler);
			}
			handler = null;
		}
	}

	protected override void Dispose(bool disposing)
	{
		if (!disposed)
		{
			object obj = Target;
			if (eventInfo.IsStatic || obj != null)
			{
				Unbind(obj);
			}
			disposed = true;
			base.Dispose(disposing);
		}
	}
}
