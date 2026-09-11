namespace Pathfinding;

public class EndingConditionDistance : PathEndingCondition
{
	public int maxGScore = 100;

	public EndingConditionDistance(Path p, int maxGScore)
		: base(p)
	{
		this.maxGScore = maxGScore;
	}

	public override bool TargetFound(PathNode node)
	{
		return node.G >= maxGScore;
	}
}
