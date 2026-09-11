using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取非我方阵营层", 0)]
[Category("Logic/Trigger")]
[Description("获取实体的Lyaer")]
[ExposeAsDefinition]
public class GetHostileLayer : CallableFunctionNode<uint, int>
{
	public override uint Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityShape)
		{
			return RoleCampProcessor.GetInterestCamp(entityWithEntityID.entityShape.mLayer);
		}
		return 0u;
	}
}
