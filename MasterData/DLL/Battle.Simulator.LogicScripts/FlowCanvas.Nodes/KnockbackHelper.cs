namespace FlowCanvas.Nodes;

public class KnockbackHelper
{
	public static void KnockbackTo(SimEntity actionEntity, Int3 direction, int length)
	{
		Int3 delta = IntMath.Divide(direction * length, 1000L);
		MovementProcessor.PathfindingMove(actionEntity, delta);
	}
}
