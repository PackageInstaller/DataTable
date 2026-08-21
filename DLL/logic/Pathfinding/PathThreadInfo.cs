namespace Pathfinding;

public struct PathThreadInfo(int index, AstarPath astar, PathHandler runData)
{
	public readonly int threadIndex = index;

	public readonly AstarPath astar = astar;

	public readonly PathHandler runData = runData;
}
