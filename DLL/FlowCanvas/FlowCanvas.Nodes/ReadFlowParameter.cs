using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Flow Controllers/Flow Convert")]
[Description("Reads a named parameter from the incomming Flow and returns it's value.\nFlow parameters can be set with a WriteFlowParameter node.\nFlow parameters are temporary variables that exist only in the context of the same Flow.")]
[ContextDefinedOutputs(new Type[] { typeof(Wild) })]
public class ReadFlowParameter<T> : FlowControlNode
{
	private T flowValue;

	protected override void RegisterPorts()
	{
		FlowOutput o = AddFlowOutput("Out");
		ValueInput<string> pName = AddValueInput<string>("Name");
		AddValueOutput("Value", () => flowValue);
		AddFlowInput("In", delegate(Flow f)
		{
			flowValue = f.ReadParameter<T>(pName.value);
			o.Call(f);
		});
	}
}
