using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("对实体造成伤害", 0)]
[Category("Logic/Config")]
[Description("对实体造成伤害, HERO-20942 加了无法对无敌对象造成伤害")]
public class HitEntityWithThrownTimelineData : FlowControlNode
{
	private ValueInput<int> m_attackerIDInput;

	private ValueInput<int> m_targetIDInput;

	private ValueInput<RoleType> m_roleType;

	private ValueInput<int> m_abilityID;

	private ValueInput<int> m_hitIndexInput;

	private ValueInput<int> m_percentInput;

	private ValueInput<int> m_affixIDInput;

	private ValueInput<int> m_affixLevelInput;

	private ValueInput<int> m_thrownIDInput;

	private FlowOutput m_error;

	private FlowOutput m_out;

	protected override void RegisterPorts()
	{
		m_attackerIDInput = AddValueInput<int>("攻击者ID", "casterID");
		m_targetIDInput = AddValueInput<int>("受击者ID", "targetID");
		m_roleType = AddValueInput<RoleType>("抛掷物阵营", "roleType").SetDefaultAndSerializedValue(RoleType.Enemy);
		m_abilityID = AddValueInput<int>("抛掷物TimelineID", "abilityID");
		m_hitIndexInput = AddValueInput<int>("第几个Hit(从0开始)", "hitIndex");
		m_percentInput = AddValueInput<int>("百分比", "percent");
		m_thrownIDInput = AddValueInput<int>("抛掷物唯一ID");
		m_error = AddFlowOutput("Error", "error");
		m_out = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			int value = m_abilityID.GetValue();
			int value2 = m_hitIndexInput.GetValue();
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_attackerIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				m_error.Call(f);
			}
			else
			{
				SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(m_targetIDInput.GetValue());
				if (entityWithEntityID2 == null || !entityWithEntityID2.hasEntityBlackboard)
				{
					m_error.Call(f);
				}
				else
				{
					Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(value);
					if (config == null)
					{
						m_error.Call(f);
					}
					else
					{
						HitCheckInfo hitCheckInfo = null;
						if (value2 >= config.HitTimeList.Count)
						{
							m_error.Call(f);
						}
						else if (AttributeProcessor.IsIgnoreHit(entityWithEntityID2))
						{
							m_error.Call(f);
						}
						else
						{
							hitCheckInfo = config.HitTimeList.get_Item(value2);
							int attributeID = CalculateDamageHelper.GetAttributeID(-1, entityWithEntityID);
							int attributeID2 = CalculateDamageHelper.GetAttributeID(-1, entityWithEntityID2);
							if (attributeID == -1 || attributeID2 == -1)
							{
								m_error.Call(f);
							}
							else
							{
								long damage = entityWithEntityID2.entityBlackboard.var.mMaxHP * m_percentInput.GetValue() / 100;
								DamageFormula.GetRootAbilityID(value, m_thrownIDInput.value, base.mSimContext, out var rootabilityID);
								damage = (int)FixedDamageFormula.CalDamage(damage, attributeID, attributeID2, value, rootabilityID);
								AttributeProcessor.GetAttributeWithIntName(attributeID2, 2176, out var baseValue, out var _, out var _);
								_ = baseValue;
								AbilitiesProcessor.AddEntityActionModifyHP(entityWithEntityID2, -(int)damage, DamageType.AffixDamage, value, entityWithEntityID.creationIndex, m_thrownIDInput.GetValue());
								AbilitiesProcessor.DoHitRecoverAction(entityWithEntityID.creationIndex, 0, value, 0, value2, hitCheckInfo, -entityWithEntityID2.entityPositon.mForward, -entityWithEntityID2.entityPositon.mForward, entityWithEntityID2);
								m_out.Call(f);
							}
						}
					}
				}
			}
		});
	}
}
