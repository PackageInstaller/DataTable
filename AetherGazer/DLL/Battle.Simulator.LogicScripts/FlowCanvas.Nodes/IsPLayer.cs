using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否为玩家(已过时)", 0)]
[Category("Logic/Spawn")]
[Description("是否为玩家")]
[ExposeAsDefinition]
public class IsPLayer : CallableFunctionNode<bool, int>
{
	public override bool Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityShape)
		{
			return RoleCampProcessor.IsPlayer(entityWithEntityID.entityShape.mLayer);
		}
		return false;
	}
}
