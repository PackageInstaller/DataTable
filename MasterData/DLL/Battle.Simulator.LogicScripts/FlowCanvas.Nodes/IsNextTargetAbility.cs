using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断下一个要执行的Ability", 0)]
[Category("Logic/Abilities")]
[Description("判断下一帧要执行的Ability是不是某个指定的ability")]
public class IsNextTargetAbility : FlowNode
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
				if (entityWithEntityID.hasEntityActionAbilityLogicInput && abilityIDInput.value == entityWithEntityID.entityActionAbilityLogicInput.mBrokenAbilityID)
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
