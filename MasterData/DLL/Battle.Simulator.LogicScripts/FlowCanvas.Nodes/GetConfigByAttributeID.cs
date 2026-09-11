using Google.Protobuf;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到配置信息(黑板ID)", 0)]
[Category("Logic/Config")]
[Description("根据ID和类型获取配置信息")]
public class GetConfigByAttributeID<T> : FlowControlNode where T : IMessage
{
	private ValueInput<int> m_attributeIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private T m_config;

	protected override void RegisterPorts()
	{
		m_attributeIDInput = AddValueInput<int>("黑板ID", "attributeID");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			AttributeProcessor.GetAttributeWithIntName(m_attributeIDInput.GetValue(), 2189, out var baseValue, out var _, out var _);
			if (baseValue == 0L)
			{
				m_error.Call(f);
			}
			else
			{
				m_config = ConfigHelper.GetInstance().GetConfig<T>((int)baseValue);
			}
		});
		AddValueOutput("配置", "config", () => m_config);
	}
}
