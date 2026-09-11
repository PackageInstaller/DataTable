namespace Pathfinding;

public class EndingConditionProximity : ABPathEndingCondition
{
	public float maxDistance = 10f;

	public EndingConditionProximity(ABPath p, float maxDistance)
		: base(p)
	{
		this.maxDistance = maxDistance;
	}

	public override bool TargetFound(PathNode node)
	{
		return (node.node.position - abPath.originalEndPoint).sqrMagnitude <= maxDistance * maxDistance;
	}
}
