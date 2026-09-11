using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断当前或接下来的Ability(后3位)", 0)]
[Category("Logic/Abilities")]
[Description("判断当前正在或接下来执行的Ability是不是某个指定的ability")]
public class IsCurrentOrWellTargetAbilityWithShortAbilityID : FlowNode
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
				int currentShortAbilityID = CommonNodeFunction.GetCurrentShortAbilityID(entityWithEntityID);
				int nextShortAbilityID = CommonNodeFunction.GetNextShortAbilityID(entityWithEntityID);
				if (abilityIDInput.value == currentShortAbilityID || abilityIDInput.value == nextShortAbilityID)
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
