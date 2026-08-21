using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取实体阵营(过时)", 0)]
[Category("Logic/Trigger")]
[Description("获取实体的Lyaer")]
[ExposeAsDefinition]
public class GetEntityLayer : CallableFunctionNode<uint, int>
{
	public override uint Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityCamp)
		{
			return entityWithEntityID.entityCamp.mRoleTypeCamp;
		}
		return 0u;
	}
}
