using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到修正模式总伤害值(渲染)", 0)]
[Category("Render/SourceSpace")]
[Description("得到修正模式中累积受到的全部伤害(仅减少值记录)")]
public class GetSourceSpaceDamageOfAgent : FlowControlNode
{
	private ValueInput<int> m_agentIDIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private long m_damage;

	protected override void RegisterPorts()
	{
		m_agentIDIDInput = AddValueInput<int>("实体ID", "agentID");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(m_agentIDIDInput.GetValue());
			if (agent == null)
			{
				m_error.Call(f);
			}
			else
			{
				m_damage = (agent.Blackboard as BBHumanoid).m_NextSimFrameData.mSourceSpaceDamage;
				m_out.Call(f);
			}
		});
		AddValueOutput("实体ID", "agentID", () => m_agentIDIDInput.GetValue());
		AddValueOutput("伤害值", "damage", () => m_damage);
	}
}
