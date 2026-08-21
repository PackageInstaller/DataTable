using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增加能量机制值(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("此处的能量是机制值的一种")]
public class AddEnergyOfPower : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<int> m_actionIDInput;

	private ValueInput<int> m_abilityIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_actionIDInput = AddValueInput<int>("后三位", "actionID").SetDefaultAndSerializedValue(999);
		m_abilityIDInput = AddValueInput<int>("技能ID(过时)", "timelineID");
		m_out = AddFlowOutput("Out", "output");
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
				if (config.EnergyType != 2)
				{
					m_error.Call(f);
				}
				else
				{
					int abilityID = m_abilityIDInput.GetValue();
					if (abilityID == 0 && !CommonProcessor.TryGetAbilityID(entityWithEntityID, m_actionIDInput.GetValue(), out abilityID))
					{
						m_error.Call(f);
					}
					else
					{
						int energyChangeValue = 0;
						int newValue;
						int oldValue;
						if (!AttributeProcessor.TryGetEnergyChangeValue(entityWithEntityID, abilityID, out energyChangeValue, out var fractionalPart))
						{
							m_error.Call(f);
						}
						else if (!AttributeProcessor.TryAddPowerValue(entityWithEntityID, energyChangeValue * 1000 + fractionalPart, out newValue, out oldValue))
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
							m_out.Call(f);
						}
					}
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
