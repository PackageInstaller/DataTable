using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到转身速度(实体)(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("得到实体转身速度, 单位为每秒x毫度")]
public class GetRotationSpeedOfEntity : FlowControlNodeOfLogic
{
	private Int rotationSpeed;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddValueOutput("转身速度", "rotaionSpeed", () => rotationSpeed);
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				rotationSpeed = entityWithEntityID.entityBlackboard.var.mDeltaRotationSpeed;
				output.Call(f);
			}
		});
	}
}
