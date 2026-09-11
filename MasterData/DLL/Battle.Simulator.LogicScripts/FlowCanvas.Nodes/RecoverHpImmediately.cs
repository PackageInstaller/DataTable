using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("立刻回血", 0)]
[Category("Logic/Attribute")]
[Description("回血,百分比向下取整, 可以同时填两个, 直接修改血量, 立即生效, 这种诙谐是没有记录的, 慎用")]
public class RecoverHpImmediately : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> percentInput = AddValueInput<int>("千分比");
		ValueInput<int> valueInput = AddValueInput<int>("固定值");
		ValueInput<bool> clampMaxInput = AddValueInput<bool>("限制上限");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				long num = valueInput.value + entityWithEntityID.entityBlackboard.var.mMaxHP * percentInput.value / 1000;
				entityWithEntityID.entityBlackboard.var.mHP += num;
				if (clampMaxInput.value && entityWithEntityID.entityBlackboard.var.mHP > entityWithEntityID.entityBlackboard.var.mMaxHP)
				{
					entityWithEntityID.entityBlackboard.var.mHP = entityWithEntityID.entityBlackboard.var.mMaxHP;
				}
				if (entityWithEntityID.entityBlackboard.var.mHP > 0)
				{
					entityWithEntityID.entityBlackboard.var.sendDeathEvent = false;
				}
				output.Call(f);
			}
		});
	}
}
