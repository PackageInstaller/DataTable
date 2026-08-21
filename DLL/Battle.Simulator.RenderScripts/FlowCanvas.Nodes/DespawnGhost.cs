using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("渲染挂件销毁", 0)]
[Category("Render/Asset")]
[Description("销毁渲染层挂件")]
public class DespawnGhost : FlowControlNode
{
	private ValueInput<int> m_agentIDVar;

	private ValueInput<int> m_pendantIDVar;

	private FlowOutput m_output;

	protected override void RegisterPorts()
	{
		m_agentIDVar = AddValueInput<int>("实体ID", "agentIDVar");
		m_pendantIDVar = AddValueInput<int>("渲染挂件索引", "pendantIDVar");
		m_output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			NAgent agent = ((BattleScene)NScene.GetCurrentScene()).GetAgentManager().GetAgent(m_agentIDVar.GetValue());
			if (agent != null)
			{
				RecyclePendant(agent, m_pendantIDVar.GetValue());
			}
			m_output.Call(f);
		});
		AddValueOutput("实体ID", "agentID", () => m_agentIDVar.GetValue());
	}

	public static void RecyclePendant(NAgent agent, int pendanteID = 0)
	{
		if (agent == null)
		{
			return;
		}
		List<IPendant> pendants = agent.gameObject.GetComponent<ComponentPendant>().GetPendants();
		for (int num = pendants.Count - 1; num >= 0; num--)
		{
			RenderPendant renderPendant = pendants[num] as RenderPendant;
			if (renderPendant != null && (pendanteID == 0 || renderPendant.PendantID == pendanteID))
			{
				renderPendant.Finish();
				pendants.RemoveAt(num);
			}
		}
	}
}
