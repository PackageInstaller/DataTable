using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("隐身特效开关", 0)]
[Category("Render/CharacterEffect")]
[Description("隐身特效开关")]
public class CharacterEffectDithering : FlowControlNodeOfRender
{
	private ValueInput<int> m_agentIDInput;

	private FlowOutput m_output;

	protected override void RegisterPorts()
	{
		m_agentIDInput = AddValueInput<int>("实体ID", "AgentID");
		ValueInput<bool> activeInput = AddValueInput<bool>("隐身", "active");
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
					componentTimeline.SetHideEffect(activeInput.value);
				}
			}
			m_output.Call(f);
		});
	}
}
