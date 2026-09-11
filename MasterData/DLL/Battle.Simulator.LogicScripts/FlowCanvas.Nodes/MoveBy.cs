using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移动", 0)]
[Category("Logic/PosAndRot")]
[Description("Move By")]
public class MoveBy : CallableActionNode<int, Int3>
{
	public override void Invoke(int simEntityID, Int3 delta)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID);
		if (entityWithEntityID != null)
		{
			MovementProcessor.PathfindingMove(entityWithEntityID, delta);
		}
	}
}
