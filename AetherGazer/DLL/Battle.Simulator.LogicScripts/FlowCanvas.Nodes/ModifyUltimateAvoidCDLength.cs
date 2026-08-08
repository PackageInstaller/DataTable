using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改闪避效果CD上限(逻辑)", 0)]
[Category("Logic/Attribute/闪避效果CD")]
[Description("对实体持有的闪避效果CD上限值进行增加,传入负数为减少")]
public class ModifyUltimateAvoidCDLength : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<int> m_addValueInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private int m_ultimateAvoidCD;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "EntityIDInput");
		m_addValueInput = AddValueInput<int>("增量", "addValueInput");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (AttributeProcessor.TryModifyUltimateAvoidCD(base.mSimContext, m_entityIDInput.GetValue(), m_addValueInput.GetValue(), out m_ultimateAvoidCD))
			{
				m_out.Call(f);
			}
			else
			{
				m_error.Call(f);
			}
		});
		AddValueOutput("实体ID", "EntityID", () => m_entityIDInput.GetValue());
		AddValueOutput("闪避效果CD", "UltimateAvoidCD", () => m_ultimateAvoidCD);
	}
}
