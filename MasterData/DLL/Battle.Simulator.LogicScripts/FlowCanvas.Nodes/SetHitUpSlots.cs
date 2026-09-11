using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置击飞槽", 0)]
[Category("Logic/Abilities")]
[Description("设置击飞槽")]
public class SetHitUpSlots : CallableActionNode<int, int>
{
	public override void Invoke(int simEntityID, int id)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID);
		if (entityWithEntityID != null)
		{
			entityWithEntityID.entityBlackboard.var.mHitUpSlot = id;
		}
	}
}
