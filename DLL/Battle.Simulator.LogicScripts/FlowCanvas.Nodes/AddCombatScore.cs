using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增加战斗评分(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("增加战斗评分,包含了增益部分")]
public class AddCombatScore : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<int> m_sourceIDInput;

	private ValueInput<EnCombatScoreModifiedType> m_addTypeInput;

	private ValueInput<int> m_addValueInput;

	private ValueInput<EntityActionStatus> m_activeStateInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_sourceIDInput = AddValueInput<int>("来源实体ID", "sourceID");
		m_addTypeInput = AddValueInput<EnCombatScoreModifiedType>("改变类型", "addType");
		m_addValueInput = AddValueInput<int>("增量", "addValue");
		m_activeStateInput = AddValueInput<EntityActionStatus>("激活状态", "activeState").SetDefaultAndSerializedValue(EntityActionStatus.E_ACTIVE);
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "intput", delegate(Flow f)
		{
			if (!AddCombatScoreBase.AddCombatScore(base.mSimContext, m_entityIDInput.GetValue(), m_addValueInput.GetValue(), (int)m_addTypeInput.GetValue(), m_sourceIDInput.GetValue(), m_activeStateInput.GetValue()))
			{
				m_error.Call(f);
			}
			else
			{
				m_out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
