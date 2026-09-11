using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置转身速度(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("设置转身速度, 单位为每秒x度")]
public class SetRotationSpeed : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		Int oldRotationSpeed = 0;
		ValueInput<Int> rotateSpeedInput = AddValueInput<Int>("转身速度");
		FlowOutput output = AddFlowOutput("Out");
		AddValueOutput("旧的转身速度", () => oldRotationSpeed);
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			oldRotationSpeed = entityWithEntityID.entityBlackboard.var.mDeltaRotationSpeed;
			entityWithEntityID.entityBlackboard.var.mDeltaRotationSpeed = rotateSpeedInput.value;
			output.Call(f);
		});
	}
}
