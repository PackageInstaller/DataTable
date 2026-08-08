using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置起身槽", 0)]
[Category("Logic/Abilities")]
[Description("设置起身槽")]
public class SetGetUpSlots : CallableActionNode<int, int>
{
	public override void Invoke(int simEntityID, int id)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID);
		if (entityWithEntityID != null)
		{
			entityWithEntityID.entityBlackboard.var.mGetUpSlot = id;
		}
	}
}
