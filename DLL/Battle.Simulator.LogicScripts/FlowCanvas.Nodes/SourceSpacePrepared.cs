using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修正模式进入准备完成(逻辑)", 0)]
[Category("Logic/SourceSpace")]
[Description("")]
public class SourceSpacePrepared : FlowControlNode
{
	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "intput", delegate(Flow f)
		{
			if (!CommonProcessor.IsInSourceSpaceState(base.mSimContext))
			{
				m_error.Call(f);
			}
			else
			{
				EntitySourceSpace entitySourceSpace = base.mSimContext.entitySourceSpace;
				if (entitySourceSpace == null)
				{
					m_error.Call(f);
				}
				else
				{
					entitySourceSpace.SourceSpaceDelayTime = 0;
					m_out.Call(f);
				}
			}
		});
	}
}
