using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取目标(过时)", 0)]
[Category("Logic/AI")]
[Description("得到ai的目标，改为使用【获取实体目标】")]
public class GetAIAimTarget : PureFunctionNode<int, int>
{
	public override int Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		return CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID.entityBlackboard.var.mAimTarget)?.creationIndex ?? entityWithEntityID.entityBlackboard.var.mAimTarget;
	}
}
