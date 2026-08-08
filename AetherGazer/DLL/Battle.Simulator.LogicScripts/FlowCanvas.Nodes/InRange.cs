using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("在范围内", 0)]
[Category("Common/Control")]
[Description("在指定范围内")]
public class InRange : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput inRange = AddFlowOutput("True");
		FlowOutput outRange = AddFlowOutput("False");
		ValueInput<int> v = AddValueInput<int>("Value");
		ValueInput<int> a = AddValueInput<int>("Min");
		ValueInput<int> b = AddValueInput<int>("Max");
		AddFlowInput("In", delegate(Flow f)
		{
			int value = a.value;
			int value2 = b.value;
			int value3 = v.value;
			if (value3 >= value && value3 <= value2)
			{
				inRange.Call(f);
			}
			else
			{
				outRange.Call(f);
			}
		});
	}
}
