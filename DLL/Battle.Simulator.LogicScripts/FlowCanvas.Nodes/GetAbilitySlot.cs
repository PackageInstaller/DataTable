using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取技能槽", 0)]
[Category("Logic/Abilities")]
[Description("获取技能槽")]
public class GetAbilitySlot : CallableFunctionNode<int, int, int>
{
	public override int Invoke(int simEntityID, int slotIndex)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID);
		if (entityWithEntityID != null && slotIndex < entityWithEntityID.entityBlackboard.var.mAbilitySlots.Length)
		{
			return entityWithEntityID.entityBlackboard.var.mAbilitySlots[slotIndex];
		}
		return 0;
	}
}
