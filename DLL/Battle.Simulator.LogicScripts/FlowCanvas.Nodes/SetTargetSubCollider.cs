using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置实体目标（子碰撞盒）", 0)]
[Category("Logic/Target")]
[Description("设置实体目标")]
public class SetTargetSubCollider : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOutput = AddFlowOutput("error");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> targetIDInput = AddValueInput<int>("目标ID");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				errorOutput.Call(f);
			}
			else
			{
				entityWithEntityID.entityBlackboard.var.mAimTarget = targetIDInput.value;
				entityWithEntityID.entityBlackboard.var.mLastTarget = targetIDInput.value;
				output.Call(f);
			}
		});
	}
}
