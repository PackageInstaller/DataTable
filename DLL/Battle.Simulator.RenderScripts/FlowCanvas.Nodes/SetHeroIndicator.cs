using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置修正者指示器", 0)]
[Category("Render/UI")]
[Description("设置修正者指示器(脚下那个圆圈)")]
public class SetHeroIndicator : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<bool> enableInput = AddValueInput<bool>("是否开启");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager != null)
			{
				NAgent playerAgent = agentManager.GetPlayerAgent();
				if (playerAgent != null && playerAgent.ComponentTimeline != null && playerAgent.ComponentTimeline.m_componentIndicator != null)
				{
					if (enableInput.value)
					{
						playerAgent.ComponentTimeline.m_componentIndicator.ShowHeroIndicator();
					}
					else
					{
						playerAgent.ComponentTimeline.m_componentIndicator.HideHeroIndicator();
					}
				}
			}
			output.Call(f);
		});
	}
}
