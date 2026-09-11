using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]增减当前技能已使用次数", 0)]
[Category("Logic/Attribute")]
[Description("增减当前技能已使用次数")]
[ExposeAsDefinition]
public class ModifyAbilityCDWithOutTime : CallableActionNode<int, int, int>
{
	public override void Invoke(int target, int abilityID, int modifyUsedCount)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(target);
		if (entityWithEntityID != null && CDProcessor.GetCD(entityWithEntityID, abilityID, out var abilityCD))
		{
			abilityID = CDProcessor.CheckAbilityIsAvoid(abilityID);
			CDProcessor.SetCD(entityWithEntityID, abilityID, abilityCD.CD, abilityCD.UsedCount + modifyUsedCount);
		}
	}
}
