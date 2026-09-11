using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到奥义队友相机时长(逻辑)", 0)]
[Category("Logic/Config")]
[Description("得到队友放奥义时候,相机观看的时长,例如用于界面隐藏、无敌等\n后三位现在用不到了，仅传递值，可以不填")]
public class GetSwitchCameraTime : FlowControlNode
{
	private ValueInput<int> m_EntityIDInput;

	private ValueInput<int> m_ActionIDInput;

	private FlowOutput m_Out;

	private FlowOutput m_Error;

	private long m_Length;

	protected override void RegisterPorts()
	{
		m_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_ActionIDInput = AddValueInput<int>("后三位(过时)", "actionID");
		m_Out = AddFlowOutput("Out", "output");
		m_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_EntityIDInput.GetValue());
			m_Length = 0L;
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				m_Error.Call(f);
			}
			else
			{
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2227, out m_Length, out var _, out var _);
				m_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_EntityIDInput.GetValue());
		AddValueOutput("后三位", "actionID", () => m_ActionIDInput.GetValue());
		AddValueOutput("时长", "length", () => (int)m_Length);
	}
}
