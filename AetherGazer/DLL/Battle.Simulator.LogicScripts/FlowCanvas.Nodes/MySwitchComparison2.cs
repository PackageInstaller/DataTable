using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("比较大小(float)", 0)]
[Category("Common/Control")]
[Description("float型比较大小")]
public class MySwitchComparison2 : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput equal = AddFlowOutput("A = B", "==");
		FlowOutput notEqual = AddFlowOutput("A ≠ B", "!=");
		FlowOutput greater = AddFlowOutput("A > B", ">");
		FlowOutput less = AddFlowOutput("A < B", "<");
		ValueInput<float> a = AddValueInput<float>("A");
		ValueInput<float> b = AddValueInput<float>("B");
		AddFlowInput("In", delegate(Flow f)
		{
			float value = a.value;
			float value2 = b.value;
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
