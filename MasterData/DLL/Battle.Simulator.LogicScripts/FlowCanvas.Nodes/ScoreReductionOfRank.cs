using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到战斗评分扣分值(随等级)(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("得到战斗评分的扣分值,随等级返回不同的值")]
public class ScoreReductionOfRank : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private int m_reduceValue;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			m_reduceValue = 0;
			if (!CommonProcessor.TryGetAliveRole(base.mSimContext, m_entityIDInput.GetValue(), out var simEntity))
			{
				m_error.Call(f);
			}
			else
			{
				int mCombatScore = simEntity.entityBlackboard.var.mCombatScore;
				CombatScore combatScore = null;
				for (int i = 0; i < 6; i++)
				{
					combatScore = ConfigHelper.GetInstance().GetConfig<CombatScore>(i);
					if (combatScore != null)
					{
						int floorValue = combatScore.FloorValue;
						if (mCombatScore < floorValue)
						{
							break;
						}
						m_reduceValue = combatScore.ScoreReduction;
					}
				}
				m_out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
		AddValueOutput("增量", "addValue", () => m_reduceValue);
	}
}
