using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("消耗机制值(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("")]
public class ConsumeEnergy : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<int> m_actionIDInput;

	private FlowOutput m_succeeded;

	private FlowOutput m_failed;

	private FlowOutput m_undefined;

	private FlowOutput m_error;

	private int m_energyTypeValue;

	private int m_energyChangeValue;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_actionIDInput = AddValueInput<int>("后三位", "actionID");
		m_succeeded = AddFlowOutput("成功", "succeeded");
		m_failed = AddFlowOutput("失败", "failed");
		m_undefined = AddFlowOutput("未定义类型", "undefined");
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
				if (config == null)
				{
					m_error.Call(f);
				}
				else
				{
					int abilityID = 0;
					if (!CommonProcessor.TryGetAbilityID(entityWithEntityID, m_actionIDInput.GetValue(), out abilityID))
					{
						m_error.Call(f);
					}
					else
					{
						m_energyChangeValue = 0;
						if (!AttributeProcessor.TryGetEnergyChangeValue(entityWithEntityID, abilityID, out m_energyChangeValue, out var _))
						{
							m_error.Call(f);
						}
						else if (m_energyChangeValue >= 0)
						{
							m_error.Call(f);
						}
						else
						{
							m_energyTypeValue = config.EnergyType;
							EnergyType energyTypeValue = (EnergyType)m_energyTypeValue;
							switch (energyTypeValue)
							{
							case EnergyType.None:
								m_undefined.Call(f);
								return;
							case EnergyType.Mark:
							{
								long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(entityWithEntityID.entityBlackboard.var.mAttributeID, 1108, AttributeCalcType.Add);
								if (DRandom.Random(1000u) < finalAttributeByAttributeID)
								{
									m_energyChangeValue++;
								}
								break;
							}
							default:
								m_undefined.Call(f);
								return;
							case EnergyType.Rage:
							case EnergyType.Power:
							case EnergyType.Tune:
								break;
							}
							if (!AttributeProcessor.TryAddPowerValue(entityWithEntityID, m_energyChangeValue * 1000, out var newValue, out var oldValue))
							{
								m_error.Call(f);
							}
							else
							{
								AttributeProcessor.TryGetEnergyMaxValue(entityWithEntityID, out var maxValue);
								if (base.mSimContext.GetSimInterface().mOnPowerUpdate != null)
								{
									base.mSimContext.GetSimInterface().mOnPowerUpdate(entityWithEntityID.creationIndex, newValue, oldValue, maxValue, maxValue, energyTypeValue);
								}
								m_succeeded.Call(f);
							}
						}
					}
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
		AddValueOutput("机制值类型", "energyType", () => m_energyTypeValue);
		AddValueOutput("机制变更值", "energyChangeValue", () => m_energyChangeValue);
	}
}
