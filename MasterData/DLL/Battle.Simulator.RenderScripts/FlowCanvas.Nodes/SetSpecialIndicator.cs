using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置特殊指示器", 0)]
[Category("Render/UI")]
[Description("设置特殊指示器")]
public class SetSpecialIndicator : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentInput = AddValueInput<int>("agentID");
		ValueInput<string> pathInput = AddValueInput<string>("指示器路径", "path");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager != null)
			{
				NAgent playerAgent = agentManager.GetPlayerAgent();
				if (playerAgent != null && playerAgent.ComponentTimeline != null && playerAgent.ComponentTimeline.m_componentIndicator != null)
				{
					playerAgent.ComponentTimeline.m_componentIndicator.AddSpecialIndicator(agentInput.value, pathInput.value);
				}
			}
			output.Call(f);
		});
	}
}
