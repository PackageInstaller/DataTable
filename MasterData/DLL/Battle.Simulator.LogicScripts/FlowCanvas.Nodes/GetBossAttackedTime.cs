using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取boss已经攻击的次数", 0)]
[Category("Logic/Attribute")]
[Description("获取boss已经攻击的次数")]
public class GetBossAttackedTime : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		int attackedTime = 0;
		AddValueOutput("次数", () => attackedTime);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID.hasEntityBoss)
			{
				attackedTime = entityWithEntityID.entityBoss.attackTime;
			}
			output.Call(f);
		});
	}
}
