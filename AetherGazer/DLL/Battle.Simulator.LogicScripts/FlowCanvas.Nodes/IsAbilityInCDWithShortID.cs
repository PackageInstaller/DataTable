using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能是否在CD中(后3位)", 0)]
[Category("Logic/Abilities")]
[Description("技能是否在CD中,通过判断指定实体ID 的指定技能当前CD是不是大于0")]
public class IsAbilityInCDWithShortID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("EntityID");
		ValueInput<int> abilityIDInput = AddValueInput<int>("AbilityID");
		AddValueOutput("EntityID", () => entityIDInput.value);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			int abilityID = entityWithEntityID.entityConfig.mId * 1000 + abilityIDInput.value;
			abilityID = CDProcessor.CheckAbilityIsAvoid(abilityID);
			if (CDProcessor.InCD(entityWithEntityID, abilityID))
			{
				f.Call(trueOut);
			}
			else
			{
				f.Call(falseOut);
			}
		});
	}
}
