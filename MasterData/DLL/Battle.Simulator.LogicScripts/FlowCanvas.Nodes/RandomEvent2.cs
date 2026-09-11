using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("随机", 0)]
[Category("Logic/Random")]
[Description("给一个概率,返回是否发生,p为0到100的整数")]
public class RandomEvent2 : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> rangeVar = AddValueInput<int>("范围(1-100)", "rangeVar");
		FlowOutput successOutput = AddFlowOutput("成功", "successOutput");
		FlowOutput faildOutput = AddFlowOutput("失败", "faildOutput");
		AddFlowInput("In", "Input", delegate(Flow f)
		{
			if (FlowCanvasLogicFuncHelper.RandomEvent(rangeVar.GetValue()))
			{
				successOutput.Call(f);
			}
			else
			{
				faildOutput.Call(f);
			}
		});
	}
}
