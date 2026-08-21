using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获得归属阵营", 0)]
[Category("Logic/抛掷物")]
[Description("获得归属阵营")]
public class GetEntityCamp : CallableFunctionNode<uint, int>
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
