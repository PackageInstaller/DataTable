using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("渲染挂件推送操作码", 0)]
[Category("Render/Asset")]
[Description("向实体身上的渲染层挂件推送操作码")]
public class PushCommandToPendant : FlowControlNode
{
	private ValueInput<int> m_agentIDVar;

	private ValueInput<int> m_codeVar;

	private FlowOutput m_output;

	protected override void RegisterPorts()
	{
		m_output = AddFlowOutput("Out", "output");
		m_agentIDVar = AddValueInput<int>("实体ID", "agentID");
		m_codeVar = AddValueInput<int>("操作码", "codeVar");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (RenderPendant.AgentPushCommandToGhost != null)
			{
				RenderPendant.AgentPushCommandToGhost(m_agentIDVar.GetValue(), m_codeVar.GetValue());
			}
			m_output.Call(f);
		});
		AddValueOutput("实体ID", "agentID", () => m_agentIDVar.GetValue());
	}
}
