namespace Pathfinding;

public interface IUpdatableGraph
{
	void UpdateArea(GraphUpdateObject o);

	void UpdateAreaInit(GraphUpdateObject o);

	void UpdateAreaPost(GraphUpdateObject o);

	GraphUpdateThreading CanUpdateAsync(GraphUpdateObject o);
}
