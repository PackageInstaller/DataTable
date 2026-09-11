using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否游戏结束(渲染)", 0)]
[Category("Render/UI")]
[Description("是否游戏结束(渲染)")]
public class IsGameOverRender : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
			if (worldStateManager == null)
			{
				trueOut.Call(f);
			}
			else if (worldStateManager.isGameOver)
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
