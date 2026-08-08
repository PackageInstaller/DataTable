using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体向目标位置平移", 0)]
[Category("Logic/PosAndRot")]
[Description("实体向目标点平移,没有动作,就是设置一下位移")]
public class MoveEntityToTargetPos : CallableFunctionNode<int, int, Int3, int>
{
	public override int Invoke(int entityID, Int3 targetPos, int speedFactor)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		int num = entityWithEntityID.entityBlackboard.var.mMaxSpeed.roundInt * speedFactor;
		Int3 mPosition = entityWithEntityID.entityPositon.mPosition;
		Int3 @int = targetPos - mPosition;
		Int3 delta = ((@int.IntMagnitude.i >= num) ? @int.NormalizeTo(num) : @int);
		MovementProcessor.PathfindingMove(entityWithEntityID, delta);
		return entityID;
	}
}
