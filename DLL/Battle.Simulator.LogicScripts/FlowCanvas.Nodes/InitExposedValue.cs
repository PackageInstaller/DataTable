using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("初始化修正值(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("")]
public class InitExposedValue : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<long> m_valueInput;

	private ValueInput<long> m_maxValueInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private ValueInput<long> m_reducedValueInput;

	private ValueInput<int> m_delayInput;

	private ValueInput<int> m_tickInput;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_valueInput = AddValueInput<long>("当前值", "curValue").SetDefaultAndSerializedValue(0L);
		m_maxValueInput = AddValueInput<long>("最大值", "maxValue");
		m_reducedValueInput = AddValueInput<long>("减少量", "reducedValue");
		m_delayInput = AddValueInput<int>("延迟(毫秒)", "delay");
		m_tickInput = AddValueInput<int>("间隔(毫秒)", "tick");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (!CommonProcessor.TryGetAliveRole(base.mSimContext, m_entityIDInput.GetValue(), out var simEntity))
			{
				m_error.Call(f);
			}
			else
			{
				if (simEntity.hasEntityExposedValueBreak)
				{
					simEntity.RemoveEntityExposedValueBreak();
				}
				if (simEntity.hasEntityExposedValue)
				{
					simEntity.ReplaceEntityExposedValue(m_valueInput.GetValue(), m_maxValueInput.GetValue(), m_reducedValueInput.GetValue(), m_tickInput.GetValue(), m_delayInput.GetValue(), 0u, newMManualEnter: false);
				}
				else
				{
					simEntity.AddEntityExposedValue(m_valueInput.GetValue(), m_maxValueInput.GetValue(), m_reducedValueInput.GetValue(), m_tickInput.GetValue(), m_delayInput.GetValue(), 0u, newMManualEnter: false);
				}
				m_out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
