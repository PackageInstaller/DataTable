using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增加Buff角色干涉特效(渲染)", 0)]
[Category("Render/Buff/Buff特效/角色干涉特效")]
[Description("增加Buff角色干涉特效(渲染)")]
public class AddBuffCharacterInterenceEffect : FlowControlNode
{
	private FlowOutput m_output;

	private FlowOutput m_error;

	private ValueInput<int> m_agentIDInput;

	private ValueInput<int> m_buffCreationIndexInput;

	private ValueInput<float> m_intensityInput;

	private ValueInput<int> m_orderInput;

	protected override void RegisterPorts()
	{
		m_output = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		m_agentIDInput = AddValueInput<int>("实体ID", "m_agentIDInput");
		m_buffCreationIndexInput = AddValueInput<int>("创建ID", "m_buffCreationIndexInput");
		m_intensityInput = AddValueInput<float>("强度", "m_intensityInput");
		m_orderInput = AddValueInput<int>("等级(播最大的)", "orderInput").SetDefaultAndSerializedValue(1);
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
						componentTimeline.AddBuffCharacterInterenceEffect(m_buffCreationIndexInput.GetValue(), m_intensityInput.GetValue(), m_orderInput.GetValue());
						m_output.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", "agentID", () => m_agentIDInput.GetValue());
		AddValueOutput("创建ID", "buffCreationIndex", () => m_buffCreationIndexInput.GetValue());
	}
}
