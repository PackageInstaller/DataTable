using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]共享CD", 0)]
[Category("Logic/Attribute")]
[Description("将A技能的CD共享给B")]
[ExposeAsDefinition]
public class AddShareCD : CallableActionNode<int, int, int>
{
	public override void Invoke(int target, int abilityID, int beShareAbilityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(target);
		if (entityWithEntityID != null)
		{
			CDProcessor.ShareCD(entityWithEntityID, abilityID, beShareAbilityID);
		}
	}
}
