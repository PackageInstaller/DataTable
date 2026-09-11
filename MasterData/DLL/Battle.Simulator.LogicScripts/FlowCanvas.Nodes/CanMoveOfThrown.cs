using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物是否可以移动", 0)]
[Category("Logic/抛掷物")]
[Description("判断抛掷物是否可以移动")]
public class CanMoveOfThrown : FlowControlNode
{
	private ValueInput<int> m_thrwonIDInput;

	private FlowOutput m_true;

	private FlowOutput m_false;

	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_thrwonIDInput = AddValueInput<int>("抛掷物ID", "thrownID");
		m_true = AddFlowOutput("True", "true");
		m_false = AddFlowOutput("False", "false");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			ThrownState thrownState = null;
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, m_thrwonIDInput.GetValue(), out thrownState))
			{
				m_error.Call(f);
			}
			else if (thrownState.mDontMovement)
			{
				m_false.Call(f);
			}
			else
			{
				m_true.Call(f);
			}
		});
		AddValueOutput("抛掷物ID", "thrownID", () => m_thrwonIDInput.GetValue());
	}
}
