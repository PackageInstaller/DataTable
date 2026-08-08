using ParadoxNotion.Design;
using Pathfinding;

namespace FlowCanvas.Nodes;

[Name("抛掷物带人", 0)]
[Category("Logic/Abilities")]
[Description("当子弹无视网管投过墙壁的时候，目标可能会脱钩，所以带人的子弹一定不能出网格")]
public class ThrownImpactAndCapture : CallableActionNode<int, int, int>
{
	public override void Invoke(int thrownID, int hitTargetID, int index)
	{
		ThrownState thrownState = null;
		if (!ThrownProcessor.TryGetThrown(base.parentNode.mSimContext, thrownID, out thrownState))
		{
			return;
		}
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(hitTargetID);
		if (thrownState.mCreationIndex == 0 || entityWithEntityID == null)
		{
			return;
		}
		MovementProcessor.Stop(entityWithEntityID);
		Int3 mPosition = entityWithEntityID.entityPositon.mPosition;
		if ((entityWithEntityID.entityPositon.mPosition - thrownState.mLastPosition).sqrMagnitudeLong2D >= 1000000)
		{
			Int3 delta = (entityWithEntityID.entityPositon.mPosition - thrownState.mLastPosition).NormalizeTo(100);
			int num = 0;
			Int3 @int = thrownState.mPosition;
			if (!PathUtilities.IsOnGraph(@int))
			{
				num = 0;
				@int = thrownState.mLastPosition + PathUtilities.Move(thrownState.mLastPosition, thrownState.mPosition - thrownState.mLastPosition, ref num);
			}
			num = 0;
			mPosition = @int + PathUtilities.Move(@int, delta, ref num);
			if (!PathUtilities.IsOnGraph(mPosition))
			{
				mPosition = entityWithEntityID.entityPositon.mPosition;
			}
		}
		else
		{
			int groundY = 0;
			Int3 int2 = entityWithEntityID.entityPositon.mPosition + PathUtilities.Move(entityWithEntityID.entityPositon.mPosition, thrownState.mPosition - thrownState.mLastPosition, ref groundY);
			Int3 int3 = (entityWithEntityID.entityPositon.mPosition - int2).NormalizeTo(10) * index;
			mPosition = new Int3(int2.x + int3.x, int2.y, int2.z + int3.z);
			if (!PathUtilities.IsOnGraph(mPosition))
			{
				mPosition = int2;
			}
		}
		entityWithEntityID.entityPositon.mPosition = mPosition;
		entityWithEntityID.entityPositon.mForward = -thrownState.mForward;
		SimShapeProcessor.UpdateShapeWorldPosition(entityWithEntityID);
	}
}
