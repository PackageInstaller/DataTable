using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取血量", 0)]
[Category("Logic/Attribute")]
[Description("获取生命值")]
[ExposeAsDefinition]
public class GetHP : CallableFunctionNode<long, int>
{
	public override long Invoke(int target)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(target);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			return entityWithEntityID.entityBlackboard.var.mHP;
		}
		return 0L;
	}
}
