using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置奥义队友相机时长(逻辑)", 0)]
[Category("Logic/Config")]
[Description("设置队友放奥义时候,相机观看的时长")]
public class SetSwitchCameraTime : FlowControlNode
{
	private ValueInput<int> m_EntityIDInput;

	private ValueInput<int> m_TimeInput;

	private FlowOutput m_Out;

	private FlowOutput m_Error;

	protected override void RegisterPorts()
	{
		m_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_TimeInput = AddValueInput<int>("时长(ms)", "time");
		m_Out = AddFlowOutput("Out", "output");
		m_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_EntityIDInput.GetValue());
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2227, m_TimeInput.value, 0L, 0L);
				m_Out.Call(f);
			}
			else
			{
				m_Error.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_EntityIDInput.GetValue());
	}
}
