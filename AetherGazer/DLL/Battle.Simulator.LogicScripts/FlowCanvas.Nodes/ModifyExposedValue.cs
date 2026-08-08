using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改修正值(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("")]
public class ModifyExposedValue : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<long> m_addValueInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_addValueInput = AddValueInput<long>("增量", "addValue");
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
				simEntity.entityExposedValue.mValue += m_addValueInput.GetValue();
				m_out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
