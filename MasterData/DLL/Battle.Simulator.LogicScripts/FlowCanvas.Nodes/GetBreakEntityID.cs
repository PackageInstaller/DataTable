using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到Break实体ID(逻辑)", 0)]
[Category("Logic/SourceSpace")]
[Description("得到Break的实体ID")]
public class GetBreakEntityID : FlowControlNode
{
	private int m_breakEntityID;

	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			m_breakEntityID = 0;
			if (!base.mSimContext.entitySourceSpace.Enable)
			{
				m_error.Call(f);
			}
			else
			{
				m_breakEntityID = base.mSimContext.entitySourceSpace.BreakEntityID;
				m_out.Call(f);
			}
		});
		AddValueOutput("Break实体ID", "breakEntityID", () => m_breakEntityID);
	}
}
