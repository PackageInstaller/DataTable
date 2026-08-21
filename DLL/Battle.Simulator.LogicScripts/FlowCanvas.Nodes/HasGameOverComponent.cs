using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否有游戏结束组件", 0)]
[Category("Logic/Control")]
[Description("结束过程有游戏结束组件")]
public class HasGameOverComponent : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("有");
		FlowOutput falseOut = AddFlowOutput("无");
		AddFlowInput("", delegate(Flow f)
		{
			if (base.mSimContext.hasSEntityGameOver)
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
