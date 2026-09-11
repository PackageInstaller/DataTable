using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除trigger特殊指示器", 0)]
[Category("Render/UI")]
[Description("移除trigger特殊指示器")]
public class RemoveLocalIndicator : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentInput = AddValueInput<int>("triggerID");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager != null)
			{
				NAgent playerAgent = agentManager.GetPlayerAgent();
				if (playerAgent != null && playerAgent.ComponentTimeline != null && playerAgent.ComponentTimeline.m_componentIndicator != null)
				{
					playerAgent.ComponentTimeline.m_componentIndicator.RemoveLocalIndicator(agentInput.value);
				}
			}
			output.Call(f);
		});
	}
}
