using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]设置技能奖励", 0)]
[Category("Logic/Attribute")]
[Description("有奖励的技能会在不影响CD及使用次数的情况下无条件施放")]
[ExposeAsDefinition]
public class SetAbilityAward : CallableActionNode<int, int, bool>
{
	public override void Invoke(int target, int abilityID, bool hasAward)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(target);
		if (entityWithEntityID != null)
		{
			abilityID = CDProcessor.CheckAbilityIsAvoid(abilityID);
			CDProcessor.SetAward(entityWithEntityID, abilityID, hasAward);
		}
	}
}
