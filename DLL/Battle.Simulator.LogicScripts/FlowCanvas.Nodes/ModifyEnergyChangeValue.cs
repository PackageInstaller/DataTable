using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改机制变更值(逻辑)", 0)]
[Category("Logic/Attribute/机制变更值")]
[Description("对现有的机制值进行增加,传入负数为减少")]
public class ModifyEnergyChangeValue : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<int> m_timelineIDInput;

	private ValueInput<int> m_addValueInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private int m_energyChangeValue;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "EntityIDInput");
		m_timelineIDInput = AddValueInput<int>("TimelineID", "timelineIDInput");
		m_addValueInput = AddValueInput<int>("增量", "addValueInput");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (!CommonProcessor.TryGetEntityWithBlackboardByEntityID(base.mSimContext, m_entityIDInput.GetValue(), out var _))
			{
				m_error.Call(f);
			}
			else if (!AttributeProcessor.TryModifyEnergyChangeValue(base.mSimContext, m_entityIDInput.GetValue(), m_timelineIDInput.GetValue(), m_addValueInput.GetValue(), out m_energyChangeValue))
			{
				m_error.Call(f);
			}
			else
			{
				m_out.Call(f);
			}
		});
		AddValueOutput("实体ID", "EntityID", () => m_entityIDInput.GetValue());
		AddValueOutput("TimelineID", "timelineID", () => m_timelineIDInput.GetValue());
		AddValueOutput("机制变更值", "energyChangeValue", () => m_energyChangeValue);
	}
}
