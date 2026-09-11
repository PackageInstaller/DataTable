using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除特殊指示器", 0)]
[Category("Render/UI")]
[Description("移除特殊指示器")]
public class RemoveSpecialIndicator : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentInput = AddValueInput<int>("agentID");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager != null)
			{
				NAgent playerAgent = agentManager.GetPlayerAgent();
				if (playerAgent != null && playerAgent.ComponentTimeline != null && playerAgent.ComponentTimeline.m_componentIndicator != null)
				{
					playerAgent.ComponentTimeline.m_componentIndicator.RemoveSpecialIndicator(agentInput.value);
				}
			}
			output.Call(f);
		});
	}
}
