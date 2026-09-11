using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否充满修正值(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("")]
public class IsFullOfExposedValue : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private FlowOutput _full;

	private FlowOutput _unfull;

	private FlowOutput m_error;

	private long m_exposedValue;

	private long m_exposedValueMaxValue;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		_full = AddFlowOutput("充满", "full");
		_unfull = AddFlowOutput("未充满", "unfull");
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
					if (m_exposedValue >= m_exposedValueMaxValue)
					{
						_full.Call(f);
						return;
					}
				}
				_unfull.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.value);
		AddValueOutput("修正值", "exposedValue", () => m_exposedValue);
		AddValueOutput("修正值最大值", "exposedValueMaxValue", () => m_exposedValueMaxValue);
	}
}
