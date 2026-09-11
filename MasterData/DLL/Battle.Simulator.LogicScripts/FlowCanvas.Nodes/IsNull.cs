using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("IsNull", 0)]
[Category("Common/Control")]
[Description("是否为空")]
public class IsNull<T> : FlowControlNodeOfRender
{
	protected override void RegisterPorts()
	{
		ValueInput<T> value = AddValueInput<T>("value", "value");
		FlowOutput trueOut = AddFlowOutput("空", "true");
		FlowOutput falseOut = AddFlowOutput("非空", "false");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (value == null)
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
