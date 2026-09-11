using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否有战斗评分(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("检查实体上是否有指定来源和类型的战斗评分")]
public class HasCombatScore : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<int> m_sourceIDInput;

	private ValueInput<EnCombatScoreModifiedType> m_typeInput;

	private FlowOutput m_has;

	private FlowOutput m_none;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_sourceIDInput = AddValueInput<int>("来源ID", "sourceID");
		m_typeInput = AddValueInput<EnCombatScoreModifiedType>("类型", "type");
		m_has = AddFlowOutput("有", "has");
		m_none = AddFlowOutput("无", "none");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			switch (HasCombatScoreBase.HasCombatScore(base.mSimContext, m_entityIDInput.GetValue(), m_sourceIDInput.GetValue(), (int)m_typeInput.GetValue()))
			{
			case EnReturnHasOrNone.None:
				m_none.Call(f);
				break;
			case EnReturnHasOrNone.Has:
				m_has.Call(f);
				break;
			case EnReturnHasOrNone.Error:
				m_error.Call(f);
				break;
			}
			m_error.Call(f);
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
