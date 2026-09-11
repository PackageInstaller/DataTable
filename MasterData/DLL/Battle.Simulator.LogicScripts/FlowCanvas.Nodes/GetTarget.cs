using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取实体目标", 0)]
[Category("Logic/Puppet")]
[Description("获取实体目标")]
public class GetTarget : PureFunctionNode<int, int>
{
	public override int Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			return 0;
		}
		return CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID.entityBlackboard.var.mAimTarget)?.creationIndex ?? 0;
	}
}
