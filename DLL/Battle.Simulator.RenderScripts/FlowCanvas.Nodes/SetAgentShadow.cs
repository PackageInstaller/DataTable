using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("显隐角色影子", 0)]
[Category("Render/Agent")]
[Description("隐藏/显示角色影子,注意,<color=red>使用本节点后如果遇到隐藏角色节点或timeline,会导致敌人、队友指示器失效。所以应当在显示隐藏之前恢复影子设置</color>")]
public class SetAgentShadow : FlowControlNode
{
	private ValueInput<int> m_agentIDInput;

	private ValueInput<bool> m_enableInput;

	private FlowOutput m_output;

	protected override void RegisterPorts()
	{
		m_agentIDInput = AddValueInput<int>("实体ID", "AgentID");
		m_enableInput = AddValueInput<bool>("是否显示", "Enable");
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
					componentTimeline.SetShadowActive(m_enableInput.value);
				}
			}
			m_output.Call(f);
		});
	}
}
