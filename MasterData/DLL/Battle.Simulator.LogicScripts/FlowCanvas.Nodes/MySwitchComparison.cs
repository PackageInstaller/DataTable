using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("比较大小(int)", 0)]
[Category("Common/Control")]
[Description("Branch the Flow based on a comparison between two comparable objects")]
public class MySwitchComparison : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput equal = AddFlowOutput("A = B", "==");
		FlowOutput notEqual = AddFlowOutput("A ≠ B", "!=");
		FlowOutput greater = AddFlowOutput("A > B", ">");
		FlowOutput less = AddFlowOutput("A < B", "<");
		ValueInput<int> a = AddValueInput<int>("A");
		ValueInput<int> b = AddValueInput<int>("B");
		AddFlowInput("In", delegate(Flow f)
		{
			int value = a.value;
			int value2 = b.value;
			if (value == value2)
			{
				equal.Call(f);
			}
			else
			{
				notEqual.Call(f);
			}
			if (value > value2)
			{
				greater.Call(f);
			}
			if (value < value2)
			{
				less.Call(f);
			}
		});
	}
}
