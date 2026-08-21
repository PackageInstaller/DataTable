using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断当前Ability(后3位)", 0)]
[Category("Logic/Abilities")]
[Description("判断当前正在执行的Ability是不是某个指定的ability")]
public class IsCurrentTargetAbilityWithShortAbilityID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> abilityIDInput = AddValueInput<int>("后3位");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput trueOut = AddFlowOutput("True");
		FlowOutput falseOut = AddFlowOutput("False");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			int num = entityWithEntityID.entityConfig.mId * 1000 + abilityIDInput.value;
			if (entityWithEntityID.hasEntityActionAbility && entityWithEntityID.entityActionAbility.mAbilityID == num)
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
