using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获得归属阵营(Pure)", 0)]
[Category("Logic/抛掷物")]
[Description("获得归属阵营")]
public class GetEntityCampPure : PureFunctionNode<RoleType, int>
{
	public override RoleType Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityCamp)
		{
			return (RoleType)entityWithEntityID.entityCamp.mRoleTypeCamp;
		}
		return RoleType.None;
	}
}
