using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改速度(非曲线移动)(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("修改非曲线移动下的角色速度")]
public class ModifyEntitySpeed : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> speedInput = AddValueInput<int>("速度(毫米)", "speed");
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
				entityWithEntityID.entityBlackboard.var.mMaxSpeed = new VFactor(speedInput.value, 1000L);
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
	}
}
