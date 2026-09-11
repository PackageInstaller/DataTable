using ParadoxNotion.Design;
using Pathfinding;

namespace FlowCanvas.Nodes;

[Name("设置实体位置(安全版)", 0)]
[Category("Logic/PosAndRot")]
[Description("设置实体位置,但是不要用于每帧调用")]
[ExposeAsDefinition]
public class SetEntityPositionWithMove : CallableActionNode<int, Int3>
{
	public override void Invoke(int entityID, Int3 position)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityPositon)
		{
			int groundY = 0;
			Int3 delta = position - entityWithEntityID.entityPositon.mPosition;
			delta = PathUtilities.Move(entityWithEntityID.entityPositon.mPosition, delta, ref groundY, isUseTangentMove: false);
			if (!PathUtilities.IsOnGraph(delta + entityWithEntityID.entityPositon.mPosition))
			{
				MovementProcessor.SetPosition(entityWithEntityID, entityWithEntityID.entityPositon.mPosition);
			}
			else
			{
				MovementProcessor.ModifyPosition(entityWithEntityID, delta);
			}
		}
	}
}
