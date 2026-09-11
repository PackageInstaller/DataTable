using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否看向目标", 0)]
[Category("Logic/AI")]
[Description("AI是否要锁定目标")]
public class AISetLookAimDirection : CallableActionNode<int, bool>
{
	public override void Invoke(int entityID, bool isLookAt)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && !entityWithEntityID.hasEntityActionDeath && entityWithEntityID.hasEntityBlackboard)
		{
			entityWithEntityID.entityBlackboard.var.mIsLookatAimTarget = isLookAt;
		}
	}
}
