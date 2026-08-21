using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("能量变更开关技能(逻辑)(过时)", 0)]
[Category("Logic/Abilities")]
[Description("")]
public class EnableSkillByEnergyChange : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<int> m_curEnergyInput;

	private ValueInput<int> _OldEnergyInput;

	private FlowOutput m_out;

	private FlowOutput m_undefined;

	private FlowOutput m_error;

	private int m_energyTypeValue;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_curEnergyInput = AddValueInput<int>("当前值", "curEnergyValue");
		_OldEnergyInput = AddValueInput<int>("原值", "oldEnergyValue");
		m_out = AddFlowOutput("Out", "output");
		m_undefined = AddFlowOutput("未定义类型", "undefined");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "intput", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityConfig)
			{
				m_error.Call(f);
			}
			else
			{
				RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.entityConfig.mId);
				if (config == null)
				{
					m_error.Call(f);
				}
				else
				{
					charactor_param config2 = ConfigHelper.GetInstance().GetConfig<charactor_param>(entityWithEntityID.entityConfig.mId);
					if (config2 == null)
					{
						m_error.Call(f);
					}
					else
					{
						m_energyTypeValue = config2.EnergyType;
						switch ((EnergyType)m_energyTypeValue)
						{
						case EnergyType.None:
							m_undefined.Call(f);
							break;
						default:
							m_undefined.Call(f);
							break;
						case EnergyType.Rage:
						case EnergyType.Power:
						case EnergyType.Mark:
						case EnergyType.Tune:
						{
							m_curEnergyInput.GetValue();
							for (int i = 0; i < config.AllSkills.Count; i++)
							{
								int num = config.AllSkills.get_Item(i);
								int energyChangeValue = 0;
								if (AttributeProcessor.TryGetEnergyChangeValue(entityWithEntityID, num, out energyChangeValue, out var _))
								{
									bool num2 = _OldEnergyInput.GetValue() + energyChangeValue >= 0;
									bool flag = m_curEnergyInput.GetValue() + energyChangeValue >= 0;
									if (num2 != flag)
									{
										entityWithEntityID.entityBlackboard.var.EnableAbility(num, flag);
									}
								}
							}
							m_out.Call(f);
							break;
						}
						}
					}
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
		AddValueOutput("机制值类型", "energyType", () => m_energyTypeValue);
		AddValueOutput("当前值", "curEnergyValue", () => m_curEnergyInput.GetValue());
	}
}
