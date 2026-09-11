using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("初始化奥义队友相机时长(逻辑)", 0)]
[Category("Logic/Config")]
[Description("初始化队友放奥义时候,相机观看的时长")]
public class InitSwitchCameraTime : FlowControlNode
{
	private ValueInput<int> m_EntityIDInput;

	private FlowOutput m_Out;

	private FlowOutput m_Error;

	protected override void RegisterPorts()
	{
		m_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_Out = AddFlowOutput("Out", "output");
		m_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_EntityIDInput.GetValue());
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				if (!ConfigHelper.GetInstance().TryGetConfig<UniqueSkill>(entityWithEntityID.ENTITY_CONFIG_ID, out var config))
				{
					m_Error.Call(f);
				}
				else
				{
					AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2227, config.TeammateQTECameraDuration * CommonProcessor.GetConfigInterval(), 0L, 0L);
					m_Out.Call(f);
				}
			}
			else
			{
				m_Error.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_EntityIDInput.GetValue());
	}
}
