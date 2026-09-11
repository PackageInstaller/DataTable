using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否是死亡(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("判断实体是否死亡")]
public class IsDeadOfEntity : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private FlowOutput m_true;

	private FlowOutput m_false;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_true = AddFlowOutput("True", "true");
		m_false = AddFlowOutput("False", "false");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (!AIProcessor.IsAIDeath(m_entityIDInput.GetValue()))
			{
				m_false.Call(f);
			}
			else
			{
				m_true.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
