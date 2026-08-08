using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到Buff渲染ID", 0)]
[Category("Logic/Config")]
[Description("根据ID和类型获取配置信息")]
public class GetBuffRenderID : FlowControlNode
{
	private ValueInput<int> m_buffConfigID;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private int m_buffRenderID;

	protected override void RegisterPorts()
	{
		m_buffConfigID = AddValueInput<int>("配置ID", "buffConfigID");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			m_buffRenderID = 0;
			public_buff config = ConfigHelper.GetInstance().GetConfig<public_buff>(m_buffConfigID.GetValue());
			if (config == null)
			{
				m_error.Call(f);
			}
			else
			{
				m_buffRenderID = config.EffectId;
				m_out.Call(f);
			}
		});
		AddValueOutput("渲染ID", "renderID", () => m_buffRenderID);
	}
}
