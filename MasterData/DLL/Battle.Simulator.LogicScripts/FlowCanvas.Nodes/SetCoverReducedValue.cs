using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置修正值临时减少量(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("在临时减少量存在期间,会使用该值进行修正值的修改")]
public class SetCoverReducedValue : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<long> m_newValueInput;

	private ValueInput<int> m_keepTime;

	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_newValueInput = AddValueInput<long>("新值", "newValue");
		m_keepTime = AddValueInput<int>("持续时间(毫秒)", "keepTime");
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
				if (simEntity.hasEntityExposedValueCoverReducedValue)
				{
					simEntity.ReplaceEntityExposedValueCoverReducedValue(m_newValueInput.GetValue(), m_keepTime.GetValue());
				}
				else
				{
					simEntity.AddEntityExposedValueCoverReducedValue(m_newValueInput.GetValue(), m_keepTime.GetValue());
				}
				m_out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
