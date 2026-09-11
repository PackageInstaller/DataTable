using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI向目标移动", 0)]
[Category("Logic/AI")]
[Description("AI向目标移动，移动时会看着目标")]
public class AIMoveToTarget : CallableActionNode<int, int>
{
	public override void Invoke(int entityID, int speedFactor)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && !entityWithEntityID.hasEntityActionDeath && entityWithEntityID.hasEntityBlackboard)
		{
			entityWithEntityID.entityBlackboard.var.mIsLookatAimTarget = true;
		}
		Int3 zero = Int3.zero;
		zero = AIProcessor.GetTargetPosition(entityWithEntityID);
		AIProcessor.MoveAIDirection(entityID, zero, new VFactor(speedFactor, 100L));
	}
}
