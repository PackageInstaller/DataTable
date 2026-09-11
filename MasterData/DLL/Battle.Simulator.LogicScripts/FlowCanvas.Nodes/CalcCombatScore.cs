using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("计算战斗评分(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("计算战斗评分的过程,放在图中避免规则变化导致重新打core")]
public class CalcCombatScore : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private int m_lastCombatScore;

	private int m_combatScore;

	public static void PostCombatScoreRankUpdateEvent(SimContext mSimContext, int entityID, int current, int last)
	{
		EnCombatScoreRank enCombatScoreRank = EnCombatScoreRank.None;
		EnCombatScoreRank enCombatScoreRank2 = EnCombatScoreRank.None;
		for (int i = 0; i < 6; i++)
		{
			CombatScore config = ConfigHelper.GetInstance().GetConfig<CombatScore>(i);
			if (config != null)
			{
				int floorValue = config.FloorValue;
				if (current >= floorValue)
				{
					enCombatScoreRank2 = (EnCombatScoreRank)i;
				}
				if (last >= floorValue)
				{
					enCombatScoreRank = (EnCombatScoreRank)i;
				}
			}
		}
		if (enCombatScoreRank != enCombatScoreRank2)
		{
			CombatScoreRankUpdateEvent evt = CombatScoreRankUpdateEvent.Claim(entityID, (int)enCombatScoreRank2, (int)enCombatScoreRank);
			mSimContext.PostEvent(evt);
		}
	}

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (CommonProcessor.TryGetAliveRole(base.mSimContext, m_entityIDInput.GetValue(), out var simEntity))
			{
				if (!simEntity.hasEntityActionModifyCombatScore)
				{
					m_error.Call(f);
				}
				else
				{
					m_lastCombatScore = simEntity.entityBlackboard.var.mCombatScore;
					m_combatScore = m_lastCombatScore;
					int max = 20000;
					CombatScore config = ConfigHelper.GetInstance().GetConfig<CombatScore>(6);
					if (config != null)
					{
						max = config.FloorValue;
					}
					int num = 0;
					List<ModifyCombatScoreInfo> mModifyInfoList = simEntity.entityActionModifyCombatScore.mModifyInfoList;
					for (int i = 0; i < mModifyInfoList.Count; i++)
					{
						ModifyCombatScoreInfo value = mModifyInfoList[i];
						if (value.mState == EntityActionStatus.E_ACTIVE)
						{
							num += value.mAddValue;
							if (value.mModifyTypeEnumValue == 3)
							{
								value.mState = EntityActionStatus.E_DELAY;
							}
							else
							{
								value.mState = EntityActionStatus.E_SUCCESS;
							}
							int mCombatScore = simEntity.entityBlackboard.var.mCombatScore;
							int num2 = mCombatScore + value.mAddValue;
							simEntity.entityBlackboard.var.mCombatScore = num2;
							PostCombatScoreRankUpdateEvent(base.mSimContext, m_entityIDInput.GetValue(), num2, mCombatScore);
						}
						mModifyInfoList[i] = value;
					}
					m_combatScore += num;
					m_combatScore = IntMath.Clamp(m_combatScore, 0, max);
					simEntity.entityBlackboard.var.mCombatScore = m_combatScore;
					if (num == 0 || (num < 0 && m_combatScore == 0))
					{
						m_out.Call(f);
					}
					else
					{
						CombatScoreValueUpdateEvent evt = CombatScoreValueUpdateEvent.Claim(m_entityIDInput.GetValue(), m_combatScore, m_lastCombatScore, num);
						base.mSimContext.PostEvent(evt);
						m_out.Call(f);
					}
				}
			}
		});
	}
}
