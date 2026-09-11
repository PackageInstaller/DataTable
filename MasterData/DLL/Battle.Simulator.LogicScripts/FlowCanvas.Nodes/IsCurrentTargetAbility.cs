using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断当前Ability", 0)]
[Category("Logic/Abilities")]
[Description("判断当前正在执行的Ability是不是某个指定的ability")]
public class IsCurrentTargetAbility : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> abilityIDInput = AddValueInput<int>("abilityID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput trueOut = AddFlowOutput("True");
		FlowOutput falseOut = AddFlowOutput("False");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityActionAbility)
			{
				falseOut.Call(f);
			}
			else if (entityWithEntityID.entityActionAbility.mAbilityID == abilityIDInput.value)
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
