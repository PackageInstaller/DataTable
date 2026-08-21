using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置机制变更值(逻辑)", 0)]
[Category("Logic/Attribute/机制变更值")]
[Description("直接将现有的机制值设置为传入的新值")]
public class SetEnergyChangeValue : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<int> m_timelineIDInput;

	private ValueInput<int> m_newValue;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private int m_energyChangeValue;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityIDInput");
		m_timelineIDInput = AddValueInput<int>("TimelineID", "TimelineIDInput");
		m_newValue = AddValueInput<int>("新值", "newValue");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (AttributeProcessor.TrySetEnergyChangeValue(base.mSimContext, m_entityIDInput.GetValue(), m_timelineIDInput.GetValue(), m_newValue.GetValue(), out m_energyChangeValue))
			{
				m_out.Call(f);
			}
			else
			{
				m_error.Call(f);
			}
		});
		AddValueOutput("实体ID", "EntityID", () => m_entityIDInput.GetValue());
		AddValueOutput("TimelineID", "timelineID", () => m_timelineIDInput.GetValue());
		AddValueOutput("机制变更值", "energyChangeValue", () => m_energyChangeValue);
	}
}
