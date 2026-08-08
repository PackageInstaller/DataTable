using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("清除Buff镜头模糊(渲染)", 0)]
[Category("Render/Buff/Buff特效/镜头模糊")]
[Description("清除实体上的全部buff控制的镜头模糊特效(Render),但不会清除buff,仅仅是清除播放器控制的效果")]
public class ClearBuffCameraAbberationList : FlowControlNode
{
	private FlowOutput m_out;

	private FlowOutput m_error;

	private ValueInput<int> m_agentIDInput;

	protected override void RegisterPorts()
	{
		m_out = AddFlowOutput("Out", "Out");
		m_error = AddFlowOutput("Error", "error");
		m_agentIDInput = AddValueInput<int>("实体ID", "agentIDInput");
		AddFlowInput("In", "input", delegate(Flow f)
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
						componentTimeline.ClearBuffCameraAbberationList();
						m_out.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", "agentID", () => m_agentIDInput.GetValue());
	}
}
