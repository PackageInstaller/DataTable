using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置修正值(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("")]
public class SetExposedValue : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<long> m_newValueInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_newValueInput = AddValueInput<long>("新值", "newValue");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (!CommonProcessor.TryGetAliveRole(base.mSimContext, m_entityIDInput.GetValue(), out var simEntity))
			{
				m_error.Call(f);
			}
			else if (!simEntity.hasEntityExposedValue)
			{
				m_error.Call(f);
			}
			else
			{
				simEntity.entityExposedValue.mValue = m_newValueInput.GetValue();
				m_out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
