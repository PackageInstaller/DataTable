using UnityEngine;

namespace Pathfinding;

public class FloodPathConstraint : NNConstraint
{
	private readonly FloodPath path;

	public FloodPathConstraint(FloodPath path)
	{
		if (path == null)
		{
			Debug.LogWarning((object)"FloodPathConstraint should not be used with a NULL path");
		}
		this.path = path;
	}

	public override bool Suitable(GraphNode node)
	{
		if (base.Suitable(node))
		{
			return path.HasPathTo(node);
		}
		return false;
	}
}
