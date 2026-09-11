using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到修正值(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("")]
public class GetExposedValue : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private long m_exposedValue;

	private long m_exposedValueMaxValue;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "intput", delegate(Flow f)
		{
			m_exposedValue = 0L;
			m_exposedValueMaxValue = 0L;
			if (!CommonProcessor.TryGetAliveRole(base.mSimContext, m_entityIDInput.GetValue(), out var simEntity))
			{
				m_error.Call(f);
			}
			else
			{
				if (simEntity.hasEntityExposedValue)
				{
					m_exposedValue = simEntity.entityExposedValue.mValue;
					m_exposedValueMaxValue = simEntity.entityExposedValue.mMaxValue;
				}
				m_out.Call(f);
			}
		});
		AddValueOutput("修正值", "exposedValue", () => m_exposedValue);
		AddValueOutput("修正值最大值", "exposedValueMaxValue", () => m_exposedValueMaxValue);
	}
}
