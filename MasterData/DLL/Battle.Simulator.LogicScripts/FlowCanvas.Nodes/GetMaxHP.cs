using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取最大血量", 0)]
[Category("Logic/Attribute")]
[Description("获取最大生命值")]
public class GetMaxHP : CallableFunctionNode<long, int>
{
	public override long Invoke(int target)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(target);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			return entityWithEntityID.entityBlackboard.var.mMaxHP;
		}
		return 0L;
	}
}
