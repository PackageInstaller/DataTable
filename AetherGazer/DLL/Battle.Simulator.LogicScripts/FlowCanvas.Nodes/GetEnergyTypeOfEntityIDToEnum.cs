using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到机制值类型(枚举)(逻辑)", 0)]
[Category("Logic/Config")]
[Description("获取机制值类型")]
public class GetEnergyTypeOfEntityIDToEnum : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private EnergyType m_energyType;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDInput.GetValue());
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
					m_out.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
		AddValueOutput("机制值类型", "energyType", () => m_energyType);
	}
}
