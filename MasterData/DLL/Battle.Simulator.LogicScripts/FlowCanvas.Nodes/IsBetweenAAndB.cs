using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否在区间内", 0)]
[Category("Logic/Math")]
[Description("是否在区间内, (A, B)")]
public class IsBetweenAAndB : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> valueInput = AddValueInput<int>("值");
		ValueInput<int> AInput = AddValueInput<int>("A");
		ValueInput<int> BInput = AddValueInput<int>("B");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput AOut = AddFlowOutput("等于A");
		FlowOutput BOut = AddFlowOutput("等于B");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			int value = valueInput.value;
			int value2 = AInput.value;
			int value3 = BInput.value;
			if (value > value2 && value < value3)
			{
				trueOut.Call(f);
			}
			else if (value == value2)
			{
				AOut.Call(f);
			}
			else if (value == value3)
			{
				BOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
