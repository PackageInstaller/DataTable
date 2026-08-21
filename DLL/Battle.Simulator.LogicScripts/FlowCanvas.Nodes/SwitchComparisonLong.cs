using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("比较大小(long)", 0)]
[Category("Common/Control")]
[Description("Branch the Flow based on a comparison between two comparable objects")]
public class SwitchComparisonLong : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput equal = AddFlowOutput("A = B", "==");
		FlowOutput notEqual = AddFlowOutput("A ≠ B", "!=");
		FlowOutput greater = AddFlowOutput("A > B", ">");
		FlowOutput less = AddFlowOutput("A < B", "<");
		ValueInput<long> a = AddValueInput<long>("A");
		ValueInput<long> b = AddValueInput<long>("B");
		AddFlowInput("In", delegate(Flow f)
		{
			long value = a.value;
			long value2 = b.value;
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
