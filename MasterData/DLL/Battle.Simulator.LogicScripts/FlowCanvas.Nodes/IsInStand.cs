using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否待机状态", 0)]
[Category("Logic/角色")]
[Description("判断当前是是否待机状态")]
public class IsInStand : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private FlowOutput m_true;

	private FlowOutput m_false;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_true = AddFlowOutput("待机中", "true");
		m_false = AddFlowOutput("不是待机", "false");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", delegate(Flow f)
		{
			if (!CommonProcessor.TryGetAliveRole(base.mSimContext, m_entityIDInput.GetValue(), out var simEntity))
			{
				m_error.Call(f);
			}
			else if (CommonProcessor.IsInStand(simEntity))
			{
				m_true.Call(f);
			}
			else
			{
				m_false.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
