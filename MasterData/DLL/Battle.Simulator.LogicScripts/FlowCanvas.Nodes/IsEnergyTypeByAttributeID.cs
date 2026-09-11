using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否是机制值类型(黑板ID)", 0)]
[Category("Logic/Config")]
[Description("是否是指定类型的机制值")]
public class IsEnergyTypeByAttributeID : FlowControlNode
{
	private ValueInput<int> m_attributeIDInput;

	private ValueInput<EnergyType> m_energyTypeInput;

	private FlowOutput m_true;

	private FlowOutput m_flase;

	private FlowOutput m_error;

	private EnergyType m_energyType;

	private long m_roleID;

	protected override void RegisterPorts()
	{
		m_attributeIDInput = AddValueInput<int>("黑板ID", "attributeID");
		m_energyTypeInput = AddValueInput<EnergyType>("机制值类型", "energyType");
		m_true = AddFlowOutput("True", "true");
		m_flase = AddFlowOutput("False", "false");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			AttributeProcessor.GetAttributeWithIntName(m_attributeIDInput.GetValue(), 2189, out m_roleID, out var _, out var _);
			if (m_roleID == 0L)
			{
				m_error.Call(f);
			}
			else
			{
				charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>((int)m_roleID);
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
		AddValueOutput("黑板ID", "attributeID", () => m_attributeIDInput.GetValue());
		AddValueOutput("实体类型ID", "roleID", () => (int)m_roleID);
		AddValueOutput("配置表中机制值类型", "energyType", () => m_energyType);
	}
}
