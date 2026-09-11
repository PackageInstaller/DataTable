using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增加Buff镜头模糊(渲染)", 0)]
[Category("Render/Buff/Buff特效/镜头模糊")]
[Description("增加Buff镜头模糊特效")]
public class AddBuffCameraRadialBlurEffect : FlowControlNode
{
	private FlowOutput m_out;

	private FlowOutput m_error;

	private ValueInput<int> m_agentIDInput;

	private ValueInput<int> m_buffIDInput;

	private ValueInput<float> m_radialBlurScaleInput;

	protected override void RegisterPorts()
	{
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		m_agentIDInput = AddValueInput<int>("实体ID", "agentIDInput");
		m_buffIDInput = AddValueInput<int>("创建ID", "BuffIDInput");
		m_radialBlurScaleInput = AddValueInput<float>("强度", "radialBlurScaleInput");
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
						componentTimeline.AddBuffCameraRadialBlurEffect(m_buffIDInput.GetValue(), m_radialBlurScaleInput.GetValue());
						m_out.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", "agentID", () => m_agentIDInput.GetValue());
		AddValueOutput("创建ID", "BuffCreationIndex", () => m_buffIDInput.GetValue());
	}
}
