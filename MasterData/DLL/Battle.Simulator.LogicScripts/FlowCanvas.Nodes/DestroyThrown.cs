using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("销毁抛掷物实体(过时)", 0)]
[Category("Logic/抛掷物")]
[Description("将指定id的抛掷物加入待销毁列表，随后发出抛掷物销毁事件。无论抛掷物是否待销毁都会发出")]
public class DestroyThrown : FlowControlNode
{
	private ValueInput<int> m_thrownIDInput;

	private FlowOutput m_output;

	protected override void RegisterPorts()
	{
		m_thrownIDInput = AddValueInput<int>("抛掷物ID", "thrownID");
		m_output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "intput", delegate(Flow f)
		{
			if (ThrownProcessor.TryGetThrown(base.mSimContext, m_thrownIDInput.value, out var thrownState))
			{
				ThrownProcessor.DestoryThrown(base.mSimContext, thrownState);
			}
			m_output.Call(f);
		});
		AddValueOutput("抛掷物ID", "thrownID", () => m_thrownIDInput.GetValue());
	}
}
