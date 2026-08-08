using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("等于", 0)]
[Category("Logic Operators/Integers")]
[Description("两个数等于\\大于\\小于")]
public class IntEqualCondition : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput Equal = AddFlowOutput("等于");
		FlowOutput GreaterThan = AddFlowOutput("大于");
		FlowOutput LessThan = AddFlowOutput("小于");
		ValueInput<int> intAVar = AddValueInput<int>("IntA");
		ValueInput<int> intBVar = AddValueInput<int>("IntB");
		AddFlowInput("In", delegate(Flow f)
		{
			if (intAVar.GetValue() == intBVar.GetValue())
			{
				Equal.Call(f);
			}
			else if (intAVar.GetValue() > intBVar.GetValue())
			{
				GreaterThan.Call(f);
			}
			else if (intAVar.GetValue() < intBVar.GetValue())
			{
				LessThan.Call(f);
			}
		});
	}
}
