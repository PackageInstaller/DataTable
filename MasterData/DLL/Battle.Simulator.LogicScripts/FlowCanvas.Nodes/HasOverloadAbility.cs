using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]是否有过载的技能", 0)]
[Category("Logic/Attribute")]
[Description("是否有过载的技能")]
public class HasOverloadAbility : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
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
					if (entityWithEntityID.entityCD.mAbilityCD[i].MaxCD < entityWithEntityID.entityCD.mAbilityCD[i].CD)
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
