using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("瞬移", 0)]
[Category("Logic/PosAndRot")]
[Description("Teleport")]
public class Teleport : CallableActionNode<int, Int3>
{
	public override void Invoke(int simEntityID, Int3 target)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID);
		if (entityWithEntityID != null)
		{
			Int3 delta = target - entityWithEntityID.entityPositon.mPosition;
			MovementProcessor.PathfindingMove(entityWithEntityID, delta);
		}
	}
}
