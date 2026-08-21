using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否反向(渲染)", 0)]
[Category("Render/UI")]
[Description("用于判断角色是否反向行进")]
public class IsInReversed : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput falseOut = AddFlowOutput("正向", "false");
		FlowOutput trueOut = AddFlowOutput("反向", "true");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (null == battleScene)
			{
				errorOut.Call(f);
			}
			else
			{
				WorldStateManager worldSatetManager = battleScene.GetWorldSatetManager();
				if (worldSatetManager == null)
				{
					errorOut.Call(f);
				}
				else if (worldSatetManager.m_isInReversed)
				{
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
		});
	}
}
