using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("显示角色(包括影子)", 0)]
[Category("Render/Agent")]
[Description("显示角色,包括影子")]
public class EnableAgentRenders : FlowControlNode
{
	private ValueInput<int> m_agentIDInput;

	private FlowOutput m_output;

	protected override void RegisterPorts()
	{
		m_agentIDInput = AddValueInput<int>("实体ID", "AgentID");
		AddValueOutput("实体ID", "AgentID", () => m_agentIDInput.GetValue());
		ValueInput<bool> onlyEffectDisableTarget = AddValueInput<bool>("只影响已经隐藏的对象");
		m_output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(m_agentIDInput.GetValue());
			if (agent != null)
			{
				ComponentTimeline componentTimeline = agent.ComponentTimeline;
				if (componentTimeline != null && (!onlyEffectDisableTarget.value || componentTimeline.IsInDisableRender()))
				{
					componentTimeline.EnableRenders();
				}
			}
			m_output.Call(f);
		});
	}
}
