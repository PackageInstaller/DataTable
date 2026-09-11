using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增加豆子机制值(仅技能)(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("")]
public class AddEnergyOfMarkOnlySkill : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<int> m_thrownIDInput;

	private ValueInput<int> m_actionIDInput;

	private ValueInput<int> m_abilityIDInput;

	private FlowOutput m_succeeded;

	private FlowOutput m_failed;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_actionIDInput = AddValueInput<int>("后三位", "actionID");
		m_thrownIDInput = AddValueInput<int>("抛掷物ID(选填)", "thrownID");
		m_abilityIDInput = AddValueInput<int>("技能ID(过时)", "timelineID");
		m_succeeded = AddFlowOutput("成功", "succeeded");
		m_failed = AddFlowOutput("失败", "failed");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityConfig)
			{
				m_error.Call(f);
			}
			else
			{
				charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>(entityWithEntityID.entityConfig.mId);
				if (config.EnergyType != 3)
				{
					m_error.Call(f);
				}
				else
				{
					int abilityID = m_abilityIDInput.GetValue();
					if (m_thrownIDInput.GetValue() < 0)
					{
						if (!ThrownProcessor.TryGetThrown(base.mSimContext, m_thrownIDInput.GetValue(), out var thrownState))
						{
							m_error.Call(f);
							return;
						}
						abilityID = thrownState.mCreatedRootTimelineID;
					}
					if (abilityID == 0 && !CommonProcessor.TryGetAbilityID(entityWithEntityID, m_actionIDInput.GetValue(), out abilityID))
					{
						m_error.Call(f);
					}
					else
					{
						AbilityConfig config2 = ConfigHelper.GetInstance().GetConfig<AbilityConfig>(abilityID);
						if (config2 != null && config2.OriginAbility != 0)
						{
							abilityID = config2.OriginAbility;
						}
						if (!ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.ENTITY_CONFIG_ID).AllSkills.Contains(abilityID))
						{
							m_error.Call(f);
						}
						else
						{
							int index = -1;
							if (!ConfigProcessor.TryGetSkillIndex(entityWithEntityID, abilityID, out index))
							{
								m_error.Call(f);
							}
							else
							{
								switch (index)
								{
								case 0:
									index = 100020101;
									break;
								case 1:
									index = 100020201;
									break;
								case 2:
									index = 100020301;
									break;
								default:
									m_error.Call(f);
									return;
								}
								if (AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, index, out var baseValue, out var _, out var _) && baseValue == 1)
								{
									m_failed.Call(f);
								}
								else
								{
									int energyChangeValue = 0;
									if (!AttributeProcessor.TryGetEnergyChangeValue(entityWithEntityID, abilityID, out energyChangeValue, out var _))
									{
										m_error.Call(f);
									}
									else if (energyChangeValue <= 0)
									{
										m_error.Call(f);
									}
									else
									{
										long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(entityWithEntityID.entityBlackboard.var.mAttributeID, 1107, AttributeCalcType.Add);
										if (DRandom.Random(1000u) < finalAttributeByAttributeID)
										{
											energyChangeValue++;
										}
										if (!AttributeProcessor.TryAddPowerValue(entityWithEntityID, energyChangeValue * 1000, out var newValue, out var oldValue))
										{
											m_error.Call(f);
										}
										else
										{
											AttributeProcessor.TryGetEnergyMaxValue(entityWithEntityID, out var maxValue);
											if (base.mSimContext.GetSimInterface().mOnPowerUpdate != null)
											{
												base.mSimContext.GetSimInterface().mOnPowerUpdate(entityWithEntityID.creationIndex, newValue, oldValue, maxValue, maxValue, (EnergyType)config.EnergyType);
											}
											AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, index, 1L, 0L, 0L);
											m_succeeded.Call(f);
										}
									}
								}
							}
						}
					}
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
