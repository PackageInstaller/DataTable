using System;

namespace FlowCanvas;

public class FlowInput : Port
{
	public FlowHandler pointer { get; private set; }

	public override Type type => typeof(Flow);

	public FlowInput(FlowNode parent, string name, string ID, FlowHandler pointer)
		: base(parent, name, ID)
	{
		this.pointer = pointer;
	}
}
