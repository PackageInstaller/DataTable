namespace Pathfinding;

public interface IWorkItemContext
{
	void QueueFloodFill();

	void EnsureValidFloodFill();
}
