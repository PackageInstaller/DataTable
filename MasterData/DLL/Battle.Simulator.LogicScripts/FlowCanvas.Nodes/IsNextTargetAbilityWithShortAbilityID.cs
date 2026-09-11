using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断下一个要执行的Ability(后3位)", 0)]
[Category("Logic/Abilities")]
[Description("判断下一帧要执行的Ability是不是某个指定的ability")]
public class IsNextTargetAbilityWithShortAbilityID : FlowNode
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
			try
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
				int num = entityWithEntityID.entityConfig.mId * 1000 + abilityIDInput.value;
				if (entityWithEntityID.hasEntityActionAbilityLogicInput && num == entityWithEntityID.entityActionAbilityLogicInput.mBrokenAbilityID)
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
