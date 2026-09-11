using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否是机制值类型(逻辑)", 0)]
[Category("Logic/Config")]
[Description("是否是指定类型的机制值")]
public class IsEnergyTypeByEntityID : FlowControlNode
{
	private ValueInput<int> _entityIDInput;

	private ValueInput<EnergyType> m_energyTypeInput;

	private FlowOutput m_true;

	private FlowOutput m_flase;

	private FlowOutput m_error;

	private EnergyType m_energyType;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_energyTypeInput = AddValueInput<EnergyType>("机制值类型", "energyType");
		m_true = AddFlowOutput("True", "true");
		m_flase = AddFlowOutput("False", "false");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_entityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityConfig)
			{
				m_error.Call(f);
			}
			else
			{
				charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>(entityWithEntityID.ENTITY_CONFIG_ID);
				if (config == null)
				{
					m_error.Call(f);
				}
				else
				{
					m_energyType = (EnergyType)config.EnergyType;
					if (m_energyType == m_energyTypeInput.GetValue())
					{
						m_true.Call(f);
					}
					else
					{
						m_flase.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => _entityIDInput.GetValue());
		AddValueOutput("配置表中机制值类型", "energyType", () => m_energyType);
	}
}
