using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否是Break状态(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("")]
public class IsExposedBreakState : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private FlowOutput m_true;

	private FlowOutput m_false;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_true = AddFlowOutput("True", "true");
		m_false = AddFlowOutput("False", "false");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDInput.GetValue());
			if (entityWithEntityID == null)
			{
				m_error.Call(f);
			}
			else if (entityWithEntityID.hasEntityExposedValueBreak)
			{
				m_true.Call(f);
			}
			else
			{
				m_false.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
