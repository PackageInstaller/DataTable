using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到闪避效果CD上限(逻辑)", 0)]
[Category("Logic/Attribute/闪避效果CD")]
[Description("得到实体ID持有的闪避效果CD")]
public class GetUltimateAvoidCD : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private int m_ultimateAvoidCD;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityIDInput");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (AttributeProcessor.TryGetUltimateAvoidCD(base.mSimContext, m_entityIDInput.GetValue(), out m_ultimateAvoidCD))
			{
				m_out.Call(f);
			}
			else
			{
				m_error.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
		AddValueOutput("闪避效果CD", "ultimateAvoidCD", () => m_ultimateAvoidCD);
	}
}
