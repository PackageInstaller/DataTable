using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置boss已经攻击的次数", 0)]
[Category("Logic/Attribute")]
[Description("获取boss已经攻击的次数")]
public class SetBossAttackedTime : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> attackedTimeInput = AddValueInput<int>("次数");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID.hasEntityBoss)
			{
				entityWithEntityID.entityBoss.attackTime = attackedTimeInput.value;
			}
			output.Call(f);
		});
	}
}
