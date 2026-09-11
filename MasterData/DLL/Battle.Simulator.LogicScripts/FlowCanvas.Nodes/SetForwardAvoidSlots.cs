using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置向前闪避槽", 0)]
[Category("Logic/Abilities")]
[Description("设置向前闪避槽")]
public class SetForwardAvoidSlots : CallableActionNode<int, int, bool>
{
	public override void Invoke(int simEntityID, int id, bool copyEnable = true)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID);
		if (entityWithEntityID != null)
		{
			int mAvoidForwardSlots = entityWithEntityID.entityBlackboard.var.mAvoidForwardSlots;
			if (((mAvoidForwardSlots != 0) & copyEnable) && entityWithEntityID.entityBlackboard.var.mAbilityEnable.TryGetValue(mAvoidForwardSlots, out var value))
			{
				entityWithEntityID.entityBlackboard.var.mAbilityEnable[id] = value;
			}
			entityWithEntityID.entityBlackboard.var.mAvoidForwardSlots = id;
		}
	}
}
