using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获得实体血量", 0)]
[Category("Logic/Attribute")]
[Description("获得实体血量.....")]
[ExposeAsDefinition]
public class GetEntityHP : CallableFunctionNode<long, int>
{
	public override long Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
		{
			return 0L;
		}
		return entityWithEntityID.entityBlackboard.var.mHP;
	}
}
