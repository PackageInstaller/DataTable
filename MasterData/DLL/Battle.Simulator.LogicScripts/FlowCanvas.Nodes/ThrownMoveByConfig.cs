using Config;
using ParadoxNotion.Design;
using Pathfinding;

namespace FlowCanvas.Nodes;

[Name("抛掷物使用配置移动(过时)", 0)]
[Category("Logic/抛掷物/移动")]
[Description("抛掷物使用配置移动")]
public class ThrownMoveByConfig : CallableActionNode<int, int>
{
	public override void Invoke(int thrownID, int timelineID)
	{
		ThrownState thrownState = null;
		if (!ThrownProcessor.TryGetThrown(base.parentNode.mSimContext, thrownID, out thrownState) || thrownState.mDontMovement)
		{
			return;
		}
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(timelineID);
		if (thrownState.mCurFrame >= config.MoveActionTimelineNode.Duration)
		{
			return;
		}
		VectorInt3 vectorInt = config.MoveActionTimelineNode.AverageSpeed;
		if (!config.MoveActionTimelineNode.UseUniformMotion)
		{
			vectorInt = config.MoveActionTimelineNode.AnimationMove.get_Item((int)thrownState.mCurFrame);
		}
		int z = vectorInt.Z;
		Int3 @int = thrownState.mForward * new VFactor(z, 1000L);
		Int3 int2 = thrownState.mPosition + @int;
		if (!config.ThrownCanOutRange)
		{
			int groundY = 0;
			@int = PathUtilities.Move(thrownState.mPosition, @int, ref groundY, isUseTangentMove: false);
			int2 = thrownState.mPosition + @int;
			if (!PathUtilities.IsOnGraph(int2))
			{
				int2 = thrownState.mPosition;
			}
		}
		if (config.IsUseConfigY)
		{
			int y = vectorInt.Y;
			thrownState.mHeight += y;
		}
		thrownState.mLastPosition = thrownState.mPosition;
		thrownState.mPosition = int2;
	}
}
