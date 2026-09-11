using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]是否过载", 0)]
[Category("Logic/Attribute")]
[Description("指定技能是否过载")]
public class IsTargetAbilityOverload : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> abilityIDInput = AddValueInput<int>("技能ID");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityCD)
			{
				f.Call(falseOut);
			}
			else
			{
				for (int i = 0; i < entityWithEntityID.entityCD.mAbilityCD.Count; i++)
				{
					if (entityWithEntityID.entityCD.mAbilityCD[i].AbilityID == abilityIDInput.value && entityWithEntityID.entityCD.mAbilityCD[i].MaxCD < entityWithEntityID.entityCD.mAbilityCD[i].CD)
					{
						f.Call(trueOut);
						return;
					}
				}
				f.Call(falseOut);
			}
		});
	}
}
