using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("隐藏角色(包括影子)", 0)]
[Category("Render/Agent")]
[Description("隐藏角色,包括影子")]
public class DisableAgentRenders : FlowControlNode
{
	private ValueInput<int> m_agentIDInput;

	private FlowOutput m_output;

	protected override void RegisterPorts()
	{
		m_agentIDInput = AddValueInput<int>("实体ID", "AgentID");
		AddValueOutput("实体ID", "AgentID", () => m_agentIDInput.GetValue());
		m_output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(m_agentIDInput.GetValue());
			if (agent != null)
			{
				ComponentTimeline componentTimeline = agent.ComponentTimeline;
				if (componentTimeline != null)
				{
					componentTimeline.DisableRenders();
				}
			}
			m_output.Call(f);
		});
	}
}
