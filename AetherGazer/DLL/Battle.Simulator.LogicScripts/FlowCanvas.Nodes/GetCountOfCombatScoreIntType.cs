using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到数量(战斗评分)(int)(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("根据传入的类型得到战斗评分对应的个数,传入【None】则得到当前战斗评分总个数")]
public class GetCountOfCombatScoreIntType : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<int> m_typeInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private int m_count;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_typeInput = AddValueInput<int>("类型", "type");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "intput", delegate(Flow f)
		{
			if (!GetCountOfCombatScoreTypeBase.GetCountOfCombatScoreType(base.mSimContext, m_entityIDInput.GetValue(), out m_count, m_typeInput.GetValue()))
			{
				m_error.Call(f);
			}
			else
			{
				m_out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
		AddValueOutput("数量", "count", () => m_count);
	}
}
