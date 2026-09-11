using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("子摇杆信标数据", 0)]
[Category("Logic/Abilities")]
[Description("技能子摇杆抬起时候,记录的信标数据")]
[ExposeAsDefinition]
public class ReadEntityBeacon : FlowControlNode
{
	private Int3 m_beaconPosition = Int3.zero;

	private Int3 m_beaconForward = Int3.forward;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID", "entityIDVar");
		ValueInput<bool> needResetVar = AddValueInput<bool>("是否重置", "needResetInput").SetDefaultAndSerializedValue(v: true);
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				error.Call(f);
			}
			else
			{
				m_beaconPosition = entityWithEntityID.entityBlackboard.var.mBeaconPosition;
				m_beaconForward = entityWithEntityID.entityBlackboard.var.mBeaconForward;
				if (needResetVar.GetValue())
				{
					entityWithEntityID.entityBlackboard.var.mBeaconPosition = Int3.zero;
					entityWithEntityID.entityBlackboard.var.mBeaconForward = Int3.forward;
				}
				output.Call(f);
			}
		});
		AddValueOutput("位置", "beaconPosition", () => m_beaconPosition);
		AddValueOutput("朝向", "beaconForward", () => m_beaconForward);
	}
}
