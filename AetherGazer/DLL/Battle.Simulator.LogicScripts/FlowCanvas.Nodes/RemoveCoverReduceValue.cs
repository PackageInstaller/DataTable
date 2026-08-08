using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除修正值临时减少量(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("移除临时减少量,恢复使用初始化的减少量进行修正值调整")]
public class RemoveCoverReduceValue : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (!CommonProcessor.TryGetAliveRole(base.mSimContext, m_entityIDInput.GetValue(), out var simEntity))
			{
				m_error.Call(f);
			}
			else if (!simEntity.hasEntityExposedValue)
			{
				m_error.Call(f);
			}
			else
			{
				if (simEntity.hasEntityExposedValueCoverReducedValue)
				{
					simEntity.RemoveEntityExposedValueCoverReducedValue();
				}
				m_out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
