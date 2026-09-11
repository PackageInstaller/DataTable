using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取锁定目标(通过ID)", 0)]
[Category("Logic/AI")]
[Description("获取锁定目标")]
public class GetLookAtByID : CallableFunctionNode<int, int>
{
	public override int Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && !entityWithEntityID.hasEntityActionDeath && entityWithEntityID.hasEntityBlackboard)
		{
			int num = 0;
			num = ((!entityWithEntityID.entityBlackboard.var.hasManualLock) ? entityWithEntityID.entityBlackboard.var.mAimTarget : entityWithEntityID.entityBlackboard.var.mLastTarget);
			SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(num);
			if (simEntityByMultiColliders != null)
			{
				return simEntityByMultiColliders.creationIndex;
			}
		}
		return 0;
	}
}
