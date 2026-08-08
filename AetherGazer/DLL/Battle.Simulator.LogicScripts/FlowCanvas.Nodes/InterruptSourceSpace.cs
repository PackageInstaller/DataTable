using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("中断修正模式(逻辑)", 0)]
[Category("Logic/SourceSpace")]
[Description("判断传入的实体ID是否是Break实体")]
public class InterruptSourceSpace : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			EntitySourceSpace entitySourceSpace = base.mSimContext.entitySourceSpace;
			if (entitySourceSpace != null && entitySourceSpace.Enable && entitySourceSpace.SourceSpaceKeepTime > 0)
			{
				base.mSimContext.entitySourceSpace.SourceSpaceKeepTime = 0;
				m_out.Call(f);
			}
			else
			{
				m_error.Call(f);
			}
		});
		AddValueOutput("中断的实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
