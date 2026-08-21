using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断当前或接下来的Ability", 0)]
[Category("Logic/Abilities")]
[Description("判断当前正在或接下来执行的Ability是不是某个指定的ability")]
public class IsCurrentOrWellTargetAbility : FlowNode
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
			try
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
				int num = (entityWithEntityID.hasEntityActionAbility ? entityWithEntityID.entityActionAbility.mAbilityID : 0);
				int num2 = (entityWithEntityID.hasEntityActionAbilityLogicInput ? entityWithEntityID.entityActionAbilityLogicInput.mBrokenAbilityID : 0);
				if (abilityIDInput.value == num || abilityIDInput.value == num2)
				{
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
			catch (Exception)
			{
				falseOut.Call(f);
			}
		});
	}
}
