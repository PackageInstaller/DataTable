using System;

namespace FlowCanvas;

public class FlowOutput : Port
{
	public FlowHandler pointer { get; private set; }

	public override Type type => typeof(Flow);

	public FlowOutput(FlowNode parent, string name, string ID)
		: base(parent, name, ID)
	{
	}

	public void Call(Flow f)
	{
		if (pointer != null && !base.parent.graph.isPaused)
		{
			f.ticks++;
			pointer(f);
		}
	}

	public void BindTo(FlowInput target)
	{
		pointer = target.pointer;
	}

	public void BindTo(FlowHandler call)
	{
		pointer = call;
	}

	public void UnBind()
	{
		pointer = null;
	}

	public void Append(FlowHandler action)
	{
		pointer = (FlowHandler)Delegate.Combine(pointer, action);
	}
}
