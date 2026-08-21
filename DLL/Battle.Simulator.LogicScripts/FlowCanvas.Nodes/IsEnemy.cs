using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否为敌人", 0)]
[Category("Logic/Trigger")]
[Description("是否为敌人")]
[ExposeAsDefinition]
public class IsEnemy : CallableFunctionNode<bool, int>
{
	public override bool Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityShape)
		{
			return RoleCampProcessor.IsEnemy(entityWithEntityID.entityShape.mLayer);
		}
		return false;
	}
}
