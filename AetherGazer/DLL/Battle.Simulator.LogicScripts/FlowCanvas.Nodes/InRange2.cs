using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否在范围内\"(]\"", 0)]
[Category("Common/Control")]
[Description("在指定范围内,不包含左边界,包含右边界")]
public class InRange2 : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput inRange = AddFlowOutput("True", "inRange");
		FlowOutput outRange = AddFlowOutput("False", "outRange");
		ValueInput<int> v = AddValueInput<int>("Value", "v");
		ValueInput<int> a = AddValueInput<int>("Min", "a");
		ValueInput<int> b = AddValueInput<int>("Max", "b");
		AddFlowInput("In", delegate(Flow f)
		{
			int value = a.value;
			int value2 = b.value;
			int value3 = v.value;
			if (value3 > value && value3 <= value2)
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
