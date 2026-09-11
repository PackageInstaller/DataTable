using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否是Break实体(逻辑)", 0)]
[Category("Logic/SourceSpace")]
[Description("判断传入的实体ID是否是Break实体")]
public class IsBreakEntityID : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private FlowOutput m_true;

	private FlowOutput m_false;

	private FlowOutput m_error;

	private int m_breakEntityID;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_true = AddFlowOutput("True", "true");
		m_false = AddFlowOutput("False", "false");
		m_error = AddFlowOutput("非间层中", "error");
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
				if (m_breakEntityID != 0 && m_breakEntityID == m_entityIDInput.GetValue())
				{
					m_true.Call(f);
				}
				else
				{
					m_false.Call(f);
				}
			}
		});
		AddValueOutput("传入的实体ID", "entityIDInput", () => m_entityIDInput.GetValue());
		AddValueOutput("Break实体ID", "breakEntityID", () => m_breakEntityID);
	}
}
