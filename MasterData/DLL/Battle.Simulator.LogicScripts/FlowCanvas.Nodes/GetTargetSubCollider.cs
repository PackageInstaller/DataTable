using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取实体目标（子碰撞盒）", 0)]
[Category("Logic/Target")]
[Description("获取实体目标")]
public class GetTargetSubCollider : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("目标ID", () => base.mSimContext.GetEntityWithEntityID(entityIDInput.value)?.entityBlackboard.var.mAimTarget ?? 0);
	}
}
