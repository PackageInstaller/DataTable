using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI锁定目标", 0)]
[Category("Logic/AI")]
[Description("AI锁定目标")]
public class AILockTarget : CallableActionNode<int, int>
{
	public override void Invoke(int entityID, int targetID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && !entityWithEntityID.hasEntityActionDeath && entityWithEntityID.hasEntityBlackboard)
		{
			AIProcessor.ChangeTarget(entityWithEntityID, targetID);
			entityWithEntityID.entityBlackboard.var.hasManualLock = true;
		}
	}
}
