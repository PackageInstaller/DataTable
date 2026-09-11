using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("渲染挂件遍历", 0)]
[Category("Render/Asset")]
[Description("对实体身上的渲染层挂件进行遍历,每次调用do并传出挂件,最后调用done")]
public class GetGhost : FlowControlNode
{
	private bool m_broken;

	private RenderPendant m_ghost;

	private FlowOutput m_doOutput;

	private FlowOutput m_doneOutput;

	private FlowOutput m_abnormalOutput;

	private ValueInput<int> m_agentIDVar;

	private ValueInput<int> m_pendantIDVar;

	public override void OnGraphStoped()
	{
		m_ghost = null;
	}

	protected override void RegisterPorts()
	{
		m_doOutput = AddFlowOutput("Do", "found");
		m_doneOutput = AddFlowOutput("Done", "unFound");
		m_abnormalOutput = AddFlowOutput("异常", "abnormal");
		m_agentIDVar = AddValueInput<int>("实体ID", "agentIDVar");
		m_pendantIDVar = AddValueInput<int>("渲染挂件索引", "pendantIDVar");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			m_ghost = null;
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(m_agentIDVar.GetValue());
			if (agent == null)
			{
				m_abnormalOutput.Call(f);
			}
			else
			{
				m_broken = false;
				f.breakCall = delegate
				{
					m_broken = true;
				};
				List<IPendant> pendants = agent.GetComponent<ComponentPendant>().GetPendants();
				int num = pendants.Count - 1;
				while (num >= 0 && !m_broken)
				{
					m_ghost = pendants[num] as RenderPendant;
					if (m_ghost != null)
					{
						m_doOutput.Call(f);
					}
					num--;
				}
				f.breakCall = null;
				m_doneOutput.Call(f);
			}
		});
		AddValueOutput("渲染挂件", "ghost", () => m_ghost);
	}
}
