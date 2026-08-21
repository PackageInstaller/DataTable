using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("启用普攻(槽)", 0)]
[Category("Logic/Buff/效果/普攻")]
[Description("计数型，当结果为禁用时，此时处于普攻槽中的技能会被判定为不可用")]
public class EnableAttackBySlot : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.GetValue());
			if (entityWithEntityID != null)
			{
				entityWithEntityID.entityBlackboard.var.mIsBanMelee--;
			}
			output.Call(f);
		});
		AddValueOutput("实体ID", () => entityIDVar.value);
	}
}
