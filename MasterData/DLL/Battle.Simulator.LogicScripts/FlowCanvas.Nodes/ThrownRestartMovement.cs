using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物重启移动", 0)]
[Category("Logic/抛掷物")]
[Description("抛掷物重新开始移动")]
public class ThrownRestartMovement : FlowControlNode
{
	private ValueInput<int> m_thrownIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_thrownIDInput = AddValueInput<int>("抛掷物ID", "thrownID");
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
				thrownState.mDontMovement = false;
				m_out.Call(f);
			}
		});
		AddValueOutput("抛掷物ID", "thrownID", () => m_thrownIDInput.GetValue());
	}
}
