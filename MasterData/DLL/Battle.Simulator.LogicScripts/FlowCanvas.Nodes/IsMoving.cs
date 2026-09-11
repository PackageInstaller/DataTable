using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否移动", 0)]
[Category("Logic/PosAndRot")]
[Description("检查是否在移动")]
public class IsMoving : PureFunctionNode<bool, int>
{
	public override bool Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityActionMoveDirection)
		{
			return EntityActionStatus.E_ACTIVE == entityWithEntityID.entityActionMoveDirection.mStatus;
		}
		return false;
	}
}
