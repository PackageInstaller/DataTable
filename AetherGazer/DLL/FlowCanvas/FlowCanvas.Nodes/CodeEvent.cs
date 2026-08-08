using System;

namespace FlowCanvas.Nodes;

[Obsolete]
public class CodeEvent : CodeEventBase
{
	private FlowOutput o;

	private Action pointer;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		pointer = Call;
		base.eventInfo.AddEventHandler(targetComponent, pointer);
	}

	public override void OnGraphStoped()
	{
		if (!string.IsNullOrEmpty(eventName) && base.eventInfo != null)
		{
			base.eventInfo.RemoveEventHandler(target.value.GetComponent(targetType), pointer);
		}
	}

	protected override void RegisterPorts()
	{
		if (!string.IsNullOrEmpty(eventName))
		{
			o = AddFlowOutput(eventName);
		}
	}

	private void Call()
	{
		o.Call(default(Flow));
	}
}
[Obsolete]
public class CodeEvent<T> : CodeEventBase
{
	private FlowOutput o;

	private Action<T> pointer;

	private T eventValue;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		pointer = Call;
		base.eventInfo.AddEventHandler(targetComponent, pointer);
	}

	public override void OnGraphStoped()
	{
		if (!string.IsNullOrEmpty(eventName) && base.eventInfo != null)
		{
			base.eventInfo.RemoveEventHandler(target.value.GetComponent(targetType), pointer);
		}
	}

	private void Call(T eventValue)
	{
		this.eventValue = eventValue;
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
