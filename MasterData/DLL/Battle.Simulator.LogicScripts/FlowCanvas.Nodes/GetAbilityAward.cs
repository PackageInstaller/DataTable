using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]是否技能奖励", 0)]
[Category("Logic/Attribute")]
[Description("获取技能奖励")]
[ExposeAsDefinition]
public class GetAbilityAward : PureFunctionNode<bool, int, int>
{
	public override bool Invoke(int target, int abilityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(target);
		if (entityWithEntityID != null)
		{
			abilityID = CDProcessor.CheckAbilityIsAvoid(abilityID);
			return CDProcessor.HasAward(entityWithEntityID, abilityID);
		}
		return false;
	}
}
