using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("匀变速抛掷物计算", 0)]
[Category("Logic/抛掷物")]
[Description("匀变速抛掷物计算")]
public class CalculateHorizontalTrajectory : CallableFunctionNode<int, int, int, int>
{
	public override int Invoke(int id, int speed, int acceleration)
	{
		ThrownState thrownState = null;
		if (!ThrownProcessor.TryGetThrown(base.parentNode.mSimContext, id, out thrownState))
		{
			return 0;
		}
		VFactor vFactor = new VFactor(CommonProcessor.GetLogicConstTick(), 1000L);
		Int3 @int = thrownState.mForward * new VFactor(speed, 1000L) * vFactor;
		thrownState.mLastPosition = thrownState.mPosition;
		thrownState.mPosition += @int;
		speed += (acceleration * vFactor).integer;
		return speed;
	}
}
