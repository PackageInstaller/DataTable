using System;

namespace FlowCanvas.Nodes;

[Obsolete]
public class StaticCodeEvent : StaticCodeEventBase
{
	private FlowOutput o;

	private Action pointer;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		pointer = Call;
		base.eventInfo.AddEventHandler(null, pointer);
	}

	public override void OnGraphStoped()
	{
		if (!string.IsNullOrEmpty(eventName) && base.eventInfo != null)
		{
			base.eventInfo.RemoveEventHandler(null, pointer);
		}
	}

	private void Call()
	{
		o.Call(default(Flow));
	}

	protected override void RegisterPorts()
	{
		if (!string.IsNullOrEmpty(eventName))
		{
			o = AddFlowOutput(eventName);
		}
	}
}
[Obsolete]
public class StaticCodeEvent<T> : StaticCodeEventBase
{
	private FlowOutput o;

	private Action<T> pointer;

	private T eventValue;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		pointer = Call;
		base.eventInfo.AddEventHandler(null, pointer);
	}

	public override void OnGraphStoped()
	{
		if (!string.IsNullOrEmpty(eventName) && base.eventInfo != null)
		{
			base.eventInfo.RemoveEventHandler(null, pointer);
		}
	}

	private void Call(T value)
	{
		eventValue = value;
		o.Call(default(Flow));
	}

	protected override void RegisterPorts()
	{
		if (!string.IsNullOrEmpty(eventName))
		{
			o = AddFlowOutput(eventName);
			AddValueOutput("Value", () => eventValue);
		}
	}
}
