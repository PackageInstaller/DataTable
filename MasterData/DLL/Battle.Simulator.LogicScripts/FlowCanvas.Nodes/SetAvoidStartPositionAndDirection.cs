using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[庚辰]设置闪避起点坐标", 0)]
[Category("Logic/角色定制/庚辰")]
[Description("庚辰闪避机制设置起点坐标")]
public class SetAvoidStartPositionAndDirection : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> directionInput = AddValueInput<int>("朝向(1前-1后)", "direction");
		ValueInput<Int3> posInput = AddValueInput<Int3>("坐标", "pos");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107630505, directionInput.value, 0L, 0L);
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107630502, posInput.value.x, 0L, 0L);
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107630503, posInput.value.y, 0L, 0L);
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107630504, posInput.value.z, 0L, 0L);
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
	}
}
