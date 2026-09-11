using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置向后闪避槽", 0)]
[Category("Logic/Abilities")]
[Description("设置向后闪避槽")]
public class SetBackAvoidSlots : CallableActionNode<int, int, bool>
{
	public override void Invoke(int simEntityID, int id, bool copyEnable = true)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID);
		if (entityWithEntityID != null)
		{
			int mAvoidBackSlots = entityWithEntityID.entityBlackboard.var.mAvoidBackSlots;
			if (((mAvoidBackSlots != 0) & copyEnable) && entityWithEntityID.entityBlackboard.var.mAbilityEnable.TryGetValue(mAvoidBackSlots, out var value))
			{
				entityWithEntityID.entityBlackboard.var.mAbilityEnable[id] = value;
			}
			entityWithEntityID.entityBlackboard.var.mAvoidBackSlots = id;
		}
	}
}
