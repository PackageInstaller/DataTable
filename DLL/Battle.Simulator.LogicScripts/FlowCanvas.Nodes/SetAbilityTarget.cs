using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置Ability的目标", 0)]
[Category("Logic/AI")]
[Description("设置Ability的目标")]
public class SetAbilityTarget : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		AddValueInput<int>("技能ID");
		ValueInput<int> tageetInput = AddValueInput<int>("目标");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityActionAbility)
			{
				entityWithEntityID.entityActionAbility.mTargetID = tageetInput.value;
			}
			output.Call(f);
		});
	}
}
