using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到机制值类型(黑板ID)", 0)]
[Category("Logic/Config")]
[Description("根据ID和类型获取配置信息")]
public class GetEnergyTypeByAttributeID : FlowControlNode
{
	private ValueInput<int> m_attributeIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private EnergyType m_energyType;

	protected override void RegisterPorts()
	{
		m_attributeIDInput = AddValueInput<int>("黑板ID", "attributeID");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			m_energyType = EnergyType.None;
			AttributeProcessor.GetAttributeWithIntName(m_attributeIDInput.GetValue(), 2189, out var baseValue, out var _, out var _);
			if (baseValue == 0L)
			{
				m_error.Call(f);
			}
			else
			{
				charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>((int)baseValue);
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
		AddValueOutput("机制值类型", "energyType", () => m_energyType);
	}
}
