using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取技能等级", 0)]
[Category("Logic/Abilities")]
[Description("获取技能等级, 如果抛掷物ID不为0, 则会根据抛掷物ID获取技能ID, 没有技能等级的那些, 默认返回1")]
public class GetAbilityLevel : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> abilityIDInput = AddValueInput<int>("技能ID");
		ValueInput<int> thrownIDInput = AddValueInput<int>("抛掷物ID");
		AddValueOutput("等级", delegate
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			return (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard) ? 1 : CommonNodeFunction.GetAbilityLevel(base.graph, entityWithEntityID.entityBlackboard.var.mAttributeID, abilityIDInput.value, thrownIDInput.value);
		});
	}
}
