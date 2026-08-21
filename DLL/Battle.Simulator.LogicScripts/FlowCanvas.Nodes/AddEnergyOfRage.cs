using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增加怒气机制值(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("")]
public class AddEnergyOfRage : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<int> m_actionIDInput;

	private ValueInput<int> m_abilityIDInput;

	private FlowOutput m_succeeded;

	private FlowOutput m_failed;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_actionIDInput = AddValueInput<int>("后三位", "actionID");
		m_abilityIDInput = AddValueInput<int>("技能ID(过时)", "timelineID");
		m_succeeded = AddFlowOutput("成功", "succeeded");
		m_failed = AddFlowOutput("失败", "failed");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDInput.GetValue());
			if (entityWithEntityID == null)
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
				else if (!ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.ENTITY_CONFIG_ID).Melees.Contains(abilityID))
				{
					m_failed.Call(f);
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
						charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>(entityWithEntityID.ENTITY_CONFIG_ID);
						if (base.mSimContext.GetSimInterface().mOnPowerUpdate != null)
						{
							base.mSimContext.GetSimInterface().mOnPowerUpdate(entityWithEntityID.creationIndex, newValue, oldValue, maxValue, maxValue, (EnergyType)config.EnergyType);
						}
						m_succeeded.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
