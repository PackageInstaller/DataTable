using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("概率事件(精简版)", 0)]
[Category("Logic/Random")]
[Description("给一个概率,返回是否发生,p为0到100的整数")]
public class MyRandomEvent : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> p = AddValueInput<int>("p");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("In", delegate(Flow f)
		{
			if (DRandom.Random(100u) < p.value)
			{
				f.Call(trueOut);
			}
			else
			{
				f.Call(falseOut);
			}
		});
	}
}
