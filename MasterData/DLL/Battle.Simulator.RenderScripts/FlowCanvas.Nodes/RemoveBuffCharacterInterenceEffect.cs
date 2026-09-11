using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除Buff角色干涉特效(渲染)", 0)]
[Category("Render/Buff/Buff特效/角色干涉特效")]
[Description("移除Buff角色干涉特效(渲染)")]
public class RemoveBuffCharacterInterenceEffect : FlowControlNode
{
	private FlowOutput m_output;

	private FlowOutput m_error;

	private ValueInput<int> m_agentIDInput;

	private ValueInput<int> m_buffCreationIndexInput;

	protected override void RegisterPorts()
	{
		m_output = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		m_agentIDInput = AddValueInput<int>("实体ID", "m_agentIDInput");
		m_buffCreationIndexInput = AddValueInput<int>("创建ID", "m_buffCreationIndexInput");
		AddFlowInput("In", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				m_error.Call(f);
			}
			else
			{
				NAgent agent = battleScene.GetAgentManager().GetAgent(m_agentIDInput.GetValue());
				if (agent == null)
				{
					m_error.Call(f);
				}
				else
				{
					ComponentTimeline componentTimeline = agent.ComponentTimeline;
					if (componentTimeline == null)
					{
						m_error.Call(f);
					}
					else
					{
						componentTimeline.RemoveBuffCharacterInterenceEffect(m_buffCreationIndexInput.GetValue());
						m_output.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", "agentID", () => m_agentIDInput.GetValue());
		AddValueOutput("创建ID", "buffCreationIndex", () => m_buffCreationIndexInput.GetValue());
	}
}
