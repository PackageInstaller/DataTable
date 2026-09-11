using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体向目标平移", 0)]
[Category("Logic/PosAndRot")]
[Description("实体向目标点平移,没有动作,就是设置一下位移")]
public class MoveEntity : CallableFunctionNode<int, int, int, int>
{
	public override int Invoke(int entityID, int targetID, int speedFactor)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		SimEntity entityWithEntityID2 = base.parentNode.mSimContext.GetEntityWithEntityID(targetID);
		int num = entityWithEntityID.entityBlackboard.var.mMaxSpeed.roundInt * speedFactor;
		Int3 mPosition = entityWithEntityID.entityPositon.mPosition;
		Int3 @int = mPosition;
		if (entityWithEntityID2 != null)
		{
			@int = entityWithEntityID2.entityPositon.mPosition;
		}
		Int3 int2 = @int - mPosition;
		Int3 delta = ((int2.IntMagnitude.i >= num) ? int2.NormalizeTo(num) : int2);
		entityWithEntityID.entityPositon.mForward = int2.NormalizeTo(1000);
		MovementProcessor.PathfindingMove(entityWithEntityID, delta);
		return entityID;
	}
}
