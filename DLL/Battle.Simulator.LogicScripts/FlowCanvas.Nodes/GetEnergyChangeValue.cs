using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到机制变更值(逻辑)", 0)]
[Category("Logic/Attribute/机制变更值")]
[Description("得到机制变化值,只会得到整数部分")]
public class GetEnergyChangeValue : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<int> m_timelineIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private int m_energyChangeValue;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityIDInput");
		m_timelineIDInput = AddValueInput<int>("TimelineID", "timelineIDInput");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (AttributeProcessor.TryGetEnergyChangeValue(base.mSimContext, m_entityIDInput.GetValue(), m_timelineIDInput.GetValue(), out m_energyChangeValue, out var _))
			{
				m_out.Call(f);
			}
			else
			{
				m_error.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
		AddValueOutput("TimelineID", "timelineID", () => m_timelineIDInput.GetValue());
		AddValueOutput("机制变更值", "energyChangeValue", () => m_energyChangeValue);
	}
}
