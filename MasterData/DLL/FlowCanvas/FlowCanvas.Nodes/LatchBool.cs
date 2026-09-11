using System;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;

namespace FlowCanvas.Nodes;

[Name("Latch Condition", 0)]
[Category("Flow Controllers/Flow Convert")]
[Description("Convert a Flow signal to boolean value")]
[ContextDefinedOutputs(new Type[] { typeof(bool) })]
[DeserializeFrom(new string[] { "FlowCanvas.Nodes.Latch" })]
public class LatchBool : FlowControlNode
{
	private bool latched;

	protected override void RegisterPorts()
	{
		FlowOutput o = AddFlowOutput("Out");
		AddFlowInput("True", delegate(Flow f)
		{
			latched = true;
			o.Call(f);
		});
		AddFlowInput("False", delegate(Flow f)
		{
			latched = false;
			o.Call(f);
		});
		AddValueOutput("Value", () => latched);
	}
}
