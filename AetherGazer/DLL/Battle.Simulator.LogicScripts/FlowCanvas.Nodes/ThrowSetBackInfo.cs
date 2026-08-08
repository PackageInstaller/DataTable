using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物限时到点", 0)]
[Category("Logic/抛掷物")]
[Description("抛掷物重新开始移动")]
public class ThrowSetBackInfo : FlowControlNode
{
	private ValueInput<int> m_thrownIDInput;

	private ValueInput<int> m_backTimeInput;

	private ValueInput<Int3> m_targetPositionInput;

	private ValueInput<int> m_targetIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_thrownIDInput = AddValueInput<int>("抛掷物ID", "thrownID");
		m_backTimeInput = AddValueInput<int>("返程耗时(毫秒)", "backTime");
		m_targetPositionInput = AddValueInput<Int3>("目标坐标", "targetPosition");
		m_targetIDInput = AddValueInput<int>("目标ID", "targetID");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			ThrownState thrownState = null;
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, m_thrownIDInput.GetValue(), out thrownState))
			{
				m_error.Call(f);
			}
			else
			{
				thrownState.mBackSpeed = m_backTimeInput.GetValue();
				thrownState.mBackTargetPosition = m_targetPositionInput.GetValue();
				thrownState.mTargetID = m_targetIDInput.GetValue();
				m_out.Call(f);
			}
		});
		AddValueOutput("抛掷物ID", "thrownID", () => m_thrownIDInput.GetValue());
	}
}
