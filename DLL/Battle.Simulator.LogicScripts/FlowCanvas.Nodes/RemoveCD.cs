using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]移除CD", 0)]
[Category("Logic/Attribute")]
[Description("移除CD")]
[ExposeAsDefinition]
public class RemoveCD : CallableActionNode<int, int>
{
	public override void Invoke(int target, int abilityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(target);
		if (entityWithEntityID != null)
		{
			abilityID = CDProcessor.CheckAbilityIsAvoid(abilityID);
			CDProcessor.RemoveCD(entityWithEntityID, abilityID);
		}
	}
}
