using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否技能施放中", 0)]
[Category("Logic/Abilities")]
[Description("检查是否在施放技能")]
public class HasEntityActionAbilityWithCallback : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityID = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityID.value);
		int abilityID = 0;
		AddValueOutput("技能ID", () => abilityID);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false", "flase");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityActionAbility)
			{
				falseOut.Call(f);
			}
			else
			{
				int abilityCategory = ConfigHelper.GetInstance().GetConfig<public_skill>(entityWithEntityID.entityActionAbility.mAbilityID).AbilityCategory;
				if ((uint)(abilityCategory - 3) <= 1u || (uint)(abilityCategory - 12) <= 2u)
				{
					abilityID = entityWithEntityID.entityActionAbility.mAbilityID;
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
		});
	}
}
