using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("销毁抛掷物实体", 0)]
[Category("Logic/抛掷物")]
[Description("销毁指定id的抛掷物，若抛掷物已处于待销毁状态，则不会再次发出事件")]
public class DestroyThrown2 : FlowNode
{
	private ValueInput<int> m_thrownIDInput;

	private FlowOutput m_output;

	protected override void RegisterPorts()
	{
		m_thrownIDInput = AddValueInput<int>("抛掷物ID", "thrownID");
		m_output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "intput", delegate(Flow f)
		{
			if (ThrownProcessor.TryGetThrown(base.mSimContext, m_thrownIDInput.value, out var thrownState) && !CommonProcessor.GetWorldState().mDestoryThrowns.Contains(thrownState.mCreationIndex))
			{
				ThrownProcessor.DestoryThrown(base.mSimContext, thrownState);
			}
			m_output.Call(f);
		});
		AddValueOutput("抛掷物ID", "thrownID", () => m_thrownIDInput.GetValue());
	}
}
