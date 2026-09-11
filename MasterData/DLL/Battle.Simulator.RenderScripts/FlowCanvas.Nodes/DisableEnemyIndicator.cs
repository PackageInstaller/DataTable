using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("开关敌人指示器", 0)]
[Category("Render/UI")]
[Description("开关敌人指示器")]
public class DisableEnemyIndicator : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<bool> disableInput = AddValueInput<bool>("是否关闭敌方指示器");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager != null)
			{
				NAgent playerAgent = agentManager.GetPlayerAgent();
				if (playerAgent != null && playerAgent.ComponentTimeline != null && playerAgent.ComponentTimeline.m_componentIndicator != null)
				{
					playerAgent.ComponentTimeline.m_componentIndicator.disableEnemyIndicator = disableInput.value;
				}
			}
			output.Call(f);
		});
	}
}
