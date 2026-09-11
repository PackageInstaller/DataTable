using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("渲染挂件播放Timeline", 0)]
[Category("Render/事件")]
[Description("渲染层挂件播放传入的TimelineID对应的Timeline")]
public class PendantPlayTimeline : FlowControlNode
{
	private ValueInput<int> m_timelineIDVar;

	private ValueInput<RenderPendant> m_renderPendantVar;

	private FlowOutput m_output;

	protected override void RegisterPorts()
	{
		m_renderPendantVar = AddValueInput<RenderPendant>("渲染挂件", "PendantVar");
		m_timelineIDVar = AddValueInput<int>("TimelineID", "timelineIDVar");
		m_output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (m_renderPendantVar != null)
			{
				m_renderPendantVar.GetValue().PlayTimeline(m_timelineIDVar.GetValue());
			}
			m_output.Call(f);
		});
		AddValueOutput("渲染挂件", "pendant", () => m_renderPendantVar.GetValue());
	}
}
