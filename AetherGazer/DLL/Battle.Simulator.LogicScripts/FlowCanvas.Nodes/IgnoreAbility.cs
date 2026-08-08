using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]设置是否忽略技能CD", 0)]
[Category("Logic/Attribute")]
[Description("设置是否忽略技能CD，被忽略的技能将无视CD及使用次数施放")]
[ExposeAsDefinition]
public class IgnoreAbility : CallableActionNode<int, int, bool>
{
	public override void Invoke(int target, int abilityID, bool isIgonre)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(target);
		if (entityWithEntityID != null)
		{
			abilityID = CDProcessor.CheckAbilityIsAvoid(abilityID);
			CDProcessor.SetIgnore(entityWithEntityID, abilityID, isIgonre);
		}
	}
}
