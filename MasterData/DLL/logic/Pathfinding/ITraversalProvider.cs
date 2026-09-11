namespace Pathfinding;

public interface ITraversalProvider
{
	bool CanTraverse(Path path, GraphNode node);

	uint GetTraversalCost(Path path, GraphNode node);
}
