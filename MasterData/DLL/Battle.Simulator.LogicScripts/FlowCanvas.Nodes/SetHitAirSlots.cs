using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置空中受击槽", 0)]
[Category("Logic/Abilities")]
[Description("设置空中受击槽")]
public class SetHitAirSlots : CallableActionNode<int, int, int>
{
	public override void Invoke(int simEntityID, int index, int id)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID);
		if (entityWithEntityID != null && index >= 0 && index < entityWithEntityID.entityBlackboard.var.mHitAirSlot.Count)
		{
			entityWithEntityID.entityBlackboard.var.mHitAirSlot[index] = id;
		}
	}
}
