using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Switch Condition", 0)]
[Category("Flow Controllers/Switchers")]
[Description("Branch the Flow based on a conditional boolean value")]
[ContextDefinedInputs(new Type[] { typeof(bool) })]
public class SwitchBool : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<bool> selector = AddValueInput<bool>("Condition");
		FlowOutput caseTrue = AddFlowOutput("True");
		FlowOutput caseFalse = AddFlowOutput("False");
		AddFlowInput("In", delegate(Flow f)
		{
			f.Call(selector.value ? caseTrue : caseFalse);
		});
	}
}
