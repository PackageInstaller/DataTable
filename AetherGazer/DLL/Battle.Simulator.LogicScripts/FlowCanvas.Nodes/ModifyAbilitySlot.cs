using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改技能槽", 0)]
[Category("Logic/Abilities")]
[Description("修改技能槽用于修改技能")]
public class ModifyAbilitySlot : CallableActionNode<int, int, int>
{
	public override void Invoke(int simEntityID, int slotIndex, int abilityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID);
		if (entityWithEntityID != null && slotIndex < entityWithEntityID.entityBlackboard.var.mAbilitySlots.Length)
		{
			int arg = entityWithEntityID.entityBlackboard.var.mAbilitySlots[slotIndex];
			entityWithEntityID.entityBlackboard.var.mAbilitySlots[slotIndex] = abilityID;
			base.parentNode.graph.mSimContext.GetSimInterface().mAbilitySlotsChangeEvent?.Invoke(entityWithEntityID.creationIndex, slotIndex, arg, entityWithEntityID.entityBlackboard.var.mAbilitySlots[slotIndex]);
		}
	}
}
