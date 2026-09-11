using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取怪物的触发器ID", 0)]
[Category("Logic/Trigger")]
[Description("获取怪物的触发器ID,也是AIID")]
public class GetEnemyTriggerID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> triggerIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("触发器ID", () => base.mSimContext.GetEntityWithEntityID(triggerIDInput.value)?.entityBlackboard.var.mAIID ?? 0);
	}
}
